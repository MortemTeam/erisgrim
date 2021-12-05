#define REDIS_REQUEST_LIB "MORTEM/adding/redis/" + (world.system_type == MS_WINDOWS ? "redis_request.dll" : "libredis_request.so")

/world/New() {
	world.log << "REDIS_REQUEST_LIB: " + call(REDIS_REQUEST_LIB, "auxtools_init")()
	..()
}
