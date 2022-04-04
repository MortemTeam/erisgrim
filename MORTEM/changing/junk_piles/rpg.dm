/obj/item/gun/projectile/rpg
	spawn_tags = SPAWN_TAG_FS_PROJECTILE
	rarity_value = 13

/obj/item/ammo_casing/rocket
	spawn_tags = SPAWN_TAG_FS_PROJECTILE
	rarity_value = 13

/obj/item/ammo_casing/rocket/throw_impact(atom/hit_atom, var/speed)
	if(amount)
		explosion(hit_atom, 0, 1, 2, 4)
		qdel(src)
