/mob/living/carbon/superior_animal/roach
	name = "Kampfer Roach"
	desc = "A monstrous, dog-sized cockroach. These huge mutants can be everywhere where humans are, on ships, planets and stations."

	icon_state = "roach"

	mob_size = MOB_SMALL

	density = FALSE //Swarming roaches! They also more robust that way.

	attack_sound = 'sound/voice/insect_battle_bite.ogg'
	emote_see = list("chirps loudly.", "cleans its whiskers with forelegs.")
	turns_per_move = 4
	turns_since_move = 0

	meat_type = /obj/item/reagent_containers/food/snacks/meat/roachmeat
	meat_amount = 2

	maxHealth = 10
	health = 10

	var/blattedin_revives_left = 1 // how many times blattedin can get us back to life (as num for adminbus fun).

	melee_damage_lower = 1
	melee_damage_upper = 4

	min_breath_required_type = 3
	min_air_pressure = 15 //below this, brute damage is dealt

	faction = "roach"
	pass_flags = PASSTABLE
	acceptableTargetDistance = 3 //consider all targets within this range equally
	randpixel = 12
	overkill_gib = 16

	sanity_damage = 0.5

	//spawn_values
	spawn_tags = SPAWN_TAG_ROACH
	rarity_value = 5

	var/atom/eat_target // target that the roach wants to eat
	var/fed = 0 // roach gets fed after eating a corpse
	var/probability_egg_laying = 25 // probability to lay an egg
	var/taming_window = 30 //How long you have to tame this roach, once it's pacified.
	var/busy_time // how long it will take to eat/lay egg
	var/busy_start_time // when it started eating/laying egg

	var/obj/item/hat
	var/hat_x_offset = 6
	var/hat_y_offset = 6

	var/hats4roaches = /obj/item/clothing/head
	var/hats_blocked = list(
		/obj/item/clothing/head,
		/obj/item/clothing/head/armor,
		/obj/item/clothing/head/armor/faceshield,
		/obj/item/clothing/head/collectable,
		/obj/item/clothing/head/collectable/hardhat,
		/obj/item/clothing/head/lightrig,
		/obj/item/clothing/head/lightrig/hacker,
		/obj/item/clothing/head/space/rig,
		/obj/item/clothing/head/space/rig/ce,
		/obj/item/clothing/head/space/rig/combat,
		/obj/item/clothing/head/space/rig/combat/ironhammer,
		/obj/item/clothing/head/space/rig/eva,
		/obj/item/clothing/head/space/rig/hazard,
		/obj/item/clothing/head/space/rig/hazmat,
		/obj/item/clothing/head/space/rig/industrial,
		/obj/item/clothing/head/space/rig/light,
		/obj/item/clothing/head/space/rig/medical,
		/obj/item/clothing/head/space/rig/merc,
		/obj/item/clothing/head/space/rig/techno
	)


/mob/living/carbon/superior_animal/roach/New()
	. = ..()
	if(hats4roaches)
		var/newhat_type = pick(subtypesof(hats4roaches) - hats_blocked)
		var/obj/item/clothing/head/newhat = new newhat_type(loc)
		wear_hat(newhat)

/mob/living/carbon/superior_animal/roach/getarmor(var/def_zone, var/type)
	if(!hat)
		return 0

	return hat.armor[type]

//When roaches die near a leader, the leader may call for reinforcements
/mob/living/carbon/superior_animal/roach/death()
	.=..()
	if(.)
		for (var/mob/living/carbon/superior_animal/roach/fuhrer/F in range(src,8))
			F.distress_call()

	if(prob(1))
		visible_message(SPAN_DANGER("\the [src] hacks up a tape!"))
		new /obj/item/music_tape(get_turf(src))

	else if(prob(10))
		visible_message(SPAN_DANGER("\the [src] drops behind a gift basket!"))
		new /obj/item/storage/box/halloween_basket(get_turf(src))

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
				offset_y = -1
				offset_x = 1
			if(SOUTH)
				offset_y = -14
				offset_x = 1
		overlays |= get_hat_icon(hat, offset_x, offset_y)

