/datum/controller/subsystem/processing/fire(resumed = 0)
	if (!resumed)
		src.current_run = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/current_run = src.current_run
	var/times_fired = src.times_fired

	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--

		if(QDELETED(thing))
			processing -= thing
		else if(call(thing, process_proc)(src.wait, times_fired, src) == PROCESS_KILL)
			STOP_PROCESSING(src, thing)

		if (MC_TICK_CHECK)
			return
