/obj/item/organ/external/robotic/attackby(obj/item/I, mob/user)
	..()
	var/datum/organ_description/DP = new default_description()
	if(!DP || DP.organ_tag != BP_CHEST)
		return
	if(!istype(I, /obj/item/organ/external/robotic))
		return

	var/obj/item/organ/external/robotic/part = I
	DP = new part.default_description()
	if(!DP || DP.organ_tag != BP_GROIN)
		return

	var/name = sanitizeSafe(input(user,"Set a name for the new prosthetic."), MAX_NAME_LEN)
	if(!name)
		name = "prosthetic ([random_id("prosthetic_id", 1, 999)])"

	var/mob/living/carbon/human/H = new /mob/living/carbon/human(get_turf(loc))
	H.death(0, "no message")
	H.set_species(SPECIES_HUMAN)
	H.fully_replace_character_name(name)

	// Remove all external organs other than chest and head..
	for(var/O in list(BP_HEAD, BP_L_ARM, BP_R_ARM, BP_L_LEG, BP_R_LEG))
		var/obj/item/organ/external/organ = H.organs_by_name[O]
		H.organs -= organ
		H.organs_by_name.Remove(organ.organ_tag)
		qdel(organ)

	// Remove internal organs
	for(var/O in list(BP_BRAIN, BP_EYES, OP_APPENDIX))
		for(var/obj/item/organ/internal/organ in H.internal_organs_by_efficiency[O])
			H.organs -= organ
			qdel(organ)

	// Convert internal organs
	for(var/O in list(OP_HEART, OP_LUNGS, OP_STOMACH, OP_LIVER, OP_KIDNEYS))
		for(var/obj/item/organ/internal/organ in H.internal_organs_by_efficiency[O])
			organ.nature = MODIFICATION_SILICON

	qdel(part)
	qdel(src)
