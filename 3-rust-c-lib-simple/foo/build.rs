extern crate cc;

fn main() {
    cc::Build::new()
    	.file("libbar/bar.c")
    	.compile("bar");
}
