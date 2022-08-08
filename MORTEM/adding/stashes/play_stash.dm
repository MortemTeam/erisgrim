/datum/stash/toys
    base_type = /datum/stash/toys
    loot_type = "Toys"
    directions = DIRECTION_COORDS
    contents_list_extra = list()

/datum/stash/toys/suit_pack
    lore = "Hey, I stole a couple of outfits from the cargos. I don't think they'll notice the loss. I hope I don't forget to take it back: %D"
    contents_list_extra = list(
        /obj/spawner/cloth/head = 3,
        /obj/spawner/cloth/masks = 3,
        /obj/spawner/cloth/under = 3,
        /obj/spawner/cloth/gloves = 3,
        /obj/spawner/cloth/shoes = 3,
        /obj/spawner/cloth/suit = 3,
    )

/datum/stash/toys/play_pack
    lore = "Haha, tricked the directorate into playing poker like suckers, you know how slick my hands are. It's not stealing if they have a lot of money. Hid the proceeds here: %D"
    contents_list_extra = list(
        /obj/item/deck/cards = 1,
        /obj/item/dice = 1,
        /obj/spawner/booze = 3,
    )
    contents_list_random = list(
        /obj/spawner/credits/c5000 = 66.6,
    )

/datum/stash/toys/sex_pack
    lore = "You know how hard it is to get? I'll leave that for the next shift: %D"
    contents_list_extra = list(
        /obj/spawner/credits/c5000 = 1,
    )
    contents_list_random = list(
        /obj/item/mirror = 66.6,
        /obj/item/lipstick/random = 66.6,
        /obj/item/haircomb = 66.6,
        /obj/item/tool/towel/random = 66.6,
        /obj/item/ammo_casing/grenade = 66.6,
        /obj/item/handcuffs/cable/pink = 66.6,
        /obj/item/clothing/under/maid/sex = 66.6,
        /obj/item/clothing/head/collectable/kitty = 66.6,
        /obj/item/clothing/head/collectable/rabbitears = 66.6,
        /obj/item/reagent_containers/glass/bottle/lube = 66.6,
        /obj/item/computer_hardware/hard_drive/portable/design/playtoys = 13,
    )
