/datum/poll/massive_events_initialize
	name = "Хардкор"
	question = "Запустить масс инфест + сеть бесконечных телепортов по кораблю?"
	choice_types = list(/datum/vote_choice/yes_massive, /datum/vote_choice/no_massive)

	can_unvote = TRUE

/datum/vote_choice/yes_massive
	text = "Запускайте дум!"

	var/list/events_init = list(
		/datum/storyevent/infestation/massive,
		/datum/storyevent/bluespace_rift/massive,
	)

/datum/vote_choice/yes_massive/on_win()
	for(var/RE in events_init)
		var/datum/storyevent/E = new RE()
		E.create(EVENT_LEVEL_MUNDANE)

	to_chat(world, SPAN_DANGER("Raise massive events..."))
	log_admin("Raise massive events by vote.")

/datum/vote_choice/no_massive
	text = "Оставь нас в покое..."

