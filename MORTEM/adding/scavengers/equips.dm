/obj/item/clothing/under/scaven
    spawn_blacklisted = TRUE
    name = "unknown jumpsuit"
    desc = "The most advanced form of jumpsuit known to reality, looks uncomfortable."

    has_sensor = FALSE

    contained_sprite = TRUE
    icon = 'MORTEM/adding/scavengers/icons.dmi'
    icon_state = "scaven_uniform"

/obj/item/clothing/head/space/void/scaven
    spawn_blacklisted = TRUE
    name = "unknown headgear"
    desc = "Abduct with style - spiky style. Prevents digital tracking."

    contained_sprite = TRUE
    icon = 'MORTEM/adding/scavengers/icons.dmi'
    icon_state = "alien_helmet"
    item_state = "alien_helmet"

    armor = list(
		melee = 50,
		bullet = 50,
		energy = 50,
		bomb = 50,
		bio = 100,
		rad = 75
	)

    species_restricted = list("Scaven")
    camera_networks = null
    siemens_coefficient = 0.35
    obscuration = 0

/obj/item/clothing/suit/space/void/merc/scaven
    spawn_blacklisted = TRUE
    name = "unknown voidsuit"
    desc = "A vest outfitted with advanced combat technology."
	
    contained_sprite = TRUE
    icon = 'MORTEM/adding/scavengers/icons.dmi'
    icon_state = "vest_combat"

    species_restricted = list("Scaven")
    helmet = /obj/item/clothing/head/space/void/scaven

/obj/item/device/radio/headset/mercenaries/scaven
    spawn_blacklisted = TRUE
    contained_sprite = TRUE
    icon = 'MORTEM/adding/scavengers/icons.dmi'
    icon_state = "scaven_headset"
    item_state = "scaven_headset"

/obj/item/storage/belt/tactical/scaven
    spawn_blacklisted = TRUE
    contained_sprite = TRUE
    icon = 'MORTEM/adding/scavengers/icons.dmi'
    icon_state = "belt"
