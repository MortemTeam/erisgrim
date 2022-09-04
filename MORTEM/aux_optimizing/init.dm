#ifndef ERIS_L
// Default automatic ERIS_L detection.
// On Windows, looks in the standard places for `erislight.dll`.
// On Linux, looks in `.`, `$LD_LIBRARY_PATH`, and `~/.byond/bin` for either of
// `liberislight.so`

/* This comment bypasses grep checks */ /var/__eris_l

/proc/__detect_eris_l()
	if(world.system_type == UNIX)
		if (fexists("./liberislight.so"))
			// No need for LD_LIBRARY_PATH badness.
			return __eris_l = "./liberislight.so"
		else if (fexists("./erislight"))
			// Old dumb filename.
			return __eris_l = "./erislight"
		else if (fexists("[world.GetConfig("env", "HOME")]/.byond/bin/erislight"))
			// Old dumb filename in `~/.byond/bin`.
			return __eris_l = "erislight"
		else
			// It's not in the current directory, so try others
			return __eris_l = "liberislight.so"
	else
		return __eris_l = "erislight"

#define ERIS_L (__eris_l || __detect_eris_l())
#endif

/proc/eris_l_init()
	return call(ERIS_L, "auxtools_init")()

/proc/eris_l_shutdown()
	return call(ERIS_L, "auxtools_shutdown")()

/hook/startup/proc/auxtools_init()
	if(ERIS_L) world.log << "ERIS L INIT: [eris_l_init()]"
	return TRUE

/hook/shutdown/proc/auxtools_shutdown()
	if(ERIS_L) world.log << "ERIS L SHUTDOWN: [eris_l_shutdown()]"
	return TRUE

/proc/make_new(path, arguments)
	var/type = text2path(path)
	return new type(arglist(arguments))

/proc/auxtools_stack_trace(msg)
	CRASH(msg)
