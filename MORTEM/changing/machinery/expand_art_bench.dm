/obj/machinery/autolathe/artist_bench
	var/include_statues_art = list(
		/obj/structure/cyberplant,
		/obj/structure/sign,

	)
	var/block_statues_art = list(
		/obj/structure/sign,
		/obj/structure/sign/department,
		/obj/structure/sign/directions,
		/obj/structure/sign/double,
		/obj/structure/sign/double/barsign,
		/obj/structure/sign/double/maltesefalcon,
		/obj/structure/sign/double/map,
		/obj/structure/sign/faction,
		/obj/structure/sign/signnew,
	)

/obj/machinery/autolathe/artist_bench/choose_full_art(ins_used, mob/living/carbon/human/user)
	. = ..()
	var/obj/structure/artwork_statue/S = .
	if(!istype(S))
		return .

	var/list/available_to_drop = list(S.type)
	qdel(S)
	for(var/t in include_statues_art)
		available_to_drop += typesof(t)

	for(var/t in block_statues_art)
		available_to_drop -= t

	var/obj/structure/to_drop = pick(available_to_drop)
	return new to_drop(src)
