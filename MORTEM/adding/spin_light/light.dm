/obj/machinery/light
	var/static/obj/effect/spinning_light/spin_effect = null

/obj/machinery/light/Initialize()
	. = ..()

	if(!spin_effect)
		spin_effect = new(null)

/obj/machinery/light/update()
	. = ..()
	if(atmosalarmed && on && cmptext(base_state,"tube"))
		vis_contents += spin_effect
	else
		vis_contents -= spin_effect
