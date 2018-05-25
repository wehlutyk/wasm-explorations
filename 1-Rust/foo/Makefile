DIST_BROWSER := dist-browser
OUTFILES_BROWSER := foo_bg.wasm foo.js foo.d.ts
OUTPATHS_BROWSER := $(foreach file,$(OUTFILES_BROWSER),$(DIST_BROWSER)/$(file))
DIST_NODEJS := dist-nodejs
OUTFILES_NODEJS := $(OUTFILES_BROWSER) foo_bg.js
OUTPATHS_NODEJS := $(foreach file,$(OUTFILES_NODEJS),$(DIST_NODEJS)/$(file))

all: $(OUTPATHS_BROWSER) $(OUTPATHS_NODEJS)

$(OUTPATHS_BROWSER): target/wasm32-unknown-unknown/debug/foo.wasm
	mkdir -p $(DIST_BROWSER)
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir $(DIST_BROWSER) --browser

$(OUTPATHS_NODEJS): target/wasm32-unknown-unknown/debug/foo.wasm
	mkdir -p $(DIST_NODEJS)
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir $(DIST_NODEJS) --nodejs

target/wasm32-unknown-unknown/debug/foo.wasm:
	cargo build --target=wasm32-unknown-unknown

clean:
	cargo clean
	rm -rf $(DIST_BROWSER) $(DIST_NODEJS)

blankslate: clean
	rm -f Cargo.lock
	rm -rf node_modules
	rm -f package-lock.json

env:
	npm install

test: $(OUTPATHS_NODEJS)
	node run.js | grep "Hello, World!"

.PHONY: all clean env blankslate test
