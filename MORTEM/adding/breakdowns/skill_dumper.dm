/datum/breakdown/negative/skill_dumper
	name = "Skill Dumper"
	duration = 0 SECONDS

	start_messages = list(
		"You feel distracted.",
		"You feel your vitality waning!",
	)

/datum/breakdown/negative/skill_dumper/conclude()
	..()
	var/datum/stat_holder/stats = holder.owner.stats
	for(var/stat in ALL_STATS)
		stats.addTempStat(stat, -round(stats.getStat(stat) / 2), 5 MINUTES, "skill dumper")
