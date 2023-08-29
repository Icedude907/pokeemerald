# TODO: Move files and make good.

# Wild encounters and region map entries data
AUTO_GEN_TARGETS += $(DATA_SRC_SUBDIR)/wild_encounters.h
$(DATA_SRC_SUBDIR)/wild_encounters.h: $(DATA_SRC_SUBDIR)/wild_encounters.json $(DATA_SRC_SUBDIR)/wild_encounters.json.txt
	$(JSONPROC) $^ $@
$(C_BUILDDIR)/wild_encounter.o: c_dep += $(DATA_SRC_SUBDIR)/wild_encounters.h

AUTO_GEN_TARGETS += $(DATA_SRC_SUBDIR)/region_map/region_map_entries.h
$(DATA_SRC_SUBDIR)/region_map/region_map_entries.h: $(DATA_SRC_SUBDIR)/region_map/region_map_sections.json $(DATA_SRC_SUBDIR)/region_map/region_map_sections.json.txt
	$(JSONPROC) $^ $@
$(C_BUILDDIR)/region_map.o: c_dep += $(DATA_SRC_SUBDIR)/region_map/region_map_entries.h

# Map JSON data
MAPS_DIR = $(DATA_ASM_SUBDIR)/maps
LAYOUTS_DIR = $(DATA_ASM_SUBDIR)/layouts
# $(ASSETS_OBJ_DIR)/
MAPS_OUTDIR := $(MAPS_DIR)
LAYOUTS_OUTDIR := $(LAYOUTS_DIR)
INCLUDECONSTS_OUTDIR := include/constants

MAP_DIRS := $(dir $(wildcard $(MAPS_DIR)/*/map.json))
MAP_OUTDIRS := $(patsubst $(MAPS_DIR)/%/, $(MAPS_OUTDIR)/%/, $(MAP_DIRS))
MAP_CONNECTIONS := $(patsubst $(MAPS_OUTDIR)/%/,$(MAPS_OUTDIR)/%/connections.inc,$(MAP_OUTDIRS))
MAP_EVENTS := $(patsubst $(MAPS_OUTDIR)/%/,$(MAPS_OUTDIR)/%/events.inc,$(MAP_OUTDIRS))
MAP_HEADERS := $(patsubst $(MAPS_OUTDIR)/%/,$(MAPS_OUTDIR)/%/header.inc,$(MAP_OUTDIRS))

$(DATA_ASM_BUILDDIR)/maps.o: $(DATA_ASM_SUBDIR)/maps.s \
                             $(LAYOUTS_OUTDIR)/layouts.inc $(LAYOUTS_OUTDIR)/layouts_table.inc \
                             $(MAPS_OUTDIR)/headers.inc $(MAPS_OUTDIR)/groups.inc $(MAPS_OUTDIR)/connections.inc \
                             $(MAP_CONNECTIONS) $(MAP_HEADERS)
	$(PREPROC) $< charmap.txt | $(CPP) $(INCLUDE_CPP) - | $(AS) $(ASFLAGS) -o $@
$(DATA_ASM_BUILDDIR)/map_events.o: $(DATA_ASM_SUBDIR)/map_events.s $(MAPS_OUTDIR)/events.inc $(MAP_EVENTS)
	$(PREPROC) $< charmap.txt | $(CPP) $(INCLUDE_CPP) - | $(AS) $(ASFLAGS) -o $@


$(MAPS_OUTDIR)/%/header.inc $(MAPS_OUTDIR)/%/events.inc $(MAPS_OUTDIR)/%/connections.inc: $(MAPS_DIR)/%/map.json
	@mkdir -p $(@D)
	$(MAPJSON) map emerald $< $(LAYOUTS_DIR)/layouts.json $(@D)

$(MAPS_OUTDIR)/connections.inc $(MAPS_OUTDIR)/groups.inc $(MAPS_OUTDIR)/events.inc $(MAPS_OUTDIR)/headers.inc $(INCLUDECONSTS_OUTDIR)/map_groups.h: $(MAPS_DIR)/map_groups.json
	@mkdir -p $(@D)
	$(MAPJSON) groups emerald $< $(@D) $(INCLUDECONSTS_OUTDIR)

$(LAYOUTS_OUTDIR)/layouts.inc $(LAYOUTS_OUTDIR)/layouts_table.inc $(INCLUDECONSTS_OUTDIR)/layouts.h: $(LAYOUTS_DIR)/layouts.json
	@mkdir -p $(@D)
	$(MAPJSON) layouts emerald $< $(@D) $(INCLUDECONSTS_OUTDIR)