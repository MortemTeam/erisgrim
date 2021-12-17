#define DRUGS_MESSAGE_DELAY 1 MINUTES

/datum/reagent/drug/thc
	id = "thc"
	name = "Tetrahydrocannabinol"
	description = "THC, or tetrahydrocannabinol, is the chemical responsible for most of marijuana's psychological effects. THC stimulates cells in the brain to release dopamine, effectively causing euphoria."
	taste_description = "dope stuff"
	reagent_type = "Drug/Stimulator"
	reagent_state = LIQUID
	color = "#778800"
	scannable = 1
	overdose = 50
	metabolism = 0.05
	data = 0
	var/thcdata = 0

/datum/reagent/drug/thc/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	affect_blood(M, alien, effect_multiplier)

/datum/reagent/drug/thc/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	M.druggy = max(M.druggy, 30 * effect_multiplier)

	var/effective_dose = dose
	if(issmall(M)) effective_dose *= 2
	if(effective_dose < 1)
		M.stats.addTempStat(STAT_COG, STAT_LEVEL_BASIC, STIM_TIME, "tetrahydrocannabinol")

		M.add_chemical_effect(CE_MIND, 1)
		M.nutrition -= 3 * effect_multiplier
		M.add_chemical_effect(CE_PAINKILLER, 25)
		if(world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			to_chat(M, SPAN_NOTICE("Your mind feels stable."))
		if(world.time > thcdata + DRUGS_MESSAGE_DELAY)
			thcdata = world.time
			if(prob(60))
				to_chat(M, SPAN_NOTICE("You feel high and happy."))
			else
				to_chat(M, SPAN_NOTICE("Why not to find something to eat?"))

		M.hallucination(50, 50)
		if(prob(5))
			M.emote(pick("cough"))

	else if(effective_dose < 2)
		M.make_jittery(10)

		M.add_chemical_effect(CE_MIND, 2)
		M.nutrition -= 5 * effect_multiplier
		M.add_chemical_effect(CE_PAINKILLER, 50)
		if(world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			to_chat(M, SPAN_NOTICE("Your mind feels much more stable."))
		if(world.time > thcdata + DRUGS_MESSAGE_DELAY)
			thcdata = world.time
			if(prob(60))
				to_chat(M, SPAN_NOTICE("You feel high and happy."))
			else
				to_chat(M, SPAN_WARNING("You feel really hungry."))

		if(prob(10))
			M.emote(pick("cough", "giggle"))

	else
		M.apply_effect(3, STUTTER)
		M.make_jittery(10)
		M.make_dizzy(10)
		M.druggy = max(M.druggy, 40)
		M.stats.addTempStat(STAT_COG, STAT_LEVEL_ADEPT, STIM_TIME, "tetrahydrocannabinol")

		M.add_chemical_effect(CE_MIND, 3)
		M.nutrition -= 10 * effect_multiplier
		M.add_chemical_effect(CE_PAINKILLER, 85)
		if(world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			to_chat(M, SPAN_NOTICE("You don't give a fuck about anything"))
		if(world.time > thcdata + DRUGS_MESSAGE_DELAY)
			thcdata = world.time
			if(prob(60))
				to_chat(M, SPAN_WARNING("You feel stoned."))
			else
				to_chat(M, SPAN_WARNING("You are hungry as fuck!"))

		M.hallucination(100, 50)
		if(prob(15))
			M.emote(pick("cough", "giggle", "laugh"))

	..()
