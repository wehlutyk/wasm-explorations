export BAR_LIB_DIR = $(shell pwd)/libbar

#foo_bg.wasm foo.d.ts foo.js: target/wasm32-unknown-unknown/debug/foo.wasm
	#wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .

#target/wasm32-unknown-unknown/debug/foo.wasm:
	#cargo build --target=wasm32-unknown-unknown
target/debug/foo: src/*	libbar/libbar.a
	cargo build

libbar/libbar.a: libbar/bar.o
	ar rcsv	libbar/libbar.a	libbar/bar.o

libbar/bar.o: libbar/bar.c
	gcc -c -o libbar/bar.o libbar/bar.c

clean:
	cargo clean
	rm -f libbar/bar.o libbar/libbar.a
	#rm -rf	node_modules
	#rm -f foo_bg.wasm foo.d.ts foo.js

blankslate: clean
	rm -f Cargo.lock
	#rm -f package-lock.json

env: blankslate
	#cargo install -f wasm-bindgen-cli
	#npm install

.PHONY:	clean env blankslate
