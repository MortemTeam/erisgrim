/datum/surgery_step/attach_organ/end_step(mob/living/user, obj/item/organ/internal/organ, obj/item/stack/tool)
	user.visible_message(
		SPAN_NOTICE("[user] reattaches [organ.get_surgery_name()] with \the [tool]."),
		SPAN_NOTICE("You reattach [organ.get_surgery_name()] with \the [tool].")
	)

	organ.status &= ~ORGAN_CUT_AWAY
	organ.replaced(organ.get_limb())
