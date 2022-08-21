/client/verb/login_discord(token as text)
    set name = "Login Discord"
    set category = "OOC"
    set desc = "Login discord for use special features"

    token = sanitize(token)
    redis_client.push("SYSTEM", "LOGIN [token]@[key]")
    to_chat(src, SPAN_NOTICE("Check your PM with bot, if he hasn't responded, notify administrators!"))
