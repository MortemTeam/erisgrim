/datum/sanity/handle_view()
	. = ..()
	if(sanity_invulnerability)
		return

	var/cog = owner.stats.getStat(STAT_COG)
	for(var/atom/A in view(owner.client ? owner.client : owner))
		if(ishuman(A))
			var/mob/living/carbon/human/H = A
			if(!owner.stats.getPerk(PERK_NIHILIST) && H.stat != DEAD)
				if(H.check_nude())
					. += -SANITY_DAMAGE_VIEW((owner.check_nude() ? 2 : 1) + (owner.gender != H.gender ? 2 : 1), cog, get_dist(owner, A))

