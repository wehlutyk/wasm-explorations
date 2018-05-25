# Rust + C library using stubbed libc calls, for WebAssembly

The basic Rust "hello world", but statically linking to a C library compiled from source as part of the build, with `wasm-bindgen` and target `wasm32-unknown-unknown`. The C library uses system calls, which we stub in order to not bring a libc implementation in the final binary.

Build: `make env && make`

Run: `npm run serve`
