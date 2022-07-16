#define INSIGHT_DESIRE_NUDES "nudes"
#define INSIGHT_DESIRE_MUSIC "music"
#define INSIGHT_DESIRE_SHOWER "shower"

/datum/sanity/pick_desires()
	desires.Cut()
	var/list/candidates = list(
		INSIGHT_DESIRE_FOOD,
		INSIGHT_DESIRE_ALCOHOL,
		INSIGHT_DESIRE_SMOKING,
		INSIGHT_DESIRE_DRUGS,
		INSIGHT_DESIRE_NUDES,
		INSIGHT_DESIRE_MUSIC,
		INSIGHT_DESIRE_SHOWER,
	)

	for(var/i in owner.metabolism_effects.addiction_list)
		if(istype(i, /datum/reagent/drug))
			if(istype(i, /datum/reagent/drug/nicotine))
				candidates.Remove(INSIGHT_DESIRE_SMOKING)
				continue
			candidates.Remove(INSIGHT_DESIRE_DRUGS)

	for(var/i = 0; i < INSIGHT_DESIRE_COUNT; i++)
		var/desire = pick_n_take(candidates)
		var/list/potential_desires = list()
		switch(desire)
			if(INSIGHT_DESIRE_FOOD)
				potential_desires = all_types_food.Copy()
			if(INSIGHT_DESIRE_ALCOHOL)
				potential_desires = all_taste_drinks.Copy()
			else
				desires += desire
				continue
		if(potential_desires.len)
			var/candidate = pick(potential_desires)
			desires += candidate
	print_desires()
