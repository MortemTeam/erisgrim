/atom/set_light(l_range, l_power, l_color=COLOR_LIGHTING_MAINT_DARK)
	if(l_range > 0 && l_range < MINIMUM_USEFUL_LIGHT_RANGE)
		l_range = MINIMUM_USEFUL_LIGHT_RANGE	//Brings the range up to 1.4, which is just barely brighter than the soft lighting that surrounds players.

	if(l_range != null) light_range = l_range
	if(l_power != null) light_power = l_power
	light_color = l_color

	update_light()

/obj/machinery/light/proc/tube_set_color(new_color)
	if(on)
		if(cmptext(base_state,"tube"))
			atmosalarmed = 1
			firealarmed = 0
			brightness_color = new_color
		update()

obj/machinery/light/set_blue()
	tube_set_color("#000055")

/obj/machinery/light/set_red()
	tube_set_color("#550000")
