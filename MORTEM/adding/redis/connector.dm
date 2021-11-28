var/global/redis/redis_client = new().setup(db=6)

#ifdef AUXSHELL
	#define SHELL aux_shell
#else
	#define SHELL shell
#endif

#define REDIS_CACHE_FOLDER (world.system_type == MS_WINDOWS ? "tmp" : "/tmp")

redis {
	var/address = "localhost"
	var/port = 6379
	var/db = 0
	var/password

	var/executor = "redis-cli"


	proc/setup(var/address = "localhost", var/port = 6379, var/db = 0, var/password = null) {
		/*
			Setup redis variables
			return: src
		*/
		src.address = address
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

		if (!islist(value)) {
			return value
		}

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

	proc/raw_request(var/data as text) {
		/*
			Clear requesting and save readable cache in game root folder
			return: terminal output as text
		*/

		var/filepath = "[REDIS_CACHE_FOLDER]/[db]-[rand(1111, 9999)].txt"
		world.log << "[executor] [data] > [filepath]"
		SHELL("[executor] [data] > [filepath]")
		var/list/out = _file2list(filepath)
		fdel(filepath)
		return out
	}

	proc/request(var/data as text) {
		/*
			Request with -h, -p, -a, -n, --raw parameters
			return: terminal output
		*/

		var/command = "-h [address] -p [port] "

		if (password) {
			command += "-a [password] "
		}

		command += "-n [db] --raw [data]"

		return raw_request(command)
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
