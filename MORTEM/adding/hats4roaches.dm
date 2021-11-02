/mob/living/carbon/superior_animal/roach
	var/obj/item/hat
	var/hat_x_offset = 6
	var/hat_y_offset = 8

	var/list/hats4roaches = list(
		/obj/item/clothing/head/collectable/chef,
		/obj/item/clothing/head/collectable/paper,
		/obj/item/clothing/head/collectable/beret,
		/obj/item/clothing/head/collectable/welding,
		/obj/item/clothing/head/collectable/flatcap,
		/obj/item/clothing/head/collectable/pirate,
		/obj/item/clothing/head/collectable/thunderdome,
		/obj/item/clothing/head/collectable/swat,
		/obj/item/clothing/head/collectable/police,
		/obj/item/clothing/head/collectable/xenom,
		/obj/item/clothing/head/collectable/petehat,
		/obj/item/clothing/head/collectable/wizard,
		/obj/item/clothing/head/collectable/hardhat,
		/obj/item/clothing/head/fedora,
		/obj/item/clothing/head/hasturhood,
		/obj/item/clothing/head/hgpiratecap,
		/obj/item/clothing/head/nursehat,
		/obj/item/clothing/head/soft/rainbow,
		/obj/item/clothing/head/soft/grey,
	)

/mob/living/carbon/superior_animal/roach/New()
	..()
	var/newhat = pick(hats4roaches)
	var/obj/item/hatobj = new newhat(loc)
	wear_hat(hatobj)


/mob/living/carbon/superior_animal/roach/Move()
	..()
	update_hat()

//When roaches die near a leader, the leader may call for reinforcements
/mob/living/carbon/superior_animal/roach/death()
	..()
	if(hat)
		hat.loc = get_turf(src)
		hat.update_plane()
		hat = null
		update_hat()

/mob/living/carbon/superior_animal/roach/proc/wear_hat(var/obj/item/new_hat)
	if(hat)
		return
	hat = new_hat
	new_hat.forceMove(src)
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
				offset_y = -2
				offset_x = 0
			if(SOUTH)
				offset_y = -16
				offset_x = 0
		overlays |= get_hat_icon(hat, offset_x, offset_y)
