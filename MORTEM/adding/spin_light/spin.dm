/obj/effect/spinning_light
	var/spin_rate = 1 SECOND
	var/_size = 48
	var/_factor = 0.5
	var/_density = 4
	var/_offset = 30
	plane = ABOVE_LIGHTING_PLANE
	layer = ABOVE_LIGHTING_LAYER
	mouse_opacity = 0

/obj/effect/spinning_light/Initialize()
	. = ..()
	filters = filter(type="rays", size = _size, color = COLOR_RED, factor = _factor, density = _density, flags = FILTER_OVERLAY, offset = _offset)

	alpha = 100

	//Rays start rotated which made synchronizing the scaling a bit difficult, so let's move it 45 degrees
	var/matrix/m = new
	var/matrix/test = new
	test.Turn(-45)
	var/matrix/squished = new
	squished.Scale(1, 0.5)
	animate(src, transform = (test * m.Turn(90)), spin_rate / 4, loop = -1,)
	animate(transform =      test * m.Turn(90), spin_rate / 4, loop = -1, )
	animate(transform =      (test * m.Turn(90)), spin_rate / 4, loop = -1, )
	animate(transform =      test * matrix(),   spin_rate / 4, loop = -1, )
