#define TURBULENCE 35
#define FLICK_LIGHT 1 HOURS
#define APC_EXPLODING 5 MINUTES
#define EXPLODE_COUNT 33

/datum/client_preference/rs_shake
	description ="Roundstart shake camera"
	key = "SHAKE_CAMERA"
	default_value = GLOB.PREF_YES

/proc/announce_crash()
	command_announcement.Announce("Ship's propulsion functions are affected, keep calm and prepare to landing.", "Distress Signal")

/proc/setup_planet_light()
	for(var/turf/T in locate(/area/space))
		for(var/datum/lighting_corner/LC as() in T.get_corners())
			if(LC.active)
				LC.update_lumcount(255, 255, 255)

/proc/turbulence_crash()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.z in list(1,2,3,4,5))
			spawn()
				H.Weaken(TURBULENCE)
				if(H.client && H.get_preference_value(/datum/client_preference/rs_shake) == GLOB.PREF_YES)
					shake_camera(H, TURBULENCE * 1 SECONDS, 2)
				playsound(H, 'MORTEM/adding/crash_event/crash.mp3', 66, 1)

/proc/light_flicking()
	var/start_time = world.time

	var/list_of_light = list()
	for(var/obj/machinery/light/L in SSmachines.processing.Copy())
		spawn()
			if(L.z in list(1,2,3,4,5))
				L.set_red()
				list_of_light += L

	while(start_time + FLICK_LIGHT > world.time)
		var/obj/machinery/light/L = pick(list_of_light)
		L.flick_light(6)
		do_sparks(1, 0, L)

		sleep(1 SECONDS)

/proc/close_all_firedoor()
	for(var/obj/machinery/firealarm/F in SSmachines.processing.Copy())
		spawn()
			F.alarm()

/proc/explode_apc()
	var/start_time = world.time
	var/sleep_time = APC_EXPLODING / EXPLODE_COUNT

	var/list_of_apc = list()
	for(var/obj/machinery/power/apc/A in SSmachines.processing.Copy())
		if(A.z in list(1,2,3,4,5))
			list_of_apc += A

	while(start_time + APC_EXPLODING > world.time)
		var/obj/machinery/power/apc/A = pick(list_of_apc)
		explosion(A, 0, 1, 3)
		sleep(sleep_time)


/datum/controller/subsystem/ticker
	round_start_events = list(
		CALLBACK(GLOBAL_PROC, /proc/setup_planet_light),
		CALLBACK(GLOBAL_PROC, /proc/turbulence_crash),
		CALLBACK(GLOBAL_PROC, /proc/light_flicking),
		CALLBACK(GLOBAL_PROC, /proc/close_all_firedoor),
		CALLBACK(GLOBAL_PROC, /proc/announce_crash),
		//CALLBACK(GLOBAL_PROC, /proc/explode_apc),
	)

/datum/controller/subsystem/ticker/setup()
	to_chat(world, "<span class='boldannounce'>Starting game...</span>")
	var/init_start = world.timeofday
	//Create and announce mode

	if(!GLOB.storyteller)
		set_storyteller(announce = FALSE)

	if(!GLOB.storyteller)
		to_chat(world, "<span class='danger'>Serious error storyteller system!</span> Reverting to pre-game lobby.")
		return FALSE

	SSjob.ResetOccupations()
	SSjob.DivideOccupations() // Apparently important for new antagonist system to register specific job antags properly.

	CHECK_TICK

	if(!GLOB.storyteller.can_start(TRUE))
		log_game("Game failed pre_setup")
		to_chat(world, "<B>Unable to start game.</B> Reverting to pre-game lobby.")
		//GLOB.storyteller = null //Possibly bring this back in future if we have storytellers with differing requirements
		//story_vote_ended = FALSE
		SSjob.ResetOccupations()
		return FALSE

	GLOB.storyteller.announce()

	setup_economy()
	newscaster_announcements = pick(newscaster_standard_feeds)

	create_characters() //Create player characters and transfer them
	collect_minds()
	move_characters_to_spawnpoints()
	equip_characters()

	CHECK_TICK

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!H.mind || player_is_antag(H.mind, only_offstation_roles = 1) || !SSjob.ShouldCreateRecords(H.mind.assigned_role))
			continue
		CreateModularRecord(H)
	data_core.manifest()

	CHECK_TICK

	for(var/I in round_start_events)
		var/datum/callback/cb = I
		cb.InvokeAsync()
	LAZYCLEARLIST(round_start_events)
	log_world("Game start took [(world.timeofday - init_start)/10]s")

	current_state = GAME_STATE_PLAYING
	Master.SetRunLevel(RUNLEVEL_GAME)

	callHook("roundstart")

	// no, block the main thread.
	GLOB.storyteller.set_up()
	to_chat(world, "<FONT color='blue'><B>Enjoy the game!</B></FONT>")
	//SEND_SOUND(world, sound('sound/AI/welcome.ogg')) // Skie
	//Holiday Round-start stuff	~Carn
	Holiday_Game_Start()

	for(var/mob/new_player/N in SSmobs.mob_list)
		N.new_player_panel_proc()

	CHECK_TICK

	generate_contracts(min(6 + round(minds.len / 5), 12))
	generate_excel_contracts(min(6 + round(minds.len / 5), 12))
	excel_check()
	addtimer(CALLBACK(src, .proc/contract_tick), 15 MINUTES)
	//start_events() //handles random events and space dust.
	//new random event system is handled from the MC.

	var/admins_number = 0
	for(var/client/C)
		if(C.holder)
			admins_number++
	if(admins_number == 0)
		send2adminirc("Round has started with no admins online.")

	return TRUE

#undef TURBULENCE
