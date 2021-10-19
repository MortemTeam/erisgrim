/datum/poll/massive_events_initialize
	name = "Хардкор"
	question = "Запустить масс инфест + сеть бесконечных телепортов по кораблю?"
	time = 60
	choice_types = list(/datum/vote_choice/yes_massive, /datum/vote_choice/no_massive)

	multiple_votes = FALSE
	can_revote = TRUE
	can_unvote = TRUE

	see_votes = TRUE

/datum/vote_choice/yes_massive
	text = "Запускайте дум!"

/datum/vote_choice/yes_massive/on_win()

/datum/vote_choice/no_massive
	text = "Оставь нас в покое..."

