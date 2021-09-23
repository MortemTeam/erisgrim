/area/update_gravity()
	has_gravity = TRUE

/area/space
	has_gravity = TRUE

/area/space/has_gravity()
	return has_gravity

/area/Entered(A)
	if(!isliving(A))
		return

	var/mob/living/L = A

	if(!L.lastarea)
		L.lastarea = get_area(L.loc)

	var/area/newarea = get_area(L.loc)
	var/area/oldarea = L.lastarea

	if(oldarea.has_gravity != newarea.has_gravity)
		if(newarea.has_gravity == 1 && !MOVING_DELIBERATELY(L)) // Being ready when you change areas allows you to avoid falling.
			thunk(L)
		L.update_floating()

	L.lastarea = newarea
	play_ambience(L)
