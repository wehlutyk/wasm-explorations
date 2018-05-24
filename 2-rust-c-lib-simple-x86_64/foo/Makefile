export BAR_LIB_DIR := libbar

#foo_bg.wasm foo.d.ts foo.js: target/wasm32-unknown-unknown/debug/foo.wasm
	#wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .

#target/wasm32-unknown-unknown/debug/foo.wasm:
	#cargo build --target=wasm32-unknown-unknown
target/debug/foo: src/* $(BAR_LIB_DIR)/libbar.a
	cargo build

$(BAR_LIB_DIR)/libbar.a: $(BAR_LIB_DIR)/bar.o
	ar rcsv $(BAR_LIB_DIR)/libbar.a $(BAR_LIB_DIR)/bar.o

$(BAR_LIB_DIR)/bar.o: $(BAR_LIB_DIR)/bar.c
	gcc -c -o $(BAR_LIB_DIR)/bar.o $(BAR_LIB_DIR)/bar.c

clean:
	cargo clean
	rm -f $(BAR_LIB_DIR)/bar.o $(BAR_LIB_DIR)/libbar.a
	#rm -f foo_bg.wasm foo.d.ts foo.js

blankslate: clean
	rm -f Cargo.lock
	#rm -rf node_modules
	#rm -f package-lock.json

env:
	#npm install

.PHONY: clean env blankslate
