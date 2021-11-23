
/obj/item/stack/material/diamond
	icon = 'MORTEM/changing/materials/icons.dmi'
	icon_state = "handful-diamond"
	max_amount = 60
	novariants = FALSE

/obj/item/stack/material/diamond/full
	amount = 60

/material/diamond
	sheet_singular_name = "handful"
	sheet_plural_name = "handful"

/*                             */

/obj/item/stack/material/uranium
	icon = 'MORTEM/changing/materials/icons.dmi'
	icon_state = "rods-uran"
	max_amount = 60
	novariants = FALSE

/obj/item/stack/material/uranium/full
	amount = 60

/material/uranium
	sheet_singular_name = "rod"
	sheet_plural_name = "rods"

/*                             */

/obj/item/stack/material/plasma
	icon = 'MORTEM/changing/materials/icons.dmi'
	icon_state = "handful-plasma"
	max_amount = 60
	novariants = FALSE

/obj/item/stack/material/plasma/full
	amount = 60

/obj/item/stack/material/plasma/attack_self(var/mob/user)
	var/turf/T = get_turf(src)
	T.assume_gas("plasma", 1 * 10, T20C)

	user.visible_message(
		SPAN_DANGER("[user] blown dust in the wind."),
		SPAN_NOTICE("You've blown dust in the wind.")
	)
	use(1)

/obj/item/stack/material/plasma/attackby(obj/item/I, mob/user)
	..()
	if(!isflamesource(I))
		return

	var/turf/T = get_turf(src)
	T.assume_gas("plasma", amount * 10, 200 + T20C)

	user.visible_message(
		SPAN_DANGER("Fire covers a handful of sand."),
		SPAN_NOTICE("Fire covers a handful of sand.")
	)

	use(amount)

/obj/item/stack/material/plasma/throw_at(atom/target, range, speed, thrower)
	var/turf/T = get_turf(src)
	T.assume_gas("plasma", amount * 10, T20C)

	thrower.visible_message(
		SPAN_DANGER("[thrower] blown dust in the wind."),
		SPAN_NOTICE("You've blown dust in the wind.")
	)

	use(amount)

/material/plasma
	sheet_singular_name = "handful"
	sheet_plural_name = "handful"

/material/plasma/combustion_effect(var/turf/T, var/temperature, var/effect_multiplier)
	if(isnull(ignition_point))
		return 0
	if(temperature < ignition_point)
		return 0
	var/totalPlasma = 0
	for(var/turf/simulated/floor/target_tile in RANGE_TURFS(2, T))
		var/plasmaToDeduce = (temperature/30) * effect_multiplier
		totalPlasma += plasmaToDeduce
		target_tile.assume_gas("plasma", plasmaToDeduce, 200+T0C)
		spawn (0)
			target_tile.hotspot_expose(temperature, 400)
	return round(totalPlasma/100)
