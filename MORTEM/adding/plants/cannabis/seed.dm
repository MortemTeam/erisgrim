/obj/item/seeds/cannabis
	seed_type = "cannabis"

/datum/seed/cannabis
	name = "cannabis"
	seed_name = "cannabis"
	display_name = "cannabis buds"
	chems = list("thc" = list(8,14))
	kitchen_tag = "cannabis"

/datum/seed/cannabis/New()
	..()
	set_trait(TRAIT_HARVEST_REPEAT,1)
	set_trait(TRAIT_MATURATION,4)
	set_trait(TRAIT_YIELD,3)
	set_trait(TRAIT_POTENCY,4)
	set_trait(TRAIT_PRODUCT_ICON,"cannabis")
	set_trait(TRAIT_PLANT_ICON,"cannabis")
	set_trait(TRAIT_PRODUCT_COLOUR,"#4c7f28")
	set_trait(TRAIT_PLANT_COLOUR,"#4c7f28")
	set_trait(TRAIT_WATER_CONSUMPTION, 10)
	set_trait(TRAIT_NUTRIENT_CONSUMPTION, 0.20)
