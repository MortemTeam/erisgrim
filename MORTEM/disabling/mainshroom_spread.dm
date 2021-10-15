
/datum/controller/subsystem/migration/fire()
	//Life scanning
	if (world.time > next_scan)
		do_scan()

	if (distressed_burrows.len)
		handle_distress_calls()

	if (world.time > next_migrate)
		do_migrate()
