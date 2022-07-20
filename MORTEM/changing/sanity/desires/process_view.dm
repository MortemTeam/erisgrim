
/datum/sanity/handle_view()
	. = ..()
	for(var/atom/A in view(owner.client ? owner.client : owner))
		if(istype(A, /obj/machinery/media/jukebox))
			var/obj/machinery/media/jukebox/J = A
			if(J.playing)
				add_rest(INSIGHT_DESIRE_MUSIC, 2 * J.volume)

		if(ishuman(A))
			var/mob/living/carbon/human/H = A
			if(H.stat != DEAD && H.check_nude())
				add_rest(INSIGHT_DESIRE_NUDES, owner.check_nude() ? 3 : 2)

		if(istype(A, /obj/item/device/synthesized_instrument))
			var/obj/item/device/synthesized_instrument/SI = A
			if(SI.real_instrument.player.song.playing)
				add_rest(INSIGHT_DESIRE_MUSIC, 0.5)
