/obj/item/implant/excelsior/on_uninstall()
	if(!istype(wearer) || !wearer.mind)
		return

	for(var/datum/antagonist/A in wearer.mind.antagonist)
		if(A.id == antag_id)
			A.remove_antagonist()

	alert(wearer, "You have forgotten all the events of this shift.")
	wearer.visible_message(SPAN_DANGER("As \the [src] is removed from \the [wearer]..."))
