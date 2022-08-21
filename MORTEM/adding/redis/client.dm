var/global/redis/redis_client = new()

/redis
	var/host = "127.0.0.1"
	var/port = 6379
	var/db = 0

/redis/New(var/host = "127.0.0.1", var/port = 6379, var/db = 0)
	src.host = host
	src.port = port
	src.db = db

	Connect()

	return src

/redis/proc/Connect()
	rustg_redis_connect("redis://[host]:[port]/[db]")

/redis/proc/push(var/channel as text, var/message as text)
	var/x = rustg_redis_publish(channel, message)
	if(x in list("sending on a closed channel", "Not connected"))
		Connect()

/redis/proc/subscribe(channel)
	rustg_redis_subscribe(channel)

/redis/proc/get_message()
	rustg_redis_get_messages()
