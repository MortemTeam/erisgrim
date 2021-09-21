/obj/structure/skyblock
	opacity = TRUE

/obj/structure/skyblock/water
	name = "shallow water"
	icon = 'icons/misc/beach.dmi'
	icon_state = "seashallow"

/obj/structure/skyblock/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snoww"

/obj/structure/skyblock/snow/Bumped(atom/A)
	if(ishuman(A))
		to_chat(A, SPAN_NOTICE("A strong gust of wind blows you away."))

/obj/structure/skyblock/snow/giber/Bumped(atom/A)
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		H.gib()
