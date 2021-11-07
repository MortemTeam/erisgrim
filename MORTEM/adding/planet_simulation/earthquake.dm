/datum/storyevent/earthquake
	id = "earthquake_failure"
	name = "earthquake"

	event_type = /datum/event/earthquake
	event_pools = list(EVENT_LEVEL_MUNDANE = POOL_THRESHOLD_MUNDANE*0.8)
	tags = list(TAG_COMMUNAL)
	weight = 0.4 //This is a pain, make it less common


/////////////////////////////////////////////////////////////

/datum/event/earthquake
	announceWhen = 5

/datum/event/earthquake/announce()
	command_announcement.Announce("The ship enters a zone of turbulence, hold on tight.", "Turbulence Alert")

/datum/event/earthquake/start()
	for(var/mob/M in SSmobs.mob_list)
		if(M.client)
			shake_camera(M, 10 SECONDS, 1)
			playsound(M, 'sound/effects/alert.ogg', 100, 1, 0.5)
