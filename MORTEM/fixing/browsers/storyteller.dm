/datum/storyteller/storyteller_panel()
	var/data = "<center><font size='3'><b>STORYTELLER PANEL</b></font></center>"

	data += "<b><a href='?src=\ref[src];panel=1'>\[UPDATE\]</a></b>"
	data += "<table><tr><td>"
	data += "[src.name] (<A href='?src=\ref[src];c_mode=1'>Change</A>)"
	data += "<br>Round duration: <b>[round(world.time / 36000)]:[add_zero(world.time / 600 % 60, 2)]:[world.time / 100 % 6][world.time / 100 % 10]</b>"
	data += "<br>Debug mode: <b><a href='?src=\ref[src];toggle_debug=1'>\[[debug_mode?"ON":"OFF"]\]</a></b>"
	data += "<br>One role per player: <b><a href='?src=\ref[src];toggle_orpp=1'>\[[one_role_per_player?"YES":"NO"]\]</a></b>"
	data += "</td><td style=\"padding-left: 40px\">"

	data += "Heads: [heads] "
	if(debug_mode)
		data += "<a href='?src=\ref[src];edit_heads=1'>\[EDIT\]</a>"
	data += "<br>Ironhammer: [sec] "
	if(debug_mode)
		data += "<a href='?src=\ref[src];edit_sec=1'>\[EDIT\]</a>"
	data += "<br>Technomancers: [eng] "
	if(debug_mode)
		data += "<a href='?src=\ref[src];edit_eng=1'>\[EDIT\]</a>"
	data += "<br>Medical: [med] "
	if(debug_mode)
		data += "<a href='?src=\ref[src];edit_med=1'>\[EDIT\]</a>"
	data += "<br>Science: [sci] "
	if(debug_mode)
		data += "<a href='?src=\ref[src];edit_sci=1'>\[EDIT\]</a>"
	data += "<br>NT Disciples: [disciples.len] "
	data += "<br><b>Total: [crew]</b> "
	if(debug_mode)
		data += "<a href='?src=\ref[src];edit_crew=1'>\[EDIT\]</a>"

	data += "</td><td style=\"padding-left: 40px\">"

	data += "<b>Event Pool Points:</b>"
	data += "<br>Mundane: [round(points[EVENT_LEVEL_MUNDANE], 0.1)] / [POOL_THRESHOLD_MUNDANE]   <a href='?src=\ref[src];modify_points=[EVENT_LEVEL_MUNDANE]'>\[ADD\]</a>"
	data += "<br>Moderate: [round(points[EVENT_LEVEL_MODERATE], 0.1)] / [POOL_THRESHOLD_MODERATE]   <a href='?src=\ref[src];modify_points=[EVENT_LEVEL_MODERATE]'>\[ADD\]</a>"
	data += "<br>Major: [round(points[EVENT_LEVEL_MAJOR], 0.1)] / [POOL_THRESHOLD_MAJOR]   <a href='?src=\ref[src];modify_points=[EVENT_LEVEL_MAJOR]'>\[ADD\]</a>"
	data += "<br>Roleset: [round(points[EVENT_LEVEL_ROLESET], 0.1)] / [POOL_THRESHOLD_ROLESET]   <a href='?src=\ref[src];modify_points=[EVENT_LEVEL_ROLESET]'>\[ADD\]</a>"

	data += "</td></tr></table>"
	data += "<hr>"
	data += "<b>Settings:</b>"
	data += "[storyteller_panel_extra()]"
	data += "<hr>"
	data += "<b><a href='?src=\ref[src];force_spawn=1'>\[FORCE ROLE SPAWN\]</a></b>"
	data += "<hr>"
	data += "<B>Evacuation</B>"
	if (!evacuation_controller.is_idle())
		data += "<a href='?src=\ref[src];call_shuttle=1'>Call Evacuation</a><br>"
	else
		var/timeleft = evacuation_controller.get_eta()
		if (evacuation_controller.waiting_to_leave())
			data += "ETA: [(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]<BR>"
			data += "<a href='?src=\ref[src];call_shuttle=2'>Send Back</a><br>"
	data += "<br><a href='?src=\ref[src];delay_round_end=1'>[SSticker.delay_end ? "End Round Normally" : "Delay Round End"]</a>"

	data += "<hr><b>Current antags:</b><div style=\"border:1px solid black;\"><ul>"

	if (GLOB.current_antags.len)
		for(var/datum/antagonist/A in GLOB.current_antags)
			var/act = "<font color=red>DEAD</font>"
			if(!A.is_dead())
				if(!A.is_active())
					act = "<font color=silver>AFK</font>"
				else
					act = "OK"



			data += "<li>[A.role_text] - [A.owner?(A.owner.name):"no owner"] ([act])<a href='?src=\ref[A];panel=1'>\[EDIT\]</a></li>"
	else
		data += "<b>There are no antagonists</b>"

	data += "</ul></div><hr>"
	data += "<br>Calculate weight: <b><a href='?src=\ref[src];toggle_weight_calc=1'>[calculate_weights?"\[AUTO\]":"\[MANUAL\]"]</a></b>"
	data += "<br><b>Events: <a href='?src=\ref[src];update_weights=1'>\[UPDATE WEIGHTS\]</a></b><div style=\"border:1px solid black;\">"


	//This complex block will print out all the events with various info
	var/severity = EVENT_LEVEL_MUNDANE
	for(var/list/L in list(event_pool_mundane, event_pool_moderate, event_pool_major, event_pool_roleset))
		data += "|[severity_to_string[severity]] events:"
		data += "|Points: [points[severity]]"
		data += "<ul>"
		for (var/datum/storyevent/S in L)
			data += "<li>[S.id] - weight: [L[S]] <a href='?src=\ref[src];event=[S.id];ev_calc_weight=1'>\[UPD\]</a>"
			if(!calculate_weights)
				data += "<a href='?src=\ref[src];event=[S.id];ev_set_weight=1'>\[SET\]</a>  "
			data += "<a href='?src=\ref[src];event=[S.id];ev_toggle=1'>\[[S.enabled?"ALLOWED":"FORBIDDEN"]\]</a>"
			data += "<a href='?src=\ref[src];event=[S.id];ev_debug=1'>\[VV\]</a>"
			data += "<b><a href='?src=\ref[src];event=[S.id];ev_spawn=1;severity=[severity]'>\[FORCE\]</a></b></li>"
			data += "</li>"
		data += "</ul>"
		data += "-------------------------<BR>"
		severity = get_next_severity(severity)

	data += "</div>"

	var/datum/browser/panel = new(usr, "story", "Story", 600, 600)
	panel.set_content(data)
	panel.open()
