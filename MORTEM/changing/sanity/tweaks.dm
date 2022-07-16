/datum/sanity
	insight_passive_gain_multiplier = 2

/datum/sanity/add_rest(type, amount)
	if(type in desires)
		give_insight_rest(amount)
		if(insight_rest >= 100)
			insight_rest = 0
			finish_rest()
