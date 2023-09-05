# This file contains rules for making most audio files in the game.

CRY_SUBDIR = sound/direct_sound_samples/cries

MID_ASM_DIR = $(ASSETS_OBJ_DIR)/$(MID_SUBDIR)
CRY_BIN_DIR = $(ASSETS_OBJ_DIR)/$(CRY_SUBDIR)
SOUND_BIN_DIR = $(ASSETS_OBJ_DIR)/sound
PHONEMES_BIN_DIR = $(ASSETS_OBJ_DIR)/sound/direct_sound_samples/phonemes
CRIES_BIN_DIR = $(ASSETS_OBJ_DIR)/sound/direct_sound_samples/cries

SPECIAL_OUTDIRS := $(MID_ASM_DIR) $(CRY_BIN_DIR) $(SOUND_BIN_DIR) $(PHONEMES_BIN_DIR) $(CRIES_BIN_DIR)
$(shell mkdir -p $(SPECIAL_OUTDIRS) )

# `.mid` assembly song compilation
$(MID_BUILDDIR)/%.o: $(MID_ASM_DIR)/%.s
	$(AS) $(ASFLAGS) -I sound -o $@ $<

# `midi.cfg` rule expansion
MID_CFG_PATH := $(MID_SUBDIR)/$(notdir $(MID_SUBDIR)).cfg
# $1: Source path no extension, $2 Options
define MID_RULE
$(MID_ASM_DIR)/$1.s: $(MID_SUBDIR)/$1.mid
	$(MID) $$< $$@ $2
endef
define MID_EXPANSION
	$(eval $(call MID_RULE,$(basename $(patsubst %:,%,$(word 1,$1))),$(wordlist 2,999,$1)))
endef
$(foreach line,$(shell cat $(MID_CFG_PATH) | sed "s/ /__SPACE__/g"),$(call MID_EXPANSION,$(subst __SPACE__, ,$(line))))

# Warn users building without a .cfg - build will fail at link time
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