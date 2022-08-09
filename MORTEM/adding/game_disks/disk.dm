/obj/item/game_tape
	name = "game tape"
	desc = "It smells nostalgic."
	icon = 'icons/obj/casettes.dmi'
	icon_state = "1"
	item_state = "card-id"
	w_class = ITEM_SIZE_TINY
	spawn_tags = SPAWN_TAG_DESIGN_COMMON
	rarity_value = 6.66

	var/game_name
	var/game_url
	var/gamelists = list(
        "Battle Chess" = "chess",
        "DOOM 2" = "doom2", 
        "Heroes Of Might And Magic II" = "homm2",
        "Master of Orion II" = "moo2",
        "Need for Speed" = "nfs",
        "PAC-MAN" = "pacman",
        "Transport Tycoon Deluxe" = "ttd",
        "X-COM" = "xcom",
    )

/obj/item/game_tape/New()
	game_name = pick(gamelists)
	game_url = gamelists[game_name]
	name = "[name] ([game_name])"
	icon_state = "prem-[rand(1, 15)]"

	. = ..()