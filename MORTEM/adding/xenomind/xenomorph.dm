/mob/living/carbon/xenomorph
	name = "xenomorph"
	icon = 'icons/mob/alien.dmi'
	icon_state = "alien"
	pass_flags = PASSTABLE

	speak_emote = list("hissing")

	layer = 5
	maxHealth = 80
	health = 80
	gender = NEUTER

	update_icon = 0
	nutrition = 700

	see_in_dark = 8
	update_slimes = 0

	// canstun and canweaken don't affect slimes because they ignore stun and weakened variables
	// for the sake of cleanliness, though, here they are.
	status_flags = CANPARALYSE|CANPUSH

	//spawn_values
	rarity_value = 10
	spawn_frequency = 10
	spawn_tags = SPAWN_TAG_MOB_ROOMBA


/mob/living/carbon/xenomorph/New(var/location, var/colour="grey")
	verbs += /mob/living/proc/ventcrawl

	name = "xenomorph ([rand(1, 1000)])"
	real_name = name

	..(location)

/mob/living/carbon/xenomorph/movement_delay()
	if (bodytemperature >= 330.23) // 135 F
		return 0	// slimes become supercharged at high temperatures

	var/tally = MOVE_DELAY_BASE

	var/health_deficiency = (maxHealth - health)
	if(health_deficiency >= 30) tally += (health_deficiency / 25)

	if (bodytemperature < 183.222)
		tally += (283.222 - bodytemperature) / 10 * 1.75

	if(health <= 0) // if damaged, the slime moves twice as slow
		tally *= 2

	return tally


/mob/living/carbon/xenomorph/Stat()
	. = ..()

	statpanel("Status")
	stat(null, "Health: [round((health / maxHealth) * 100)]%")
	stat(null, "Intent: [a_intent]")


/mob/living/carbon/xenomorph/u_equip(obj/item/W as obj)
	return

/mob/living/carbon/xenomorph/attack_ui(slot)
	return


/mob/living/carbon/xenomorph/attackby(obj/item/W, mob/user)
	if(W.force > 0)
		if(prob(25))
			to_chat(user, SPAN_DANGER("[W] passes right through [src]!"))
			return

	..()

/mob/living/carbon/xenomorph/restrained()
	return

/mob/living/carbon/xenomorph/toggle_throw_mode()
	return
