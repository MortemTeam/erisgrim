/obj/item/trash/shell
	icon = 'MORTEM/adding/beach/icons.dmi'
	matter = list(MATERIAL_BIOMATTER = 1)
	spawn_blacklisted = TRUE

	icon_state = "shell1"
	var/list/rand_state = list("shell1")

/obj/item/trash/shell/New()
	..()
	icon_state = pick(rand_state)

/obj/item/trash/shell/sea
	name = "sea shell"
	desc = "The shell of sea."
	icon_state = "shell1"
	rand_state = list("shell1", "shell2", "shell3")

/obj/item/trash/shell/mollusc
	name = "mollusc shell"
	desc = "The shell of an unfortunate mollusc."
	icon_state = "mollusc"
	rand_state = list("mollusc", "clam", "barnacle", "ras'val_clams", "mollusc_shell", "clam_shell", "barnacle_shell", "ras'val_clams_shell")
