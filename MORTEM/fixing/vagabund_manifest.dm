/datum/datacore/manifest_inject(var/mob/living/carbon/human/H)
	if(H.job != ASSISTANT_TITLE)
		. = ..()
