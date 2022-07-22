/obj/item/gun/projectile/rpg
	rarity_value = 10
	spawn_blacklisted = FALSE

/obj/item/ammo_casing/rocket
	spawn_tags = SPAWN_TAG_AMMO

/obj/item/ammo_casing/rocket/throw_impact(atom/hit_atom, var/speed)
	if(amount)
		explosion(hit_atom, 0, 1, 2, 4)
		qdel(src)
