/datum/sanity/onLife()
    if(owner.client)
        . = ..()

/datum/sanity/onSay()
    if(owner.client)
        . = ..()