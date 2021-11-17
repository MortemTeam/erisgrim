/datum/breakdown/negative/insight_dumper
	duration = 5 MINUTES
	restore_sanity_post = 0

	start_messages = list(
		"You don't feel a rush of energy!",
		"No inspiration...",
	)

	end_messages = list(
		"You are feeling the rush again."
	)

/datum/breakdown/negative/insight_dumper/update()
	. = ..()
	holder.insight = 66.6
