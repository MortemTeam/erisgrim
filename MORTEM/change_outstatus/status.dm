/world/update_status()
	var/out = ""
	var/links = list(
		"Discord" = config.discordurl,
		"Wiki"    = config.wikiurl,
		"Git"     = config.githuburl
	)

	var/pure_links = list()
	for(var/K in links)
		pure_links += "<a href='[links[K]]'>[K]</a>"

	var/features = list("MRP", "No Xenos", "ERP", "Админка за актив!")

	if(config && config.server_name)
		out += "<b>[config.server_name]</b><br>"

	out += "Features: " + jointext(features, ", ") + "<br>"
	out += "Links: " + jointext(pure_links, ", ") + "<br>"

	out += "\[by <b>Mortem</b>"

	/* does this help? I do not know */
	if(status != out)
		status = out
