/datum/evacuation_controller
	deny = TRUE

/obj/machinery/computer/shuttle_control/multi/mercenary/attack_hand(user as mob)
	if(!allowed(user))
		to_chat(user, "<span class='warning'>Access Denied.</span>")
		return 1

	ui_interact(user)

/obj/machinery/computer/shuttle_control/attack_hand(user as mob)
	to_chat(user, SPAN_NOTICE("Unable to calibrate the navigator..."))

/obj/machinery/computer/supplycomp/attack_hand(user as mob)
	to_chat(user, SPAN_NOTICE("Unable to calibrate the navigator..."))