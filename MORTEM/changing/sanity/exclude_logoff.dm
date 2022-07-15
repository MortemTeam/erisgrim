/datum/sanity/onLife()
    if(owner.client)
        return ..()

/datum/sanity/onSay()
    if(owner.client)
        return ..()