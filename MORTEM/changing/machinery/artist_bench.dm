/obj/machinery/autolathe/artist_bench/choose_base_art(ins_used, mob/living/carbon/human/user)
	var/list/LStats = list()

	if(inspiration && user.stats.getPerk(PERK_ARTIST))
		LStats = inspiration.calculate_statistics()

	var/weight_artwork_statue = 20
	var/weight_artwork_revolver = 1 + LStats[STAT_VIG] * 2
	var/weight_artwork_weapon = 1 + max(LStats[STAT_ROB], LStats[STAT_TGH]) * 2
	var/weight_artwork_oddity = 1 + max(LStats[STAT_COG], LStats[STAT_BIO]) * 2
	var/weight_artwork_tool = 2 + LStats[STAT_MEC] * 2
	var/weight_artwork_toolmod = 2 + LStats[STAT_MEC] * 2
	var/weight_artwork_gunmod = 2 + LStats[STAT_COG] * 2
	var/weight_artwork_gunPart = 1 + LStats[STAT_COG] + LStats[STAT_MEC]
	var/weight_artwork_armorPart = 2 + LStats[STAT_TGH] + LStats[STAT_BIO]

	if(ins_used >= 85)//Arbitrary values
		weight_artwork_revolver += 9
		weight_artwork_weapon += 9
		weight_artwork_gunPart += 5
	if(ins_used >= 70)
		weight_artwork_revolver += 4
		weight_artwork_weapon += 4
		weight_artwork_gunPart += 8
		weight_artwork_oddity += 13
		weight_artwork_gunmod += 8
		weight_artwork_armorPart += 8
	if(ins_used >= 55)
		weight_artwork_gunmod += 4
		weight_artwork_armorPart += 4
		weight_artwork_tool += 12
		weight_artwork_toolmod += 12
	else
		weight_artwork_statue += 12

	return pickweight(list(
		"artwork_revolver" = weight_artwork_revolver,
		"artwork_oddity" = weight_artwork_oddity,
		"artwork_toolmod" = weight_artwork_toolmod,
		"artwork_statue" = weight_artwork_statue,
		"artwork_gunPart" = weight_artwork_gunPart,
		"artwork_armorPart" = weight_artwork_armorPart,
	))
