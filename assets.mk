# These rules catch most assets - some exceptions (see graphics_file_rules.mk)

%.s: ;
%.png: ;
%.pal: ;
%.aif: ;

# Off to the assets folder you go
# FIXME: Lots of mkdir
$(ASSETS_OBJ_DIR)/%.1bpp: %.png
	@mkdir -p $(@D)
	$(GFX) $< $@
$(ASSETS_OBJ_DIR)/%.4bpp: %.png
	@mkdir -p $(@D)
	$(GFX) $< $@
$(ASSETS_OBJ_DIR)/%.8bpp: %.png
	@mkdir -p $(@D)
	$(GFX) $< $@
%.gbapal: %.pal
	$(GFX) $< $@
# Derives the palette from the image in the absence of a .pal file
%.gbapal: %.png
	$(GFX) $< $@

# These rules are cool. Because make can extract linked files from your source code,
# if you put `.lz` on the end of a filename it'll be automatically compressed!
%.lz: %
	$(GFX) $< $@
%.rl: %
	$(GFX) $< $@