/obj/effect/portal/wormhole/rift/massive
	lifetime = 666 MINUTES

/obj/effect/portal/wormhole/rift/massive/Process()
	failchance = 0
	teleportations_left = 666
	entropy_value = 6
	update_icon()

/obj/effect/portal/wormhole/rift/massive/pair()
	partner = null
	if(!target)
		return

	var/turf/T = get_turf(target)
	partner = (locate(/obj/effect/portal/wormhole/rift/massive) in T)

	//There's no wormhole in the target tile yet. We shall make one
	if(!partner)
		partner = new /obj/effect/portal/wormhole/rift/massive(T, lifetime, loc)


/datum/storyevent/bluespace_rift/massive
	weight = 0

	name = "massive_bluespacerift"
	id = "massive_bluespacerift"

	event_type = /datum/event/bluespace_rift/massive

/datum/event/bluespace_rift/massive/setup()
	pair_number = 6
	rift_number = pair_number * 2
	prepare_event_areas(rift_number)

/datum/event/bluespace_rift/massive/start()
	for(var/i=0, i<pair_number, i++)
		var/area/enterence = pick_n_take(event_areas)
		var/area/exit = pick_n_take(event_areas)
		new /obj/effect/portal/wormhole/rift/massive(enterence.random_space(), exit.random_space())
