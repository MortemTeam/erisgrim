/datum/storyevent/infestation/massive
	id = "massive_infestation"
	name = "massive_infestation"
	enabled = FALSE

	event_type = /datum/event/infestation/massive

/datum/event/infestation/massive
	possible_mobs_mundane = list(
		INFESTATION_ROACHES = 6,
		INFESTATION_SPIDERS = 6,
	)

	possible_mobs_moderate = list(
		INFESTATION_ROACHES = 7,
		INFESTATION_SPIDERS = 7,
	)

	possible_mobs_major = list(
		INFESTATION_ROACHES = 8,
		INFESTATION_SPIDERS = 8,
	)

/datum/event/infestation/massive/setup()
	announceWhen = rand(20, 80) //Very large random window for announcement,
	switch(severity)
		if(EVENT_LEVEL_MUNDANE)
			num_areas = 666
		if(EVENT_LEVEL_MODERATE)
			num_areas = 777
		if(EVENT_LEVEL_MAJOR)
			num_areas = 999

	choose_area()
	choose_mobs()

/datum/event/infestation/spawn_mobs()
	var/mobs = 0
	for (var/obj/structure/burrow/B in chosen_burrows)
		for(var/i = 1, i <= num_spawns_per_area,i++)
			var/spawned_mob = pickweight(chosen_mob_classification)
			new spawned_mob(B)
			mobs++

		//Send the migration
		B.migrate_to(chosen_burrows[B], infestation_time, 0)

	log_and_message_admins("Infestation [event_name] sending [mobs] mobs to [num_areas] areas!")
