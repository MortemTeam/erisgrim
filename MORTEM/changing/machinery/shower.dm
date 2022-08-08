/obj/machinery/shower
    desc = "The HS-451. Installed in the 2550s by the Hygiene Division."

/obj/machinery/shower/verb/change_temp()
        set category = "Object"
        set name = "Change Water Temperature"
        set src in view(1)

        watertemp = input(usr, "What setting would you like to set the temperature valve to?", "Water Temperature Valve") in temperature_settings
        add_fingerprint(usr)
        usr.visible_message(
            SPAN_NOTICE("\The [usr] adjusts \the [src]."),
            SPAN_NOTICE("You adjust the shower."),
        )

/obj/machinery/shower/attack_hand(mob/M as mob)
    if(anchored)
        return ..()

/obj/machinery/shower/attackby(obj/item/I, mob/living/user)
    if(I.has_quality(QUALITY_BOLT_TURNING))
        if(I.use_tool(user, src, WORKTIME_NORMAL, QUALITY_BOLT_TURNING, FAILCHANCE_EASY, STAT_MEC))
            user.visible_message(SPAN_WARNING("[user] has [anchored ? "un" : ""]secured \the [src]."), SPAN_NOTICE("You [anchored ? "un" : ""]secure \the [src]."))
            set_anchored(!anchored)
            on = FALSE
            update_icon()
