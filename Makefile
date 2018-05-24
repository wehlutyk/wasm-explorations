STEPS := $(sort $(wildcard */foo))
STEPS_BUILD := $(foreach step,$(STEPS),$(step)/.BUILD)
STEPS_CLEAN := $(foreach step,$(STEPS),$(step)/.CLEAN)
STEPS_ENV := $(foreach step,$(STEPS),$(step)/.ENV)

all: $(STEPS_BUILD)

clean: $(STEPS_CLEAN)

env: $(STEPS_ENV)
	-cargo install wasm-bindgen-cli

update-wasm-bindgen:
	cargo install -f wasm-bindgen-cli

$(STEPS_BUILD):
	$(MAKE) -C $(@D)

$(STEPS_CLEAN):
	$(MAKE) -C $(@D) clean

$(STEPS_ENV):
	$(MAKE) -C $(@D) env

.PHONY: all env update-wasm-bindgen $(STEPS_BUILD) $(STEPS_ENV)
