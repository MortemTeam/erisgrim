/obj/item/organ/external/robotic
	var/basis_tag = BP_CHEST
	var/constructs_body = list(
		BP_HEAD  = null,
		BP_CHEST = null,
		BP_GROIN = null,
		BP_L_ARM = null,
		BP_R_ARM = null,
		BP_L_LEG = null,
		BP_R_LEG = null,
	)

/obj/item/organ/external/robotic/New()
	..()
	organ_tag = new default_description().organ_tag
	if(organ_tag == basis_tag)
		constructs_body[basis_tag] = src

/obj/item/organ/external/robotic/update_icon()
	..()
	overlays.Cut()
	for(var/tag in constructs_body)
		if(constructs_body[tag])
			overlays += constructs_body[tag]

/obj/item/organ/external/robotic/attackby(obj/item/I, mob/user)
	..()
	var/organ_tag = new default_description().organ_tag
	if(!organ_tag || organ_tag != basis_tag)
		return

	if(!istype(I, bad_type))
		return

	var/obj/item/organ/external/robotic/part = I
	organ_tag = new part.default_description().organ_tag
	if(!organ_tag || constructs_body[organ_tag])
		return

	constructs_body[organ_tag] = part
	user.drop_from_inventory(part)
	part.forceMove(src)
	update_icon()

	for(var/tag in constructs_body)
		if(!constructs_body[tag])
			return

	var/name = sanitizeSafe(input(user,"Set a name for the new prosthetic."), MAX_NAME_LEN)
	if(!name)
		name = "prosthetic ([random_id("prosthetic_id", 1, 999)])"

	var/mob/living/carbon/human/H = new /mob/living/carbon/human(get_turf(loc))
	H.death(0, "no message")
	H.set_species(SPECIES_HUMAN)
	H.fully_replace_character_name(name)

	// Remove internal organs
	for(var/O in list(BP_BRAIN, OP_APPENDIX))
		for(var/obj/item/organ/internal/organ in H.internal_organs_by_efficiency[O])
			H.organs -= organ
			qdel(organ)

	// Convert internal organs
	for(var/O in list(OP_HEART, BP_EYES, OP_LUNGS, OP_STOMACH, OP_LIVER, OP_KIDNEYS))
		for(var/obj/item/organ/internal/organ in H.internal_organs_by_efficiency[O])
			organ.nature = MODIFICATION_SILICON

	for(var/tag in constructs_body)
		qdel(constructs_body[tag])

	qdel(src)
