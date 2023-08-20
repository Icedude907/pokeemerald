# These rules catch most assets - with some exceptions (see graphics_file_rules.mk)

%.s: ;
%.png: ;
%.pal: ;
%.aif: ;

%.1bpp: %.png
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