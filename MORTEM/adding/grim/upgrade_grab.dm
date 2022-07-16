/obj/item/grab/upgrade_grab(delay_time, hud_icon_state_after, state_after)
	if(!allow_upgrade)
		return // upgrading now is not allowed!
	delay_time = round(delay_time / 8) // the sprites have eight configurations for timer
	var/original_icon = hud.icon_state
	var/original_loc = get_turf(assailant) // used to see if the assailant moved and thus disrupted the upgrade
	var/original_time = world.time
	for(var/counter in 1 to 8)
		if(QDELING(src) || !hud)
			break // hud is null after dropped and sleep does not care so we check manually
		if(last_action > original_time || !confirm() || get_turf(assailant) != original_loc) // cannot do a grab attack while upgrading a grab
			hud.icon_state = original_icon //  or move and upgrade a grab or keep upgrading it when the grab is escaped.
			break
		else
			hud.icon_state = "[original_icon][counter]"
			sleep(delay_time)
			if(counter == 8)
				hud.icon_state = hud_icon_state_after
				state = state_after
				return TRUE
	to_chat(assailant, SPAN_WARNING("You failed to upgrade your grab."))
