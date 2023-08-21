
MID_ASM_DIR = $(ASSETS_OBJ_DIR)/$(MID_SUBDIR)
CRY_BIN_DIR = $(ASSETS_OBJ_DIR)/$(CRY_SUBDIR)
SOUND_BIN_DIR = $(ASSETS_OBJ_DIR)/sound
PHONEMES_BIN_DIR = $(ASSETS_OBJ_DIR)/sound/direct_sound_samples/phonemes

# TODO: Improve mkdir
SPECIAL_OUTDIRS := $(MID_ASM_DIR) $(CRY_BIN_DIR) $(SOUND_BIN_DIR) $(PHONEMES_BIN_DIR)
$(shell mkdir -p $(SPECIAL_OUTDIRS) )

# `.mid` assembly song compilation
$(MID_BUILDDIR)/%.o: $(MID_ASM_DIR)/%.s
	$(AS) $(ASFLAGS) -I sound -o $@ $<

# Midi files *must* have an associated .cfg file, which is just command line arguments passed into `mid2agb`
$(MID_ASM_DIR)/%.s: $(MID_SUBDIR)/%.mid $(MID_SUBDIR)/%.cfg
	$(MID) $< $@ $(file < $(word 2,$^))

# Warn users building without a .cfg - build will most likely fail later
$(MID_ASM_DIR)/%.s: $(MID_SUBDIR)/%.mid
	$(warning $< does not have an associated .cfg file! It cannot be built)

# Build sound samples (compress cries)
$(CRY_BIN_DIR)/%.bin: $(CRY_SUBDIR)/%.aif
	$(AIF) $< $@ --compress

# Build sound samples (uncompressed by default)
$(SOUND_BIN_DIR)/%.bin: sound/%.aif
	$(AIF) $< $@

# Assembly song compilation
$(SONG_BUILDDIR)/%.o: $(SONG_SUBDIR)/%.s
	$(AS) $(ASFLAGS) -I sound -o $@ $<