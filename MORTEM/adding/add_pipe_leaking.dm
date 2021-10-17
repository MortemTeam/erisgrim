/obj/machinery/atmospherics/pipe
	var/leaking = FALSE

/obj/machinery/atmospherics/pipe/proc/set_leaking(new_leaking)
	leaking = TRUE

/obj/machinery/atmospherics/pipe/simple/on_update_icon(var/safety = 0)
	if(!check_icon_cache())
		return

	alpha = 255

	cut_overlays()

	if(!node1 && !node2)
		var/turf/T = get_turf(src)
		new /obj/item/pipe(loc, make_from=src)
		for (var/obj/machinery/meter/meter in T)
			if (meter.target == src)
				new /obj/item/pipe_meter(T)
				qdel(meter)
		qdel(src)
	else if(node1 && node2)
		add_overlays(icon_manager.get_atmos_icon("pipe", , pipe_color, "[pipe_icon]intact[icon_connect_type]"))
		set_leaking(FALSE)
	else
		add_overlays(icon_manager.get_atmos_icon("pipe", , pipe_color, "[pipe_icon]exposed[node1?1:0][node2?1:0][icon_connect_type]"))
		set_leaking(TRUE)

/obj/machinery/atmospherics/pipe/simple/Process()
	if(!parent) //This should cut back on the overhead calling build_network thousands of times per cycle
		..()
	else if(leaking)
		parent.mingle_with_turf(loc, volume)
	else
		. = PROCESS_KILL
