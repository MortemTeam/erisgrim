/obj/item/electronics/circuitboard/unary_atmos/engine
	name = T_BOARD("gas thruster")
	icon_state = "mcontroller"
	build_path = /obj/machinery/atmospherics/unary/engine/
	origin_tech = list(TECH_POWER = 6, TECH_BLUESPACE = 5, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 100,
		/obj/item/stock_parts/matter_bin/super = 5,
		/obj/item/stock_parts/micro_laser/ultra = 5,
		/obj/item/stock_parts/manipulator/pico = 5,
		/obj/item/stock_parts/scanning_module/phasic = 5,
		/obj/item/stock_parts/capacitor/super = 5,
	)
