/datum/category_group/setup_option_category/background/ability
	name = "Ability"
	category_item_type = /datum/category_item/setup_option/background/ability

/datum/category_item/setup_option/background/ability
    var/datum/perk/oddity/perk

/datum/category_item/setup_option/background/ability/New()
    if(perk)
        name = initial(perk.name)
        desc = initial(perk.desc)
        perks = list(perk)

/datum/category_item/setup_option/background/ability/fast_walker
	perk = PERK_FAST_WALKER

/datum/category_item/setup_option/background/ability/ear_of_quicksilver
	perk = PERK_EAR_OF_QUICKSILVER

/datum/category_item/setup_option/background/ability/gunslinger
	perk = PERK_GUNSLINGER

/datum/category_item/setup_option/background/ability/terrible_fate
	perk = PERK_TERRIBLE_FATE

/datum/category_item/setup_option/background/ability/unfinished_delivery
	perk = PERK_UNFINISHED_DELIVERY

/datum/category_item/setup_option/background/ability/lungs_of_iron
	perk = PERK_LUNGS_OF_IRON

/datum/category_item/setup_option/background/ability/blood_of_lead
	perk = PERK_BLOOD_OF_LEAD

/datum/category_item/setup_option/background/ability/space_asshole
	perk = PERK_SPACE_ASSHOLE

/datum/category_item/setup_option/background/ability/parkour
	perk = PERK_PARKOUR

/datum/category_item/setup_option/background/ability/charming_personality
	perk = PERK_CHARMING_PERSONALITY

/datum/category_item/setup_option/background/ability/horrible_deeds
	perk = PERK_HORRIBLE_DEEDS

/datum/category_item/setup_option/background/ability/chaingun_smoker
	perk = PERK_CHAINGUN_SMOKER

/datum/category_item/setup_option/background/ability/nightcrawler
	perk = PERK_NIGHTCRAWLER

/datum/category_item/setup_option/background/ability/fast_fingers
	perk = PERK_FAST_FINGERS

/datum/category_item/setup_option/background/ability/quiet_as_mouse
	perk = PERK_QUIET_AS_MOUSE

/datum/category_item/setup_option/background/ability/balls_of_plasteel
	perk = PERK_BALLS_OF_PLASTEEL

/datum/category_item/setup_option/background/ability/junkborn
	perk = PERK_JUNKBORN

/datum/category_item/setup_option/background/ability/ass_of_concrete
	perk = PERK_ASS_OF_CONCRETE

/datum/category_item/setup_option/background/ability/toxic_revenger
	perk = PERK_TOXIC_REVENGER

/datum/category_item/setup_option/background/ability/absolute_grab
	perk = PERK_ABSOLUTE_GRAB

/datum/category_item/setup_option/background/ability/sure_step
	perk = PERK_SURE_STEP

/datum/category_item/setup_option/background/ability/market_prof
	perk = PERK_MARKET_PROF

/datum/category_item/setup_option/background/ability/gunsmith
	perk = /datum/perk/oddity/gunsmith

/datum/category_item/setup_option/background/ability/unstoppable_arm
	perk = /datum/perk/oddity/unstoppable_arm

/datum/category_item/setup_option/background/ability/long_arm
	perk = /datum/perk/oddity/long_arm
