/datum/hud/human
	icon = 'MORTEM/adding/grim/icons.dmi'

	HUDneed = list(
//status
		"nutrition"          = list("type" = /obj/screen/nutrition,         "loc" = "EAST+1:1,BOTTOM+3:25",   "minloc" = "RIGHT:1,5:26",  "background" = "back17"),
		"neural system accumulation" = list("type" = /obj/screen/nsa,       "loc" = "EAST+1:1,BOTTOM+4:6",    "minloc" = "RIGHT:1,6:7",   "background" = "back17"),
		"body temperature"   = list("type" = /obj/screen/bodytemp,          "loc" = "EAST+1:1,BOTTOM+4:19",   "minloc" = "RIGHT:1,6:20",  "background" = "back17"),
		"health"             = list("type" = /obj/screen/health,            "loc" = "EAST+1,BOTTOM+5",        "minloc" = "RIGHT,7",       "background" = "back1"),
		"sanity"             = list("type" = /obj/screen/sanity,            "loc" = "EAST+1,BOTTOM+6",        "minloc" = "RIGHT,8:-2",    "background" = "back1"),
		"oxygen"             = list("type" = /obj/screen/oxygen,            "loc" = "EAST+1:1,BOTTOM+7",      "minloc" = "RIGHT:1,9:-3",  "background" = "back18"),
		"fire"               = list("type" = /obj/screen/fire,              "loc" = "EAST+1:16,BOTTOM+7",     "minloc" = "RIGHT:16,9:-3", "background" = "back18"),
		"pressure"           = list("type" = /obj/screen/pressure,          "loc" = "EAST+1:1,BOTTOM+7:15",   "minloc" = "RIGHT:1,9:12",  "background" = "back18"),
		"toxin"              = list("type" = /obj/screen/toxin,             "loc" = "EAST+1:16,BOTTOM+7:15",  "minloc" = "RIGHT:16,9:12", "background" = "back18"),
		"internal"           = list("type" = /obj/screen/internal,          "loc" = "EAST+1,BOTTOM+8:-2",     "minloc" = "RIGHT,10:-5",   "background" = "back15"),
	//corner buttons
		"jump"               = list("type" = /obj/screen/jump,              "loc" = "EAST+1,BOTTOM+1:-6",     "minloc" = "RIGHT,3:-6",    "background" = "back17-1"),
		"look up"            = list("type" = /obj/screen/look_up,           "loc" = "EAST,BOTTOM:15",         "minloc" = "RIGHT-1,2:13",  "background" = "back17-1"),
		"throw"              = list("type" = /obj/screen/HUDthrow,          "loc" = "EAST+1,BOTTOM:16",       "minloc" = "RIGHT,2:13",    "background" = "back17-1"),
		"pull"               = list("type" = /obj/screen/pull,              "loc" = "EAST-1,BOTTOM:16",       "minloc" = "RIGHT-2,2:13",  "background" = "back17-1"),
		"drop"               = list("type" = /obj/screen/drop,              "loc" = "EAST+1,BOTTOM",          "minloc" = "RIGHT,2",       "background" = "back17-1"),
		"resist"             = list("type" = /obj/screen/resist,            "loc" = "EAST-1,BOTTOM",          "minloc" = "RIGHT-2,2",     "background" = "back17-1"),
		"rest"               = list("type" = /obj/screen/rest,              "loc" = "EAST,BOTTOM",            "minloc" = "RIGHT-1,2",     "background" = "back17-1"),
		"move intent"        = list("type" = /obj/screen/mov_intent,        "loc" = "EAST,BOTTOM-1",          "minloc" = "RIGHT-1,1",     "background" = "back1"),
		"implant bionics"    = list("type" = /obj/screen/implant_bionics,   "loc" = "EAST-2,BOTTOM-1",        "minloc" = "12,1",          "background" = "back13"),
		"craft menu"         = list("type" = /obj/screen/craft_menu,        "loc" = "EAST-2:16,BOTTOM-1",     "minloc" = "12:16,1",       "background" = "back13"),
		"wield"              = list("type" = /obj/screen/wield,             "loc" = "EAST-2:16,BOTTOM",       "minloc" = "12:16,2",       "background" = "back13"),
		"intent"             = list("type" = /obj/screen/intent,            "loc" = "EAST-1,BOTTOM-1",        "minloc" = "13,1",          "background" = "back1"),
		"damage zone"        = list("type" = /obj/screen/zone_sel,          "loc" = "EAST+1,BOTTOM-1",        "minloc" = "RIGHT,1",       "background" = "back1"),
	//hand buttons
		"equip"              = list("type" = /obj/screen/equip,             "loc" = "8,1",                    "minloc" = "7,2",           "background" = "back14-l"),
		"swap hand"          = list("type" = /obj/screen/swap,              "loc" = "8,1",                    "minloc" = "7,2"),
		"right arm bionics"  = list("type" = /obj/screen/bionics/r_arm,     "loc" = "7:19,1",                 "minloc" = "6:20,2",        "background" = "back16"),
		"left arm bionics"   = list("type" = /obj/screen/bionics/l_arm,     "loc" = "10,1",                   "minloc" = "9:-1,2",        "background" = "back16"),

		"toggle inventory"    = list("type" = /obj/screen/toggle_invetory,  "loc" = "2,0",                    "minloc" = "1,1",           "background" = "back1")
	)

	HUDfrippery = list(
		list("loc" = "1,0", "icon_state" = "frame0-3", ),
		list("loc" = "1,0", "icon_state" = "frame3-4", ),
		list("loc" = "1,1", "icon_state" = "frame2-2",  "hideflag" = TOGGLE_INVENTORY_FLAG),
		list("loc" = "1,2", "icon_state" = "frame2-3",  "hideflag" = TOGGLE_INVENTORY_FLAG),
		list("loc" = "1,3", "icon_state" = "frame2-1",  "hideflag" = TOGGLE_INVENTORY_FLAG),
		list("loc" = "1,1", "icon_state" = "frame1-3",  "hideflag" = TOGGLE_INVENTORY_FLAG),
		list("loc" = "1,2", "icon_state" = "frame1-7",  "hideflag" = TOGGLE_INVENTORY_FLAG),
		list("loc" = "1,3", "icon_state" = "frame1-5",  "hideflag" = TOGGLE_INVENTORY_FLAG),

		list("loc" = "12,0", "icon_state" = "frame0-2"),
		list("loc" = "EAST+1,BOTTOM+2:25", "icon_state" = "frame0-4"),
		list("loc" = "EAST+1,BOTTOM+8:14", "icon_state" = "frame0-1"),
		list("loc" = "EAST+1,BOTTOM+8:14", "icon_state" = "frame3-1")
	)

/obj/screen/grab
	icon = 'MORTEM/adding/grim/icons.dmi'

/obj/screen/sanity/update_icon()
	var/mob/living/carbon/human/H = parentmob
	if(!istype(H) || H.stat == DEAD)
		return

	cut_overlays()

	var/image/ovrl
	switch(H.sanity.insight)
		if(-INFINITY to 15)
			ovrl = ovrls["sanity0"]
		if(15 to 30)
			ovrl = ovrls["sanity1"]
		if(30 to 45)
			ovrl = ovrls["sanity2"]
		if(45 to 60)
			ovrl = ovrls["sanity3"]
		if(60 to 75)
			ovrl = ovrls["sanity4"]
		if(75 to 90)
			ovrl = ovrls["sanity5"]
		if(90 to INFINITY)
			ovrl = ovrls["sanity6"]

	overlays += ovrl
