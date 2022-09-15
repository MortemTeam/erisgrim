/datum/storyevent/spacevine
	enabled = FALSE

/obj/effect/spawner/maintshroom/Initialize()
	return QDEL_HINT_QUEUE

/datum/controller/subsystem/migration/handle_plant_spreading()
	return
