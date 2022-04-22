/datum/hud/human
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
	"jump"               = list("type" = /obj/screen/jump,              "loc" = "EAST+1,BOTTOM+1:-6", "minloc" = "RIGHT,3:-6",   "background" = "back17-1"),
	"look up"            = list("type" = /obj/screen/look_up,           "loc" = "EAST,BOTTOM+1:15",   "minloc" = "RIGHT-1,2:13", "background" = "back17-1"),
	"throw"              = list("type" = /obj/screen/HUDthrow,          "loc" = "EAST+1,BOTTOM+1:16", "minloc" = "RIGHT,2:13",   "background" = "back17-1"),
	"pull"               = list("type" = /obj/screen/pull,              "loc" = "EAST-1,BOTTOM+1:16", "minloc" = "RIGHT-2,2:13", "background" = "back17-1"),
	"drop"               = list("type" = /obj/screen/drop,              "loc" = "EAST+1,BOTTOM+1",    "minloc" = "RIGHT,2",      "background" = "back17-1"),
	"resist"             = list("type" = /obj/screen/resist,            "loc" = "EAST-1,BOTTOM+1",    "minloc" = "RIGHT-2,2",    "background" = "back17-1"),
	"rest"               = list("type" = /obj/screen/rest,              "loc" = "EAST,BOTTOM+1",      "minloc" = "RIGHT-1,2",    "background" = "back17-1"),
	"move intent"        = list("type" = /obj/screen/mov_intent,        "loc" = "EAST,BOTTOM",        "minloc" = "RIGHT-1,1",    "background" = "back1"),
	"implant bionics"    = list("type" = /obj/screen/implant_bionics,   "loc" = "EAST-2,BOTTOM-1",    "minloc" = "12,1",         "background" = "back13"),
	"craft menu"         = list("type" = /obj/screen/craft_menu,        "loc" = "EAST-2:16,BOTTOM",   "minloc" = "12:16,1",      "background" = "back13"),
	"wield"              = list("type" = /obj/screen/wield,             "loc" = "EAST-2:16,BOTTOM+1", "minloc" = "12:16,2",      "background" = "back13"),
	"intent"             = list("type" = /obj/screen/intent,            "loc" = "EAST-1,BOTTOM",      "minloc" = "13,1",         "background" = "back1"),
	"damage zone"        = list("type" = /obj/screen/zone_sel,          "loc" = "EAST+1,BOTTOM",      "minloc" = "RIGHT,1",      "background" = "back1"),
//hand buttons
	"equip"              = list("type" = /obj/screen/equip,             "loc" = "8,1",                "minloc" = "7,2",          "background" = "back14-l"),
	"swap hand"          = list("type" = /obj/screen/swap,              "loc" = "8,1",                "minloc" = "7,2",          ),
	"right arm bionics"  = list("type" = /obj/screen/bionics/r_arm,     "loc" = "7:19,1",             "minloc" = "6:20,2",       "background" = "back16"),
	"left arm bionics"   = list("type" = /obj/screen/bionics/l_arm,     "loc" = "10,1",               "minloc" = "9:-1,2",       "background" = "back16"),

	"toggle inventory"    = list("type" = /obj/screen/toggle_invetory,   "loc" = "2,0",                "minloc" = "1,1",         "background" = "back1")

	)