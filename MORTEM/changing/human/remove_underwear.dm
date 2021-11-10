/mob/living/carbon/human/show_inv(mob/user as mob)
	if(user.incapacitated()  || !user.Adjacent(src))
		return

	var/obj/item/clothing/under/suit
	if(istype(w_uniform, /obj/item/clothing/under))
		suit = w_uniform

	src.set_machine(user)
	var/dat = "<B><HR><FONT size=3>[name]</FONT></B><BR><HR>"

	for(var/entry in species.hud.gear)
		var/slot = species.hud.gear[entry]
		if(slot in list(slot_l_store, slot_r_store))
			continue
		var/obj/item/thing_in_slot = get_equipped_item(slot)
		dat += "<BR><B>[entry]:</b> <a href='?src=\ref[src];item=[slot]'>[istype(thing_in_slot) ? thing_in_slot : "nothing"]</a>"

	dat += "<BR><HR>"

	if(!suit && worn_underwear.len)
		dat += "<BR><B>Underwear:</B>"
		for(var/obj/item/underwear/UW in worn_underwear)
			dat += "<BR><a href='?src=\ref[src];item=\ref[UW]'>Remove \the [UW]</a>"
		dat += "<BR>"

	// Do they get an option to set internals?
	if(istype(wear_mask, /obj/item/clothing/mask) || istype(head, /obj/item/clothing/head/space))
		if(istype(back, /obj/item/tank) || istype(belt, /obj/item/tank) || istype(s_store, /obj/item/tank))
			dat += "<BR><A href='?src=\ref[src];item=internals'>Toggle internals.</A>"

	// Other incidentals.
	if(handcuffed)
		dat += "<BR><A href='?src=\ref[src];item=[slot_handcuffed]'>Handcuffed</A>"
	if(legcuffed)
		dat += "<BR><A href='?src=\ref[src];item=[slot_legcuffed]'>Legcuffed</A>"

	if(suit && suit.accessories.len)
		dat += "<BR><A href='?src=\ref[src];item=tie'>Remove accessory</A>"

	dat += "<BR><A href='?src=\ref[src];item=splints'>Remove splints</A>"
	dat += "<BR><A href='?src=\ref[src];item=pockets'>Empty pockets</A>"
	dat += "<BR><A href='?src=\ref[user];refresh=1'>Refresh</A>"
	dat += "<BR><A href='?src=\ref[user];mach_close=mob[name]'>Close</A>"

	var/datum/browser/out = new(user, "mob[name]", "Inventory", 325, 500)
	out.set_content(dat)
	out.open()

/mob/living/carbon/human/handle_strip(slot_to_strip, mob/living/user)
	if(!slot_to_strip || !user.IsAdvancedToolUser())
		return

	if(user.incapacitated()  || !user.Adjacent(src))
		user << browse(null, text("window=mob[src.name]"))
		return

	var/obj/item/target_slot = get_equipped_item(text2num(slot_to_strip))

	switch(slot_to_strip)
		// Handle things that are part of this interface but not removing/replacing a given item.
		if("pockets")
			if(!user.stats.getPerk(PERK_FAST_FINGERS))
				visible_message(SPAN_DANGER("\The [user] is trying to empty \the [src]'s pockets!"))
			else
				to_chat(user, SPAN_NOTICE("You silently try to empty \the [src]'s pockets."))
			if(do_mob(user,src,HUMAN_STRIP_DELAY,progress = 1))
				empty_pockets(user)
			return
		if("splints")
			visible_message(SPAN_DANGER("\The [user] is trying to remove \the [src]'s splints!"))
			if(do_mob(user,src,HUMAN_STRIP_DELAY,progress = 1))
				remove_splints(user)
			return
		if("internals")
			visible_message(SPAN_DANGER("\The [usr] is trying to set \the [src]'s internals!"))
			if(do_mob(user,src,HUMAN_STRIP_DELAY, progress = 1))
				toggle_internals(user)
			return
		if("tie")
			var/obj/item/clothing/under/suit = w_uniform
			if(!istype(suit) || !suit.accessories.len)
				return
			var/obj/item/clothing/accessory/A = suit.accessories[1]
			if(!istype(A))
				return
			visible_message(SPAN_DANGER("\The [usr] is trying to remove \the [src]'s [A.name]!"))

			if(!do_mob(user,src,HUMAN_STRIP_DELAY,progress=1))
				return

			if(!A || suit.loc != src || !(A in suit.accessories))
				return

			if(istype(A, /obj/item/clothing/accessory/badge) || istype(A, /obj/item/clothing/accessory/medal))
				user.visible_message(SPAN_DANGER("\The [user] tears off \the [A] from [src]'s [suit.name]!"))
			attack_log += "\[[time_stamp()]\] <font color='orange'>Has had \the [A] removed by [user.name] ([user.ckey])</font>"
			user.attack_log += "\[[time_stamp()]\] <font color='red'>Attempted to remove [name]'s ([ckey]) [A.name]</font>"
			A.on_removed(user)
			suit.accessories -= A
			update_inv_w_uniform()
			return
		else
			var/obj/item/underwear/UW = locate(slot_to_strip) in src
			if(UW && UW.DelayedRemoveUnderwear(user, src))
				user.put_in_active_hand(UW)
				return


	// Are we placing or stripping?
	var/stripping
	var/obj/item/held = user.get_active_hand()
	if(!istype(held) || is_robot_module(held))
		if(!istype(target_slot))  // They aren't holding anything valid and there's nothing to remove, why are we even here?
			return
		if(!target_slot.canremove)
			to_chat(user, SPAN_WARNING("You cannot remove \the [src]'s [target_slot.name]."))
			return
		stripping = TRUE

	if(stripping)
		if((target_slot == r_hand || target_slot == l_hand) && user.stats.getPerk(PERK_FAST_FINGERS))
			to_chat(user, SPAN_NOTICE("You silently try to remove \the [src]'s [target_slot.name]."))
		else
			visible_message(SPAN_DANGER("\The [user] is trying to remove \the [src]'s [target_slot.name]!"))
	else
		if((slot_to_strip == r_hand || slot_to_strip == l_hand) && user.stats.getPerk(PERK_FAST_FINGERS))
			to_chat(user, SPAN_NOTICE("You silently try to put \a [held] on \the [src]."))
		else
			visible_message(SPAN_DANGER("\The [user] is trying to put \a [held] on \the [src]!"))

	if(!do_mob(user,src,HUMAN_STRIP_DELAY,progress = 1))
		return

	if(!stripping && user.get_active_hand() != held)
		return

	if(stripping)
		admin_attack_log(user, src, "Attempted to remove \a [target_slot]", "Target of an attempt to remove \a [target_slot].", "attempted to remove \a [target_slot] from")
		unEquip(target_slot)
		if(istype(target_slot,  /obj/item/storage/backpack))
			SEND_SIGNAL(user, COMSIG_EMPTY_POCKETS, src)
	else if(user.unEquip(held))
		equip_to_slot_if_possible(held, text2num(slot_to_strip), TRUE) // Disable warning
		if(held.loc != src)
			user.put_in_hands(held)


/obj/item/underwear/DelayedRemoveUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanRemoveUnderwear(user, H))
		return
	if(user != H)
		visible_message("<span class='danger'>\The [user] is trying to remove \the [H]'s [name]!</span>")
		if(!do_after(user, HUMAN_STRIP_DELAY, H, progress = TRUE))
			return FALSE
	. = RemoveUnderwear(user, H)
	if(. && user != H)
		user.visible_message("<span class='warning'>\The [user] has removed \the [src] from \the [H].</span>", "<span class='notice'>You have removed \the [src] from \the [H].</span>")
		admin_attack_log(user, H, "Removed \a [src]", "Had \a [src] removed.", "removed \a [src] from")

/obj/item/underwear/DelayedEquipUnderwear(var/mob/user, var/mob/living/carbon/human/H)
	if(!CanEquipUnderwear(user, H))
		return
	if(user != H)
		user.visible_message("<span class='warning'>\The [user] has begun putting on \a [src] on \the [H].</span>", "<span class='notice'>You begin putting on \the [src] on \the [H].</span>")
		if(!do_after(user, HUMAN_STRIP_DELAY, H, progress = TRUE))
			return FALSE
	. = EquipUnderwear(user, H)
	if(. && user != H)
		user.visible_message("<span class='warning'>\The [user] has put \the [src] on \the [H].</span>", "<span class='notice'>You have put \the [src] on \the [H].</span>")
		admin_attack_log(user, H, "Put on \a [src]", "Had \a [src] put on.", "put on \a [src] on")
