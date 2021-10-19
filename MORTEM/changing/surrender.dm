/datum/poll/evac
	name = "Surrender"
	question = "Желаете сдаться и закончить игру?"

/datum/vote_choice/evac
	text = "Признаю поражение, желаю закончить игру!"

/datum/vote_choice/evac/on_win()
	to_chat(world, SPAN_DANGER("Restarting world, because you surrender!"))
	log_admin("Initiated a reboot by surrender.")
	sleep(5 SECONDS)
	world.Reboot("Surrender game")

/datum/vote_choice/noevac
	text = "Хуй там, мы играем дальше!"
