/datum/event/infestation
	possible_mobs_mundane = list(
		//INFESTATION_MICE = 17,
		INFESTATION_SPIDERLINGS = 8,
	)

/datum/event/supply_pod/add_guardians()
	var/list/possible_mobs = list(
		/mob/living/simple_animal/hostile/hivebot,
		/mob/living/simple_animal/hostile/scarybat,
		// /mob/living/simple_animal/mouse,
		/obj/spawner/mob/slime/rainbow,
		/obj/spawner/mob/spiders,
		/obj/spawner/mob/roaches,
		/mob/living/simple_animal/hostile/samak,
		/mob/living/simple_animal/hostile/bear,
		/mob/living/simple_animal/hostile/carp,
		/mob/living/simple_animal/hostile/creature,
		/mob/living/simple_animal/hostile/carp/pike
	)

	//It may not contain mobs, or it may be a clown car full of horrors that spill forth like boiling oil
	while (prob(80))
		var/newtype = pick(possible_mobs)

		var/num = rand(2,6)
		for (var/i = 0; i < num;i++)
			pod_contents.Add(newtype)

/datum/turf_initializer/maintenance/Initialize(var/turf/simulated/T)
	if(T.density)
		return
	// Quick and dirty check to avoid placing things inside windows
	if(locate(/obj/structure/low_wall || /obj/structure/grille, T))
		return

	var/cardinal_turfs = T.CardinalTurfs()

	if(prob(2))
		var/path = junk()
		new path(T)
	if(prob(2))
		new /obj/effect/decal/cleanable/blood/oil(T)
	//if(prob(1))
	//	new /mob/living/simple_animal/mouse(T)
	if(prob(25))	// Keep in mind that only "corners" get any sort of web
		attempt_web(T, cardinal_turfs)

/datum/random_map/noise/desert/get_additional_spawns(var/value, var/turf/T)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(isnull(val)) val = 0
	switch(val)
		if(2 to 3)
			if(prob(60))
				var/grass_path = pick(typesof(/obj/structure/flora/grass)-/obj/structure/flora/grass)
				new grass_path(T)
			if(prob(5))
				//var/mob_type = pick(list(/mob/living/simple_animal/lizard, /mob/living/simple_animal/mouse))
				var/mob_type = /mob/living/simple_animal/lizard
				new mob_type(T)
		if(5 to 6)
			if(prob(20))
				var/grass_path = pick(typesof(/obj/structure/flora/grass)-/obj/structure/flora/grass)
				new grass_path(T)
		if(7 to 9)
			if(prob(60))
				new /obj/structure/flora/bush(T)
			else if(prob(20))
				new /obj/structure/flora/tree/dead(T)

/datum/random_map/noise/tundra/get_additional_spawns(var/value, var/turf/T)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(isnull(val)) val = 0
	switch(val)
		if(2)
			if(prob(5))
				new /mob/living/simple_animal/crab(T)
		if(6)
			if(prob(60))
				var/grass_path = pick(typesof(/obj/structure/flora/grass)-/obj/structure/flora/grass)
				new grass_path(T)
			if(prob(5))
				//var/mob_type = pick(list(/mob/living/simple_animal/lizard, /mob/living/simple_animal/mouse))
				var/mob_type = /mob/living/simple_animal/lizard
				new mob_type(T)
		if(7)
			if(prob(60))
				new /obj/structure/flora/bush(T)
			else if(prob(30))
				new /obj/structure/flora/tree/pine(T)
			else if(prob(20))
				new /obj/structure/flora/tree/dead(T)
		if(8)
			if(prob(70))
				new /obj/structure/flora/tree/pine(T)
			else if(prob(30))
				new /obj/structure/flora/tree/dead(T)
			else
				new /obj/structure/flora/bush(T)
		if(9)
			new /obj/structure/flora/tree/pine(T)
