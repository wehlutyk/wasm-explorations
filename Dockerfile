FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y \
  g++ \
  make \
  cmake \
  curl \
  xz-utils \
  python \
  git

WORKDIR /llvm/build
RUN curl http://releases.llvm.org/6.0.0/llvm-6.0.0.src.tar.xz | \
  tar xJf - -C /llvm --strip-components 1
RUN mkdir /llvm/tools/clang
RUN curl http://releases.llvm.org/6.0.0/cfe-6.0.0.src.tar.xz | \
  tar xJf - -C /llvm/tools/clang --strip-components 1
RUN mkdir /llvm/tools/lld
RUN curl https://releases.llvm.org/6.0.0/lld-6.0.0.src.tar.xz | \
  tar xJf - -C /llvm/tools/lld --strip-components 1
RUN cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/clang \
  -DLLVM_TARGETS_TO_BUILD=X86 \
  -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly
RUN make -j $(nproc)
RUN make install

ENV CC /clang/bin/clang
ENV AR /clang/bin/llvm-ar
ENV LD /clang/bin/ld.lld
ENV LLVM_CONFIG /clang/bin/llvm-config

WORKDIR /
RUN git clone https://github.com/jfbastien/musl
WORKDIR /musl
RUN git reset --hard d312ecae
ENV CFLAGS -O3 --target=wasm32-unknown-unknown-wasm -nostdlib -Wl,--no-entry
RUN CFLAGS="$CFLAGS -Wno-error=pointer-sign" ./configure --prefix=/musl-sysroot wasm32
RUN make -j$(nproc) install

ENV CFLAGS -O3 --target=wasm32-unknown-unknown-wasm -nostdlib -Wl,--no-entry --sysroot=/musl-sysroot
