/datum/sanity
	var/scream_sounds = list(
		'MORTEM/add_bohemian_sounds/track1.mp3',
		'MORTEM/add_bohemian_sounds/track2.mp3',
		'MORTEM/add_bohemian_sounds/track3.mp3',
	)
	var/last_played_scream = TimeOfGame
	var/scream_sound_cd = 6 MINUTES

/datum/sanity/updateLevel(new_level)
	..()

	switch(new_level)
		if(-INFINITY to 6.66)
			if(last_played_scream > TimeOfGame && prob(6.66))
				last_played_scream = TimeOfGame + scream_sound_cd
				playsounds(owner, pick(sounds), 66.6, use_pressure = FALSE)
