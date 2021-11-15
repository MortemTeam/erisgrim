/obj/item/contraband/poster/placed/New()
	..()
	if(icon_state == "random")
		icon_state = pickweight(list(
			"bsposter[rand(1,58)]" = 58,
			"poster[rand(1,10)]"   = 10,
			"excel[rand(1,2)]"     = 2,
		))
