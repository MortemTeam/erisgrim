/obj/item/device/camera/get_mobs(turf/the_turf as turf)
	var/mob_detail = ""
	for(var/mob/living/carbon/A in the_turf)
		if(A.invisibility) continue
		mob_detail += "\n" + A.examine() + "\n"

	return mob_detail
