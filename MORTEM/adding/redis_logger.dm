/game_log(category, text)
	..()
	if(category in list("ADMIN", "GAME", "SAY", "WHISPER", "EMOTE", "OOC"))
		redis_client.lpush(category, "[game_id]@[text]")
