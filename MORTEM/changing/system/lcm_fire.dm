/datum/click_handler/Click(var/atom/target, location, control, params)
	if(!findtext(params, "left=1") || owner.mob.in_throw_mode)
		return FALSE

	if(!isHUDobj(target))
		if (mob_check(owner.mob) && use_ability(owner.mob, target))
			//Ability successful
			if (one_use_flag)
				//If we're single use, delete ourselves anyways
				qdel(src)
		else
			//Ability fail, delete ourselves
			to_chat(owner.mob, "For some reason you can't use [handler_name] ability")
			qdel(src)

		return FALSE //As long as we're not clicking a hud object, we drop the click
	return TRUE

/datum/click_handler/fullauto/MouseDown(object, location, control, params)
	if(!findtext(params, "left=1") || owner.mob.in_throw_mode)
		return FALSE

	if(!isturf(owner.mob.loc)) // This stops from firing full auto weapons inside closets or in /obj/effect/dummy/chameleon chameleon projector
		return FALSE

	object = resolve_world_target(object)
	if(object)
		target = object
		shooting_loop()
	return TRUE
