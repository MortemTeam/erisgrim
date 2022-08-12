/datum/sanity/handle_area()
    . = ..()
    var/area/A = get_area_master(owner)
    var/obj/machinery/media/M = A.media_source
    if(M && M.playing)
        add_rest(INSIGHT_DESIRE_MUSIC, 2 * M.volume)
