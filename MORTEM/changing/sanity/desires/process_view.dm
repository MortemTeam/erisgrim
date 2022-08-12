
/datum/sanity/handle_view()
	. = ..()
	for(var/mob/living/carbon/human/H in view(owner.client.eye ? owner.client : owner))
		if(H.stat != DEAD && !H.isMonkey() && H.check_nude())
			add_rest(INSIGHT_DESIRE_NUDES, owner.check_nude() ? 3 : 2)
