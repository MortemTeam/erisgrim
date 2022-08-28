/obj/item/gun_upgrade/scope/watchman_advanced    
    name = "Frozen Star \"Watchman Advanced\" scope"
    desc = "Scope that can be attachet to avarage gun."
    matter = list(MATERIAL_GLASS = 3, MATERIAL_PLASTEEL = 3)
    icon_state = "2,0"

/obj/item/gun_upgrade/scope/watchman_advanced/New()
    ..()
    var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
    I.weapon_upgrades = list(
        GUN_UPGRADE_RECOIL = 1.2,
        GUN_UPGRADE_ZOOM = 1.5
    )
    I.gun_loc_tag = GUN_SCOPE
    I.req_gun_tags = list(GUN_SCOPE)
