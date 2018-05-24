export BAR_LIB_DIR := libbar

foo_bg.wasm foo.d.ts foo.js: target/wasm32-unknown-unknown/debug/foo.wasm
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .

target/wasm32-unknown-unknown/debug/foo.wasm: src/* $(BAR_LIB_DIR)/libbar.a
	cargo build --target=wasm32-unknown-unknown

$(BAR_LIB_DIR)/libbar.a: $(BAR_LIB_DIR)/bar.o
	docker run \
	  --user $(shell id -u):$(shell id -g) \
	  --volume $(CURDIR):/c:ro \
	  --volume $(CURDIR)/$(BAR_LIB_DIR):/c/$(BAR_LIB_DIR) \
	  --workdir /c \
	  --interactive \
	  --tty \
	  --rm \
	  wasm-compiler-test \
	  /clang/bin/llvm-ar rcsv $(BAR_LIB_DIR)/libbar.a $(BAR_LIB_DIR)/bar.o

$(BAR_LIB_DIR)/bar.o: $(BAR_LIB_DIR)/bar.c
	 #--volume $(CURDIR)/target:/c/target \
	 #--volume $HOME/.cargo:/cargo \
	 #--volume (rustc +nightly --print sysroot):/rust:ro \
	docker run \
	  --user $(shell id -u):$(shell id -g) \
	  --volume $(CURDIR):/c:ro \
	  --volume $(CURDIR)/$(BAR_LIB_DIR):/c/$(BAR_LIB_DIR) \
	  --workdir /c \
	  --interactive \
	  --tty \
	  --rm \
	  wasm-compiler-test \
	 /clang/bin/clang -c --target=wasm32-unknown-unknown-wasm -o $(BAR_LIB_DIR)/bar.o $(BAR_LIB_DIR)/bar.c

clean:
	cargo clean
	rm -f $(BAR_LIB_DIR)/bar.o $(BAR_LIB_DIR)/libbar.a
	rm -f foo_bg.wasm foo.d.ts foo.js

blankslate: clean
	rm -f Cargo.lock
	rm -rf node_modules
	rm -f package-lock.json

env:
	npm install

.PHONY: clean env blankslate
