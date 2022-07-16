/obj/item/projectile/bullet/bolt
    muzzle_type = null
    armor_penetration = ARMOR_PEN_EXTREME

/obj/item/projectile/bullet/bolt/on_hit(mob/living/target, def_zone = BP_CHEST)
    if(istype(target) && prob(armor_penetration))
        target.embed(src, def_zone)


/obj/item/gun/energy/poweredcrossbow
	fire_sound = 'sound/weapons/punchmiss.ogg'
	fire_sound_text = "a solid thunk"

/obj/item/gun/energy/poweredcrossbow/attackby(obj/item/I, mob/living/user)
    . = ..()
    update_icon()
    I.update_icon()
    return .

/obj/item/gun/energy/poweredcrossbow/attack_hand(mob/living/user)
	if(pre_pickup(user))
		pickup(user)
		return TRUE
	return FALSE

/obj/item/gun/energy/poweredcrossbow/MouseDrop(over_object)
    if(bolt && (src.loc == usr) && istype(over_object, /obj/screen/inventory/hand))
        usr.put_in_hands(bolt)
        bolt = null

        usr.visible_message(
            "[usr] removes [bolt] from [src].",
            SPAN_NOTICE("You remove [bolt] from [src].")
        )

        update_icon()
        return

    return ..()
