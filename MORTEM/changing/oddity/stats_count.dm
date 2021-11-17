/obj/item/oddity/Initialize()
	if(islist(armor))
		armor = getArmor(arglist(armor))
	else if(!armor)
		armor = getArmor()
	else if(!istype(armor, /datum/armor))
		error("Invalid type [armor.type] found in .armor during /obj Initialize()")

	AddComponent(/datum/component/atom_sanity, sanity_value, "")
	if(!perk && prob(prob_perk))
		perk = get_oddity_perk()

	if(oddity_stats)
		var/list/stats = ALL_STATS
		var/list/final_oddity = list()
		var/stat = pick(stats)
		final_oddity += stat
		final_oddity[stat] = rand(1,7)

		AddComponent(/datum/component/inspiration, final_oddity, perk)
