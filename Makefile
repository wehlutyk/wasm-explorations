DOCKER_IMAGE_VERSION := 0.2.0
DOCKER_IMAGE := wehlutyk/wasm-compiler:$(DOCKER_IMAGE_VERSION)
STEPS := $(sort $(wildcard */foo))
STEPS_BUILD := $(foreach step,$(STEPS),$(step)/.BUILD)
STEPS_CLEAN := $(foreach step,$(STEPS),$(step)/.CLEAN)
STEPS_ENV := $(foreach step,$(STEPS),$(step)/.ENV)
STEPS_TEST := $(foreach step,$(STEPS),$(step)/.TEST)

all: $(STEPS_BUILD)

clean: $(STEPS_CLEAN)

docker:
	docker build --rm --tag $(DOCKER_IMAGE) .
	docker push $(DOCKER_IMAGE)

env: $(STEPS_ENV)
	-cargo install wasm-bindgen-cli

update-wasm-bindgen:
	cargo install -f wasm-bindgen-cli

test: $(STEPS_TEST)

$(STEPS_BUILD):
	$(MAKE) -C $(@D)

$(STEPS_CLEAN):
	$(MAKE) -C $(@D) clean

$(STEPS_ENV):
	$(MAKE) -C $(@D) env

$(STEPS_TEST):
	$(MAKE) -C $(@D) test

.PHONY: all clean docker env update-wasm-bindgen test $(STEPS_BUILD) $(STEPS_CLEAN) $(STEPS_ENV) $(STEPS_TEST)
