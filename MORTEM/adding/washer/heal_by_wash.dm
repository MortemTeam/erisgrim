/obj/machinery/shower/process_heat(var/mob/living/carbon/human/H)
	..()
	for(var/obj/item/organ/external/E in H.organs)
		if(!BP_IS_SILICON(E))
			if(E.brute_dam + E.burn_dam == 0)
				if(!(E.status & ORGAN_BLEEDING && E.open))
					E.wounds.Cut()