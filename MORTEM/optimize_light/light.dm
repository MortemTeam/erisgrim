/proc/auxtools_new(path, arguments)
	var/type = text2path(path)
	return new type(arglist(arguments))

/datum/controller/master/StartProcessing(delay)
	world.log << call("MORTEM/optimize_light/lightlib.dll", "auxtools_init")()
	..()
