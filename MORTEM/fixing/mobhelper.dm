/mob/living/carbon/human/proc/check_nude()
	return !body_part_covered(BP_CHEST) || !body_part_covered(BP_GROIN)
