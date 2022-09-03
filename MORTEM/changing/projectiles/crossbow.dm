//AMMUNITION

/obj/item/arrow
    name = "bolt"
    desc = "It's got a tip for you - get the point?"
    icon = 'icons/obj/weapons.dmi'
    icon_state = "bolt"
    item_state = "bolt"
    w_class = ITEM_SIZE_NORMAL
    sharp = TRUE
    edge = FALSE

/obj/item/arrow/rod
    name = "metal rod"
    desc = "A projectile for a crossbow. Don't cry for me, Orithena."
    icon_state = "metal-rod"
    force = WEAPON_FORCE_NORMAL
    throwforce = WEAPON_FORCE_LETHAL
    armor_divisor = ARMOR_PEN_EXTREME

/obj/item/gun/launcher/crossbow
    name = "powered crossbow"
    desc = "A 2557AD twist on an old classic. Pick up that can."
    icon = 'icons/obj/guns/energy/poweredcrossbow.dmi'
    icon_state = "crossbow"
    item_state = "crossbow"
    
    spawn_tags = SPAWN_TAG_GUN_HANDMADE 
    matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 5, MATERIAL_WOOD = 5)

    fire_sound = 'sound/weapons/punchmiss.ogg' // TODO: Decent THWOK noise.
    fire_sound_text = "a solid thunk"
    fire_delay = 25
    throw_distance = 13
    slot_flags = SLOT_BACK
    restrict_safety = TRUE
    twohanded = TRUE
    rarity_value = 35 //no price tag,then high rarirty

    var/charge_cost = 2000
    var/obj/item/bolt
    var/tension = 0                        // Current draw on the bow.
    var/max_tension = 5                    // Highest possible tension.
    var/release_speed = 5                // Speed per unit of tension.
    var/obj/item/cell/large/cell    // Used for firing superheated rods.
    var/current_user                    // Used to check if the crossbow has changed hands since being drawn.
    var/draw_time = 10                    // How long it takes to increase the draw on the bow by one "tension"

/obj/item/gun/launcher/crossbow/proc/superheat_rod(mob/user)
    if(!user || !cell || !bolt) return
    if(initial(bolt.throwforce) != bolt.throwforce)
        to_chat(user, SPAN_NOTICE("[bolt] already overheated!"))
        return

    if(!cell.check_charge(charge_cost))
        to_chat(user, SPAN_NOTICE("[bolt] not enough power to overheat."))
        return

    to_chat(user, SPAN_NOTICE("[bolt] sparks and crackles as it gives off a red-hot glow."))

    bolt.throwforce *= 2
    bolt.armor_divisor *= 2
    bolt.icon_state = "blade_stun"
    cell.use(charge_cost)

/obj/item/gun/launcher/crossbow/update_icon()
    icon_state = bolt ? "crossbow_drawn" : "crossbow"

/obj/item/gun/launcher/crossbow/update_release_force()
    release_force = tension * release_speed

/obj/item/gun/launcher/crossbow/consume_next_projectile(mob/user)
    if(tension <= 0)
        to_chat(user, SPAN_WARNING("\The [src] is not drawn back!"))
        return null

    return bolt

/obj/item/gun/launcher/crossbow/handle_post_fire(mob/user, atom/target)
    bolt = null
    tension = 0
    update_icon()
    ..()

/obj/item/gun/launcher/crossbow/attack_self(mob/living/user)
    if(tension)
        if(bolt)
            user.visible_message("[user] relaxes the tension on [src]'s string and removes [bolt].","You relax the tension on [src]'s string and remove [bolt].")
            bolt.loc = get_turf(src)
            bolt = null
        else
            user.visible_message("[user] relaxes the tension on [src]'s string.","You relax the tension on [src]'s string.")
        tension = 0
        update_icon()
    else
        draw(user)

/obj/item/gun/launcher/crossbow/proc/draw(mob/user)

    if(!bolt)
        to_chat(user, "You don't have anything nocked to [src].")
        return

    if(user.restrained())
        return

    current_user = user
    user.visible_message("[user] begins to draw back the string of [src].",SPAN_NOTICE("You begin to draw back the string of [src]."))
    tension = 1

    while(bolt && tension && loc == current_user)
        if(!do_after(user, draw_time, src)) //crossbow strings don't just magically pull back on their own.
            user.visible_message("[usr] stops drawing and relaxes the string of [src].",SPAN_WARNING("You stop drawing back and relax the string of [src]."))
            tension = 0
            update_icon()
            return

        //double check that the user hasn't removed the bolt in the meantime
        if(!(bolt && tension && loc == current_user))
            return

        tension++
        update_icon()

        if(tension >= max_tension)
            tension = max_tension
            to_chat(user, "[src] gives a satisfying clunk as the string is pulled back as far as it can go!")
            return

        user.visible_message("[usr] draws back the string of [src]!",SPAN_NOTICE("You continue drawing back the string of [src]!"))

/obj/item/gun/launcher/crossbow/proc/increase_tension(mob/user)
    if(!bolt || !tension || current_user != user) //Arrow has been fired, bow has been relaxed or user has changed.
        return

/obj/item/gun/launcher/crossbow/attackby(obj/item/I, mob/user)
    if(!bolt)
        if (istype(I,/obj/item/arrow))
            user.drop_from_inventory(I, src)
            bolt = I
            bolt.loc = src

            update_icon()
            user.visible_message("[user] slides [bolt] into [src].","You slide [bolt] into [src].")
            superheat_rod(user)
            return
        else if(istype(I,/obj/item/stack/rods))
            var/obj/item/stack/rods/R = I
            if (R.use(1))
                bolt = new /obj/item/arrow/rod(src)
                bolt.fingerprintslast = fingerprintslast
                bolt.loc = src
    
                update_icon()
                user.visible_message("[user] jams [bolt] into [src].","You jam [bolt] into [src].")
                superheat_rod(user)
            return

    if(istype(I, /obj/item/cell/large))
        if(!cell)
            user.drop_item()
            cell = I
            cell.loc = src
            to_chat(user, SPAN_NOTICE("You jam [cell] into [src] and wire it to the firing coil."))
            superheat_rod(user)
        else
            to_chat(user, SPAN_NOTICE("[src] already has a cell installed."))

    else if(I.get_tool_type(usr, list(QUALITY_SCREW_DRIVING), src))
        if(cell)
            var/obj/item/C = cell
            C.loc = get_turf(user)
            to_chat(user, SPAN_NOTICE("You jimmy [cell] out of [src] with [I]."))
            cell = null
        else
            to_chat(user, SPAN_NOTICE("[src] doesn't have a cell installed."))

    else
        ..()

// Replace "NEW" crossbow

/datum/craft_recipe/gun/poweredcrossbow
    name = "crossbow"
    result = /obj/item/gun/launcher/crossbow

/obj/item/gun/energy/poweredcrossbow
    spawn_blacklisted = TRUE

/datum/craft_recipe/gun/crossbow_bolt
    avaliableToEveryone = FALSE
