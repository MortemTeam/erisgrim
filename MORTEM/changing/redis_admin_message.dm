/game_log(category, text)
	..()

	if(category in list("ADMIN", "SAY", "WHISPER", "EMOTE", "GAME"))
		var/redis/R = new(db=6)
		R.lpush(category, "[game_id]@[text]")