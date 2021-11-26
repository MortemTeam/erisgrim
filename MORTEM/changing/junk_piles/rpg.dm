/obj/item/gun/projectile/rpg
	spawn_blacklisted = FALSE
	rarity_value = 6.66

/obj/item/ammo_casing/rocket
	spawn_blacklisted = FALSE
	rarity_value = 6.66
	spawn_tags = SPAWN_TAG_AMMO

/obj/item/ammo_casing/rocket/throw_impact(atom/hit_atom, var/speed)
	if(amount)
		explosion(hit_atom, 0, 1, 2, 4)
