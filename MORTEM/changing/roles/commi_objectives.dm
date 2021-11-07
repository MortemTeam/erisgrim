/datum/faction
	var/converted = 0

/datum/objective/timed/excelsior/New(datum/antagonist/new_owner, datum/mind/_target)
	if (istype(new_owner))
		antag = new_owner
		antag.objectives += src
		if(antag.owner)
			owner = antag.owner
	else if (istype(new_owner, /datum/faction))
		owner_faction = new_owner
		owner_faction.objectives += src
	if(!_target)
		find_target()
	else if (_target != ANTAG_SKIP_TARGET)
		target = _target

	update_explanation()
	all_objectives.Add(src)
	explanation_text = "Expand and grow!"

/datum/objective/timed/excelsior/start_excel_timer()
	return

/datum/objective/timed/excelsior/on_convert()
	owner_faction.converted += 1

/datum/objective/timed/excelsior/check_completion()
	if(owner_faction.members > (GLOB.human_mob_list.len / 2))
		return TRUE

/datum/faction/excelsior/print_success_extra()
	return "Converted [converted] humans!"
