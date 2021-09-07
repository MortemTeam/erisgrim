#define TURBULENCE 30
#define FLICK_LIGHT 10 MINUTES
#define APC_EXPLODING 5 MINUTES
#define EXPLODE_COUNT 40 SECONDS

/proc/announce()
	command_announcement.Announce("Ship's propulsion functions are affected, keep calm and prepare to landing.", "Distress Signal")

/proc/turbulence()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		spawn(0)
			H.Weaken(TURBULENCE)
			shake_camera(H, TURBULENCE * 1 SECONDS, 2)
			playsound(H, 'MORTEM/crash_event/crash.mp3', 66, 1)

/proc/light_flicking()
	var/start_time = world.time

	var/list_of_light = list()
	for(var/obj/machinery/light/L in SSmachines.processing.Copy())
		L.set_red()
		list_of_light += L

	while(start_time + FLICK_LIGHT > world.time)
		for(var/obj/machinery/light/L as() in list_of_light)
			if(prob(10))
				L.on = !L.on
				L.update()
		sleep(1 SECONDS)

	for(var/obj/machinery/light/L as() in list_of_light)
		L.reset_color()
		L.on = TRUE
		L.update()

/proc/explode_apc()

/datum/controller/subsystem/ticker
	round_start_events = list(
		CALLBACK(GLOBAL_PROC, /proc/announce),
		CALLBACK(GLOBAL_PROC, /proc/turbulence),
		CALLBACK(GLOBAL_PROC, /proc/light_flicking),
		CALLBACK(GLOBAL_PROC, /proc/explode_apc),
	)

datum/controller/subsystem/ticker/setup()
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


