/obj/item/organ/internal/brain/scaven
    name = "mindshock"
    desc = "Neural crosstalk uninhibitor."
    icon = 'MORTEM/adding/scavengers/bodyparts.dmi'
    icon_state = "mindshock"

/obj/item/organ/internal/heart/scaven
    name = "replicator"
    desc = "Organic replicator."
    icon = 'MORTEM/adding/scavengers/bodyparts.dmi'
    icon_state = "health"

/obj/item/organ/external/make_base_internal_organs()
    if(species != /datum/species/scaven)
        . = ..()

/obj/item/organ/external/set_description(datum/organ_description/desc)
    . = ..()
    if(species == /datum/species/scaven)
        cannot_amputate = TRUE

/datum/species/scaven
    name = "Scaven"
    name_plural = "Scavens"
    name_language = null

    spawn_flags = IS_RESTRICTED

    genders = list(NEUTER)

    default_language = LANGUAGE_CULT
    language = LANGUAGE_CULT  

    breath_type = null
    poison_type = null

    darksight = 6
    flags = NO_BLOOD | NO_BREATHE | NO_SCAN
    appearance_flags = HAS_SKIN_COLOR
    hazard_high_pressure = 666666

    icobase = 'MORTEM/adding/scavengers/bodyparts.dmi'

    has_process = list(    // which required-process checks are conducted and defalut organs for them.
        OP_HEART = /obj/item/organ/internal/heart/scaven,
        BP_BRAIN = /obj/item/organ/internal/brain/scaven,
    )

    has_limbs = list(
        BP_CHEST =  new /datum/organ_description/chest,
        BP_HEAD  =  new /datum/organ_description/head,
        BP_L_ARM =  new /datum/organ_description/arm/left,
        BP_R_ARM =  new /datum/organ_description/arm/right,
        BP_L_LEG =  new /datum/organ_description/leg/left,
        BP_R_LEG =  new /datum/organ_description/leg/right
    )

/mob/living/carbon/human/proc/scavenize()
    set_species("Scaven")

    for(var/obj/item/organ/external/E in organs)
        E.cannot_amputate = TRUE

    to_chat(src, "<B>You are now [species.name]. </B>")
    return src
