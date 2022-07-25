/datum/perk/fate/noble/assign(mob/living/carbon/human/H)
	if(istype(H))
		holder = H
		RegisterSignal(holder, COMSIG_MOB_LIFE, .proc/on_process)
		to_chat(holder, SPAN_NOTICE("[gain_text]"))

	if(!holder || !holder.last_name)
		holder.stats.removePerk(src.type)
		return

	holder.sanity.environment_cap_coeff -= 1

	var/turf/T = get_turf(holder)

	var/list/block_list = list(
		/obj/item/tool/sword/nt_sword,
		/obj/item/tool/sword/katana/nano,

		/obj/item/gun/projectile,
		/obj/item/gun/projectile/automatic,
		/obj/item/gun/projectile/automatic/slaught_o_matic,
		/obj/item/gun/projectile/heavysniper,
		/obj/item/gun/projectile/automatic/c20r/moebius,
		/obj/item/gun/projectile/avasarala,
		/obj/item/gun/projectile/gyropistol,
		/obj/item/gun/projectile/dartgun,

		/obj/item/gun/projectile/automatic/lmg/pk/mounted,
		/obj/item/gun/projectile/automatic/lmg/pk/mounted/mech,

		/obj/item/gun/projectile/shotgun/pump/grenade/makeshift,
		/obj/item/gun/projectile/shotgun/slidebarrel,
		/obj/item/gun/projectile/revolver/handmade,
		/obj/item/gun/projectile/revolver/artwork_revolver,
		/obj/item/gun/projectile/handmade_pistol,
		/obj/item/gun/projectile/boltgun/handmade,
		/obj/item/gun/projectile/automatic/armsmg,
		/obj/item/gun/projectile/automatic/ak47/makeshift,


		/obj/item/gun/energy,
		/obj/item/gun/energy/captain/xenoarch,
		/obj/item/gun/energy/chameleon,
		/obj/item/gun/energy/decloner,
		/obj/item/gun/energy/gun/mounted,
		/obj/item/gun/energy/ionrifle/mounted,
		/obj/item/gun/energy/ionrifle/mounted/mech,
		/obj/item/gun/energy/laser/makeshift,
		/obj/item/gun/energy/laser/mounted,
		/obj/item/gun/energy/laser/mounted/blitz,
		/obj/item/gun/energy/laser/mounted/mech,
		/obj/item/gun/energy/laser/practice,
		/obj/item/gun/energy/laser/practice/xenoarch,
		/obj/item/gun/energy/laser/xenoarch,
	)

	var/obj/item/W = pick(typesof(/obj/item/tool/sword) + typesof(/obj/item/gun/projectile) - block_list)

	holder.sanity.valid_inspirations += W

	W = new W(T)
	W.desc += " It has been inscribed with the \"[holder.last_name]\" family name."
	W.name = "[W] of [holder.last_name]"

	var/list/stats = ALL_STATS
	var/list/final_oddity = list()
	for(var/i = 1 to 2)
		var/stat = pick(stats)
		stats.Remove(stat)

		final_oddity += stat
		final_oddity[stat] = rand(1,7)

	W.AddComponent(/datum/component/inspiration, final_oddity, get_oddity_perk())
	W.AddComponent(/datum/component/atom_sanity, 1, "") //sanity gain by area
	W.sanity_damage -= 1 //damage by view
	W.price_tag += rand(1000, 2500)

	spawn(1)
		holder.equip_to_storage_or_drop(W)
