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

MAP_DIRS := $(dir $(wildcard $(MAPS_DIR)/*/map.json))
MAP_CONNECTIONS := $(patsubst $(MAPS_DIR)/%/,$(MAPS_DIR)/%/connections.inc,$(MAP_DIRS))
MAP_EVENTS := $(patsubst $(MAPS_DIR)/%/,$(MAPS_DIR)/%/events.inc,$(MAP_DIRS))
MAP_HEADERS := $(patsubst $(MAPS_DIR)/%/,$(MAPS_DIR)/%/header.inc,$(MAP_DIRS))

$(DATA_ASM_BUILDDIR)/maps.o: $(DATA_ASM_SUBDIR)/maps.s $(LAYOUTS_DIR)/layouts.inc $(LAYOUTS_DIR)/layouts_table.inc $(MAPS_DIR)/headers.inc $(MAPS_DIR)/groups.inc $(MAPS_DIR)/connections.inc $(MAP_CONNECTIONS) $(MAP_HEADERS)
	$(PREPROC) $< charmap.txt | $(CPP) -I include - | $(AS) $(ASFLAGS) -o $@
$(DATA_ASM_BUILDDIR)/map_events.o: $(DATA_ASM_SUBDIR)/map_events.s $(MAPS_DIR)/events.inc $(MAP_EVENTS)
	$(PREPROC) $< charmap.txt | $(CPP) -I include - | $(AS) $(ASFLAGS) -o $@

$(MAPS_DIR)/%/header.inc: $(MAPS_DIR)/%/map.json
	$(MAPJSON) map emerald $< $(LAYOUTS_DIR)/layouts.json
$(MAPS_DIR)/%/events.inc: $(MAPS_DIR)/%/header.inc ;
$(MAPS_DIR)/%/connections.inc: $(MAPS_DIR)/%/events.inc ;

$(MAPS_DIR)/groups.inc: $(MAPS_DIR)/map_groups.json
	$(MAPJSON) groups emerald $<
$(MAPS_DIR)/connections.inc: $(MAPS_DIR)/groups.inc ;
$(MAPS_DIR)/events.inc: $(MAPS_DIR)/connections.inc ;
$(MAPS_DIR)/headers.inc: $(MAPS_DIR)/events.inc ;
include/constants/map_groups.h: $(MAPS_DIR)/headers.inc ;

$(LAYOUTS_DIR)/layouts.inc: $(LAYOUTS_DIR)/layouts.json
	$(MAPJSON) layouts emerald $<
$(LAYOUTS_DIR)/layouts_table.inc: $(LAYOUTS_DIR)/layouts.inc ;
include/constants/layouts.h: $(LAYOUTS_DIR)/layouts_table.inc ;
