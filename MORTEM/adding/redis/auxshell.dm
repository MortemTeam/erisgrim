#define AUXSHELL "MORTEM/adding/redis/" + (world.system_type == MS_WINDOWS ? "auxshell.dll" : "libauxshell.so")

/proc/aux_shell()

/world/New() {
	world.log << "AUXSHELL: " + call(AUXSHELL, "auxtools_init")()
	..()
}