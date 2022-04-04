/obj/item/arrow
    force = WEAPON_FORCE_WEAK
    throwforce = WEAPON_FORCE_NORMAL
    armor_penetration = ARMOR_PEN_SHALLOW

/obj/item/gun/launcher/crossbow
    var/charge_cost = 1000

/obj/item/gun/launcher/crossbow/superheat_rod(mob/user)
    if(!user || !cell || !bolt) return
    if(!cell.check_charge(charge_cost)) return

    to_chat(user, SPAN_NOTICE("[bolt] sparks and crackles as it gives off a red-hot glow."))

    bolt.throwforce = WEAPON_FORCE_DANGEROUS
    bolt.armor_penetration = ARMOR_PEN_DEEP
    bolt.icon_state = "metal-rod-superheated"
    cell.use(charge_cost)
