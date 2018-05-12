foo_bg.wasm foo.d.ts foo.js: target/wasm32-unknown-unknown/foo.wasm
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .

target/wasm32-unknown-unknown/foo.wasm:
	cargo build --target=wasm32-unknown-unknown

clean:
	cargo clean
	rm -rf node_modules
	rm foo_bg.wasm foo.d.ts foo.js

prepare:
	cargo install -f wasm-bindgen-cli
	npm install

serve:
	npm run serve

.PHONY: clean prepare serve
