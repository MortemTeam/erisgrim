/datum/job/assistant
	title = "Vagabund"
	description = "You are a vagabund, journeying through the vast expanses of space upon the CEV Eris. You will not be paid a wage.<br>\
Though this does not mean you have no home, as the Eris is your home. Whatever planet you may have came from a now distant memory.<br>\
You remember boarding the Eris sometime in your past, when it had a different purpose and a different captain.<br>\
Over time you've become accustomed to the dangers of this ship.<br>\
The ID you wear likely not even your own. At least as far as you can remember.<br>\
But this chunk of plastic still can be a rare oddity, that can change your character.<br>\
As an vagabund, you should strive to help out anyone you can. Or at least, anyone who offers you a paying job. Find a way to make money, stay out of trouble, and survive."

/datum/perk/vagabond
	name = "Vagabund"

/obj/item/toy/figure/vagabond
	name = "vagabund figurine"

/datum/gear/clown
	allowed_roles = list("Vagabund")

/datum/controller/subsystem/job/ShouldCreateRecords(var/title)
	if(!title) return 0
	var/datum/job/job = GetJob(title)
	if(!job || job == "Vagabund") return 0
	return job.create_record

/datum/datacore/manifest_inject(var/mob/living/carbon/human/H)
	if(H.mind && !player_is_antag(H.mind, only_offstation_roles = 1) && H.job != "Vagabund")
		var/assignment = GetAssignment(H)

		var/id = generate_record_id()
		//General Record
		var/datum/data/record/G = CreateGeneralRecord(H, id)
		G.fields["name"]		= H.real_name
		G.fields["real_rank"]	= H.mind.assigned_role
		G.fields["rank"]		= assignment
		G.fields["age"]			= H.age
		G.fields["fingerprint"]	= H.fingers_trace
		if(H.mind.initial_account)
			G.fields["pay_account"]	= H.mind.initial_account.account_number ? H.mind.initial_account.account_number : "N/A"
		G.fields["email"]		= H.mind.initial_email_login["login"]
		G.fields["p_stat"]		= "Active"
		G.fields["m_stat"]		= "Stable"
		G.fields["sex"]			= H.gender
		if(H.gen_record && !jobban_isbanned(H, "Records"))
			G.fields["notes"] = H.gen_record

		//Medical Record
		var/datum/data/record/M = CreateMedicalRecord(H.real_name, id)
		M.fields["b_type"]		= H.b_type
		M.fields["b_dna"]		= H.dna_trace
		//M.fields["id_gender"]	= gender2text(H.identifying_gender)
		if(H.med_record && !jobban_isbanned(H, "Records"))
			M.fields["notes"] = H.med_record

		//Security Record
		var/datum/data/record/S = CreateSecurityRecord(H.real_name, id)
		if(H.sec_record && !jobban_isbanned(H, "Records"))
			S.fields["notes"] = H.sec_record

		//Locked Record
		var/datum/data/record/L = new()
		L.fields["id"]			= md5("[H.real_name][H.mind.assigned_role]")
		L.fields["name"]		= H.real_name
		L.fields["rank"] 		= H.mind.assigned_role
		L.fields["age"]			= H.age
		L.fields["fingerprint"]	= H.fingers_trace
		L.fields["sex"]			= H.gender
		L.fields["b_type"]		= H.b_type
		L.fields["b_dna"]		= H.dna_trace
		L.fields["image"]		= getFlatIcon(H)	//This is god-awful
		if(H.exploit_record && !jobban_isbanned(H, "Records"))
			L.fields["exploit_record"] = H.exploit_record
		else
			L.fields["exploit_record"] = "No additional information acquired."
		locked += L
	return

/datum/job/setup_account(var/mob/living/carbon/human/H)
	if(!account_allowed || (H.mind && H.mind.initial_account))
		return

	//give them an account in the station database
	if(H.job == "Vagabund") // Vagabound do not get an account.
		H.mind.store_memory("As a freelancer you do not have a bank account.")
		return
	var/species_modifier = (H.species ? economic_species_modifier[H.species.type] : 2)
	if(!species_modifier)
		species_modifier = economic_species_modifier[/datum/species/human]

	var/money_amount = one_time_payment(species_modifier)
	var/datum/money_account/M = create_account(H.real_name, money_amount, null)
	if(H.mind)
		var/remembered_info = ""
		remembered_info += "<b>Your account number is:</b> #[M.account_number]<br>"
		remembered_info += "<b>Your account pin is:</b> [M.remote_access_pin]<br>"
		remembered_info += "<b>Your account funds are:</b> [M.money][CREDS]<br>"

		if(M.transaction_log.len)
			var/datum/transaction/T = M.transaction_log[1]
			remembered_info += "<b>Your account was created:</b> [T.time], [T.date] at [T.source_terminal]<br>"
		H.mind.store_memory(remembered_info)

		H.mind.initial_account = M

	to_chat(H, SPAN_NOTICE("<b>Your account number is: [M.account_number], your account pin is: [M.remote_access_pin]</b>"))

/datum/computer_file/report/crew_record/load_from_mob(var/mob/living/carbon/human/H)
	if(istype(H))
		if(H.job == "Vagabund") // As stowaways, Vagabond do not show up on the crew manifest.
			GLOB.all_crew_records.Remove(src)
			return
		photo_front = getFlatIcon(H, SOUTH)
		photo_side = getFlatIcon(H, WEST)
	else
		var/mob/living/carbon/human/dummy/mannequin/dummy = new()
		photo_front = getFlatIcon(dummy, SOUTH)
		photo_side = getFlatIcon(dummy, WEST)
		qdel(dummy)

	// Add education, honorifics, etc.
	/*
	var/formal_name = "Unset"
	if(H)
		formal_name = H.real_name
		if(H.client && H.client.prefs)
			for(var/culturetag in H.client.prefs.cultural_info)
				var/decl/cultural_info/culture = SSculture.get_culture(H.client.prefs.cultural_info[culturetag])
				if(H.char_rank && H.char_rank.name_short)
					formal_name = "[formal_name][culture.get_formal_name_suffix()]"
				else
					formal_name = "[culture.get_formal_name_prefix()][formal_name][culture.get_formal_name_suffix()]"
	*/
	// Generic record
	set_name(H ? H.real_name : "")
	set_department(H ? GetDepartment(H) : "Unset")
	set_job(H ? GetAssignment(H) : "Unset")
	set_sex(H ? gender2text(H.get_sex()) : "Unset")
	set_age(H ? H.age : 30)
	set_status(GLOB.default_physical_status)

	set_email((H && H.mind) ? H.mind.initial_email_login["login"] : "none")
	set_account((H && H.mind) ? H.mind.initial_account.account_number : "000000")

	// TODO: enable after baymed
	//set_species(H ? H.get_species() : SPECIES_HUMAN)

	set_species(SPECIES_HUMAN)
	//set_branch(H ? (H.char_branch && H.char_branch.name) : "None")
	//set_rank(H ? (H.char_rank && H.char_rank.name) : "None")

	// Medical record
	set_bloodtype(H ? H.b_type : "Unset")
	set_medRecord((H && H.med_record && !jobban_isbanned(H, "Records") ? html_decode(H.med_record) : "No record supplied"))

	// Security record
	set_criminalStatus(GLOB.default_security_status)
	set_dna(H ? H.dna_trace : "")
	set_fingerprint(H ? H.fingers_trace : "")
	set_secRecord(H && H.sec_record && !jobban_isbanned(H, "Records") ? html_decode(H.sec_record) : "No record supplied")

	// Employment record
	var/employment_record = "No record supplied"
	if(H)
		if(H.gen_record && !jobban_isbanned(H, "Records"))
			employment_record = html_decode(H.gen_record)
		if(H.client && H.client.prefs)
			var/list/qualifications
	/*		for(var/culturetag in H.client.prefs.cultural_info)
				var/decl/cultural_info/culture = SSculture.get_culture(H.client.prefs.cultural_info[culturetag])
				var/extra_note = culture.get_qualifications()
				if(extra_note)
					LAZYADD(qualifications, extra_note)*/
			if(LAZYLEN(qualifications))
				employment_record = "[employment_record ? "[employment_record]\[br\]" : ""][jointext(qualifications, "\[br\]>")]"
	set_emplRecord(employment_record)

	// Misc cultural info.
	//set_homeSystem(H ? html_decode(H.get_cultural_value(TAG_HOMEWORLD)) : "Unset")
	//set_faction(H ? html_decode(H.get_cultural_value(TAG_FACTION)) : "Unset")

	if(H)
		var/stats = list()
		for(var/statName in ALL_STATS)
			var/points = H.stats.getStat(statName,pure = TRUE)
			if(points > STAT_LEVEL_NONE)
				stats += "[statName]: [points] ([statPointsToLevel(points)])"

		set_skillset(jointext(stats,"\n"))

	// Antag record
	set_antagRecord(H && H.exploit_record && !jobban_isbanned(H, "Records") ? html_decode(H.exploit_record) : "")