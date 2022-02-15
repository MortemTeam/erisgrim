/obj/item/clothing/suit/ianshirt
	name = "ianshirt"
	desc = "A worn out, curiously comfortable t-shirt with a picture of Ian. You wouldn't go so far as to say it feels like being hugged when you wear it, but it's pretty close. Good for sleeping in."
	style = STYLE_HIGH
	price_tag = 65

	body_parts_covered = UPPER_TORSO
	equip_delay = 3 SECONDS

	contained_sprite = TRUE
	icon = 'MORTEM/adding/clothing/suit_shirt/icons.dmi'

	icon_state = "ianshirt"
	item_state = "ianshirt"

/datum/gear/suit/ianshirt
	display_name = "ianshirt"
	path = /obj/item/clothing/suit/ianshirt
	cost = 1

/obj/machinery/vending/style/build_inventory()
	..()
	var/list/all_products = list(
		/obj/item/clothing/suit/ianshirt = 5,
	)

	for(var/entry in all_products)
		var/datum/data/vending_product/product = new/datum/data/vending_product(src, entry, amount = all_products[entry])
		product_records.Add(product)
