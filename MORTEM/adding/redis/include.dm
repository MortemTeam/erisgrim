#include "connector.dm"
#include "gset.dm"
#include "list.dm"

#define REDIS_REQUEST_LIB "MORTEM/adding/redis/" + (world.system_type == MS_WINDOWS ? "redis_request.dll" : "libredis_request.so")

/proc/redis_cmd(host, port, db, request)

/world/New() {
	world.log << "REDIS_REQUEST_LIB: " + call(REDIS_REQUEST_LIB, "auxtools_init")()
	..()
}
