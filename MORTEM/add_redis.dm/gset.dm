redis {
	proc/get(var/key as text) {
		// https://redis.io/commands/get
		return request(_form_single("GET", key))
	}

	proc/getdel(var/key as text) {
		// https://redis.io/commands/getdel
		return request(_form_single("GETDEL", key))
	}

	/* set reserved name */
	proc/sset(var/key as text, var/value) {
		// https://redis.io/commands/set
		return request(_form_key_value("SET", key, value))
	}

	proc/getset(var/key as text, var/value) {
		// https://redis.io/commands/getset
		return request(_form_key_value("GETSET", key, value))
	}
}
