#ifndef ERIS_L
// Default automatic ERIS_L detection.
// On Windows, looks in the standard places for `erislight.dll`.
// On Linux, looks in `.`, `$LD_LIBRARY_PATH` for either of `liberislight.so`

/proc/__detect_eris_l()
	if(world.system_type == UNIX && fexists("./liberislight.so"))
		return "./liberislight.so"
	if(world.system_type == MS_WINDOWS && fexists("erislight.dll"))
		return "erislight.dll"

#define ERIS_L __detect_eris_l()

/proc/eris_l_init()
	return call(ERIS_L, "auxtools_init")()

/proc/eris_l_shutdown()
	return call(ERIS_L, "auxtools_shutdown")()

/hook/startup/proc/auxtools_init()
	if(ERIS_L) world.log << "ERIS L INIT: [eris_l_init()]"
	return TRUE

/world/Del()
	if(ERIS_L) world.log << "ERIS L SHUTDOWN: [eris_l_shutdown()]"
	. = ..()

#endif