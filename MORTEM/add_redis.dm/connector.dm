redis {
	var/address = "localhost"
	var/port = 6379
	var/db = 0
	var/password

	var/executor = "redis-cli"
	var/cache_folder = "redis_cache"


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
			O += @{""[K]" "}
		}

		return copytext(O, 1, -1)
	}

	proc/_form_value(var/value) {
		/*
			Converting byond list in canonical form
			return: formed string
		*/

		if (islist(value)) {
			return _convert_list(value)
		} else {
			return  @{""[value]""}
		}
	}

	proc/_form_single(var/command as text, var/value) {
		/*
			Converting a value to canonical form
			return: formed string with three args
		*/

		return @{"[command] [_form_value(value)]"}
	}

	proc/_form_key_value(var/command as text, var/key as text, var/value) {
		/*
			Converting a key and value to canonical form
			return: formed string with three args
		*/

		return @{"[command] [key] [_form_value(value)]"}
	}

	proc/raw_request(var/data as text) {
		/*
			Clear requesting and save readable cache in game root folder
			return: terminal output as text
		*/

		var/filepath = "[cache_folder]/[db]-[rand(1111, 9999)]"
		testing("[executor] [data] > [filepath]")
		shell("[executor] [data] > [filepath]")
		var/list/out = file2list(filepath)
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
