extern crate wasm_bindgen;

use wasm_bindgen::prelude::*;

extern "C" {
    fn add(a: i32, b: i32) -> i32;
}

#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

#[wasm_bindgen]
pub fn greet(name: &str) {
    log(&format!("Hello, {}!", name));
    log(&format!("4 + 5 = {}", unsafe { add(4, 5) }));
}
