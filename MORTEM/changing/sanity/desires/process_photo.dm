/obj/item/photo
	var/nude_count = 0

/obj/item/device/camera/proc/get_nudes_count(var/turf/T)
	var/nude_count = 0
	for(var/mob/living/carbon/human/H in T)
		if(H.invisibility || H.stat == DEAD)
			continue

		if(H.check_nude())
			nude_count += 1

	return nude_count

/obj/item/device/camera/captureimage(var/atom/target, var/mob/living/user, var/capturemode = CAPTURE_MODE_REGULAR)
	var/x_c = target.x - radius
	var/y_c = target.y + radius
	var/z_c	= target.z
	var/mobs = ""
	var/nudes = 0
	var/size = (radius*2)+1
	for(var/i = 1; i <= size; i++)
		for(var/j = 1; j <= size; j++)
			var/turf/T = locate(x_c, y_c, z_c)
			if(user.can_capture_turf(T))
				mobs += get_mobs(T)
				nudes += get_nudes_count(T)

			x_c++
		y_c--
		x_c = x_c - size

	var/obj/item/photo/p = createpicture(target, user, capturemode, radius)
	p.desc = "You can see on photo: \n" + mobs
	p.nude_count = nudes
	printpicture(user, p)


/datum/sanity/handle_Insight()
	. = ..()
	for(var/obj/item/photo/P in owner.get_contents())
		if(P.nude_count)
			add_rest(INSIGHT_DESIRE_NUDES, P.nude_count)
