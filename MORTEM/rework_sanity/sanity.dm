#define CONTEMPLATION 2

/mob/living/carbon/human/proc/check_nude()
	return !(wear_suit  && w_uniform)

/datum/sanity/handle_view()
	. = 0
	if(sanity_invulnerability)//Sorry, but that needed to be added here :C
		for(var/mob/living/L in view(owner.client ? owner.client : owner))
			L.try_activate_ai()
		return

	var/vig = owner.stats.getStat(STAT_VIG)
	for(var/atom/A in view(owner.client ? owner.client : owner))
		if(A.sanity_damage) //If this thing is not nice to behold
			. += SANITY_DAMAGE_VIEW(A.sanity_damage, vig, get_dist(owner, A))
			if(isliving(A))
				var/mob/living/L = A
				L.try_activate_ai()

		if(ishuman(A))
			var/mob/living/carbon/human/H = A
			if(owner.stats.getPerk(PERK_MORALIST)) //Moralists react negatively to people in distress
				if(H.sanity.level < 30 || H.health < 50)
					. += SANITY_DAMAGE_VIEW(0.1, vig, get_dist(owner, A))

			if(!owner.stats.getPerk(PERK_NIHILIST) && H.stat != DEAD && H.gender != owner.gender && H.check_nude())
				. += CONTEMPLATION * (owner.check_nude()? 1.5 : 1)
