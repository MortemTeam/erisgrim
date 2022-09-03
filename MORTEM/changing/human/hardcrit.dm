/mob/living/carbon/human/enter_hard_crit()
	var/knockout_time = 30 SECONDS
	to_chat(src, SPAN_DANGER("[pick("You are knocked out", "You can't feel anything anymore", "You just can't keep going anymore")]!"))
	visible_message(SPAN_DANGER("[src] [species.knockout_message]"))
	Weaken(knockout_time)
	Paralyse(knockout_time)
	status_flags |= HARDCRIT

	addtimer(CALLBACK(src, .proc/exit_hard_crit), knockout_time)
