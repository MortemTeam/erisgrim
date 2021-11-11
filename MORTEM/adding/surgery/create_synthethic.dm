/obj/item/organ/external/robotic
	var/basis_tag = BP_CHEST
	var/list/constructs_body = list(
		BP_CHEST = null,
		BP_HEAD  = null,
		BP_GROIN = null,
		BP_L_ARM = null,
		BP_R_ARM = null,
		BP_L_LEG = null,
		BP_R_LEG = null,
	)

/obj/item/organ/external/robotic/New()
	..()
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
	if(!organ_tag || organ_tag != basis_tag)
		return

	if(!istype(I, bad_type))
		return to_chat(user, SPAN_NOTICE("Assemble parts of the same set."))

	var/obj/item/organ/external/robotic/part = I
	if(!part.organ_tag || constructs_body[part.organ_tag])
		return to_chat(user, SPAN_NOTICE("You've already put that part in."))

	constructs_body[part.organ_tag] = part
	user.drop_from_inventory(part)
	part.forceMove(src)
	update_icon()

	w_class += ITEM_SIZE_SMALL

	for(var/tag in constructs_body)
		if(!constructs_body[tag])
			return

	var/name = sanitizeSafe(input(user, "Set a name for the new prosthetic."), MAX_NAME_LEN)
	if(!name)
		name = "prosthetic ([random_id("prosthetic_id", 1, 999)])"

	var/sex = input(user, "Choose your character's sex:", CHARACTER_PREFERENCE_INPUT_TITLE) as null|anything in list(FEMALE, MALE, NEUTER)
	if(!sex)
		sex = NEUTER

	var/mob/living/carbon/human/H = new /mob/living/carbon/human(get_turf(loc))
	H.fully_replace_character_name(name, name)
	H.death(0)

	// Заменяются конечности
	for(var/tag in constructs_body)
		if(H.organs_by_name[tag])
			qdel(H.organs_by_name[tag])

		var/obj/item/organ/external/organ = constructs_body[tag]
		new organ.type(H)

	// Создаются органы и протезируются, кроме мозга и аппендикса
	for(var/tag in H.species.has_process - list(BP_BRAIN, OP_APPENDIX))
		var/organ_type = H.species.has_process[tag]
		var/obj/item/organ/internal/O = new organ_type(H)
		O.nature = MODIFICATION_SILICON

	H.gender = sex
	H.update_body()
	H.regenerate_icons()
	qdel(src)
