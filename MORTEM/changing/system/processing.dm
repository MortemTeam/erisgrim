/datum/controller/subsystem/processing
	var/atom/most_busy_thing = null
	var/most_busy_time = null

/datum/controller/subsystem/processing/fire(resumed = 0)
	if(!resumed)
		src.current_run = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/current_run = src.current_run
	var/times_fired = src.times_fired

	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--

		var/start_time = TimeOfGame

		if(QDELETED(thing))
			processing -= thing
		else if(call(thing, process_proc)(src.wait, times_fired, src) == PROCESS_KILL)
			STOP_PROCESSING(src, thing)

		var/total_time = TimeOfGame - start_time
		if(QDELETED(most_busy_thing) || total_time > most_busy_time)
			most_busy_thing = thing
			most_busy_time = total_time

		if (MC_TICK_CHECK)
			return
