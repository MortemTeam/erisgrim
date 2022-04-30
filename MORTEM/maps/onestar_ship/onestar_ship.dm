#include "onestar_ship.dmm"

/obj/map_data/onestar_ship
	name = "OneStar Ship Level"
	is_player_level = TRUE
	is_contact_level = TRUE
	is_accessable_level = TRUE
	height = 1


/obj/effect/overmap/sector/onestar_ship
	name = "unknown spatial phenomenon"
	desc = "An abandoned one star ship, carved inside an asteroid. Minimal life signs."
	generic_waypoints = list(
		"nav_onestar_ship_1",
	)
	known = 1
	invisibility = 101

	name_stages = list("abandoned ship", "unknown object", "unknown spatial phenomenon")
	icon_stages = list("htu_frigate_r", "object", "poi")


/obj/effect/shuttle_landmark/onestar_ship/nav1
	name = "OneStar Ship Navpoint #1"
	landmark_tag = "nav_onestar_ship_1"
	base_turf = /turf/space