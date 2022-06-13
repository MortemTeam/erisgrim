/obj/machinery/nuclearbomb/explode()
	if (src.safety)
		timing = 0
		return
	src.timing = -1
	src.yes_code = 0
	src.safety = 1
	update_icon()
	playsound(src,'sound/machines/Alarm.ogg',100,0,5)
	SSticker.nuke_in_progress = TRUE
	sleep(100)

	var/off_station = 0
	var/turf/bomb_location = get_turf(src)
	if(bomb_location && isStationLevel(bomb_location.z))
		if( (bomb_location.x < (128-NUKERANGE)) || (bomb_location.x > (128+NUKERANGE)) || (bomb_location.y < (128-NUKERANGE)) || (bomb_location.y > (128+NUKERANGE)) )
			off_station = 1
	else
		off_station = 2

	if(get_storyteller())
		SSticker.nuke_in_progress = FALSE
		if(off_station == 1)
			to_chat(world, "<b>A nuclear device was set off, but the explosion was out of reach of the ship!</b>")
		else if(off_station == 2)
			to_chat(world, "<b>A nuclear device was set off, but the device was not on the ship!</b>")
		else
			to_chat(world, "<b>The ship was destoyed by the nuclear blast!</b>")

		//SSticker.ship_was_nuked = (off_station<2)	//offstation==1 is a draw. the station becomes irradiated and needs to be evacuated.
														//kinda shit but I couldn't  get permission to do what I wanted to do.

		SSticker.station_explosion_cinematic(off_station)

	return