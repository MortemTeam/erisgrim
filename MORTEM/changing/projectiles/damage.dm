/obj/item/projectile/New()
    . = ..()
    for(var/dtype in damage_types)
        if(dtype in list(BRUTE, BURN))
            damage_types[dtype] *= 1.3
