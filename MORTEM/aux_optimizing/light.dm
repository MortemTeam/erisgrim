/proc/auxtools_new(path, arguments)
	var/type = text2path(path)
	return new type(arglist(arguments))

/datum/controller/master/StartProcessing(delay)
	world.log << call("MORTEM/aux_optimizing/lightlib.dll", "auxtools_init")()
	..()
