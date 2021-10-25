/world/update_status()
	var/out = ""
	var/links = list(
		"Discord" = config.discordurl,
		"Wiki"    = config.wikiurl,
	)

	var/pure_links = list()
	for(var/K in links)
		pure_links += "<a href='[links[K]]'>[K]</a>"

	var/features = list("MRP", "No Xenos", "ERP Allowed")

	if(config && config.server_name)
		out += "<b>[config.server_name]</b><br>"

	out += "<b>Features:</b> " + jointext(features, ", ") + "<br>"
	out += "<b>Links:</b> " + jointext(pure_links, ", ") + "<br>"

	out += "\[Eris downstream"

	/* does this help? I do not know */
	if(status != out)
		status = out
