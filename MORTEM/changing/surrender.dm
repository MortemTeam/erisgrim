/datum/poll/evac
	name = "Surrender"
	question = "Желаете сдаться и закончить игру?"
	next_vote = 60 MINUTES

/datum/vote_choice/evac
	text = "Признаю поражение, желаю закончить игру!"

/datum/vote_choice/evac/on_win()
	world.Reboot("You fail")

/datum/vote_choice/noevac
	text = "Хуй там, мы играем дальше!"
