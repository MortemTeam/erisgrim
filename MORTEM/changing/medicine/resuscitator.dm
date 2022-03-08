/mob/living/carbon/human
	var/resusciate_available = TRUE

/mob/living/carbon/human/resuscitate()
	var/obj/item/organ/internal/heart_organ = random_organ_by_process(OP_HEART)
	var/obj/item/organ/internal/brain_organ = random_organ_by_process(BP_BRAIN)

	if(!is_asystole() && !(heart_organ && brain_organ) || (heart_organ.is_broken() || brain_organ.is_broken()))
		return 0

	if(world.time >= (timeofdeath + 30 MINUTES))
		return 0

	if(!resusciate_available)
		visible_message(SPAN_WARNING("\The [src] twitches a bit, but their body is too damaged to sustain life!"))
		timeofdeath = 0
		return 0

	resusciate_available = FALSE

	visible_message(SPAN_NOTICE("\The [src] twitches a bit as their heart restarts!"))
	pulse = PULSE_NORM
	handle_pulse()
	timeofdeath = 0
	stat = UNCONSCIOUS
	jitteriness += 3 SECONDS
	updatehealth()
	switch_from_dead_to_living_mob_list()
	if(mind)
		for(var/mob/observer/ghost/G in GLOB.player_list)
			if(G.can_reenter_corpse && G.mind == mind)
				if(alert("Do you want to enter your body?","Resuscitate","OH YES","No, I'm autist") == "OH YES")
					G.reenter_corpse()
					break
				else
					break
	return 1
