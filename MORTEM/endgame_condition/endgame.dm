#define TURBULENCE 35 SECONDS

/toggle_move_stars(zlevel, direction)
	if(!zlevel)
		return

	var/gen_dir = null
	if(direction & (NORTH|SOUTH))
		gen_dir += "ns"
	else if(direction & (EAST|WEST))
		gen_dir += "ew"
	if(!direction)
		gen_dir = null

	var/static/list/moving_levels
	moving_levels = moving_levels || new

	if (moving_levels["[zlevel]"] != gen_dir)
		moving_levels["[zlevel]"] = gen_dir

		var/list/spaceturfs = block(locate(1, 1, zlevel), locate(world.maxx, world.maxy, zlevel))
		if(!gen_dir)
			for(var/turf/space/T in spaceturfs)
				T.icon_state = "white"
				CHECK_TICK
		else
			for(var/turf/space/T in spaceturfs)
				T.icon_state = "speedspace_[gen_dir]_[rand(1,15)]"
				CHECK_TICK

/obj/machinery/computer/helm/attack_hand(mob/user)
	if(linked.get_total_thrust() < 50)
		return to_chat(user, SPAN_NOTICE("Too little engine power for takeoff!"))

	var/out = input("You really want escape? (This will end the round)", "End Round", "No") in list("Yes", "No")
	if(out == "Yes")
		SSticker.ship_was_nuked = TRUE //SSvote.start_vote(/datum/poll/votemap)
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(H.z in list(1,2,3,4,5))
				spawn(0)
					shake_camera(H, TURBULENCE, 2)
					playsound(H, 'MORTEM/endgame_condition/takeoff.mp3', 100, 1)

		sleep(TURBULENCE / 2)

		for(var/turf/simulated/T in locate(/area/space) in world)
			T.ChangeTurf(/turf/space)

		for(var/Z in list(1,2,3,4,5))
			toggle_move_stars(Z)

/obj/machinery/computer/shuttle_control/attack_hand(user as mob)
	to_chat(user, SPAN_NOTICE("Unable to calibrate the navigator..."))
