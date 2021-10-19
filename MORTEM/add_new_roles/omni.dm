
#define ROLE_OMNI "robo_omni"

/datum/antagonist/omni
	id = ROLE_OMNI
	only_human = FALSE

	survive_objective = null

/datum/antagonist/omni/New()
	..()
	welcome_text = SPAN_WARNING("0///N1 W@$ H3Я3")

/datum/antagonist/omni/can_become_antag(datum/mind/player)
	return issilicon(player.current) && ..(player)

/datum/antagonist/omni/equip()
	var/mob/living/silicon/S = owner.current

	if(!S.is_malf_or_traitor())
		S.set_zeroth_law("")
	S.laws.clear_supplied_laws()
	S.laws.clear_ion_laws()
	S.laws.clear_inherent_laws()
	S.show_laws()
