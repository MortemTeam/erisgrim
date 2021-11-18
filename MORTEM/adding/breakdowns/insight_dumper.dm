/datum/breakdown/negative/insight_dumper
	name = "Insight Dumper"
	duration = 5 MINUTES

	start_messages = list(
		"You don't feel a rush of energy!",
		"No inspiration...",
	)

	end_messages = list(
		"You are feeling the rush again."
	)

/datum/breakdown/negative/insight_dumper/update()
	..()
	holder.insight = 66.6

/datum/breakdown/negative/insight_dumper/conclude()
	..()
	holder.insight = 0
