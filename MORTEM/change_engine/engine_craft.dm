/datum/technology/bluespace_extended
	unlocks_designs = list(
		/datum/design/research/item/belt_holding,
		/datum/design/research/item/pouch_holding,
		/datum/design/research/item/trashbag_holding,
		/datum/design/research/item/oresatchel_holding,
		/datum/design/research/circuit/gas_thruster
	)

/datum/design/research/circuit/gas_thruster
	name = "Gas Thruster"
	build_path = /obj/item/electronics/circuitboard/engine
	sort_string = "FAHAH"
	category = CAT_MISC

/obj/item/electronics/circuitboard/engine
	name = T_BOARD("gas thruster")
	icon_state = "mcontroller"
	board_type = "machine"
	build_path = /obj/machinery/atmospherics/unary/engine
	req_components = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stock_parts/micro_laser/ultra = 3,
		/obj/item/stock_parts/capacitor/super = 3,
		/obj/item/stock_parts/subspace/ansible = 1
	)
