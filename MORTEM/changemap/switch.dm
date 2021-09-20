/datum/map_template/default
	discard_prob = 100 // If non-zero, there is a chance that the map seeding algorithm will skip this template when selecting potential templates to use.

/datum/map_template/default/beach
	id = "d_beach"
	name = "Distress Beach"
	desc = "Light survival."

	mappath = 'MORTEM/maps/CEVEris/CEV_Eris_beach.dmm'

/datum/map_template/default/arctic
	id = "d_arctic"
	name = "Distress Arctic"
	desc = "Hard survival."

	mappath = 'MORTEM/maps/CEVEris/CEV_Eris_frost.dmm'

/proc/change_map(datum/map_template/default/M)
	to_world("<span class='notice'>Map has been changed to: <b>[M.name]</b></span>")
	log_and_message_admins("[key_name(usr)] changed map to [M.name]")
	fdel("data/use_map")
	text2file("[M.type]", "data/use_map")

ADMIN_VERB_ADD(/datum/admins/proc/changemap, R_ADMIN, TRUE)
/datum/admins/proc/changemap()
	set category = "Admin"
	set name = "Change map"

	if(!check_rights(R_ADMIN))
		return

	var/list/MT = list()
	for(var/K in SSmapping.map_templates)
		if(istype(SSmapping.map_templates[K], /datum/map_template/default))
			MT += SSmapping.map_templates[K].name

	var/datum/map_template/M = SSmapping.map_templates[input("Select map:","Change map",MT) as null|anything in MT]
	if(M)
		change_map(M)
