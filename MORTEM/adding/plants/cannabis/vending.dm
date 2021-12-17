/obj/machinery/vending/hydroseeds/build_inventory()
	..()
	var/list/all_products = list(
		/obj/item/seeds/cannabis = 3,
	)

	for(var/entry in all_products)
		var/obj/item/seeds/S = new entry(src)
		var/name = S.name
		var/datum/data/vending_product/product = new/datum/data/vending_product(src, entry, name, amount = all_products[entry])
		product_records.Add(product)
