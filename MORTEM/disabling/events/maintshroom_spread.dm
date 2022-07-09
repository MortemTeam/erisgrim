/datum/storyevent/spacevine
	enabled = FALSE

/obj/effect/spawner/maintshroom/Initialize()
	qdel_self()

/datum/controller/subsystem/migration/handle_plant_spreading()
	return
