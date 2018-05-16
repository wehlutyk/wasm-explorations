extern "C" {
    fn add(a: i32, b: i32) -> i32;
}

pub fn greet(name: &str) {
    println!("Hello, {}!", name);
    println!("4 + 5 = {}", unsafe { add(4, 5) });
}
