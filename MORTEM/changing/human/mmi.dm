/obj/item/device/mmi/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O,/obj/item/organ/internal/brain) && !brainmob) //Time to stick a brain in it --NEO

		var/obj/item/organ/internal/brain/B = O
		if(B.health <= 0)
			to_chat(user, "\red That brain is well and truly dead.")
			return
		else if(!B.brainmob)
			to_chat(user, "\red You aren't sure where this brain came from, but you're pretty sure it's a useless brain.")
			return
		B.nature = MODIFICATION_SILICON
		var/mob/living/carbon/brain/BM = B.brainmob
		if(!BM.client)
			for(var/mob/observer/ghost/G in GLOB.player_list)
				if(G.can_reenter_corpse && G.mind == BM.mind)
					if(alert(G, "Somebody is attempting to put your brain in an MMI. Would you like to return to it?","Become brain","OH YES","No") == "OH YES")
						G.reenter_corpse()
						break
			if(!BM.client)
				to_chat(user, SPAN_WARNING("\The [src] indicates that \the [B] is unresponsive."))
				return

		for(var/mob/V in viewers(src, null))
			V.show_message(text("\blue [user] sticks \a [O] into \the [src]."))

		brainmob = B.brainmob
		brainmob.loc = src
		brainmob.container = src
		brainmob.stat = 0
		GLOB.dead_mob_list -= brainmob//Update dem lists
		GLOB.living_mob_list += brainmob

		user.drop_item()
		brainobj = O
		brainobj.loc = src

		name = "Man-Machine Interface: [brainmob.real_name]"
		icon_state = "mmi_full"

		locked = 1



		return
