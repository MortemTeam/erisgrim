/datum/controller/subsystem/vote/start_vote(newvote)
	if(active_vote)
		return FALSE

	var/datum/poll/poll

	if(ispath(newvote) && (newvote in votes))
		poll = votes[newvote]

	//can_start check is done before calling this so that admins can skip it
	if(!poll)
		return FALSE

	if(!poll.start())
		return

	vote_start_time = world.time

	var/text = "[poll.name] vote started by [poll.initiator]."
	log_vote(text)
	to_chat(world, {"<font color='purple'><b>[text]</b>\nType <b>vote</b> or click <a href='?src=\ref[src]'>here</a> to place your votes. <br>You have [poll.time] seconds to vote.</font>"})
	sound_to(world, sound('sound/ambience/alarm4.ogg', repeat = 0, wait = 0, volume = 50, channel = GLOB.vote_sound_channel))

	return TRUE

/datum/controller/subsystem/vote/Topic(href,href_list[],hsrc)
	if(href_list["vote"])
		if(active_vote)
			var/datum/vote_choice/choice = locate(href_list["vote"]) in active_vote.choices
			if(istype(choice) && usr && usr.client)
				active_vote.vote(choice, usr.client)

	if(href_list["toggle_admin"])
		var/datum/poll/poll = locate(href_list["toggle_admin"])
		if(istype(poll) && check_rights(R_ADMIN))
			poll.only_admin = !poll.only_admin

	if(href_list["start_vote"])
		var/datum/poll/poll = locate(href_list["start_vote"])
		if(istype(poll) && (check_rights(R_ADMIN) || (!poll.only_admin && poll.can_start())))
			start_vote(poll.type)

	if(href_list["cancel"])
		if(active_vote && check_rights())
			stop_vote()

	if(href_list["debug"])
		usr.client.debug_variables(src)

	if(href_list["close"])
		if(usr && usr.client)
			voters.Remove(usr.client)
			usr.client << browse(null,"window=Vote")
			return

	usr.vote()
