/obj/item/organ/external/robotic/moebius/reinforced
	matter = list(
		MATERIAL_PLASTEEL = 2,
		MATERIAL_SILVER = 1,
		MATERIAL_GOLD = 1,
	)

/datum/design/research/item/mechfab/prosthesis_moebius/torso
	build_path = /obj/item/organ/external/robotic/moebius/reinforced/torso


/datum/technology/top_biotech
	unlocks_designs = list(
		/datum/design/research/item/mechfab/modules/armor,
		/datum/design/research/item/mechfab/modules/armblade,
		/datum/design/research/item/mechfab/modules/runner,
		/datum/design/research/item/mechfab/modules/multitool/surgical,
		/datum/design/research/item/mechfab/modules/multitool/engineer,
		/datum/design/research/item/mechfab/modules/multitool/miner,

		/datum/design/research/item/mechfab/prosthesis_moebius/head,
		/datum/design/research/item/mechfab/prosthesis_moebius/torso,
		/datum/design/research/item/mechfab/prosthesis_moebius/groin,
		/datum/design/research/item/mechfab/prosthesis_moebius/r_arm,
		/datum/design/research/item/mechfab/prosthesis_moebius/l_arm,
		/datum/design/research/item/mechfab/prosthesis_moebius/r_leg,
		/datum/design/research/item/mechfab/prosthesis_moebius/l_leg,
	)
