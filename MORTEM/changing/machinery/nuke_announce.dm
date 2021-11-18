/obj/machinery/nuclearbomb
	var/loc_announced = FALSE

/obj/machinery/nuclearbomb/secure_device()
	..()
	loc_announced = FALSE

/obj/machinery/nuclearbomb/Process()
	..()
	if(timing && !loc_announced)
		command_announcement.Announce("Nuke bomb engaged in [loc]. Make sure the process is authorized by the command.", "Nuke Safety")
		loc_announced = TRUE
