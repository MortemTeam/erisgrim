/obj/machinery/complant_teleporter
	materials_list = list(
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

	parts_list = list(
		/obj/item/stock_parts/console_screen = 50,
		/obj/item/stock_parts/capacitor = 100,
		/obj/item/stock_parts/scanning_module = 100,
		/obj/item/stock_parts/manipulator = 100,
		/obj/item/stock_parts/micro_laser = 100,
		/obj/item/stock_parts/matter_bin = 100,
		/obj/item/stock_parts/capacitor/excelsior = 350,
		/obj/item/stock_parts/scanning_module/excelsior = 350,
		/obj/item/stock_parts/manipulator/excelsior = 350,
		/obj/item/stock_parts/micro_laser/excelsior = 350,
		/obj/item/stock_parts/matter_bin/excelsior = 350,
		/obj/item/clothing/under/excelsior = 50,
		/obj/item/electronics/circuitboard/excelsior_teleporter = 500,
		/obj/item/electronics/circuitboard/excelsiorautolathe = 150,
		/obj/item/electronics/circuitboard/excelsiorreconstructor = 150,
		/obj/item/electronics/circuitboard/excelsior_turret = 150,
		/obj/item/electronics/circuitboard/excelsiorshieldwallgen = 150,
		/obj/item/electronics/circuitboard/excelsior_boombox = 150,
		/obj/item/electronics/circuitboard/excelsior_autodoc = 150,
		/obj/item/electronics/circuitboard/diesel = 150,
	)

/obj/machinery/complant_teleporter/affect_grab(var/mob/user, var/mob/target)
	to_chat(user, SPAN_NOTICE("Not enough signal strength to send large objects."))

/obj/machinery/complant_teleporter/MouseDrop_T(var/mob/living/L, mob/living/user)
	to_chat(user, SPAN_NOTICE("Not enough signal strength to send large objects."))
