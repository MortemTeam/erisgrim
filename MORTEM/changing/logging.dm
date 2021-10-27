/game_log(category, text)
	..()
	world.log << "[category], [text]"
	if(category in list("ADMIN", "GAME", "SAY", "WHISPER", "EMOTE", "OOC"))
		world.log << redis_client.lpush(category, "[game_id]@[text]")
