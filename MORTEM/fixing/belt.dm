#define BELT_LAYER 10
#define WORN_BELT "_be"

/mob/living/carbon/human/update_inv_belt(var/update_icons=1)
	overlays_standing[BELT_LAYER] = null
	if(belt)
		var/t_state = belt.icon_state
		var/t_icon = belt.icon
		if(!t_state)	t_state = belt.item_state
		var/image/standing	= image(icon_state = t_state)

		if(belt.contained_sprite)
			t_state = ""
			t_state += "[belt.item_state][WORN_BELT]"

			if(belt.icon_override)
				t_icon = belt.icon_override

		else if(belt.icon_override)
			t_icon = belt.icon_override

		else
			t_icon = get_gender_icon(gender, "belt")

		standing = image(icon = t_icon, icon_state = t_state)
		standing.color = belt.color

		var/beltlayer = BELT_LAYER
		var/otherlayer = BELT_LAYER_ALT
		if(istype(belt, /obj/item/storage/belt))
			var/obj/item/storage/belt/ubelt = belt
			if(ubelt.show_above_suit)
				beltlayer = BELT_LAYER_ALT
				otherlayer = BELT_LAYER

		overlays_standing[beltlayer] = standing
		overlays_standing[otherlayer] = null

	if(update_icons)   update_icons()

#undef BELT_LAYER
#undef WORN_BELT
