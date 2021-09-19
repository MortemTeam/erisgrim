/datum/vote_choice/map
	text = "You shouldn't see this."
	var/mappath

/datum/vote_choice/map/on_win()
	change_map(mappath)
	world.Reboot()

/datum/poll/votemap
	name = "Votemap"
	question = "Choice map"

	time = 30
	choice_types = list()

	can_revote = TRUE
	can_unvote = TRUE
	see_votes = TRUE

/datum/poll/storyteller/init_choices()
	for(var/K in SSmapping.map_templates)
		if(istype(SSmapping.map_templates[K], /datum/map_template/default))
			var/datum/vote_choice/map/M = new
			M.text = SSmapping.map_templates[K].name
			M.mappath = SSmapping.map_templates[K].mappath
			choices += M

	SSticker.ship_was_nuked = TRUE
