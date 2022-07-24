/obj/item/clothing/under/maid
	bad_type = /obj/item/clothing/under/maid
	desc = "Traditional French maid uniform."
	style = STYLE_HIGH
	price_tag = 250

	has_sensor = FALSE

	contained_sprite = TRUE
	icon = 'MORTEM/adding/clothing/maids/icons.dmi'


/obj/item/clothing/under/maid/classic
	name = "maid uniform"

	body_parts_covered = UPPER_TORSO|LOWER_TORSO

	icon_state = "maid"
	item_state = "maid"

/obj/item/clothing/under/maid/naked
	name = "naked maid uniform"

	body_parts_covered = 0

	icon_state = "nakedmaid"
	item_state = "nakedmaid"

/obj/item/clothing/under/maid/janitor
	name = "janimaid uniform"

	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

	icon_state = "janimaid"
	item_state = "janimaid"
