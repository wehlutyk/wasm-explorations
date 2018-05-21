foo_bg.wasm foo.d.ts foo.js: target/wasm32-unknown-unknown/debug/foo.wasm
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .

target/wasm32-unknown-unknown/debug/foo.wasm: src/*
	cargo build --target=wasm32-unknown-unknown

clean:
	cargo clean
	rm -rf node_modules
	rm -f foo_bg.wasm foo.d.ts foo.js

blankslate: clean
	rm -f Cargo.lock
	rm -f package-lock.json

env: blankslate
	cargo install -f wasm-bindgen-cli
	npm install

.PHONY: clean env blankslate
