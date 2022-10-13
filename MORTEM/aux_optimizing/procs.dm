/proc/make_new(path, arguments)
	var/type = text2path(path)
	return new type(arglist(arguments))

/proc/world_contents()
    return world.contents.Copy()

/proc/make_view(Dist, Center)
	return view(Dist, Center)

/proc/make_ispath(Val, Type)
	return ispath(Val, Type)

/proc/make_block(Start, End)
	return block(Start, End)

/proc/make_locate(x, y, z)
	return locate(x, y, z)

/proc/inspect_value(v)
	return v // set debug breakpoint here

/* Uncomment if not implemented DMM_SUITE
/proc/auxtools_stack_trace(msg)
	CRASH(msg)
*/
