/obj/machinery/computer/arcade/orion_trail
    name = "Classic Arcade"
    desc = "Time machine!"
    var/obj/item/game_tape/game

/obj/machinery/computer/arcade/orion_trail/verb/eject_game()
	set category = "Object"
	set name = "Eject Game Tape"
	set src in oview(1)

	if(!usr || usr.stat || usr.lying) return

	if(!game)
		to_chat(usr, "There is nothing to remove from the arcade.")
	else
		to_chat(usr, "You remove \the [game] from \the [src].")
		game.loc = get_turf(src)
		if(!usr.get_active_hand() && ishuman(usr))
			usr.put_in_hands(game)
		game = null
	
	for(var/mob/M in oview(1))
		M << browse(null, "window=arcade")

		
/obj/machinery/computer/arcade/orion_trail/attackby(obj/item/W as obj, mob/user as mob)
	src.add_fingerprint(user)
	if(istype(W, /obj/item/game_tape))
		if(game)
			to_chat(user, SPAN_NOTICE("There's already a tape inside [src]."))
		else
			game = W
			user.unEquip(game, src)
			game.forceMove(src)
			to_chat(user, SPAN_NOTICE("You insert the tape inside [src]."))

	return ..()

/obj/machinery/computer/arcade/orion_trail/attack_hand(mob/user)
	if(!game)
		to_chat(user, SPAN_NOTICE("There is no game to launch here."))
		return 1

	if(..())
		return

	var/dat = {"
		<!DOCTYPE HTML>
		<html><head>
		<style>
			iframe {
				display: none;
			}
		</style>
			<meta http-equiv="X-UA-Compatible" content="IE=edge" />
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		</head>
		<body>
			<script type="text/javascript">
				function pageloaded(myframe) {
					document.getElementById("loading").style.display = "none";
					myframe.style.display = "inline";
    			}
			</script>
			<p id='loading'>You start skimming through the console...</p>
			<iframe width='100%' height='97%' onload="pageloaded(this)" src="https://mortem.one/dos/[game.game_url]/" frameborder="0" id="main_frame"></iframe>
		</body>
		</html>
	"}

	user << browse(dat, "window=arcade; size=640x480")
