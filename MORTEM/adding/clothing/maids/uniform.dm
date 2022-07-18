/obj/item/clothing/under/maid
	spawn_blacklisted = TRUE
	desc = "Traditional French maid uniform."
	style = STYLE_HIGH
	price_tag = 250

	has_sensor = FALSE

	contained_sprite = TRUE
	icon = 'MORTEM/adding/clothing/maids/icons.dmi'


/obj/item/clothing/under/maid/classic
	spawn_blacklisted = FALSE
	name = "maid uniform"

	body_parts_covered = UPPER_TORSO|LOWER_TORSO

	icon_state = "maid"
	item_state = "maid"

/obj/item/clothing/under/maid/janitor
	spawn_blacklisted = FALSE
	name = "janimaid uniform"

	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

	icon_state = "janimaid"
	item_state = "janimaid"
