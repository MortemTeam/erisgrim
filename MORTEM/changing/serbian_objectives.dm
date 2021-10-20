/datum/faction/mercenary
	objective_quantity = 1
	possible_objectives = list(
		/datum/objective/nuclear = 1,
	)

/datum/objective/timed/merc
	explanation_text = "Return to your ship and withdraw to base within 666 minutes of being detected."
	mission_timer = 666 MINUTES

/datum/objective/timed/merc/update_explanation()

/datum/objective/nuclear/check_completion()
	return SSticker.ship_was_nuked
