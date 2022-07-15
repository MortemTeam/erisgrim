/datum/weather/rad_storm/New()
    . = ..()
    protected_areas.Add(
        /area/eris/engineering/breakroom,
        /area/eris/quartermaster/misc,
        /area/eris/quartermaster/artistoffice,
        /area/eris/crew_quarters/barbackroom,
        /area/eris/crew_quarters/barquarters,
        /area/eris/neotheology/churchbarracks,

        /area/eris/rnd/xenobiology,
        /area/eris/rnd/xenobiology/xenoflora,
        /area/eris/medical/virology,

        /area/eris/crew_quarters/hydroponics,
        /area/eris/crew_quarters/hydroponics/garden,

        /area/eris/command/captain,
        /area/eris/command/commander,
        /area/eris/neotheology/office,
        /area/eris/quartermaster/office,
        /area/eris/command/fo/quarters,
        /area/eris/command/meo/quarters,
        /area/eris/command/exultant/quarters,
        /area/eris/command/mbo/quarters,

        /area/eris/security/barracks,
        /area/eris/security/prison,

        /area/shuttle/research/station,
    )
    return .