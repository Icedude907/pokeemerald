# These rules catch most assets - with some exceptions (see graphics_file_rules.mk)

%.s: ;
%.png: ;
%.pal: ;
%.aif: ;

# Off to the assets folder you go
$(ASSETS_OBJ_DIR)/%.1bpp: %.png
	mkdir -p $(@D)
	$(GFX) $< $@
%.4bpp: %.png
	$(GFX) $< $@
%.8bpp: %.png
	$(GFX) $< $@
%.gbapal: %.pal
	$(GFX) $< $@
%.gbapal: %.png
	$(GFX) $< $@
%.lz: %
	$(GFX) $< $@
%.rl: %
	$(GFX) $< $@