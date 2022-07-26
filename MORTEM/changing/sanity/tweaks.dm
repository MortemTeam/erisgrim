/datum/sanity/add_rest(type, amount)
	if(type in desires)
		give_insight_rest(amount)
		if(insight_rest >= 100)
			insight_rest = 0
			finish_rest()

/datum/sanity/finish_rest()
	desires.Cut()
	return ..()

/datum/reagent/drink/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	. = ..()
	apply_sanity_effect(M, effect_multiplier)
