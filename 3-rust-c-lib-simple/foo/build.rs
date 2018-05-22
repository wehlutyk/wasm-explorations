use std::env;

fn main() {
    println!("cargo:rerun-if-env-changed=BAR_LIB_DIR");

    let lib_dir = env::var("BAR_LIB_DIR").unwrap();
    println!("cargo:rustc-link-search=native={}", lib_dir);
    println!("cargo:rustc-link-lib=static=bar");
}
