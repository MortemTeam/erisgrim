SUBSYSTEM_DEF(daynight)
	name = "Day and night"
	priority = SS_PRIORITY_PROCESSING
	flags = SS_BACKGROUND|SS_POST_FIRE_TIMING|SS_NO_INIT
	wait = 10 MINUTES

	var/sky_color = COLOR_DEEP_SKY_BLUE
	var/hours = 11
	var/lum_by_hours = list(
		0,   //1
		0,   //2
		0,   //3
		0.1, //4
		0.2, //5
		0.3, //6
		0.4, //7
		0.5, //8
		0.6, //9
		0.7, //10
		0.8, //11
		0.9, //12
		0.8, //13
		0.7, //14
		0.6, //15
		0.5, //16
		0.4, //17
		0.3, //18
		0.2, //19
		0.1, //20
		0,   //21
		0,   //22
		0,   //23
		0    //24
 	)

/datum/controller/subsystem/daynight/stat_entry()
	..(hours)

/datum/controller/subsystem/daynight/fire(resumed = 0)
	hours += 1
	if(hours > 24)
		hours = 1

	var/lightlevel = lum_by_hours[hours]
	if(!lightlevel)
		return 0

	var/lum_r = lightlevel * GetRedPart  (sky_color) / 255
	var/lum_g = lightlevel * GetGreenPart(sky_color) / 255
	var/lum_b = lightlevel * GetBluePart (sky_color) / 255

	for(var/turf/T in block(locate(1,1,3),locate(world.maxx,world.maxy,3)))
		if(istype(T.loc, /area/space))
			if(!T.lighting_corners_initialised)
				T.generate_missing_corners()

			for(var/datum/lighting_corner/LC as() in T.get_corners())
				if(LC.active)
					LC.update_lumcount(lum_r, lum_g, lum_b)
		CHECK_TICK
