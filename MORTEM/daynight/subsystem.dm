SUBSYSTEM_DEF(daynight)
	name = "Day and night"
	priority = SS_PRIORITY_PROCESSING
	flags = SS_BACKGROUND|SS_POST_FIRE_TIMING|SS_NO_INIT
	wait = 10 MINUTES

	var/hours = 0
	var/lum_by_hours = list(
		0 = 0,
		1 = 0,
		2 = 0,
		3 = 0,
		4 = 1.7,
		5 = 3.4,
		6 = 5.1,
		7 = 6.8,
		8 = 8.5,
		9 = 10.2,
		10 = 11.9,
		11 = 13.6,
		12 = 15.3,
		13 = 13.6,
		14 = 11.9,
		15 = 10.2,
		16 = 8.5,
		17 = 6.8,
		18 = 5.1,
		19 = 3.4,
		20 = 1.7,
		21 = 0,
		22 = 0,
		23 = 0,
	)

/datum/controller/subsystem/daynight/stat_entry()
	..(hours)

/datum/controller/subsystem/daynight/fire(resumed = 0)
	hours += 1
	if(hours >= 24)
		hours = 0

/datum/controller/subsystem/daynight/proc/get_lumcount()
	return lum_by_hours[hours]
