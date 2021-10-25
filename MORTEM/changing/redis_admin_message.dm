/game_log(category, text)
	..()
	world.log << category
	if(category in list("ADMIN", "SAY", "WHISPER", "EMOTE", "GAME"))
		var/redis/R = new().setup(db=6)
		R.lpush(category, "[game_id]@[text]")
