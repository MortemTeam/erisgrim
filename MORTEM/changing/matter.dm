/obj/item/device/lighting/glowstick
    matter = list(MATERIAL_PLASTIC = 1)
    matter_reagents = list("phosphorus" = 3)

/obj/item/device/lighting/glowstick/turn_on()
    . = ..()
    for(var/r in preloaded_reagents)
        matter_reagents[r] = 1

/obj/item/device/lighting/glowstick/flare
    matter = list(MATERIAL_PLASTIC = 2)
    matter_reagents = list("phosphorus" = 5)
    preloaded_reagents = null

/obj/item/flame/match
    matter = list(MATERIAL_WOOD = 0.5)
    preloaded_reagents = null
