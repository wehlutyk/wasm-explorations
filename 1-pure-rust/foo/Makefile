foo_bg.wasm foo.d.ts foo.js: target/wasm32-unknown-unknown/debug/foo.wasm
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .

target/wasm32-unknown-unknown/debug/foo.wasm:
	cargo build --target=wasm32-unknown-unknown

clean:
	cargo clean
	rm -f foo_bg.wasm foo.d.ts foo.js

blankslate: clean
	rm -f Cargo.lock
	rm -rf node_modules
	rm -f package-lock.json

env:
	npm install

.PHONY: clean env blankslate
