/obj/item/gun/projectile/rpg
	spawn_blacklisted = FALSE
	rarity_value = 13

/obj/item/ammo_casing/rocket
	spawn_blacklisted = FALSE
	spawn_tags = SPAWN_TAG_AMMO
	rarity_value = 13

/obj/item/ammo_casing/rocket/throw_impact(atom/hit_atom, var/speed)
	if(amount)
		explosion(hit_atom, 0, 1, 2, 4)
		qdel(src)
