/datum/reagent/medicine/methylphenidate/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(volume <= 0.1 && data != -1)
		data = -1
		to_chat(M, SPAN_WARNING("You lose focus..."))
	else
		M.add_chemical_effect(CE_MIND, 1)
		if(world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			to_chat(M, SPAN_NOTICE("Your mind feels focused and undivided."))

/mob/living/carbon/human/handle_hallucinations()
	if(chem_effects[CE_MIND] > 0)
		for(var/datum/breakdown/negative/N in sanity.breakdowns)
			N.conclude()
	..()
