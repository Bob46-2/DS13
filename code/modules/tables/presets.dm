/obj/structure/table/standard
	icon_state = "plain_preview"
	color = COLOR_OFF_WHITE
	material = DEFAULT_TABLE_MATERIAL

/obj/structure/table/steel
	icon_state = "plain_preview"
	color = COLOR_GRAY40
	material = MATERIAL_STEEL

/obj/structure/table/marble
	icon_state = "stone_preview"
	color = COLOR_GRAY80
	material = MATERIAL_MARBLE

/obj/structure/table/reinforced
	icon_state = "reinf_preview"
	color = COLOR_OFF_WHITE
	material = DEFAULT_TABLE_MATERIAL
	reinforced = MATERIAL_STEEL

/obj/structure/table/steel_reinforced
	icon_state = "reinf_preview"
	color = COLOR_GRAY40
	material = MATERIAL_STEEL
	reinforced = MATERIAL_STEEL

/obj/structure/table/woodentable
	icon_state = "solid_preview"
	color = COLOR_BROWN_ORANGE
	material = "wood"

/obj/structure/table/woodentable_reinforced
	icon_state = "reinf_preview"
	color = COLOR_BROWN_ORANGE
	material = "wood"
	reinforced = "wood"

/obj/structure/table/gamblingtable
	icon_state = "gamble_preview"
	carpeted = 1
	material = "wood"

/obj/structure/table/glass
	icon_state = "plain_preview"
	color = COLOR_DEEP_SKY_BLUE
	alpha = 77 // 0.3 * 255
	material = MATERIAL_GLASS

/obj/structure/table/glass/pglass
	color = "#8f29a3"
	material = "phglass"

/obj/structure/table/holotable
	icon_state = "holo_preview"
	color = COLOR_OFF_WHITE

/obj/structure/table/holotable/Initialize()
	material = "holo[DEFAULT_TABLE_MATERIAL]"
	.=..()

/obj/structure/table/holo_woodentable
	icon_state = "holo_preview"
	material = "holowood"
