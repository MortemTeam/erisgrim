/datum/surgery_step/robotic/can_use(mob/living/user, obj/item/organ/external/organ, obj/item/tool)
	if(organ.organ_tag == BP_BRAIN)
		return TRUE

	return BP_IS_ROBOTIC(organ)
