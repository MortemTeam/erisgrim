/obj/effect/water_effect
	name = "water"
	icon = 'MORTEM/adding/beach/icons.dmi'
	layer = TURF_LAYER
	plane = 127
	alpha = 255

	opacity       = FALSE
	anchored      = TRUE
	mouse_opacity = FALSE
	unacidable    = TRUE

/obj/effect/water_effect/above
	layer = MOB_LAYER+0.1

/obj/effect/water_effect/update_plane()
	return

/*
/turf/simulated/floor/beach
	name = "beach"
	icon = 'icons/misc/beach.dmi'
	icon_state = "sand"
	footstep_sound = /decl/sound_category/sand_footstep

/turf/simulated/floor/beach/sand
	name = "sand"

/turf/simulated/floor/beach/sand/alt
	icon_state = "sand_alt"

/turf/simulated/floor/beach/sand/desert
	icon_state = "desert"

/turf/simulated/floor/beach/coastline
	name = "coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"
	footstep_sound = /decl/sound_category/water_footstep
*/

/turf/simulated/floor/beach/water
	name = "water"
	icon = 'MORTEM/adding/beach/icons.dmi'
	icon_state = "water"
	initial_flooring = null

	var/obj/effect/water_effect/water_overlay
	var/watertype = "water5"
	var/processing_counts = 0

/turf/simulated/floor/beach/water/get_footstep_sound()
	return pick(list(
		'MORTEM/adding/beach/sounds/water1.ogg',
		'MORTEM/adding/beach/sounds/water2.ogg',
		'MORTEM/adding/beach/sounds/water3.ogg',
		'MORTEM/adding/beach/sounds/water4.ogg',
	))

/turf/simulated/floor/beach/water/pool
	name = "pool"
	icon_state = "pool"
	watertype = "poolwater"

/turf/simulated/floor/beach/water/ocean
	name = "ocean"
	icon_state = "seadeep"

/turf/simulated/floor/beach/water/ocean/abyss
	name = "abyss"
	icon_state = "abyss"
	watertype = "seadeep"

/turf/simulated/floor/beach/water/Initialize()
	. = ..()
	var/obj/effect/water_effect/W = new /obj/effect/water_effect(src)
	W.icon_state = watertype
	W.alpha = 255
	water_overlay = W

	create_reagents(2)

/turf/simulated/floor/beach/water/Destroy()
	if(water_overlay)
		qdel(water_overlay)
		water_overlay = null
	return ..()

/mob/living/proc/can_breathe_water()
	return FALSE

/turf/simulated/floor/beach/water/return_air_for_internal_lifeform(var/mob/living/carbon/L)
	var/datum/gas_mixture/above_air = return_air()
	if(L && L.lying && (!L.can_breathe_water() || !istype(L.wear_mask, /obj/item/clothing/mask/snorkel)))
		return new/datum/gas_mixture()

	return above_air // Otherwise their head is above the water, so get the air from the atmosphere instead.


/mob/living/carbon/human
	var/obj/effect/water_effect/water_overlay

/mob/living/carbon/human/update_icons()
	..()
	if(water_overlay)
		water_overlay.icon_state = "water_l" + (lying ? "_lying" : "")
		add_overlay(water_overlay)

/turf/simulated/floor/beach/water/Entered(atom/movable/AM, atom/oldloc)
	if(ishuman(AM))
		if(!processing_counts)
			START_PROCESSING(SSprocessing, src)

		var/mob/living/carbon/human/H = AM
		if(!H.water_overlay)
			sleep(H.movement_delay())
			H.water_overlay = new /obj/effect/water_effect/above(H)
			H.water_overlay.icon_state = "water_l"
			H.update_icons()

		processing_counts++

	..()

/turf/simulated/floor/beach/water/Exited(atom/movable/AM, atom/newloc)
	if(ishuman(AM))
		if(processing_counts > 0)
			processing_counts--

		if(!processing_counts)
			STOP_PROCESSING(SSprocessing, src)

		var/mob/living/carbon/human/H = AM
		if(!istype(newloc, type) && H.water_overlay)
			qdel(H.water_overlay)
			H.water_overlay = null
			H.update_icons()

	..()

/turf/simulated/floor/beach/water/Process()
	for(var/atom/movable/AM as() in loc)
		if(istype(AM) && AM.simulated)
			wash(AM)

	clean(src)
	reagents.add_reagent("water", reagents.get_free_space())

// Taken from shower
/turf/simulated/floor/beach/water/proc/wash(atom/movable/O as obj|mob)
	if(isliving(O))
		var/mob/living/L = O
		L.ExtinguishMob()
		L.fire_stacks = -20 //Douse ourselves with water to avoid fire more easily

	if(iscarbon(O))
		var/mob/living/carbon/M = O
		if(M.r_hand)
			M.r_hand.clean_blood()
		if(M.l_hand)
			M.l_hand.clean_blood()
		if(M.back)
			if(M.back.clean_blood())
				M.update_inv_back(0)

		//flush away reagents on the skin
		if(M.touching)
			var/remove_amount = M.touching.maximum_volume * M.reagent_permeability() //take off your suit first
			M.touching.remove_any(remove_amount)

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/washgloves = 1
			var/washshoes = 1
			var/washmask = 1
			var/washears = 1
			var/washglasses = 1

			if(H.wear_suit)
				washgloves = !(H.wear_suit.flags_inv & HIDEGLOVES)
				washshoes = !(H.wear_suit.flags_inv & HIDESHOES)

			if(H.head)
				washmask = !(H.head.flags_inv & HIDEMASK)
				washglasses = !(H.head.flags_inv & HIDEEYES)
				washears = !(H.head.flags_inv & HIDEEARS)

			if(H.wear_mask)
				if (washears)
					washears = !(H.wear_mask.flags_inv & HIDEEARS)
				if (washglasses)
					washglasses = !(H.wear_mask.flags_inv & HIDEEYES)

			if(H.head)
				if(H.head.clean_blood())
					H.update_inv_head(0)
			if(H.wear_suit)
				if(H.wear_suit.clean_blood())
					H.update_inv_wear_suit(0)
			else if(H.w_uniform)
				if(H.w_uniform.clean_blood())
					H.update_inv_w_uniform(0)
			if(H.gloves && washgloves)
				if(H.gloves.clean_blood())
					H.update_inv_gloves(0)
			if(H.shoes && washshoes)
				if(H.shoes.clean_blood())
					H.update_inv_shoes(0)
			if(H.wear_mask && washmask)
				if(H.wear_mask.clean_blood())
					H.update_inv_wear_mask(0)
			if(H.glasses && washglasses)
				if(H.glasses.clean_blood())
					H.update_inv_glasses(0)
			if(H.l_ear && washears)
				if(H.l_ear.clean_blood())
					H.update_inv_ears(0)
			if(H.r_ear && washears)
				if(H.r_ear.clean_blood())
					H.update_inv_ears(0)
			if(H.belt)
				if(H.belt.clean_blood())
					H.update_inv_belt(0)
			H.clean_blood(washshoes)
			H.update_icons()
		else
			if(M.wear_mask)						//if the mob is not human, it cleans the mask without asking for bitflags
				if(M.wear_mask.clean_blood())
					M.update_inv_wear_mask(0)
			M.clean_blood()
	else
		O.clean_blood()

	if(isturf(loc))
		var/turf/tile = loc
		for(var/obj/effect/E in tile)
			if(istype(E,/obj/effect/decal/cleanable) || istype(E,/obj/effect/overlay))
				qdel(E)

	reagents.splash(O, 10)
