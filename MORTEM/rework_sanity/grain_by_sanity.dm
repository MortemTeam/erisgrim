/datum/sanity
	var/obj/screen/film_grain

/datum/sanity/New(mob/living/carbon/human/H)
	..()
	film_grain = new()
	film_grain.name = "Film Grain"
	film_grain.icon = 'MORTEM/rework_sanity/static.dmi'
	film_grain.screen_loc = ui_entire_screen
	film_grain.alpha = 110
	film_grain.layer = FULLSCREEN_LAYER
	film_grain.plane = FULLSCREEN_PLANE
	film_grain.mouse_opacity = 0

/mob/living/carbon/human/show_HUD()
	..()
	if(client)
		client.screen += sanity.film_grain

/datum/sanity/updateLevel(new_level)
	..()
	var/state = "[rand(1, 9)] "
	switch(new_level)
		if(-INFINITY to 33)
			state += "heavy"
		if(33 to 66)
			state += "moderate"
		if(66 to INFINITY)
			state += "light"

	film_grain.icon_state = state

/mob/living/silicon
	var/obj/screen/film_grain

/mob/living/silicon/New()
	..()
	film_grain = new()
	film_grain.name = "Film Grain"
	film_grain.icon = 'MORTEM/rework_sanity/static.dmi'
	film_grain.icon_state = "[rand(1, 9)] moderate"
	film_grain.screen_loc = ui_entire_screen
	film_grain.alpha = 110
	film_grain.layer = FULLSCREEN_LAYER
	film_grain.plane = FULLSCREEN_PLANE
	film_grain.mouse_opacity = 0

/mob/living/silicon/show_HUD()
	..()
	if(client)
		client.screen += film_grain
