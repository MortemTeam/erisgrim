/turf/get_lumcount(var/minlum = 0, var/maxlum = 1)
	var/totallums = istype(loc, /area/space) ? SSdaynight.get_lumcount(): 0
	if (!lighting_overlay)
		return totallums

	for(var/LL in corners)
		var/datum/lighting_corner/L = LL
		totallums += L.lum_r + L.lum_b + L.lum_g

	totallums /= 12 // 4 corners, each with 3 channels, get the average.

	totallums = (totallums - minlum) / (maxlum - minlum)

	return CLAMP01(totallums)
