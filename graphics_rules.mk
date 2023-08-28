CASTFORMGFXDIR := graphics/pokemon/castform
TILESETGFXDIR := data/tilesets
FONTGFXDIR := graphics/fonts
INTERFACEGFXDIR := graphics/interface
BTLANMSPRGFXDIR := graphics/battle_anims/sprites
UNUSEDGFXDIR := graphics/unused
UNKNOWNGFXDIR := graphics/unknown
BATINTGFXDIR := graphics/battle_interface
MASKSGFXDIR := graphics/battle_anims/masks
BATTRANSGFXDIR := graphics/battle_transitions
TYPESGFXDIR := graphics/types
RAYQUAZAGFXDIR := graphics/rayquaza_scene
ROULETTEGFXDIR := graphics/roulette
SLOTMACHINEGFXDIR := graphics/slot_machine
PKNAVGFXDIR := graphics/pokenav
PKNAVOPTIONSGFXDIR := graphics/pokenav/options
WALLPAPERGFXDIR := graphics/pokemon_storage/wallpapers
OBJEVENTGFXDIR := graphics/object_events
MISCGFXDIR := graphics/misc
JPCONTESTGFXDIR := graphics/contest/japanese
POKEDEXGFXDIR := graphics/pokedex
STARTERGFXDIR := graphics/starter_choose
NAMINGGFXDIR := graphics/naming_screen
SPINDAGFXDIR := graphics/pokemon/spinda/spots
PARTYMENUGFXDIR := graphics/party_menu

types := normal fight flying poison ground rock bug ghost steel mystery fire water grass electric psychic ice dragon dark
contest_types := cool beauty cute smart tough

# Output folders
CASTFORM_OUTDIR     := $(ASSETS_OBJ_DIR)/$(CASTFORMGFXDIR)
TILESET_OUTDIR      := $(ASSETS_OBJ_DIR)/$(TILESETGFXDIR)
FONT_OUTDIR         := $(ASSETS_OBJ_DIR)/$(FONTGFXDIR)
INTERFACE_OUTDIR    := $(ASSETS_OBJ_DIR)/$(INTERFACEGFXDIR)
BTLANMSPR_OUTDIR    := $(ASSETS_OBJ_DIR)/$(BTLANMSPRGFXDIR)
UNUSED_OUTDIR       := $(ASSETS_OBJ_DIR)/$(UNUSEDGFXDIR)
UNKNOWN_OUTDIR      := $(ASSETS_OBJ_DIR)/$(UNKNOWNGFXDIR)
BATINT_OUTDIR       := $(ASSETS_OBJ_DIR)/$(BATINTGFXDIR)
MASKS_OUTDIR        := $(ASSETS_OBJ_DIR)/$(MASKSGFXDIR)
BATTRANS_OUTDIR     := $(ASSETS_OBJ_DIR)/$(BATTRANSGFXDIR)
TYPES_OUTDIR        := $(ASSETS_OBJ_DIR)/$(TYPESGFXDIR)
RAYQUAZA_OUTDIR     := $(ASSETS_OBJ_DIR)/$(RAYQUAZAGFXDIR)
ROULETTE_OUTDIR     := $(ASSETS_OBJ_DIR)/$(ROULETTEGFXDIR)
SLOTMACHINE_OUTDIR  := $(ASSETS_OBJ_DIR)/$(SLOTMACHINEGFXDIR)
PKNAV_OUTDIR        := $(ASSETS_OBJ_DIR)/$(PKNAVGFXDIR)
PKNAVOPTIONS_OUTDIR := $(ASSETS_OBJ_DIR)/$(PKNAVOPTIONSGFXDIR)
WALLPAPER_OUTDIR    := $(ASSETS_OBJ_DIR)/$(WALLPAPERGFXDIR)
OBJEVENT_OUTDIR     := $(ASSETS_OBJ_DIR)/$(OBJEVENTGFXDIR)
MISC_OUTDIR         := $(ASSETS_OBJ_DIR)/$(MISCGFXDIR)
JPCONTEST_OUTDIR    := $(ASSETS_OBJ_DIR)/$(JPCONTESTGFXDIR)
POKEDEX_OUTDIR      := $(ASSETS_OBJ_DIR)/$(POKEDEXGFXDIR)
STARTER_OUTDIR      := $(ASSETS_OBJ_DIR)/$(STARTERGFXDIR)
NAMING_OUTDIR       := $(ASSETS_OBJ_DIR)/$(NAMINGGFXDIR)
SPINDA_OUTDIR       := $(ASSETS_OBJ_DIR)/$(SPINDAGFXDIR)
PARTYMENU_OUTDIR    := $(ASSETS_OBJ_DIR)/$(PARTYMENUGFXDIR)

# TEMP TODO: A nicer way to create the directory tree
SPECIAL_OUTDIRS := $(CASTFORM_OUTDIR) $(TILESET_OUTDIR) $(FONT_OUTDIR) $(INTERFACE_OUTDIR) $(BTLANMSPR_OUTDIR) $(UNUSED_OUTDIR) $(UNKNOWN_OUTDIR) $(BATINT_OUTDIR) $(MASKS_OUTDIR) $(BATTRANS_OUTDIR) $(TYPES_OUTDIR) $(RAYQUAZA_OUTDIR) $(ROULETTE_OUTDIR) $(SLOTMACHINE_OUTDIR) $(PKNAV_OUTDIR) $(PKNAVOPTIONS_OUTDIR) $(WALLPAPER_OUTDIR) $(OBJEVENT_OUTDIR) $(MISC_OUTDIR) $(JPCONTEST_OUTDIR) $(POKEDEX_OUTDIR) $(STARTER_OUTDIR) $(NAMING_OUTDIR) $(SPINDA_OUTDIR) $(PARTYMENU_OUTDIR)
$(shell mkdir -p $(SPECIAL_OUTDIRS))

### Castform has all 4 of its forms joined together before compression (in this order)
castform_types := normal sunny rainy snowy
$(CASTFORM_OUTDIR)/front.4bpp: $(patsubst %,$(CASTFORM_OUTDIR)/%/front.4bpp,$(castform_types))
	cat $^ >$@

$(CASTFORM_OUTDIR)/back.4bpp: $(patsubst %,$(CASTFORM_OUTDIR)/%/back.4bpp,$(castform_types))
	cat $^ >$@

$(CASTFORM_OUTDIR)/anim_front.4bpp: $(patsubst %,$(CASTFORM_OUTDIR)/%/anim_front.4bpp,$(castform_types))
	cat $^ >$@

# TODO: Remember to replace these lines.
$(CASTFORM_OUTDIR)/normal.gbapal: $(patsubst %,$(CASTFORM_OUTDIR)/%/normal.gbapal,$(castform_types))
	cat $^ >$@

$(CASTFORM_OUTDIR)/shiny.gbapal: $(patsubst %,$(CASTFORM_OUTDIR)/%/shiny.gbapal,$(castform_types))
	cat $^ >$@

### Tilesets
$(TILESET_OUTDIR)/secondary/petalburg/tiles.4bpp: $(TILESETGFXDIR)/secondary/petalburg/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 159 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/rustboro/tiles.4bpp: $(TILESETGFXDIR)/secondary/rustboro/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 498 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/dewford/tiles.4bpp: $(TILESETGFXDIR)/secondary/dewford/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 503 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/slateport/tiles.4bpp: $(TILESETGFXDIR)/secondary/slateport/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 504 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/mauville/tiles.4bpp: $(TILESETGFXDIR)/secondary/mauville/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 503 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/lavaridge/tiles.4bpp: $(TILESETGFXDIR)/secondary/lavaridge/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 450 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/fortree/tiles.4bpp: $(TILESETGFXDIR)/secondary/fortree/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 493 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/pacifidlog/tiles.4bpp: $(TILESETGFXDIR)/secondary/pacifidlog/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 504 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/sootopolis/tiles.4bpp: $(TILESETGFXDIR)/secondary/sootopolis/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 328 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/battle_frontier_outside_west/tiles.4bpp: $(TILESETGFXDIR)/secondary/battle_frontier_outside_west/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 508 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/battle_frontier_outside_east/tiles.4bpp: $(TILESETGFXDIR)/secondary/battle_frontier_outside_east/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 508 -Wnum_tiles

$(TILESET_OUTDIR)/primary/building/tiles.4bpp: $(TILESETGFXDIR)/primary/building/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 502 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/shop/tiles.4bpp: $(TILESETGFXDIR)/secondary/shop/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 502 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/pokemon_center/tiles.4bpp: $(TILESETGFXDIR)/secondary/pokemon_center/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 478 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/cave/tiles.4bpp: $(TILESETGFXDIR)/secondary/cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 425 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/pokemon_school/tiles.4bpp: $(TILESETGFXDIR)/secondary/pokemon_school/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 278 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/pokemon_fan_club/tiles.4bpp: $(TILESETGFXDIR)/secondary/pokemon_fan_club/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 319 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/unused_1/tiles.4bpp: $(TILESETGFXDIR)/secondary/unused_1/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 17 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/meteor_falls/tiles.4bpp: $(TILESETGFXDIR)/secondary/meteor_falls/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 460 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/oceanic_museum/tiles.4bpp: $(TILESETGFXDIR)/secondary/oceanic_museum/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 319 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/cable_club/unknown_tiles.4bpp: $(TILESETGFXDIR)/secondary/cable_club/unknown_tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 120 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/seashore_house/tiles.4bpp: $(TILESETGFXDIR)/secondary/seashore_house/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 312 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/pretty_petal_flower_shop/tiles.4bpp: $(TILESETGFXDIR)/secondary/pretty_petal_flower_shop/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 345 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/pokemon_day_care/tiles.4bpp: $(TILESETGFXDIR)/secondary/pokemon_day_care/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 355 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/brown_cave/tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/brown_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 83 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/tree/tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/tree/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 83 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/shrub/tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/shrub/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 83 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/blue_cave/tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/blue_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 83 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/yellow_cave/tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/yellow_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 83 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/red_cave/tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/red_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 83 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/inside_of_truck/tiles.4bpp: $(TILESETGFXDIR)/secondary/inside_of_truck/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 62 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/contest/tiles.4bpp: $(TILESETGFXDIR)/secondary/contest/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 430 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/lilycove_museum/tiles.4bpp: $(TILESETGFXDIR)/secondary/lilycove_museum/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 431 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/lab/tiles.4bpp: $(TILESETGFXDIR)/secondary/lab/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 500 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/underwater/tiles.4bpp: $(TILESETGFXDIR)/secondary/underwater/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 500 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/generic_building/tiles.4bpp: $(TILESETGFXDIR)/secondary/generic_building/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 509 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/mauville_game_corner/tiles.4bpp: $(TILESETGFXDIR)/secondary/mauville_game_corner/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 469 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/unused_2/tiles.4bpp: $(TILESETGFXDIR)/secondary/unused_2/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 150 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/rustboro_gym/tiles.4bpp: $(TILESETGFXDIR)/secondary/rustboro_gym/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 60 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/dewford_gym/tiles.4bpp: $(TILESETGFXDIR)/secondary/dewford_gym/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 61 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/lavaridge_gym/tiles.4bpp: $(TILESETGFXDIR)/secondary/lavaridge_gym/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 54 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/petalburg_gym/tiles.4bpp: $(TILESETGFXDIR)/secondary/petalburg_gym/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 148 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/fortree_gym/tiles.4bpp: $(TILESETGFXDIR)/secondary/fortree_gym/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 61 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/mossdeep_gym/tiles.4bpp: $(TILESETGFXDIR)/secondary/mossdeep_gym/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 82 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/sootopolis_gym/tiles.4bpp: $(TILESETGFXDIR)/secondary/sootopolis_gym/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 484 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/trick_house_puzzle/tiles.4bpp: $(TILESETGFXDIR)/secondary/trick_house_puzzle/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 294 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/inside_ship/tiles.4bpp: $(TILESETGFXDIR)/secondary/inside_ship/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 342 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/elite_four/tiles.4bpp: $(TILESETGFXDIR)/secondary/elite_four/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 505 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/battle_frontier/tiles.4bpp: $(TILESETGFXDIR)/secondary/battle_frontier/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 310 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/battle_factory/tiles.4bpp: $(TILESETGFXDIR)/secondary/battle_factory/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 424 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/battle_pike/tiles.4bpp: $(TILESETGFXDIR)/secondary/battle_pike/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 382 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/mirage_tower/tiles.4bpp: $(TILESETGFXDIR)/secondary/mirage_tower/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 420 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/mossdeep_game_corner/tiles.4bpp: $(TILESETGFXDIR)/secondary/mossdeep_game_corner/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 95 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/island_harbor/tiles.4bpp: $(TILESETGFXDIR)/secondary/island_harbor/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 503 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/trainer_hill/tiles.4bpp: $(TILESETGFXDIR)/secondary/trainer_hill/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 374 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/navel_rock/tiles.4bpp: $(TILESETGFXDIR)/secondary/navel_rock/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 420 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/battle_frontier_ranking_hall/tiles.4bpp: $(TILESETGFXDIR)/secondary/battle_frontier_ranking_hall/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 136 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/mystery_events_house/tiles.4bpp: $(TILESETGFXDIR)/secondary/mystery_events_house/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 509 -Wnum_tiles

#### Unused Tilesets (TODO: 1 rule for them all)
$(TILESET_OUTDIR)/secondary/secret_base/brown_cave/unused_tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/brown_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 82 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/tree/unused_tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/tree/tiles.png
	$(GFX) $< $@ -num_tiles 82 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/shrub/unused_tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/shrub/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 82 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/blue_cave/unused_tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/blue_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 82 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/yellow_cave/unused_tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/yellow_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 82 -Wnum_tiles

$(TILESET_OUTDIR)/secondary/secret_base/red_cave/unused_tiles.4bpp: $(TILESETGFXDIR)/secondary/secret_base/red_cave/tiles.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 82 -Wnum_tiles

### Fonts ###
$(FONT_OUTDIR)/%.latfont: $(FONTGFXDIR)/latin_%.png
	$(GFX) $< $@

$(FONT_OUTDIR)/braille.fwjpnfont: $(FONTGFXDIR)/braille.png
	$(GFX) $< $@

$(FONT_OUTDIR)/%.hwjpnfont: $(FONTGFXDIR)/japanese_%.png
	$(GFX) $< $@

$(FONT_OUTDIR)/%.fwjpnfont: $(FONTGFXDIR)/japanese_%.png
	$(GFX) $< $@

### Unused Graphics
$(UNUSED_OUTDIR)/obi_palpak1.gbapal: $(patsubst %,$(UNUSED_OUTDIR)/old_pal%.gbapal,1 2 3)
	cat $^ >$@

$(UNUSED_OUTDIR)/obi_palpak3.gbapal: $(patsubst %,$(UNUSED_OUTDIR)/old_pal%.gbapal,5 6 7)
	cat $^ >$@

$(UNUSED_OUTDIR)/obi1.4bpp: $(UNUSED_OUTDIR)/old_bulbasaur.4bpp \
                           $(UNUSED_OUTDIR)/old_charizard.4bpp
	cat $^ >$@

$(UNUSED_OUTDIR)/obi2.4bpp: $(UNUSED_OUTDIR)/old_bulbasaur2.4bpp \
                           $(UNUSED_OUTDIR)/old_battle_interface_1.4bpp \
                           $(UNUSED_OUTDIR)/old_battle_interface_2.4bpp \
                           $(UNUSED_OUTDIR)/old_battle_interface_3.4bpp
	cat $^ >$@

$(UNUSED_OUTDIR)/color_frames.4bpp: $(UNUSEDGFXDIR)/color_frames.png
	$(GFX) $< $@ -num_tiles 353 -Wnum_tiles

unused_frames := red_frame yellow_frame green_frame blank_frame
$(UNUSED_OUTDIR)/redyellowgreen_frame.bin: $(patsubst %,$(UNUSEDGFXDIR)/%.bin,$(unused_frames))
	cat $^ >$@

### Battle transitions
$(BATTRANS_OUTDIR)/vs_frame.4bpp: $(BATTRANSGFXDIR)/vs_frame.png
	$(GFX) $< $@ -num_tiles 16 -Wnum_tiles

$(BATTRANS_OUTDIR)/regis.4bpp: $(BATTRANSGFXDIR)/regis.png
	$(GFX) $< $@ -num_tiles 53 -Wnum_tiles

$(BATTRANS_OUTDIR)/rayquaza.4bpp: $(BATTRANSGFXDIR)/rayquaza.png
	$(GFX) $< $@ -num_tiles 938 -Wnum_tiles

$(BATTRANS_OUTDIR)/frontier_logo_center.4bpp: $(BATTRANSGFXDIR)/frontier_logo_center.png
	$(GFX) $< $@ -num_tiles 43 -Wnum_tiles

$(BATTRANS_OUTDIR)/frontier_square_1.4bpp: $(BATTRANS_OUTDIR)/frontier_squares_blanktiles.4bpp \
                                          $(BATTRANS_OUTDIR)/frontier_squares_1.4bpp
	cat $^ >$@

$(BATTRANS_OUTDIR)/frontier_square_2.4bpp: $(BATTRANS_OUTDIR)/frontier_squares_blanktiles.4bpp \
                                          $(BATTRANS_OUTDIR)/frontier_squares_2.4bpp
	cat $^ >$@

$(BATTRANS_OUTDIR)/frontier_square_3.4bpp: $(BATTRANS_OUTDIR)/frontier_squares_blanktiles.4bpp \
                                          $(BATTRANS_OUTDIR)/frontier_squares_3.4bpp
	cat $^ >$@

$(BATTRANS_OUTDIR)/frontier_square_4.4bpp: $(BATTRANS_OUTDIR)/frontier_squares_blanktiles.4bpp \
                                          $(BATTRANS_OUTDIR)/frontier_squares_4.4bpp
	cat $^ >$@

### Battle Interface
$(BATINT_OUTDIR)/textbox.gbapal: $(BATINT_OUTDIR)/textbox_0.gbapal \
                                $(BATINT_OUTDIR)/textbox_1.gbapal
	cat $^ >$@

$(BATINT_OUTDIR)/battle_bar.4bpp: $(BATINT_OUTDIR)/hpbar_anim_unused.4bpp \
                                 $(BATINT_OUTDIR)/numbers1.4bpp \
                                 $(BATINT_OUTDIR)/numbers2.4bpp
	cat $^ >$@

$(BATINT_OUTDIR)/unused_window2bar.4bpp: $(BATINTGFXDIR)/unused_window2bar.png
	$(GFX) $< $@ -num_tiles 5 -Wnum_tiles

### Battle animation sprites
$(BTLANMSPR_OUTDIR)/ice_cube.4bpp: $(BTLANMSPR_OUTDIR)/ice_cube_0.4bpp \
                                  $(BTLANMSPR_OUTDIR)/ice_cube_1.4bpp \
                                  $(BTLANMSPR_OUTDIR)/ice_cube_2.4bpp \
                                  $(BTLANMSPR_OUTDIR)/ice_cube_3.4bpp
	cat $^ >$@

$(BTLANMSPR_OUTDIR)/ice_crystals.4bpp: $(BTLANMSPR_OUTDIR)/ice_crystals_0.4bpp \
                                      $(BTLANMSPR_OUTDIR)/ice_crystals_1.4bpp \
                                      $(BTLANMSPR_OUTDIR)/ice_crystals_2.4bpp \
                                      $(BTLANMSPR_OUTDIR)/ice_crystals_3.4bpp \
                                      $(BTLANMSPR_OUTDIR)/ice_crystals_4.4bpp
	cat $^ >$@

$(BTLANMSPR_OUTDIR)/mud_sand.4bpp: $(BTLANMSPR_OUTDIR)/mud_sand_0.4bpp \
                                  $(BTLANMSPR_OUTDIR)/mud_sand_1.4bpp
	cat $^ >$@

$(BTLANMSPR_OUTDIR)/flower.4bpp: $(BTLANMSPR_OUTDIR)/flower_0.4bpp \
                                $(BTLANMSPR_OUTDIR)/flower_1.4bpp
	cat $^ >$@

$(BTLANMSPR_OUTDIR)/spark.4bpp: $(BTLANMSPR_OUTDIR)/spark_0.4bpp \
                               $(BTLANMSPR_OUTDIR)/spark_1.4bpp
	cat $^ >$@

### Rayquaza scene
$(RAYQUAZA_OUTDIR)/scene_2/rayquaza.8bpp: $(RAYQUAZAGFXDIR)/scene_2/rayquaza.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 227 -Wnum_tiles

$(RAYQUAZA_OUTDIR)/scene_2/bg.4bpp: $(RAYQUAZAGFXDIR)/scene_2/bg.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 313 -Wnum_tiles

$(RAYQUAZA_OUTDIR)/scene_3/rayquaza.4bpp: $(RAYQUAZAGFXDIR)/scene_3/rayquaza.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 124 -Wnum_tiles

$(RAYQUAZA_OUTDIR)/scene_3/rayquaza_tail_fix.4bpp: $(RAYQUAZA_OUTDIR)/scene_3/rayquaza_tail.4bpp
	mkdir -p $(@D)
	cp $< $@
	head -c 12 /dev/zero >> $@

$(RAYQUAZA_OUTDIR)/scene_4/streaks.4bpp: $(RAYQUAZAGFXDIR)/scene_4/streaks.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 19 -Wnum_tiles

$(RAYQUAZA_OUTDIR)/scene_4/rayquaza.4bpp: $(RAYQUAZAGFXDIR)/scene_4/rayquaza.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 155 -Wnum_tiles

### Japaneese Contests
jpcontest_composite1 = frame_1 floor frame_2 symbols meter letters numbers
$(JPCONTEST_OUTDIR)/composite_1.4bpp: $(patsubst %,$(JPCONTEST_OUTDIR)/%.4bpp,$(jpcontest_composite1))
	cat $^ >$@

$(JPCONTEST_OUTDIR)/composite_2.4bpp: $(JPCONTEST_OUTDIR)/interface.4bpp \
                                     $(JPCONTEST_OUTDIR)/audience.4bpp
	cat $^ >$@

# $(JPCONTEST_OUTDIR)/voltage.4bpp: $(JPCONTEST_OUTDIR)/%.4bpp: %.png
$(JPCONTEST_OUTDIR)/voltage.4bpp: $(JPCONTESTGFXDIR)/voltage.png
	$(GFX) $< $@ -num_tiles 36 -Wnum_tiles

### Game Corner
$(ROULETTE_OUTDIR)/roulette_tilt.4bpp: $(ROULETTE_OUTDIR)/shroomish.4bpp \
                                      $(ROULETTE_OUTDIR)/tailow.4bpp
	cat $^ >$@

$(ROULETTE_OUTDIR)/wheel_icons.4bpp: $(ROULETTE_OUTDIR)/wynaut.4bpp \
                                    $(ROULETTE_OUTDIR)/azurill.4bpp \
                                    $(ROULETTE_OUTDIR)/skitty.4bpp \
                                    $(ROULETTE_OUTDIR)/makuhita.4bpp
	cat $^ >$@

$(SLOTMACHINE_OUTDIR)/reel_time_gfx.4bpp: $(SLOTMACHINE_OUTDIR)/reel_time_pikachu.4bpp \
                                         $(SLOTMACHINE_OUTDIR)/reel_time_machine.4bpp
	cat $^ >$@

### Pokemon types
$(TYPES_OUTDIR)/move_types.gbapal: $(TYPES_OUTDIR)/move_types_1.gbapal \
                                  $(TYPES_OUTDIR)/move_types_2.gbapal \
                                  $(TYPES_OUTDIR)/move_types_3.gbapal
	cat $^ >$@

$(TYPES_OUTDIR)/move_types.4bpp: $(types:%=$(TYPES_OUTDIR)/%.4bpp) $(contest_types:%=$(TYPES_OUTDIR)/contest_%.4bpp)
	cat $^ >$@

### Miscellaneous ###
$(ASSETS_OBJ_DIR)/graphics/title_screen/pokemon_logo.gbapal: graphics/title_screen/pokemon_logo.pal
	mkdir -p $(@D)
	$(GFX) $< $@ -num_colors 224

$(ASSETS_OBJ_DIR)/graphics/pokemon_jump/bg.4bpp: graphics/pokemon_jump/bg.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 63 -Wnum_tiles

$(ASSETS_OBJ_DIR)/graphics/pokenav/region_map/map.8bpp: graphics/pokenav/region_map/map.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 233 -Wnum_tiles

$(ASSETS_OBJ_DIR)/graphics/bag/menu.4bpp: graphics/bag/menu.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 53 -Wnum_tiles

$(ASSETS_OBJ_DIR)/graphics/picture_frame/lobby.4bpp: graphics/picture_frame/lobby.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 86 -Wnum_tiles

$(ASSETS_OBJ_DIR)/graphics/birch_speech/unused_beauty.4bpp: graphics/birch_speech/unused_beauty.png
	mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 822 -Wnum_tiles

$(INTERFACE_OUTDIR)/outline_cursor.4bpp: $(INTERFACEGFXDIR)/outline_cursor.png
	$(GFX) $< $@ -num_tiles 8 -Wnum_tiles

$(MISC_OUTDIR)/japanese_hof.4bpp: $(MISCGFXDIR)/japanese_hof.png
	$(GFX) $< $@ -num_tiles 29 -Wnum_tiles

$(MASKS_OUTDIR)/unused_level_up.4bpp: $(MASKSGFXDIR)/unused_level_up.png
	$(GFX) $< $@ -num_tiles 14 -Wnum_tiles

$(PARTYMENU_OUTDIR)/bg.4bpp: $(PARTYMENUGFXDIR)/bg.png
	$(GFX) $< $@ -num_tiles 62 -Wnum_tiles

### Pokémon Storage System
#### Base images
$(WALLPAPER_OUTDIR)/forest/frame.4bpp: $(WALLPAPERGFXDIR)/forest/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 55 -Wnum_tiles

$(WALLPAPER_OUTDIR)/city/frame.4bpp: $(WALLPAPERGFXDIR)/city/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 52 -Wnum_tiles

$(WALLPAPER_OUTDIR)/savanna/frame.4bpp: $(WALLPAPERGFXDIR)/savanna/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 45 -Wnum_tiles

$(WALLPAPER_OUTDIR)/savanna/bg.4bpp: $(WALLPAPERGFXDIR)/savanna/bg.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 23 -Wnum_tiles

$(WALLPAPER_OUTDIR)/crag/frame.4bpp: $(WALLPAPERGFXDIR)/crag/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 49 -Wnum_tiles

$(WALLPAPER_OUTDIR)/volcano/frame.4bpp: $(WALLPAPERGFXDIR)/volcano/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 56 -Wnum_tiles

$(WALLPAPER_OUTDIR)/snow/frame.4bpp: $(WALLPAPERGFXDIR)/snow/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 57 -Wnum_tiles

$(WALLPAPER_OUTDIR)/cave/frame.4bpp: $(WALLPAPERGFXDIR)/cave/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 55 -Wnum_tiles

$(WALLPAPER_OUTDIR)/beach/frame.4bpp: $(WALLPAPERGFXDIR)/beach/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 46 -Wnum_tiles

$(WALLPAPER_OUTDIR)/beach/bg.4bpp: $(WALLPAPERGFXDIR)/beach/bg.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 23 -Wnum_tiles

$(WALLPAPER_OUTDIR)/seafloor/frame.4bpp: $(WALLPAPERGFXDIR)/seafloor/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 54 -Wnum_tiles

$(WALLPAPER_OUTDIR)/river/frame.4bpp: $(WALLPAPERGFXDIR)/river/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 51 -Wnum_tiles

$(WALLPAPER_OUTDIR)/river/bg.4bpp: $(WALLPAPERGFXDIR)/river/bg.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 11 -Wnum_tiles

$(WALLPAPER_OUTDIR)/sky/frame.4bpp: $(WALLPAPERGFXDIR)/sky/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 45 -Wnum_tiles

$(WALLPAPER_OUTDIR)/polkadot/frame.4bpp: $(WALLPAPERGFXDIR)/polkadot/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 54 -Wnum_tiles

$(WALLPAPER_OUTDIR)/pokecenter/frame.4bpp: $(WALLPAPERGFXDIR)/pokecenter/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 35 -Wnum_tiles

$(WALLPAPER_OUTDIR)/machine/frame.4bpp: $(WALLPAPERGFXDIR)/machine/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 33 -Wnum_tiles

$(WALLPAPER_OUTDIR)/plain/frame.4bpp: $(WALLPAPERGFXDIR)/plain/frame.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 18 -Wnum_tiles

$(WALLPAPER_OUTDIR)/friends_frame1.4bpp: $(WALLPAPERGFXDIR)/friends_frame1.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 57 -Wnum_tiles

$(WALLPAPER_OUTDIR)/friends_frame2.4bpp: $(WALLPAPERGFXDIR)/friends_frame2.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 57 -Wnum_tiles

#### Compound wallpapers
$(WALLPAPER_OUTDIR)/forest/tiles.4bpp: $(WALLPAPER_OUTDIR)/forest/frame.4bpp $(WALLPAPER_OUTDIR)/forest/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/city/tiles.4bpp: $(WALLPAPER_OUTDIR)/city/frame.4bpp $(WALLPAPER_OUTDIR)/city/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/desert/tiles.4bpp: $(WALLPAPER_OUTDIR)/desert/frame.4bpp $(WALLPAPER_OUTDIR)/desert/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/savanna/tiles.4bpp: $(WALLPAPER_OUTDIR)/savanna/frame.4bpp $(WALLPAPER_OUTDIR)/savanna/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/crag/tiles.4bpp: $(WALLPAPER_OUTDIR)/crag/frame.4bpp $(WALLPAPER_OUTDIR)/crag/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/volcano/tiles.4bpp: $(WALLPAPER_OUTDIR)/volcano/frame.4bpp $(WALLPAPER_OUTDIR)/volcano/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/snow/tiles.4bpp: $(WALLPAPER_OUTDIR)/snow/frame.4bpp $(WALLPAPER_OUTDIR)/snow/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/cave/tiles.4bpp: $(WALLPAPER_OUTDIR)/cave/frame.4bpp $(WALLPAPER_OUTDIR)/cave/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/beach/tiles.4bpp: $(WALLPAPER_OUTDIR)/beach/frame.4bpp $(WALLPAPER_OUTDIR)/beach/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/seafloor/tiles.4bpp: $(WALLPAPER_OUTDIR)/seafloor/frame.4bpp $(WALLPAPER_OUTDIR)/seafloor/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/river/tiles.4bpp: $(WALLPAPER_OUTDIR)/river/frame.4bpp $(WALLPAPER_OUTDIR)/river/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/sky/tiles.4bpp: $(WALLPAPER_OUTDIR)/sky/frame.4bpp $(WALLPAPER_OUTDIR)/sky/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/polkadot/tiles.4bpp: $(WALLPAPER_OUTDIR)/polkadot/frame.4bpp $(WALLPAPER_OUTDIR)/polkadot/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/pokecenter/tiles.4bpp: $(WALLPAPER_OUTDIR)/pokecenter/frame.4bpp $(WALLPAPER_OUTDIR)/pokecenter/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/machine/tiles.4bpp: $(WALLPAPER_OUTDIR)/machine/frame.4bpp $(WALLPAPER_OUTDIR)/machine/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/plain/tiles.4bpp: $(WALLPAPER_OUTDIR)/plain/frame.4bpp $(WALLPAPER_OUTDIR)/plain/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/zigzagoon/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/zigzagoon/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/screen/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/screen/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/horizontal/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/horizontal/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/diagonal/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/diagonal/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/block/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/block/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/ribbon/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/ribbon/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/pokecenter2/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/pokecenter2/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/frame/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/frame/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/blank/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/blank/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/circles/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame1.4bpp $(WALLPAPER_OUTDIR)/circles/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/azumarill/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame2.4bpp $(WALLPAPER_OUTDIR)/azumarill/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/pikachu/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame2.4bpp $(WALLPAPER_OUTDIR)/pikachu/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/legendary/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame2.4bpp $(WALLPAPER_OUTDIR)/legendary/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/dusclops/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame2.4bpp $(WALLPAPER_OUTDIR)/dusclops/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/ludicolo/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame2.4bpp $(WALLPAPER_OUTDIR)/ludicolo/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

$(WALLPAPER_OUTDIR)/whiscash/tiles.4bpp: $(WALLPAPER_OUTDIR)/friends_frame2.4bpp $(WALLPAPER_OUTDIR)/whiscash/bg.4bpp
	@mkdir -p $(@D)
	cat $^ >$@

### Pokenav
pknav_options = hoenn_map condition match_call ribbons switch_off party search $(contest_types) cancel
$(PKNAVOPTIONS_OUTDIR)/options.4bpp: $(patsubst %,$(PKNAVOPTIONS_OUTDIR)/%.4bpp,$(pknav_options))
	cat $^ >$@

$(PKNAV_OUTDIR)/header.4bpp : $(PKNAVGFXDIR)/header.png
	$(GFX) $< $@ -num_tiles 53 -Wnum_tiles

$(PKNAV_OUTDIR)/device_outline.4bpp : $(PKNAVGFXDIR)/device_outline.png
	$(GFX) $< $@ -num_tiles 53 -Wnum_tiles

$(PKNAV_OUTDIR)/match_call/ui.4bpp : $(PKNAVGFXDIR)/match_call/ui.png
	@mkdir -p $(@D)
	$(GFX) $< $@ -num_tiles 13 -Wnum_tiles

### Region map
$(POKEDEX_OUTDIR)/region_map.8bpp: $(POKEDEXGFXDIR)/region_map.png
	$(GFX) $< $@ -num_tiles 232 -Wnum_tiles

$(POKEDEX_OUTDIR)/region_map_affine.8bpp: $(POKEDEXGFXDIR)/region_map_affine.png
	$(GFX) $< $@ -num_tiles 233 -Wnum_tiles

### Some naming graphics
$(NAMING_OUTDIR)/cursor.4bpp: $(NAMINGGFXDIR)/cursor.png
	$(GFX) $< $@ -num_tiles 5 -Wnum_tiles

$(NAMING_OUTDIR)/cursor_squished.4bpp: $(NAMINGGFXDIR)/cursor_squished.png
	$(GFX) $< $@ -num_tiles 5 -Wnum_tiles

$(NAMING_OUTDIR)/cursor_filled.4bpp: $(NAMINGGFXDIR)/cursor_filled.png
	$(GFX) $< $@ -num_tiles 5 -Wnum_tiles

### Spinda to win-da (TODO: Maybe these should have optional config files rather than rules?)
$(SPINDA_OUTDIR)/%.1bpp: $(SPINDAGFXDIR)/%.png
	$(GFX) $< $@ -plain -data_width 2