/obj/machinery/shower/process_heat(var/mob/living/carbon/human/H)
	..()
	H.sanity.add_rest(INSIGHT_DESIRE_SHOWER, 1.5)
