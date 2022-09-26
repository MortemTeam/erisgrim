/datum/storyevent/spacevine
	enabled = FALSE

/obj/effect/spawner/maintshroom/Initialize()
	return QDEL_HINT_QUEUE

/obj/effect/spawner/maintshroom/delayed/spawn_shroom()
	return

/datum/controller/subsystem/migration/handle_plant_spreading()
	return
