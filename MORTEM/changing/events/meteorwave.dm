/spawn_meteors(var/number = 1, var/list/meteortypes, var/startSide, var/zlevel)
	for(var/i = 0; i < number; i++)
		//If no target zlevel is specified, then we'll throw each meteor at an individually randomly selected ship zlevel
		var/target_level
		if (zlevel)
			target_level = zlevel
		else
			target_level = pick(list(1,2,3))
		spawn_meteor(meteortypes, startSide, target_level)
