export BAR_LIB_DIR := $(PWD)/libbar

foo_bg.wasm foo.d.ts foo.js: target/wasm32-unknown-unknown/debug/foo.wasm
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .

target/wasm32-unknown-unknown/debug/foo.wasm: src/* libbar/libbar.a
	cargo build --target=wasm32-unknown-unknown

libbar/libbar.a: libbar/bar.o
	ar rcsv	libbar/libbar.a	libbar/bar.o

libbar/bar.o: libbar/bar.c docker
	 #--volume $(PWD)/target:/c/target \
	 #--volume $HOME/.cargo:/cargo \
	 #--volume (rustc +nightly --print sysroot):/rust:ro \
       docker run \
	 --user	$(shell	id -u):$(shell id -g) \
	 --volume $(PWD):/c:ro \
	 --volume $(PWD)/libbar:/c/libbar \
	 --workdir /c \
	 --interactive \
	 --tty \
	 --rm \
	 wasm-compiler-test \
	 /clang/bin/clang -c --target=wasm32-unknown-unknown-wasm -o libbar/bar.o libbar/bar.c

docker:
	docker build --rm --tag	wasm-compiler-test .

clean:
	cargo clean
	rm -f libbar/bar.o libbar/libbar.a
	rm -rf node_modules
	rm -f foo_bg.wasm foo.d.ts foo.js

blankslate: clean
	rm -f Cargo.lock
	rm -f package-lock.json

env: blankslate	docker
	cargo install -f wasm-bindgen-cli
	npm install

.PHONY:	clean env blankslate docker
