/mob/living/update_sight()
	set_sight(0)
	set_see_in_dark(0)

	if(stat == DEAD || eyeobj)
		update_dead_sight()
	else
		if(is_ventcrawling)
			sight |= SEE_TURFS|SEE_OBJS|BLIND
		else
			sight &= ~(SEE_TURFS|SEE_MOBS|SEE_OBJS|SEE_BLACKNESS)
			see_in_dark = initial(see_in_dark)
			see_invisible = initial(see_invisible)

	var/list/vision = get_accumulated_vision_handlers()
	set_sight(sight | vision[1])
	set_see_invisible(max(vision[2], see_invisible))

/datum/species/handle_vision(var/mob/living/carbon/human/H)
	H.update_sight()
	H.sight |= get_vision_flags(H)
	H.sight |= H.equipment_vision_flags

	if(H.stat == DEAD || !H.client)
		return 1

	if(!H.druggy)
		//H.see_in_dark = (H.sight == SEE_TURFS|SEE_MOBS|SEE_OBJS|SEE_BLACKNESS) ? 2 : min(darksight + H.equipment_darkness_modifier, 2)
		H.see_in_dark = max(darksight + H.equipment_darkness_modifier, 2)

	if(H.equipment_see_invis)
		H.see_invisible = H.equipment_see_invis

	if(H.equipment_tint_total >= TINT_BLIND)
		H.eye_blind = max(H.eye_blind, 1)

	if(config.welder_vision)
		if(H.equipment_tint_total == TINT_HEAVY)
			H.client.screen += global_hud.darkMask
		else if((!H.equipment_prescription && (H.disabilities & NEARSIGHTED)) || H.equipment_tint_total == TINT_MODERATE)
			H.client.screen += global_hud.vimpaired

	for(var/overlay in H.equipment_overlays)
		H.client.screen |= overlay

	return 1
