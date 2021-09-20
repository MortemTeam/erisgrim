/datum/controller/subsystem/mapping
	//var/datum/map_template/default/using_map

/datum/controller/subsystem/mapping/Initialize(start_timeofday)
	..()
	var/path = text2path(copytext(file2text("data/use_map"),1,-1))
	if(!path)
		path = 'MORTEM/maps/CEVEris/CEV_Eris_beach.dmm'

	maploader.load_map('MORTEM/maps/CEVEris/CEV_Eris_beach.dmm')
