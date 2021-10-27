redis {
	proc/lpush(var/key as text, var/value) {
		// https://redis.io/commands/lpush
		return request(_form_key_value("LPUSH", key, value))
	}

	proc/rpush(var/key as text, var/value) {
		// https://redis.io/commands/rpush
		return request(_form_key_value("RPUSH", key, value))
	}

	proc/lpop(var/key as text) {
		// https://redis.io/commands/lpop
		return request(_form_single("LPOP", key))
	}

	proc/rpop(var/key as text) {
		// https://redis.io/commands/rpop
		return request(_form_single("RPOP", key))
	}
}
