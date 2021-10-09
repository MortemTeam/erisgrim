/mob/living/carbon/human/handle_speech_problems(var/message, var/verb)
	if(silent || (sdisabilities & MUTE))
		message = ""
		speech_problem_flag = 1
	else if(istype(wear_mask, /obj/item/clothing/mask))
		var/obj/item/clothing/mask/M = wear_mask
		if(M.voicechange)
			message = pick(M.say_messages)
			verb = pick(M.say_verbs)
			speech_problem_flag = 1

	else if(istype(wear_mask, /obj/item/underwear/bottom))
		var/obj/item/underwear/bottom/M = wear_mask
		message = pick(M.say_messages)
		verb = pick(M.say_verbs)
		speech_problem_flag = 1

	if(message != "")
		var/list/parent = ..()
		message = parent[1]
		verb = parent[2]
		if(parent[3])
			speech_problem_flag = 1

	var/list/returns[3]
	returns[1] = message
	returns[2] = verb
	returns[3] = speech_problem_flag
	return returns

/datum/category_item/underwear
	var/item_state

/datum/category_item/underwear/create_underwear(var/atom/location, var/list/metadata, var/iconfile)	//we iconfile from bodybuild
	if(!underwear_type)
		return

	var/obj/item/underwear/UW = new underwear_type(location)
	UW.SetName(underwear_name)
	UW.gender = underwear_gender
	UW.icon_state = icon_state
	UW.item_state = item_state

	for(var/datum/gear_tweak/gt in tweaks)
		gt.tweak_item(UW, metadata && metadata["[gt]"] ? metadata["[gt]"] : gt.get_default())
	return UW

/obj/item/underwear
	icon = 'MORTEM/mouth_underwear/underwear.dmi'

/obj/item/underwear/bottom
	slot_flags = SLOT_MASK
	contained_sprite = TRUE

	var/say_messages = list("Mmfph!", "Mmmf mrrfff!", "Mmmf mnnf!")
	var/say_verbs = list("mumbles", "says")

/datum/category_item/underwear/bottom/briefs //white
	item_state = "wear_m1"

/datum/category_item/underwear/bottom/briefs_grey
	item_state = "wear_m2"

/datum/category_item/underwear/bottom/briefs_green
	item_state = "wear_m3"

/datum/category_item/underwear/bottom/briefs_blue
	item_state = "wear_m4"

/datum/category_item/underwear/bottom/briefs_black
	item_state = "wear_m5"

/datum/category_item/underwear/bottom/panties_noback
	item_state = "wear_m1"
