/obj/item/clothing/mask/smokable/cigarette/joint
	name = "joint"
	desc = "A regular joint."
	icon_state = "samokrutkaoff"

	icon_on = "samokrutkaon"
	icon_off = "samokrutkaoff"
	type_butt = null
	chem_volume = 15.0
	smoketime = 150

/obj/item/paper/attackby(obj/item/P as obj, mob/user as mob)
	..()
	if(istype(P, /obj/item/reagent_containers/food/snacks/grown))
		var/obj/item/reagent_containers/food/snacks/grown/G = P
		if(!G.dry)
			to_chat(user, SPAN_NOTICE("[G] must be dried before you can grind and roll it."))
			return
		var/R_loc = loc
		var/roll_in_hands = FALSE
		if(ishuman(loc))
			R_loc = user.loc
			roll_in_hands = TRUE
		var/obj/item/clothing/mask/smokable/cigarette/joint/R = new(R_loc)
		if(G.reagents)
			if(G.reagents.has_reagent("nutriment"))
				G.reagents.del_reagent("nutriment")
			G.reagents.trans_to_obj(R, G.reagents.total_volume)
		R.desc += " Looks like it contains some [G]."
		to_chat(user, SPAN_NOTICE("You grind \the [G] and roll a big joint!"))
		R.add_fingerprint(user)
		qdel(src)
		qdel(G)
		if(roll_in_hands)
			user.put_in_hands(R)
		return
