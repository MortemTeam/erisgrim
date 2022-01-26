/world/update_status()
	var/features = list("Free RolePlay", "No Xenos")
	var/links = list(
		"Site" = config.forumurl,
		"Wiki" = config.wikiurl,
	)

	var/pure_links = list()
	for(var/K in links)
		pure_links += "<a href='[links[K]]'>[K]</a>"

	var/out = ""
	if(config && config.server_name)
		out += "<b>[config.server_name]</b><br>"

	out += "<b>Features:</b> " + jointext(features, ", ") + "<br>"
	out += "<b>Links:</b> " + jointext(pure_links, ", ") + "<br>"

	out += "\[ERIS DOWNSTREAM"

	/* does this help? I do not know */
	if(status != out)
		status = out
