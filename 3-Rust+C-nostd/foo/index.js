const js = import("./dist-browser/foo");

js.then(js => {
  js.greet("World!");
});
