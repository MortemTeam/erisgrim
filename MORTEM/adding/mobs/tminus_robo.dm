/obj/item/robot_module/syndicate/bladewolf
	name = "bladewolf robot module"

/obj/item/robot_module/syndicate/bladewolf/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/tool/robotic_engineering_omnitool(src)
	src.modules += new /obj/item/tool/robotic_medical_omnitool(src)
	src.modules += new /obj/item/gun/energy/plasma/mounted/blitz(src)
	src.modules += new /obj/item/device/nanite_container(src)
	src.modules += new /obj/item/handcuffs/cyborg(src)
	src.modules += new /obj/item/card/id/syndicate(src)


	..(R)

/mob/living/silicon/robot/syndicate/bladewolf
    icon_state = "bladewolfmk2"
    speed_factor = 1.5
    health = 250

/mob/living/silicon/robot/syndicate/bladewolf/New()
	..()
	verbs += /mob/living/proc/hide
    
    real_name = "Blade Wolf"
    name = real_name

/mob/living/silicon/robot/syndicate/bladewolf/init()
	aiCamera = new/obj/item/device/camera/siliconcam/robot_camera(src)

	laws = new /datum/ai_laws/syndicate_override
	overlays.Cut()
	init_id()
	new /obj/item/robot_module/syndicate/bladewolf(src)

	radio.keyslot = new /obj/item/device/encryptionkey/syndicate(radio)
	radio.recalculateChannels()

	playsound(loc, 'sound/mechs/nominalsyndi.ogg', 75, 0)