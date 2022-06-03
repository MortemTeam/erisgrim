#include "volniy_station.dmm"
#include "transit_space.dmm"

#define VOLNIY_CITIZEN 1<<666

/// MAPS

/obj/map_data/volniy_station
	name = "Volniy Station Level"
	is_player_level = TRUE
	is_accessable_level = FALSE
	is_sealed = TRUE
	height = 1

/obj/effect/overmap/sector/volniy_station
	name = "Volniy Station"
	desc = "Hidden from radars station."
	generic_waypoints = list(
		"nav_volniy_station_1",
		"nav_volniy_station_2",
		"out_volniy_station_1",
		"out_volniy_station_2",
	)

	known = 0

	name_stages = list("volniy station", "unknown station", "unknown spatial phenomenon")
	icon_stages = list("htu_capital", "station", "poi")

/obj/effect/shuttle_landmark/volniy_station/nav1
	name = "Volniy Station Dock #1"
	landmark_tag = "nav_volniy_station_1"
	base_turf = /turf/space

/obj/effect/shuttle_landmark/volniy_station/nav2
	name = "Volniy Station Dock #2"
	landmark_tag = "nav_volniy_station_2"
	base_turf = /turf/space

/obj/effect/shuttle_landmark/volniy_station/out1
	name = "Volniy Station Out #1"
	landmark_tag = "out_volniy_station_1"
	base_turf = /turf/space

/obj/effect/shuttle_landmark/volniy_station/out2
	name = "Volniy Station Out #2"
	landmark_tag = "out_volniy_station_2"
	base_turf = /turf/space

/// SHUTTLES 

/datum/shuttle/autodock/overmap/hulk
	name = "Hulk"
	move_time = 60
	shuttle_area = /area/shuttle/mining/station
	default_docking_controller = "hulk_shuttle"
	current_location = "nav_dock_hulk"
	landmark_transition = "nav_transit_hulk"
	range = INFINITY  // Can go anywhere on overmap to avoidance depending on the jobs with bridge access to direct the ship
	fuel_consumption = 4

/obj/effect/shuttle_landmark/eris/dock/hulk
	name = "Hulk Dock"
	landmark_tag = "nav_dock_hulk"
	dock_target = "mining_dock_airlock"
	docking_controller = "hulk_shuttle"
	base_turf = /turf/space

/obj/effect/shuttle_landmark/eris/transit/hulk
	name = "In transit"
	landmark_tag = "nav_transit_hulk"
	base_turf = /turf/space

/// AREAS

/area/away/volniy
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/space
	requires_power = 0

/area/away/volniy/station
	name = "\improper Volniy Station"
	sound_env = STANDARD_STATION

/area/away/volniy/shuttle/scrapper
	name = "\improper Volniy Scrapper Shuttle"

/area/away/volniy/shuttle/aboarding
	name = "\improper Volniy Aboarding Shuttle"


/// JOBS

/datum/job/volniy
	title = "Volniy Citizen"
	flag = VOLNIY_CITIZEN
	department = DEPARTMENT_OFFSHIP
	department_flag = VOLNIY_CITIZEN
	faction = "MSS \"Volniy\""
	selection_color = "#000000"
	outfit_type = /decl/hierarchy/outfit/volniy

	total_positions = -1
	spawn_positions = -1

	create_record = FALSE
	account_allowed = FALSE
	wage = WAGE_NONE

	perks = list(PERK_JUNKBORN)
	stat_modifiers = list(
		STAT_MEC = 15,
		STAT_BIO = 15,
		STAT_TGH = 10,
	)
	
	description = "Volniy Citizen a resident of an ancient and rusty station. Here only those who have found no other home."
	duties = "Stay alive and pray the anarchy."
	loyalties = "You are a member of a fraternal station, anarchy brotherhood it's all for you."
	supervisors = "Anarchy is the mother of order."

/obj/landmark/join/start/volniy
	name = "Volniy Citizen"
	icon_state = "player-black"
	join_tag = /datum/job/volniy

/decl/hierarchy/outfit/volniy
	name = OUTFIT_JOB_NAME("Volniy Citizen")
