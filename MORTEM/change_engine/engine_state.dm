/obj/machinery/atmospherics/unary/engine
	anchored = FALSE
	on = FALSE

/obj/machinery/atmospherics/unary/engine/New()
	..()
	dir = NORTH
	initialize_directions = NORTH

/obj/machinery/atmospherics/unary/engine/attackby(obj/item/I, mob/user)
	if(I.has_quality(QUALITY_BOLT_TURNING))
		if(I.use_tool(user, src, WORKTIME_LONG, QUALITY_BOLT_TURNING, FAILCHANCE_EASY, STAT_MEC))
			user.visible_message(SPAN_WARNING("[user] has [anchored ? "un" : ""]secured \the [src]."), SPAN_NOTICE("You [anchored ? "un" : ""]secure \the [src]."))
			set_anchored(!anchored)
			if(anchored)
				atmos_init()
				build_network()
				if(node1)
					node1.atmos_init()
					node1.build_network()
			else
				disconnect()
