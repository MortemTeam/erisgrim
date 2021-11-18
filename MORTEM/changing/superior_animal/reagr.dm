/mob/living/carbon/superior_animal/adjustBruteLoss(damage)
	..()
	var/target = findTarget()
	for(var/mob/living/carbon/superior_animal/SA in view(1))
		SA.target_mob = target
