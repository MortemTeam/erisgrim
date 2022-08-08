/datum/craft_recipe/furniture/shower
	name = "shower"
	result = /obj/machinery/shower
	steps = list(
		list(CRAFT_MATERIAL, 60, MATERIAL_STEEL),
        list(QUALITY_WELDING, 15, 5 SECONDS),
        list(CRAFT_MATERIAL, 5, MATERIAL_PLASTIC),
        list(QUALITY_ADHESIVE, 15, 3 SECONDS),
        list(QUALITY_SCREW_DRIVING, 10, 2 SECONDS),
	)
