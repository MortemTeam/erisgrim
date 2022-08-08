#define PERK_LONG_ARM /datum/perk/oddity/long_arm

/datum/perk/oddity/long_arm
    name = "Long Arm"
    desc = "Your hands will get up any ass. \
            You can open any bags on your back."

    icon = 'MORTEM/adding/perks/icons.dmi'
    icon_state = "long_arm" // https://game-icons.net/1x1/skoll/click.html


/obj/item/storage/backpack/worn_check(no_message = FALSE)
    if(!equip_access && is_equipped())
        if(!no_message && use_sound)
            playsound(loc, use_sound, 50, 1, -5)

        var/mob/living/L = loc
        if(istype(L))
            if(L.stats.getPerk(PERK_LONG_ARM))
                return TRUE
            if(!no_message)
                to_chat(L, "<span class='warning'>The [src] is too cumbersome to handle with one hand, you're going to have to set it down somewhere!</span>")

        return FALSE

    else if(!worn_access && is_worn())
        var/mob/living/L = loc
        if (istype(L))
            if(!no_message)
                to_chat(L, "<span class='warning'>Oh no! Your arms are not long enough to open [src] while it is on your back!</span>")
        if (!no_message && use_sound)
            playsound(loc, use_sound, 50, 1, -5)
        return FALSE

    return TRUE
