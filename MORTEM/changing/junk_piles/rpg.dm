/obj/item/gun/projectile/rpg
	spawn_blacklisted = FALSE
	rarity_value = 66.6

/obj/item/ammo_casing/rocket
	rarity_value = 66.6
	spawn_tags = SPAWN_TAG_AMMO

/obj/item/ammo_casing/rocket/throw_impact(atom/hit_atom, var/speed)
	if(amount)
		explosion(hit_atom, 0, 1, 2, 4)
