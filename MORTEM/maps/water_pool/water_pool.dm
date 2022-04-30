#include "water_pool.dmm"

/obj/map_data/water_pool
	name = "Water Pool Level"
	is_player_level = TRUE
	is_contact_level = TRUE
	is_accessable_level = TRUE
	height = 1

/obj/effect/overmap/sector/water_pool
	name = "derelict water pool"
	desc = "An abandoned water pool. There are signs of life."
	generic_waypoints = list(
		"nav_water_pool_1",
		"nav_water_pool_2",
		"nav_water_pool_3",
	)
	known = 1

	name_stages = list("water pool", "unknown object", "unknown spatial phenomenon")
	icon_stages = list("htu_station", "object", "poi")

/obj/effect/shuttle_landmark/water_pool/dock1
	name = "Water Pool Dock №1"
	landmark_tag = "nav_water_pool_1"
	base_turf = /turf/space

/obj/effect/shuttle_landmark/water_pool/dock2
	name = "Water Pool Dock №2"
	landmark_tag = "nav_water_pool_2"
	base_turf = /turf/space

/obj/effect/shuttle_landmark/water_pool/outer1
	name = "Water Pool Outer"
	landmark_tag = "nav_water_pool_3"
	base_turf = /turf/space

////////////////////////////////////space

/area/away/water_pool
	name = "Abandoned Water Pool"
	icon_state = "blue"

