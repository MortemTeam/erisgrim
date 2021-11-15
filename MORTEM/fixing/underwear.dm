#define UNDERWEAR_LAYER 5

/mob/living/carbon/human/update_underwear(var/update_icons=1)
	overlays_standing[UNDERWEAR_LAYER] = null

	if(species.appearance_flags & HAS_UNDERWEAR)
		var/icon/underwear = new/icon(get_gender_icon(gender, "underwear"), "blank")
		for(var/entry in worn_underwear)
			var/obj/item/underwear/UW = entry
			var/icon/I = new /icon(UW.contained_sprite ? UW.icon : get_gender_icon(gender, "underwear"), UW.icon_state)
			if(UW.color)
				I.Blend(UW.color, ICON_ADD)
			underwear.Blend(I, ICON_OVERLAY)
		overlays_standing[UNDERWEAR_LAYER] = image(underwear)
	if(update_icons)
		update_icons()

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

#undef UNDERWEAR_LAYER
