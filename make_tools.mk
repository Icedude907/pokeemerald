
MAKEFLAGS += --no-print-directory

# Inclusive list. If you don't want a tool to be built, don't add it here.
TOOLS_DIR := tools
TOOL_NAMES := aif2pcm bin2c gbafix gbagfx jsonproc mapjson mid2agb preproc ramscrgen rsfont scaninc

TOOLDIRS := $(TOOL_NAMES:%=$(TOOLS_DIR)/%)

.PHONY: tools check-tools clean-tools $(TOOLDIRS) $(CHECKTOOLDIRS)
# Tool making doesnt require a pokeemerald dependency scan.
RULES_NO_SCAN += tools check-tools clean-tools $(TOOLDIRS) $(CHECKTOOLDIRS)

tools: $(TOOLDIRS)
check-tools: $(CHECKTOOLDIRS)

$(TOOLDIRS):
	@$(MAKE) -C $@

$(CHECKTOOLDIRS):
	@$(MAKE) -C $@

clean-tools:
	@$(foreach tooldir,$(TOOLDIRS),$(MAKE) clean -C $(tooldir);)
