/datum/mind/show_memory(mob/recipient)
	var/output = "<B>[current.real_name]'s Memory</B><HR>"
	output += memory

	for(var/datum/antagonist/A in antagonist)
		if(!A.objectives.len)
			break
		if(A.faction)
			output += "<br><b>Your [A.faction.name] faction objectives:</b>"
		else
			output += "<br><b>Your [A.role_text] objectives:</b>"
		output += "[A.print_objectives(FALSE)]"

	output += print_individualobjectives()

	var/datum/browser/panel = new(recipient, "memory", "Memory", 333, 333)
	panel.set_content(output)
	panel.open()
