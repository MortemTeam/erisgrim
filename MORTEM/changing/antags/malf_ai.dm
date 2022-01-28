/datum/antagonist/rogue_ai/can_become_antag(var/datum/mind/player)
	if(GLOB.player_list.len < 10)
		return FALSE

	return ..()
