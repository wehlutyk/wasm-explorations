DIST_BROWSER := dist-browser
OUTFILES_BROWSER := foo_bg.wasm foo.js foo.d.ts
OUTPATHS_BROWSER := $(foreach file,$(OUTFILES_BROWSER),$(DIST_BROWSER)/$(file))
DIST_NODEJS := dist-nodejs
OUTFILES_NODEJS := $(OUTFILES_BROWSER) foo_bg.js
OUTPATHS_NODEJS := $(foreach file,$(OUTFILES_NODEJS),$(DIST_NODEJS)/$(file))

DOCKER_IMAGE_VERSION := 0.1.0
DOCKER_IMAGE := wehlutyk/wasm-compiler:$(DOCKER_IMAGE_VERSION)
export BAR_LIB_DIR := libbar
DOCKER_RUN = docker run \
  --user $(shell id -u):$(shell id -g) \
  --volume $(CURDIR):/c:ro \
  --volume $(CURDIR)/$(BAR_LIB_DIR):/c/$(BAR_LIB_DIR) \
  --workdir /c \
  --interactive \
  --tty \
  --rm \
  $(DOCKER_IMAGE)
#--volume $(CURDIR)/target:/c/target \
#--volume $(HOME)/.cargo:/cargo \
#--volume $(shell rustc +nightly --print sysroot):/rust:ro \

all: $(OUTPATHS_BROWSER) $(OUTPATHS_NODEJS)

$(OUTPATHS_BROWSER): target/wasm32-unknown-unknown/debug/foo.wasm
	mkdir -p $(DIST_BROWSER)
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir $(DIST_BROWSER) --browser

$(OUTPATHS_NODEJS): target/wasm32-unknown-unknown/debug/foo.wasm
	mkdir -p $(DIST_NODEJS)
	wasm-bindgen target/wasm32-unknown-unknown/debug/foo.wasm --out-dir $(DIST_NODEJS) --nodejs

target/wasm32-unknown-unknown/debug/foo.wasm: src/* libc-stub/src/* $(BAR_LIB_DIR)/libbar.a
	cargo build --target=wasm32-unknown-unknown

$(BAR_LIB_DIR)/libbar.a: $(BAR_LIB_DIR)/bar.o
	$(DOCKER_RUN) /clang/bin/llvm-ar rcsv $(BAR_LIB_DIR)/libbar.a $(BAR_LIB_DIR)/bar.o

$(BAR_LIB_DIR)/bar.o: $(BAR_LIB_DIR)/bar.c
	$(DOCKER_RUN) /clang/bin/clang -c --target=wasm32-unknown-unknown-wasm --sysroot=/musl-sysroot -o $(BAR_LIB_DIR)/bar.o $(BAR_LIB_DIR)/bar.c

clean:
	cargo clean
	rm -f $(BAR_LIB_DIR)/bar.o $(BAR_LIB_DIR)/libbar.a
	rm -rf $(DIST_BROWSER) $(DIST_NODEJS)

blankslate: clean
	rm -f Cargo.lock
	rm -rf node_modules
	rm -f package-lock.json

env:
	npm install

test: $(OUTPATHS_NODEJS)
	node run.js | grep "Hello, World!!"
	node run.js | grep "sin²(.5) = 0.2298"
	node run.js | grep "erf²(1.0) = 0.7101"

.PHONY: all clean env blankslate test
