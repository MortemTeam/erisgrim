/obj/item/tool/towel
	name = "towel"
	desc = "A soft cotton towel."
	w_class = ITEM_SIZE_NORMAL

	contained_sprite = TRUE
	icon = 'MORTEM/adding/clothing/towel/icons.dmi'
	icon_state = "towel"
	item_state = "towel"

	item_flags = THICKMATERIAL
	slot_flags = SLOT_HEAD | SLOT_BELT | SLOT_OCLOTHING | SLOT_ICLOTHING

	force = WEAPON_FORCE_HARMLESS
	armor_divisor = ARMOR_PEN_GRAZING
	attack_verb = list("whipped")
	hitsound = 'MORTEM/adding/clothing/towel/towelwhip.ogg'

	matter = list(MATERIAL_BIOMATTER = 5)
	spawn_tags = SPAWN_TAG_CLOTHING
	rarity_value = 13

/obj/item/tool/towel/attack_self(mob/living/user as mob)
	user.visible_message(text("<span class='notice'>[] uses [] to towel themselves off.</span>", user, src))
	playsound(user, 'MORTEM/adding/clothing/towel/towelwipe.ogg', 25, 1)

/obj/item/tool/towel/random/New()
	..()
	color = get_random_colour(0, 0, 255)

/obj/item/tool/towel/fleece // loot from the king of goats. it's a golden towel
	name = "golden fleece"
	desc = "The legendary Golden Fleece of Jason made real."
	color = "#ffd700"
