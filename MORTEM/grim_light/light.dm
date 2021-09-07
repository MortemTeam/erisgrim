#define GRIM_RED    "#550000"
#define GRIM_GREEN  "#005500"
#define GRIM_BLUE   "#000055"
#define GRIM_ORANGE "#663300"
#define GRIM_YELLOW "#666600"

/atom/set_light(l_range, l_power, l_color=COLOR_LIGHTING_MAINT_DARK)
	if(l_range > 0 && l_range < MINIMUM_USEFUL_LIGHT_RANGE)
		l_range = MINIMUM_USEFUL_LIGHT_RANGE	//Brings the range up to 1.4, which is just barely brighter than the soft lighting that surrounds players.

	if(l_range != null) light_range = l_range
	if(l_power != null) light_power = l_power
	if(l_color != COLOR_LIGHTING_MAINT_DARK) light_color = l_color

	update_light()

/obj/machinery/light/proc/tube_set_color(new_color)
	if(on)
		if(cmptext(base_state,"tube"))
			atmosalarmed = 1
			firealarmed = 0
			brightness_color = new_color
		update()

obj/machinery/light/set_blue()
	tube_set_color(GRIM_BLUE)

/obj/machinery/light/set_red()
	tube_set_color(GRIM_RED)

/obj/machinery/power/apc/on_update_icon()
	..()
	var/l_range = 2
	var/l_power = 0.6

	if(update_state & UPDATE_BLUESCREEN)
		set_light(l_range, l_power, GRIM_BLUE)
		return

	if(!(stat & (BROKEN|MAINT)) && update_state & UPDATE_ALLGOOD)
		var/color
		switch(charging)
			if(0)
				color = GRIM_RED
			if(1)
				color = GRIM_BLUE
			if(2)
				color = GRIM_GREEN
		set_light(l_range, l_power, color)
		return

/obj/item/device/lighting/glowstick/flare
	light_color = GRIM_RED

/obj/item/device/lighting/glowstick/red
	light_color = GRIM_RED

/obj/item/device/lighting/glowstick/blue
	light_color = GRIM_BLUE

/obj/item/device/lighting/glowstick/orange
	light_color = GRIM_ORANGE

/obj/item/device/lighting/glowstick/yellow
	light_color = GRIM_YELLOW
