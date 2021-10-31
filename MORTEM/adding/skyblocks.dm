/area/skyblock/warn
	icon_state = "shuttlegrn"

/area/skyblock/warn/Entered(atom/A)
	..()
	if(ishuman(A))
		to_chat(A, SPAN_DANGER("<font size=3>A strong gust of wind blows you away.</font>"))

/area/skyblock/gib
	icon_state = "shuttlered"

/area/skyblock/gib/Entered(atom/A)
	..()
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		H.gib()
