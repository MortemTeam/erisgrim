/obj/spawner/pack/junk_machine/item_to_spawn()
	return pickweight(list(
		/obj/spawner/structures/common = 14, //That one have MUCH MORE important objects for maints inside, that's why the number is hight
		/obj/spawner/closet/maintloot = 18, //That one is also important part of the maints
		/obj/spawner/closet/wardrobe = 6,
		/obj/machinery/atmospherics/unary/engine = 2,
		/obj/spawner/exosuit/damaged = 1, //Some dangerous shit can be found there
	))
