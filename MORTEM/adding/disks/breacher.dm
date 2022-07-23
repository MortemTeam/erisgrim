/obj/item/computer_hardware/hard_drive/portable/design/breacher
	disk_name = "Illegal Breach Tools"
	icon_state = "black"
	rarity_value = 15
	spawn_tags = SPAWN_TAG_DESIGN_ADVANCED_COMMON
	license = 5
	designs = list(
        /datum/design/autolathe/gun/rpg,
        /datum/design/autolathe/ammo/rpg,
        /datum/design/autolathe/ammo/rpg_hesh,
        /datum/design/autolathe/ammo/rpg_heat,
        /datum/design/autolathe/ammo/rpg_thermo,
        /datum/design/autolathe/tool/hammer_IH,
        /datum/design/autolathe/tool/emag,
        /datum/design/autolathe/tool/plastique,
    )

/datum/design/autolathe/gun/rpg
	build_path = /obj/item/gun/projectile/rpg

/datum/design/autolathe/ammo/rpg
	build_path = /obj/item/ammo_casing/rocket

/datum/design/autolathe/ammo/rpg_hesh
	build_path = /obj/item/ammo_casing/rocket/hesh

/datum/design/autolathe/ammo/rpg_heat
	build_path = /obj/item/ammo_casing/rocket/heat

/datum/design/autolathe/ammo/rpg_thermo
	build_path = /obj/item/ammo_casing/rocket/thermo


/datum/design/autolathe/tool/hammer_IH
    build_path = /obj/item/tool/hammer/IH


/datum/design/autolathe/tool/emag
	build_path = /obj/item/card/emag

/datum/design/autolathe/tool/plastique
	build_path = /obj/item/plastique


/obj/item/card/emag
    matter = list(MATERIAL_PLASTIC = 10, MATERIAL_GOLD = 5, MATERIAL_SILVER = 2)

/obj/item/plastique
    matter = list(MATERIAL_PLASTIC = 20, MATERIAL_PLASMA = 10, MATERIAL_SILVER = 2)
