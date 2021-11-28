#define AUXSHELL "MORTEM/adding/redis/auxshell." + (world.system_type == MS_WINDOWS ? "dll" : "so")

/proc/aux_shell()

/world/New() {
	world.log << "AUXSHELL: " + call(AUXSHELL, "auxtools_init")()
	..()
}
