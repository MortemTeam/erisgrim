/datum/reagent/alcohol/jivin
	name = "Jivin"
	id = "jivin"
	description = "Jivin is an extremely toxic treating substance. Most of the synthesized synthetic."
	taste_description = "disgustingly bitter"
	strength = 5
	color = "#000000"
	overdose = 13
	taste_tag = list(TASTE_STRONG, TASTE_BITTER)

/datum/reagent/alcohol/jivin/affect_ingest(mob/living/carbon/human/H, alien, effect_multiplier)
	H.adjustOxyLoss(-1.3 * effect_multiplier)
	H.heal_organ_damage(1.3 * effect_multiplier, 1.3 * effect_multiplier)
	H.adjustToxLoss(0.666 * effect_multiplier)

/datum/reagent/alcohol/jivin/overdose(mob/living/carbon/human/H, alien)
	H.make_jittery(1.3)



/obj/item/reagent_containers/food/drinks/bottle/jivin
	name = "Jivin bottle"
	desc = "*Indecipherable text from some ancient paper sticker*"
	icon_state = "jivin"
	volume = 15
	center_of_mass = list("x"=13, "y"=3)
	preloaded_reagents = list("jivin"=15)
	spawn_tags = SPAWN_TAG_BOOZE
