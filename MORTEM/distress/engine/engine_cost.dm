/obj/machinery/atmospherics/unary/engine/get_item_cost()
	return rand(5000, 15000)

/datum/trade_station/station_zarya
	inventory = list(
		"BO3DYX" = list(
			/obj/item/tank/air,
			/obj/item/tank/plasma,
			/obj/machinery/portable_atmospherics/canister/sleeping_agent,
			/obj/machinery/portable_atmospherics/canister/nitrogen,
			/obj/machinery/portable_atmospherics/canister/oxygen,
			/obj/machinery/portable_atmospherics/canister/air
		),
		"CHAPR*EHNE" = list(
			/obj/item/clothing/mask/gas,
			/obj/item/clothing/suit/storage/hazardvest,
			/obj/item/clothing/gloves/insulated,
			/obj/item/storage/toolbox/emergency,
			/obj/item/clothing/head/welding,
			/obj/item/storage/belt/utility,
			/obj/item/storage/pouch/engineering_supply,
			/obj/item/storage/pouch/engineering_tools,
			/obj/item/storage/briefcase/inflatable/empty,
			/obj/item/inflatable/door,
			/obj/item/inflatable/wall
		),
		"E/\\EKTPOHNKA" = list(
			/obj/item/electronics/circuitboard/shield_diffuser,
			/obj/item/electronics/circuitboard/shield_generator,
			/obj/item/electronics/circuitboard/long_range_scanner,
			/obj/item/electronics/circuitboard/solar_control,
			/obj/item/electronics/circuitboard/smes,
			/obj/item/electronics/circuitboard/breakerbox,
			/obj/item/electronics/circuitboard/recharger
		),
		"EHEPLNR" = list(
			/obj/item/electronics/tracker,
			/obj/machinery/power/emitter,
			/obj/machinery/power/rad_collector,
			/obj/machinery/power/supermatter,
			/obj/machinery/power/generator,
			/obj/machinery/atmospherics/binary/circulator,
			/obj/item/solar_assembly,
//			/obj/item/tracker_electronics, // broken for now? This is even used for something?
			/obj/machinery/field_generator,
			/obj/machinery/atmospherics/unary/engine = good_data("Gas Thruster", list(18,22), 6000)
		),
		"BCRKAR BCR4NHA" = list(
			/obj/machinery/pipedispenser/orderable,
			/obj/machinery/pipedispenser/disposal/orderable,
			/obj/machinery/pipelayer, // is this unused for some reason? its broken????
			/obj/item/cell/large,
			/obj/item/cell/large/high,
			/obj/structure/reagent_dispensers/watertank,
			/obj/structure/reagent_dispensers/fueltank,
			/obj/machinery/floodlight
		),
	)
