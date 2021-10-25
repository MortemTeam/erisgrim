/proc/send_to_redis(category, text)
	var/redis/R = new().setup(db=6)
	R.lpush(category, "[game_id]@[text]")

/log_admin(text)
	..()
	send_to_redis("ADMIN", text)

/log_game(text)
	..()
	send_to_redis("GAME", text)

/log_say(text)
	..()
	send_to_redis("SAY", text)

/log_whisper(text)
	..()
	send_to_redis("WHISPER", text)

/log_emote(text)
	..()
	send_to_redis("EMOTE", text)

/log_ooc(text)
	..()
	send_to_redis("OOC", text)
