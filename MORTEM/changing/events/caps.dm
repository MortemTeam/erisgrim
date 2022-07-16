/datum/storyevent/blob
    req_crew = 6

/datum/storyevent/hivemind
    req_crew = 0

/datum/controller/subsystem/ticker/setup()
    GLOB.hive_data_bool["maximum_existing_mobs"] = TRUE
    GLOB.hive_data_bool["teleport_core_when_damaged"] = FALSE
    GLOB.hive_data_bool["spread_trough_burrows"] = FALSE

    GLOB.hive_data_float["maximum_existing_mobs"] = 50
    GLOB.hive_data_float["maximum_controlled_areas"] = 13
    return ..()
