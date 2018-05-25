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
RUN cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/clang \
  -DLLVM_TARGETS_TO_BUILD=X86 \
  -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly
RUN make -j $(nproc)
RUN make install

ENV CC /clang/bin/clang

WORKDIR /
RUN git clone https://github.com/jfbastien/musl
WORKDIR /musl
RUN git reset --hard d312ecae
ENV CFLAGS -O3 --target=wasm32-unknown-unknown-wasm -nostdlib -Wl,--no-entry
RUN CFLAGS="$CFLAGS -Wno-error=pointer-sign" ./configure --prefix=/musl-sysroot wasm32
RUN make -j$(nproc) install

WORKDIR /
ENV CARGO_HOME /cargo
ENV PATH /rust/bin:$PATH
ENV BAR_LIB_DIR /c/libbar
ENV C_LIB_DIR /musl-sysroot/lib
