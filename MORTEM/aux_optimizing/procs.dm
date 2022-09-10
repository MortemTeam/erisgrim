/proc/make_new(path, arguments)
	var/type = text2path(path)
	return new type(arglist(arguments))

/proc/world_contents()
    return world.contents

/proc/make_ispath(Val, Type)
	return ispath(Val, Type)

/proc/make_block(Start, End)
	return block(Start, End)

/proc/make_locate(x, y, z)
	return locate(x, y, z)


/* Uncomment if not implemented DMM_SUITE
/proc/auxtools_stack_trace(msg)
	CRASH(msg)
*/
