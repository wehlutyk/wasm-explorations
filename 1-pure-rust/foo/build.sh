#!/bin/bash
set -ex

cargo build --target=wasm32-unknown-unknown
wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir .
npm install
echo 'Now `npm run serve`'
