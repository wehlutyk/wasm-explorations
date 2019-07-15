extern crate wasm_bindgen;
extern crate libc_stub as libc;

use wasm_bindgen::prelude::*;

extern "C" {
    fn sin2(a: libc::c_float) -> libc::c_float;
    fn erf2(a: libc::c_float) -> libc::c_float;
}

#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

#[wasm_bindgen]
pub fn greet(name: &str) {
    log(&format!("Hello, {}!", name));
    log(&format!("sin²(.5) = {}", unsafe { sin2(0.5) }));
    log(&format!("erf²(1.0) = {}", unsafe { erf2(1.0) }));
}
