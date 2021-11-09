/*
/obj/machinery/atm/attack_hand(user as mob)
	to_chat(user, SPAN_NOTICE("Unable to connect, try later..."))
*/

/obj/machinery/atm/verb/eject_id()
	set name = "Remove ID"
	set category = "Object"

	set src in view(1)

	if(usr.incapacitated())
		to_chat(usr, "<span class='warning'>You can't do that.</span>")
		return FALSE

	if(!Adjacent(usr))
		to_chat(usr, "<span class='warning'>You can't reach it.</span>")
		return FALSE

	if(!held_card)
		return

	playsound(loc, 'sound/machines/id_swipe.ogg', 100, 1)

	var/obj/item/card/id/card = held_card
	card.forceMove(get_turf(src))
	if(!issilicon(usr))
		usr.put_in_hands(card)

	to_chat(usr, SPAN_NOTICE("You remove [card] from [src]."))
	held_card = null
