/obj/item/organ
	var/cloned = FALSE

/mob/living/simple_animal/spider_core/generate_body()
	to_chat(src, SPAN_NOTICE("You start building a body"))

	if(!do_after(src, 1 MINUTES, src))
		to_chat(src, SPAN_NOTICE("The new body is not ready yet, it takes a minute to make one. You have to stand still."))
		return

	var/mob/living/carbon/human/H = new /mob/living/carbon/human(loc)
	visible_message(SPAN_DANGER("[src] morphs into a human body!"))
	gibs(loc, null)
	var/obj/item/organ/internal/carrion/core/core = locate(/obj/item/organ/internal/carrion/core) in contents

	for(var/obj/item/organ/O in H.organs|H.internal_organs)
		O.cloned = TRUE

	H.faction = "spiders"
	if(core)
		core.spiderlist.Cut()
		core.geneticpoints = 0

		core.purchasedpowers.Cut()
		if(!powerinstances.len)
			for(var/P in powers)
				powerinstances += new P()

		var/obj/item/organ/external/chest/chest = H.get_organ(BP_CHEST) // get_organ with no arguments defaults to BP_CHEST, but it makes it less readable
		core.replaced(chest)
		for(var/item in core.active_spiders)
			var/obj/item/implant/carrion_spider/CS = item
			if(istype(CS))
				CS.update_owner_mob()

		usr.mind.transfer_to(H)

		core.associated_spider = null

	qdel(src)

/obj/item/organ/internal/carrion/maw/consume_flesh()
	var/food = owner.get_active_hand()

	if(!food)
		to_chat(owner, SPAN_WARNING("You can't eat nothing."))
		return

	if(istype(food, /obj/item/grab))
		var/obj/item/grab/grab = food
		var/mob/living/carbon/human/H = grab.affecting
		if (grab.state < GRAB_AGGRESSIVE)
			to_chat(owner, SPAN_WARNING("Your grip upon [H.name] is too weak."))
			return
		if(istype(H))
			var/obj/item/organ/external/E = H.get_organ(owner.targeted_organ)
			if (tearing) // one at a time, thank you.
				to_chat(owner, SPAN_WARNING("Your maw is already focused on something."))
				return

			if(E.is_stump())
				to_chat(owner, SPAN_WARNING("There is nothing there!"))
				return
			tearing = TRUE

			visible_message(SPAN_DANGER("[owner] bites into [H.name]'s [E.name] and starts tearing it apart!"))
			if(do_after(owner, 5 SECONDS, H))
				tearing = FALSE
				E.take_damage(30)
				var/blacklist = list()
				for (var/obj/item/organ/internal/to_blacklist in E.internal_organs)
					if (istype(to_blacklist, /obj/item/organ/internal/bone/))
						blacklist += to_blacklist
						continue
					if (istype(to_blacklist, /obj/item/organ/internal/brain/))
						blacklist += to_blacklist// removing bones from a valid_organs list based on
				var/list/valid_organs = E.internal_organs - blacklist// E.internal_organs gibs the victim.
				if (!valid_organs.len)
					visible_message(SPAN_DANGER("[owner] tears up [H]'s [E.name]!"))
					return
				var/obj/item/organ/internal/organ_to_remove = pick(valid_organs)
				organ_to_remove.removed(owner)
				visible_message(SPAN_DANGER("[owner] tears \a [organ_to_remove] out of [H.name]'s [E.name]!"))
				playsound(loc, 'sound/voice/shriek1.ogg', 50)
				return
			else
				tearing = FALSE
		else
			to_chat(owner, SPAN_WARNING("You can only tear flesh out of humanoids!"))
			return

	if(istype(food, /obj/item/organ) || istype(food, /obj/item/reagent_containers/food/snacks/meat))
		var/geneticpointgain = 0
		var/chemgain = 0
		var/taste_description = ""

		if(owner.carrion_hunger < 1)
			to_chat(owner, SPAN_WARNING("You are not hungry."))
			return

		var/obj/item/organ/O = food
		if(istype(O))
			if(BP_IS_ROBOTIC(O))
				to_chat(owner, SPAN_WARNING("This organ is robotic, you can't eat it."))
				return

			if(istype(O, /obj/item/organ/internal/carrion))
				var/obj/item/organ/internal/carrion/core/G = owner.random_organ_by_process(BP_SPCORE)
				if(O in G.associated_carrion_organs)
					taste_description = "albeit delicious, your own organs carry no new genetic material"
				else
					owner.carrion_hunger += 3
					geneticpointgain = 4
					chemgain = 50
					taste_description = "carrion organs taste heavenly, you need more!"

			if(O.cloned)
				to_chat(owner, SPAN_WARNING("This organ is cloned and useless"))
				return

			if(istype(O, /obj/item/organ/internal))
				var/organ_rotten = FALSE
				if (O.status & ORGAN_DEAD)
					organ_rotten = TRUE
				if(O.species != all_species[SPECIES_HUMAN])
					chemgain = 5
					taste_description = "this non-human organ is very bland." // no removal of hunger here, getting and storing a ton of monkey organs isn't too easy, and 5 chem points isn't terribly much.
				else
					geneticpointgain = organ_rotten ? 1 : 3
					chemgain = organ_rotten ? 4 : 10
					taste_description = "internal organs are delicious[organ_rotten ? ", but rotten ones less so." : "."]"

			if(istype(O, /obj/item/organ/external))
				geneticpointgain = 2
				chemgain = 5
				taste_description = "limbs are satisfying."

		else if(istype(food, /obj/item/reagent_containers/food/snacks/meat/human))
			geneticpointgain = 2
			chemgain = 2
			taste_description = "human meat is satisfying."

		else
			geneticpointgain = 1
			chemgain = 1
			taste_description = "this meat is bland."

		var/obj/item/organ/internal/carrion/core/C = owner.random_organ_by_process(BP_SPCORE)
		if(C)
			C.geneticpoints += min(geneticpointgain, owner.carrion_hunger)

		owner.carrion_hunger = max(owner.carrion_hunger - geneticpointgain, 0)
		owner.ingested.add_reagent("nutriment", chemgain)

		var/chemvessel_efficiency = owner.get_organ_efficiency(OP_CHEMICALS)
		if(chemvessel_efficiency > 1)
			owner.carrion_stored_chemicals = min(owner.carrion_stored_chemicals + 0.01 * chemvessel_efficiency , 0.5 * chemvessel_efficiency)

		to_chat(owner, SPAN_NOTICE("You consume \the [food], [taste_description]."))
		visible_message(SPAN_DANGER("[owner] devours \the [food]!"))
		qdel(food)

	else
		to_chat(owner, SPAN_WARNING("You can't eat this!"))
