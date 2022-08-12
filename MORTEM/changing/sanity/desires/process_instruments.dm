/datum/sound_token/instrument/update_listener(var/listener)
	var/mob/m = listener
	if(istype(m))
		add_rest(INSIGHT_DESIRE_MUSIC, 0.5)
	return ..()