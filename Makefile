# The main rules to use in the make file:
# - `make`: Builds the original ROM
# - `make modern`: Builds the ROM using a modern toolchain
# - `make clean`: Removes every build file except `tools` (use `make clean-tools`). May be the solution when you find an non-obvious error while building.
# - `make compare`: Will check the ROM against a known dump to confirm if they are identical. Agbcc/Legacy ROM only.
# Special variables can be set using `make <targets> VAR=value`:
# - `DINFO=1`: Enables debug info on output files.
# - `O_LEVEL=...`: (Default = 2) Set an optimisation level for the C compiler. Modern only. Refer to the GCC manual for more details.
# - `NODEP=1`: FIXME: Not entirely sure what this does. Presumably: Build the ROM without verifying all assets exist. Increases build speed, but certain edits will not work.

# Other tips:
# - It's a good idea to `make` multiple things at once in line with your cpu core count. Use `make -jN <rules>`.
# - Tabs and Spaces mean different things when editing makefiles - you should make indentation visible in your editor.

# GBA rom header
TITLE       := POKEMON EMER
GAME_CODE   := BPEE
MAKER_CODE  := 01
REVISION    := 0

# `File name`.gba ('_modern' will be appended to the modern builds)
FILE_NAME := pokeemerald
BUILD_DIR := build

# Builds the ROM using a modern compiler
MODERN      ?= 0
ifeq (modern,$(MAKECMDGOALS))
  MODERN := 1
endif

# don't use dkP's base_tools anymore
# because the redefinition of $(CC) conflicts
# with when we want to use $(CC) to preprocess files
# thus, manually create the variables for the bin
# files, or use arm-none-eabi binaries on the system
# if dkP is not installed on this system
TOOLCHAIN := $(DEVKITARM)
ifneq (,$(TOOLCHAIN))
  ifneq ($(wildcard $(TOOLCHAIN)/bin),)
    export PATH := $(TOOLCHAIN)/bin:$(PATH)
  endif
endif

PREFIX := arm-none-eabi-
OBJCOPY := $(PREFIX)objcopy
OBJDUMP := $(PREFIX)objdump
AS := $(PREFIX)as
LD := $(PREFIX)ld

EXE :=
ifeq ($(OS),Windows_NT)
  EXE := .exe
endif

# Pick C++ preprocessor
CPP := $(PREFIX)cpp
ifeq ($(MODERN),0)
  ifneq ($(shell uname -s),Darwin)
    # we can't unconditionally use arm-none-eabi-cpp
    # as installations which install binutils-arm-none-eabi
    # don't come with it
    CPP := $(CC) -E
  endif
endif

SHELL := /bin/bash -o pipefail

# Assign useful variables
LEGACY_ROM_NAME := $(FILE_NAME).gba
LEGACY_OBJ_DIR_NAME := $(BUILD_DIR)/emerald

MODERN_ROM_NAME := $(FILE_NAME)_modern.gba
MODERN_OBJ_DIR_NAME := $(BUILD_DIR)/modern

# Shared dir for asset files, (not finalised .o files).
ASSETS_OBJ_DIR := $(BUILD_DIR)/assets

# Pick our chosen variables
ifeq ($(MODERN),0)
  ROM := $(LEGACY_ROM_NAME)
  OBJ_DIR := $(LEGACY_OBJ_DIR_NAME)
else
  ROM := $(MODERN_ROM_NAME)
  OBJ_DIR := $(MODERN_OBJ_DIR_NAME)
endif
ELF := $(ROM:.gba=.elf)
MAP := $(ROM:.gba=.map)
SYM := $(ROM:.gba=.sym)

# Paths
C_SUBDIR = src
GFLIB_SUBDIR = gflib
ASM_SUBDIR = asm
DATA_SRC_SUBDIR = src/data
DATA_ASM_SUBDIR = data
SONG_SUBDIR = sound/songs
MID_SUBDIR = sound/songs/midi

C_BUILDDIR = $(OBJ_DIR)/$(C_SUBDIR)
GFLIB_BUILDDIR = $(OBJ_DIR)/$(GFLIB_SUBDIR)
ASM_BUILDDIR = $(OBJ_DIR)/$(ASM_SUBDIR)
DATA_ASM_BUILDDIR = $(OBJ_DIR)/$(DATA_ASM_SUBDIR)
SONG_BUILDDIR = $(OBJ_DIR)/$(SONG_SUBDIR)
MID_BUILDDIR = $(OBJ_DIR)/$(MID_SUBDIR)

# Flags
ASFLAGS := -mcpu=arm7tdmi --defsym MODERN=$(MODERN)
LDFLAGS := -Map ../../$(MAP)

INCLUDE_DIRS := include $(ASSETS_OBJ_DIR)/include
INCLUDE_CPP := $(INCLUDE_DIRS:%=-iquote %)
INCLUDE_FLAGS = $(INCLUDE_DIRS:%=-I %)

CPPFLAGS := $(INCLUDE_CPP) -iquote $(GFLIB_SUBDIR) -Wno-trigraphs -DMODERN=$(MODERN)
ifeq ($(MODERN),0)
  CC1             := tools/agbcc/bin/agbcc$(EXE)
  override CFLAGS += -mthumb-interwork -Wimplicit -Wparentheses -Werror -O2 -fhex-asm -g
  LIBPATH := -L ../../tools/agbcc/lib
  LIB := $(LIBPATH) -lgcc -lc -L../../libagbsyscall -lagbsyscall
  CPPFLAGS += -I tools/agbcc/include -I tools/agbcc -nostdinc -undef
else
  MODERNCC := $(PREFIX)gcc
  PATH_MODERNCC := PATH="$(PATH)" $(MODERNCC)
  CC1              = $(shell $(PATH_MODERNCC) --print-prog-name=cc1) -quiet
  O_LEVEL ?= 2
  override CFLAGS += -mthumb -mthumb-interwork -O$(O_LEVEL) -mabi=apcs-gnu -mtune=arm7tdmi -march=armv4t -fno-toplevel-reorder -Wno-pointer-to-int-cast
  LIBPATH := -L "$(dir $(shell $(PATH_MODERNCC) -mthumb -print-file-name=libgcc.a))" -L "$(dir $(shell $(PATH_MODERNCC) -mthumb -print-file-name=libnosys.a))" -L "$(dir $(shell $(PATH_MODERNCC) -mthumb -print-file-name=libc.a))"
  LIB := $(LIBPATH) -lc -lnosys -lgcc -L../../libagbsyscall -lagbsyscall
endif

# Default rule
all: rom

# C files to be created in assets/include/generated
AUTO_GEN_TARGETS :=
include make_tools.mk
include codegen_rules.mk
# Tool Executables
SHA1 := $(shell { command -v sha1sum || command -v shasum; } 2>/dev/null) -c
GFX := $(TOOLS_DIR)/gbagfx/gbagfx$(EXE)
AIF := $(TOOLS_DIR)/aif2pcm/aif2pcm$(EXE)
MID := $(TOOLS_DIR)/mid2agb/mid2agb$(EXE)
SCANINC := $(TOOLS_DIR)/scaninc/scaninc$(EXE)
PREPROC := $(TOOLS_DIR)/preproc/preproc$(EXE)
RAMSCRGEN := $(TOOLS_DIR)/ramscrgen/ramscrgen$(EXE)
FIX := $(TOOLS_DIR)/gbafix/gbafix$(EXE)
MAPJSON := $(TOOLS_DIR)/mapjson/mapjson$(EXE)
JSONPROC := $(TOOLS_DIR)/jsonproc/jsonproc$(EXE)
PERL := perl

MAKEFLAGS += --no-print-directory

# Special targets
RULES_NO_SCAN += clean-all clean clean-assets clean-assets-old tidy tidymodern tidynonmodern libagbsyscall generated clean-generated
.PHONY: all rom modern compare
.PHONY: $(RULES_NO_SCAN)

# Clear the default suffixes
.SUFFIXES:
# Don't delete intermediate files
.SECONDARY:
# Delete files that weren't built properly
.DELETE_ON_ERROR:

infoshell = $(foreach line, $(shell $1 | sed "s/ /__SPACE__/g"), $(info $(subst __SPACE__, ,$(line))))

# Check if we need to scan dependencies based on the chosen rule OR user preference
NODEP ?= 0
# Check if we need to setup tools and generated assets based on the chosen rule.
SETUP_PREREQS ?= 1
ifneq (,$(MAKECMDGOALS))
  ifeq (,$(filter-out $(RULES_NO_SCAN),$(MAKECMDGOALS)))
    # $(info No Scan)
    NODEP := 1
    SETUP_PREREQS := 0
  endif
endif
ifeq ($(SETUP_PREREQS),1)
  # Set on: Default target, a rule requiring a scan, or manually turned off
  # $(info Scan)
  # Forcibly execute `make tools` since we need them for what we are doing.
  $(call infoshell, $(MAKE) -f make_tools.mk)
  # Oh and also generate sources before we use `SCANINC` later on.
  $(call infoshell, $(MAKE) generated)
endif

ifneq ($(NODEP),1)
  C_SRCS_IN := $(wildcard $(C_SUBDIR)/*.c $(C_SUBDIR)/*/*.c $(C_SUBDIR)/*/*/*.c)
  C_SRCS := $(foreach src,$(C_SRCS_IN),$(if $(findstring .inc.c,$(src)),,$(src)))
  C_OBJS := $(patsubst $(C_SUBDIR)/%.c,$(C_BUILDDIR)/%.o,$(C_SRCS))

  GFLIB_SRCS := $(wildcard $(GFLIB_SUBDIR)/*.c)
  GFLIB_OBJS := $(patsubst $(GFLIB_SUBDIR)/%.c,$(GFLIB_BUILDDIR)/%.o,$(GFLIB_SRCS))

  C_ASM_SRCS := $(wildcard $(C_SUBDIR)/*.s $(C_SUBDIR)/*/*.s $(C_SUBDIR)/*/*/*.s)
  C_ASM_OBJS := $(patsubst $(C_SUBDIR)/%.s,$(C_BUILDDIR)/%.o,$(C_ASM_SRCS))

  ASM_SRCS := $(wildcard $(ASM_SUBDIR)/*.s)
  ASM_OBJS := $(patsubst $(ASM_SUBDIR)/%.s,$(ASM_BUILDDIR)/%.o,$(ASM_SRCS))

  # get all the data/*.s files EXCEPT the ones with specific rules
  # Some specific files are included in codegen_rules
  REGULAR_DATA_ASM_SRCS := $(filter-out $(DATA_ASM_SUBDIR)/maps.s $(DATA_ASM_SUBDIR)/map_events.s, $(wildcard $(DATA_ASM_SUBDIR)/*.s))

  DATA_ASM_SRCS := $(wildcard $(DATA_ASM_SUBDIR)/*.s)
  DATA_ASM_OBJS := $(patsubst $(DATA_ASM_SUBDIR)/%.s,$(DATA_ASM_BUILDDIR)/%.o,$(DATA_ASM_SRCS))

  SONG_SRCS := $(wildcard $(SONG_SUBDIR)/*.s)
  SONG_OBJS := $(patsubst $(SONG_SUBDIR)/%.s,$(SONG_BUILDDIR)/%.o,$(SONG_SRCS))

  MID_SRCS := $(wildcard $(MID_SUBDIR)/*.mid)
  MID_OBJS := $(patsubst $(MID_SUBDIR)/%.mid,$(MID_BUILDDIR)/%.o,$(MID_SRCS))

  OBJS     := $(C_OBJS) $(GFLIB_OBJS) $(C_ASM_OBJS) $(ASM_OBJS) $(DATA_ASM_OBJS) $(SONG_OBJS) $(MID_OBJS)
  OBJS_REL := $(patsubst $(OBJ_DIR)/%,%,$(OBJS))

  SUBDIRS  := $(sort $(dir $(OBJS)))
  $(shell mkdir -p $(SUBDIRS))
endif

# Main rules
modern: all
compare: all
	@$(SHA1) rom.sha1

syms: $(SYM)

rom: $(ROM)

clean-all: clean clean-tools

clean: tidy clean-assets
	@$(MAKE) clean -C libagbsyscall

clean-assets:
	-rm -rf $(ASSETS_OBJ_DIR)

# To be used for those upgrading from before the `build/assets` switch
clean-assets-old:
	-rm -f sound/direct_sound_samples/*.bin
	-rm -f sound/direct_sound_samples/cries/*.bin
	-rm -f $(MID_SUBDIR)/*.s
	-find . \( -iname '*.1bpp' -o -iname '*.4bpp' -o -iname '*.8bpp' -o -iname '*.gbapal' -o -iname '*.lz' -o -iname '*.rl' -o -iname '*.latfont' -o -iname '*.hwjpnfont' -o -iname '*.fwjpnfont' \) -exec rm {} +
	-rm -f $(DATA_ASM_SUBDIR)/layouts/layouts.inc $(DATA_ASM_SUBDIR)/layouts/layouts_table.inc
	-rm -f $(DATA_ASM_SUBDIR)/maps/connections.inc $(DATA_ASM_SUBDIR)/maps/events.inc $(DATA_ASM_SUBDIR)/maps/groups.inc $(DATA_ASM_SUBDIR)/maps/headers.inc
	-find $(DATA_ASM_SUBDIR)/maps \( -iname 'connections.inc' -o -iname 'events.inc' -o -iname 'header.inc' \) -exec rm {} +

tidy: tidynonmodern tidymodern

tidynonmodern:
	-rm -f $(LEGACY_ROM_NAME) $(LEGACY_ROM_NAME:.gba=.elf) $(LEGACY_ROM_NAME:.gba=.map)
	-rm -rf $(LEGACY_OBJ_DIR_NAME)

tidymodern:
	-rm -f $(MODERN_ROM_NAME) $(MODERN_ROM_NAME:.gba=.elf) $(MODERN_ROM_NAME:.gba=.map)
	-rm -rf $(MODERN_OBJ_DIR_NAME)

include graphics_rules.mk
include spritesheet_rules.mk
include audio_rules.mk
include assets.mk

# Note, if you do not have Make 4.4, there's no guarantee this will work correctly when making in parallel. You may need to run `make tools` first.
generated: tools .WAIT $(AUTO_GEN_TARGETS)
clean-generated:
	-rm -f $(AUTO_GEN_TARGETS)

# Modify build flags for some files.
ifeq ($(MODERN),0)
$(C_BUILDDIR)/libc.o: CC1 := tools/agbcc/bin/old_agbcc$(EXE)
$(C_BUILDDIR)/libc.o: CFLAGS := -O2
$(C_BUILDDIR)/siirtc.o: CFLAGS := -mthumb-interwork
$(C_BUILDDIR)/agb_flash.o: CFLAGS := -O -mthumb-interwork
$(C_BUILDDIR)/agb_flash_1m.o: CFLAGS := -O -mthumb-interwork
$(C_BUILDDIR)/agb_flash_mx.o: CFLAGS := -O -mthumb-interwork
$(C_BUILDDIR)/m4a.o: CC1 := tools/agbcc/bin/old_agbcc$(EXE)
$(C_BUILDDIR)/record_mixing.o: CFLAGS += -ffreestanding
$(C_BUILDDIR)/librfu_intr.o: CC1 := tools/agbcc/bin/agbcc_arm$(EXE)
$(C_BUILDDIR)/librfu_intr.o: CFLAGS := -O2 -mthumb-interwork -quiet
else
$(C_BUILDDIR)/librfu_intr.o: CFLAGS := -Wno-pointer-to-int-cast
$(C_BUILDDIR)/berry_crush.o: override CFLAGS += -Wno-address-of-packed-member
endif

# Add debug info if flag set
ifeq ($(DINFO),1)
  override CFLAGS += -g
endif

# Dependency searching rules (*.c & .s)
# The dep rules have to be explicit or else missing files won't be reported.
# As a side effect, they're evaluated immediately instead of when the rule is invoked.
# It doesn't look like $(shell) can be deferred so there might not be a better way.

# C sources
ifeq ($(NODEP),1)
$(C_BUILDDIR)/%.o: $(C_SUBDIR)/%.c
ifeq (,$(KEEP_TEMPS))
	@echo "$(CC1) <flags> -o $@ $<"
	@$(CPP) $(CPPFLAGS) $< | $(PREPROC) $< charmap.txt -i | $(CC1) $(CFLAGS) -o - - | cat - <(echo -e ".text\n\t.align\t2, 0") | $(AS) $(ASFLAGS) -o $@ -
else
	@$(CPP) $(CPPFLAGS) $< -o $(C_BUILDDIR)/$*.i
	@$(PREPROC) $(C_BUILDDIR)/$*.i charmap.txt | $(CC1) $(CFLAGS) -o $(C_BUILDDIR)/$*.s
	@echo -e ".text\n\t.align\t2, 0\n" >> $(C_BUILDDIR)/$*.s
	$(AS) $(ASFLAGS) -o $@ $(C_BUILDDIR)/$*.s
endif
$(GFLIB_BUILDDIR)/%.o: $(GFLIB_SUBDIR)/%.c
ifeq (,$(KEEP_TEMPS))
	@echo "$(CC1) <flags> -o $@ $<"
	@$(CPP) $(CPPFLAGS) $< | $(PREPROC) $< charmap.txt -i | $(CC1) $(CFLAGS) -o - - | cat - <(echo -e ".text\n\t.align\t2, 0") | $(AS) $(ASFLAGS) -o $@ -
else
	@$(CPP) $(CPPFLAGS) $< -o $(GFLIB_BUILDDIR)/$*.i
	@$(PREPROC) $(GFLIB_BUILDDIR)/$*.i charmap.txt | $(CC1) $(CFLAGS) -o $(GFLIB_BUILDDIR)/$*.s
	@echo -e ".text\n\t.align\t2, 0\n" >> $(GFLIB_BUILDDIR)/$*.s
	$(AS) $(ASFLAGS) -o $@ $(GFLIB_BUILDDIR)/$*.s
endif
else
define C_DEP
$1: $2 $3 $$(shell $(SCANINC) $(INCLUDE_FLAGS) -I tools/agbcc/include -I gflib $2)
ifeq (,$$(KEEP_TEMPS))
	@echo "$$(CC1) <flags> -o $$@ $$<"
	@$$(CPP) $$(CPPFLAGS) $$< | $$(PREPROC) $$< charmap.txt -i | $$(CC1) $$(CFLAGS) -o - - | cat - <(echo -e ".text\n\t.align\t2, 0") | $$(AS) $$(ASFLAGS) -o $$@ -
else
	@$$(CPP) $$(CPPFLAGS) $$< -o $3/$4.i
	@$$(PREPROC) $3/$4.i charmap.txt | $$(CC1) $$(CFLAGS) -o $3/$4.s
	@echo -e ".text\n\t.align\t2, 0\n" >> $3/$4.s
	$$(AS) $$(ASFLAGS) -o $$@ $3/$4.s
endif
endef
$(foreach src, $(C_SRCS), $(eval $(call C_DEP,$(patsubst $(C_SUBDIR)/%.c,$(C_BUILDDIR)/%.o,$(src)),$(src),$(C_BUILDDIR),$(patsubst $(C_SUBDIR)/%.c,%,$(src)))))
$(foreach src, $(GFLIB_SRCS), $(eval $(call C_DEP,$(patsubst $(GFLIB_SUBDIR)/%.c,$(GFLIB_BUILDDIR)/%.o, $(src)),$(src),$(GFLIB_BUILDDIR),$(patsubst $(GFLIB_SUBDIR)/%.c,%, $(src)))))
endif

# Assembly sources
ifeq ($(NODEP),1)
$(C_BUILDDIR)/%.o: $(C_SUBDIR)/%.s
	$(PREPROC) $< charmap.txt | $(CPP) $(INCLUDE_FLAGS) - | $(AS) $(ASFLAGS) -o $@
$(ASM_BUILDDIR)/%.o: $(ASM_SUBDIR)/%.s
	$(AS) $(ASFLAGS) -o $@ $<
$(DATA_ASM_BUILDDIR)/%.o: $(DATA_ASM_SUBDIR)/%.s
	$(PREPROC) $< charmap.txt | $(CPP) $(INCLUDE_FLAGS) - | $(AS) $(ASFLAGS) -o $@
else
define SRC_ASM_DATA_DEP
$1: $2 $$(shell $(SCANINC) $(INCLUDE_FLAGS) -I "" $2)
	$$(PREPROC) $$< charmap.txt | $$(CPP) $(INCLUDE_FLAGS) - | $$(AS) $$(ASFLAGS) -o $$@
endef
$(foreach src, $(C_ASM_SRCS), $(eval $(call SRC_ASM_DATA_DEP,$(patsubst $(C_SUBDIR)/%.s,$(C_BUILDDIR)/%.o, $(src)),$(src))))
define ASM_DEP
$1: $2 $$(shell $(SCANINC) $(INCLUDE_FLAGS) -I "" $2)
	$$(AS) $$(ASFLAGS) -o $$@ $$<
endef
$(foreach src, $(ASM_SRCS), $(eval $(call ASM_DEP,$(patsubst $(ASM_SUBDIR)/%.s,$(ASM_BUILDDIR)/%.o, $(src)),$(src))))

$(foreach src, $(REGULAR_DATA_ASM_SRCS), $(eval $(call SRC_ASM_DATA_DEP,$(patsubst $(DATA_ASM_SUBDIR)/%.s,$(DATA_ASM_BUILDDIR)/%.o, $(src)),$(src))))
endif

# Linker script generation
$(OBJ_DIR)/sym_bss.ld: sym_bss.txt
	$(RAMSCRGEN) .bss $< ENGLISH > $@

$(OBJ_DIR)/sym_common.ld: sym_common.txt $(C_OBJS) $(wildcard common_syms/*.txt)
	$(RAMSCRGEN) COMMON $< ENGLISH -c $(C_BUILDDIR),common_syms > $@

$(OBJ_DIR)/sym_ewram.ld: sym_ewram.txt
	$(RAMSCRGEN) ewram_data $< ENGLISH > $@

ifeq ($(MODERN),0)
  LD_SCRIPT := ld_script.ld
  LD_SCRIPT_DEPS := $(OBJ_DIR)/sym_bss.ld $(OBJ_DIR)/sym_common.ld $(OBJ_DIR)/sym_ewram.ld
else
  LD_SCRIPT := ld_script_modern.ld
  LD_SCRIPT_DEPS :=
endif

$(OBJ_DIR)/ld_script.ld: $(LD_SCRIPT) $(LD_SCRIPT_DEPS)
	cd $(OBJ_DIR) && sed "s#tools/#../../tools/#g" ../../$(LD_SCRIPT) > ld_script.ld

# GBA .elf
libagbsyscall:
	@$(MAKE) -C libagbsyscall TOOLCHAIN=$(TOOLCHAIN) MODERN=$(MODERN)

$(ELF): $(OBJ_DIR)/ld_script.ld $(OBJS) libagbsyscall
	@echo "cd $(OBJ_DIR) && $(LD) $(LDFLAGS) -T ld_script.ld -o ../../$@ <objects> <lib>"
	@cd $(OBJ_DIR) && $(LD) $(LDFLAGS) -T ld_script.ld -o ../../$@ $(OBJS_REL) $(LIB)
	$(FIX) $@ -t"$(TITLE)" -c$(GAME_CODE) -m$(MAKER_CODE) -r$(REVISION) --silent

# Building the ROM
$(ROM): $(ELF)
	$(OBJCOPY) -O binary $< $@
	$(FIX) $@ -p --silent

# Symbol file (`make syms`)
$(SYM): $(ELF)
	$(OBJDUMP) -t $< | sort -u | grep -E "^0[2389]" | $(PERL) -p -e 's/^(\w{8}) (\w).{6} \S+\t(\w{8}) (\S+)$$/\1 \2 \3 \4/g' > $@
