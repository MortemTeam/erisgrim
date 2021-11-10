/mob/living/carbon/superior_animal/roach
	var/obj/item/hat
	var/hat_x_offset = 6
	var/hat_y_offset = 6

	var/hats4roaches = /obj/item/clothing/head/armor
	var/hats_blocked = list(
		/obj/item/clothing/head,
		/obj/item/clothing/head/armor,
		/obj/item/clothing/head/armor/faceshield,
		/obj/item/clothing/head/collectable,
		/obj/item/clothing/head/collectable/hardhat,
	)

/mob/living/carbon/superior_animal/roach/Move()
	..()
	update_hat()

/mob/living/carbon/superior_animal/roach/New()
	. = ..()
	if(hats4roaches && prob(25))
		var/newhat_type = pick(
			subtypesof(hats4roaches) - \
			subtypesof(/obj/item/clothing/head/space/) - \
			subtypesof(/obj/item/clothing/head/space/rig) - \
			subtypesof(/obj/item/clothing/head/lightrig) - \
			hats_blocked)
		var/obj/item/clothing/head/newhat = new newhat_type(loc)
		wear_hat(newhat)

/mob/living/carbon/superior_animal/roach/getarmor(var/def_zone, var/type)
	return hat ? hat.armor[type] : 0

/mob/living/carbon/superior_animal/roach/death()
	..()
	if(hat)
		if(prob(1))
			hat.loc = get_turf(src)
			hat.update_plane()
		else
			new /obj/item/material/shard/shrapnel/scrap(loc)
			qdel(hat)

		hat = null
		update_hat()

/mob/living/carbon/superior_animal/roach/proc/wear_hat(var/obj/item/new_hat)
	if(hat)
		return
	hat = new_hat
	hat.forceMove(src)
	update_hat()

/mob/living/carbon/superior_animal/roach/proc/update_hat()
	overlays.Cut()
	if(hat)
		var/offset_x = hat_x_offset
		var/offset_y = hat_y_offset
		switch(dir)
			if(EAST)
				offset_y = -hat_y_offset
				offset_x = hat_x_offset
			if(WEST)
				offset_y = -hat_y_offset
				offset_x = -hat_x_offset
			if(NORTH)
				offset_y = -1
				offset_x = 1
			if(SOUTH)
				offset_y = -14
				offset_x = 1
		overlays |= get_hat_icon(hat, offset_x, offset_y)
