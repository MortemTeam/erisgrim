/obj/machinery/complant_teleporter
	var/list/materials_list = list(
		MATERIAL_STEEL = list("amount" = 30, "price" = 500), //base prices doubled untill new item are in
		MATERIAL_WOOD = list("amount" = 30, "price" = 500),
		MATERIAL_PLASTIC = list("amount" = 30, "price" = 500),
		MATERIAL_GLASS = list("amount" = 30, "price" = 500),
		MATERIAL_SILVER = list("amount" = 10, "price" = 1000),
		MATERIAL_PLASTEEL = list("amount" = 10, "price" = 2000),
		MATERIAL_GOLD = list("amount" = 10, "price" = 2000),
		MATERIAL_URANIUM = list("amount" = 10, "price" = 3000),
		MATERIAL_DIAMOND = list("amount" = 10, "price" = 4000),
	)

	var/list/parts_list = list(
		/obj/item/stock_parts/console_screen = 500,
		/obj/item/stock_parts/capacitor = 1000,
		/obj/item/stock_parts/scanning_module = 1000,
		/obj/item/stock_parts/manipulator = 1000,
		/obj/item/stock_parts/micro_laser = 1000,
		/obj/item/stock_parts/matter_bin = 1000,
		/obj/item/stock_parts/capacitor/excelsior = 3500,
		/obj/item/stock_parts/scanning_module/excelsior = 3500,
		/obj/item/stock_parts/manipulator/excelsior = 3500,
		/obj/item/stock_parts/micro_laser/excelsior = 3500,
		/obj/item/stock_parts/matter_bin/excelsior = 3500,
		/obj/item/clothing/under/excelsior = 500,
		/obj/item/electronics/circuitboard/excelsior_teleporter = 5000,
		/obj/item/electronics/circuitboard/excelsiorautolathe = 1500,
		/obj/item/electronics/circuitboard/excelsiorreconstructor = 1500,
		/obj/item/electronics/circuitboard/excelsior_turret = 1500,
		/obj/item/electronics/circuitboard/excelsiorshieldwallgen = 1500,
		/obj/item/electronics/circuitboard/excelsior_boombox = 1500,
		/obj/item/electronics/circuitboard/excelsior_autodoc = 1500,
		/obj/item/electronics/circuitboard/diesel = 1500,
	)

/obj/machinery/complant_teleporter/affect_grab(var/mob/user, var/mob/target)
	to_chat(user, SPAN_NOTICE("Not enough signal strength to send large objects."))

/obj/machinery/complant_teleporter/MouseDrop_T(var/mob/living/L, mob/living/user)
	to_chat(user, SPAN_NOTICE("Not enough signal strength to send large objects."))
