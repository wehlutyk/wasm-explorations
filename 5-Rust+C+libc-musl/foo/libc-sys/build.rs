use std::env;

fn main() {
    println!("cargo:rerun-if-env-changed=C_LIB_DIR");

    let lib_dir = env::var("C_LIB_DIR").unwrap();
    println!("cargo:rustc-link-search=native={}", lib_dir);
    println!("cargo:rustc-link-lib=static=c");
}
