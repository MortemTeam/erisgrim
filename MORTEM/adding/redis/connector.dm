var/global/redis/redis_client = new()

redis {
	var/host = "localhost"
	var/port = 6379
	var/db = 0
	var/password //useless

	proc/setup(var/host = "localhost", var/port = 6379, var/db = 0, var/password = null) {
		/*
			Setup redis variables
			return: src
		*/
		src.host = host
		src.port = port
		src.db = db
		src.password = password
		return src
	}

	/proc/_file2list(var/filename, var/seperator = "\n") {
		/*
			Converting file in list
			return: list of text rows
		*/
		return splittext(file2text(filename), seperator)
	}

	proc/_convert_list(var/value) {
		/*
			Converting byond list in canonical form
			return: formed string
		*/

		var/O = ""
		for (var/K in value) {
			O += "\"[K]\" "
		}

		return copytext(O, 1, -1)
	}

	proc/_form_value(var/value) {
		/*
			Converting byond list in canonical form
			return: formed string
		*/

		return islist(value) ? _convert_list(value) : "\"[value]\""
	}

	proc/_form_single(var/command as text, var/value) {
		/*
			Converting a value to canonical form
			return: formed string with three args
		*/

		return "[command] [_form_value(value)]"
	}

	proc/_form_key_value(var/command as text, var/key as text, var/value) {
		/*
			Converting a key and value to canonical form
			return: formed string with three args
		*/

		return "[command] [key] [_form_value(value)]"
	}

	proc/request(var/data as text) {
		/*
			Abstract proc for hook from .dll,  Request to redis
		*/
	}

	proc/echo(var/data as text|num) {
		// https://redis.io/commands/echo
		return request(_form_single("ECHO", data))
	}

	proc/ping() {
		// https://redis.io/commands/ping
		return request("PING")
	}

	proc/flushall() {
		// https://redis.io/commands/flushall
		return request("FLUSHALL")
	}

	proc/flushdb() {
		// https://redis.io/commands/flushdb
		return request("FLUSHDB")
	}
}