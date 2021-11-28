#define AUXSHELL "MORTEM/adding/redis/auxshell." + (world.system_type == MS_WINDOWS ? "dll" : "so")

/proc/aux_shell()

/datum/controller/master/StartProcessing(delay) {
	world.log << "AUXSHELL: " + call(AUXSHELL, "auxtools_init")()
	..()
}
