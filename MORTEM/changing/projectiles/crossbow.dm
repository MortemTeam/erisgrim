/obj/item/arrow/rod
    force = WEAPON_FORCE_DANGEROUS
    throwforce = WEAPON_FORCE_LETHAL
    armor_penetration = ARMOR_PEN_EXTREME

/obj/item/gun/energy/poweredcrossbow
    spawn_blacklisted = TRUE

/obj/item/gun/launcher/crossbow
    icon = 'icons/obj/guns/energy/poweredcrossbow.dmi'
    icon_state = "crossbow"
    item_state = "crossbow"

    spawn_tags = SPAWN_TAG_GUN_HANDMADE 
    matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 5, MATERIAL_WOOD = 5)

    draw_time = 10
    var/charge_cost = 2000

/obj/item/gun/launcher/crossbow/update_icon()
    icon_state = bolt ? "crossbow_drawn" : "crossbow"

/obj/item/gun/launcher/crossbow/superheat_rod(mob/user)
    if(!user || !cell || !bolt) return
    if(!cell.check_charge(charge_cost))
        to_chat(user, SPAN_NOTICE("[bolt] not enough power to overheat."))
        return

    to_chat(user, SPAN_NOTICE("[bolt] sparks and crackles as it gives off a red-hot glow."))

    bolt.throwforce *= 2
    bolt.armor_penetration *= 2
    bolt.icon_state = "metal-rod-superheated"
    cell.use(charge_cost)

/datum/craft_recipe/weapon/crossbow_bolt
	name = "crossbow"
	result = /obj/item/gun/launcher/crossbow
	steps = list(
		list(CRAFT_MATERIAL, 5, MATERIAL_WOOD), //old frame recipe
		list(/obj/item/stack/rods, 3, "time" = 20),
		list(QUALITY_WELDING, 10, "time" = 30),
		list(/obj/item/stack/cable_coil, 10, "time" = 10),
		list(CRAFT_MATERIAL, 3, MATERIAL_PLASTIC, "time" = 10),
		list(QUALITY_SCREW_DRIVING, 5, 10,"time" = 3)
	)
