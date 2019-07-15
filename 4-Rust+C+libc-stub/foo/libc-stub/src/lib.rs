extern crate wasm_bindgen;
extern crate statrs;

use wasm_bindgen::prelude::*;
use statrs::function::erf;

// Types (the libc crate doesn't yet support wasm32-unknown-unknown)
#[allow(non_camel_case_types)]
pub type c_float = f32;

// Generic function referencing the libc stubs to prevent them from being optimised away
pub fn keep<T>() -> usize {
    sin as usize +
        erff as usize
}

// External functions used by libbar ...
// ... for which we rely on the browser (in this case, wasm-bindgen would do
// this automatically for `sin`, but this keeps us organised)
#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = Math)]
    fn sin(a: c_float) -> c_float;
}

// ... which we define ourselves
#[no_mangle]
extern fn erff(a: c_float) -> c_float {
    erf::erf(a as f64) as c_float
}
