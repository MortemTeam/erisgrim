/datum/spawnpoint/put_mob(mob/M, ignore_environment = FALSE, announce = TRUE)
	var/list/free_turfs = get_free_turfs()
	if(!free_turfs.len)
		return FALSE
	var/turf/spawn_turf = pick(free_turfs)

	M.forceMove(spawn_turf)

	// Moving wheelchair if they have one
	if(M.buckled && istype(M.buckled, /obj/structure/bed/chair/wheelchair))
		M.buckled.forceMove(M.loc)
		M.buckled.set_dir(M.dir)
	return TRUE