/obj/item/stock_parts/manipulator/nt
	name = "neotheology-manipulator"
	desc = "A strange-looking manipulator."
	icon = 'MORTEM/adding/machinery/stockparts/icons.dmi'
	icon_state = "nt_mani"

	rating = 0.8
	rarity_value = 13
	origin_tech = list(TECH_MATERIAL = 3, TECH_DATA = 3)
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 3)

/obj/machinery/autolathe/RefreshParts()
	. = ..()

	unsuitable_materials = list(MATERIAL_BIOMATTER)
	for(var/obj/item/stock_parts/manipulator/nt/M in component_parts)
		unsuitable_materials -= list(MATERIAL_BIOMATTER)
		break
