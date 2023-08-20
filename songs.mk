
MID_ASM_DIR = $(ASSETS_OBJ_DIR)/$(MID_SUBDIR)
$(shell mkdir -p $(MID_ASM_DIR))

# Universal build
$(MID_BUILDDIR)/%.o: $(MID_ASM_DIR)/%.s
	$(AS) $(ASFLAGS) -I sound -o $@ $<

# Midi files *must* have an associated .cfg file, which is just command line arguments passed into `mid2agb`
$(MID_ASM_DIR)/%.s: $(MID_SUBDIR)/%.mid $(MID_SUBDIR)/%.cfg
	$(MID) $< $@ $(file < $(word 2,$^))

# Fallback for .mid without .cfg
$(MID_ASM_DIR)/%.s: $(MID_SUBDIR)/%.mid
	$(warning $< does not have an associated .cfg file! It cannot be built)
