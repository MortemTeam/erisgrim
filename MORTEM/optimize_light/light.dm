#define STAGE_SOURCES  1
#define STAGE_CORNERS  2
#define STAGE_OVERLAYS 3

#define APPLY_CORNER(C)              \
	. = LUM_FALLOFF(C, source_turf); \
                                     \
	. *= light_power;                \
                                     \
	effect_str[C] = .;               \
                                     \
	C.update_lumcount                \
	(                                \
		. * applied_lum_r,           \
		. * applied_lum_g,           \
		. * applied_lum_b            \
	);

// I don't need to explain what this does, do I?
#define REMOVE_CORNER(C)             \
	. = -effect_str[C];              \
	C.update_lumcount                \
	(                                \
		. * applied_lum_r,           \
		. * applied_lum_g,           \
		. * applied_lum_b            \
	);

#define LUM_FALLOFF(C, T) (1 - CLAMP01(sqrt((C.x - T.x) ** 2 + (C.y - T.y) ** 2 + LIGHTING_HEIGHT) / max(1, light_range)))

/datum/light_source/apply_lum()
	var/static/update_gen = 1
	applied = 1

	// Keep track of the last applied lum values so that the lighting can be reversed
	applied_lum_r = lum_r
	applied_lum_g = lum_g
	applied_lum_b = lum_b

	FOR_DVIEW(var/turf/T, light_range, source_turf, INVISIBILITY_LIGHTING)
		if(!T.lighting_corners_initialised)
			T.generate_missing_corners()

		for(var/datum/lighting_corner/C as() in T.get_corners())
			if(C.update_gen == update_gen)
				continue

			C.update_gen = update_gen
			C.affecting += src

			if(!C.active)
				effect_str[C] = 0
				continue

			APPLY_CORNER(C)

		if(!T.affecting_lights)
			T.affecting_lights = list()

		T.affecting_lights += src
		affecting_turfs    += T
	END_FOR_DVIEW

	update_gen++

/datum/light_source/remove_lum()
	applied = FALSE

	for(var/turf/T as() in affecting_turfs)
		if(T.affecting_lights)
			T.affecting_lights -= src

	affecting_turfs.Cut()

	for(var/datum/lighting_corner/C as() in effect_str)
		REMOVE_CORNER(C)
		C.affecting -= src

	effect_str.Cut()

/datum/controller/subsystem/lighting/fire(resumed=FALSE)
	if (resuming_stage == 0 || !resumed)
		src.currentrun_lights   = lighting_update_lights
		lighting_update_lights   = list()

		resuming_stage = STAGE_SOURCES

	var/list/currentrun_lights = src.currentrun_lights

	while (currentrun_lights.len)
		var/datum/light_source/L = currentrun_lights[currentrun_lights.len]
		currentrun_lights.len--

		if(L.destroyed || L.force_update || L.check())
			L.remove_lum()
			if(!L.destroyed)
				L.apply_lum()

		else if (L.vis_update)
			L.smart_vis_update()

		L.vis_update   = FALSE
		L.force_update = FALSE
		L.needs_update = FALSE

		if (MC_TICK_CHECK)
			return

	if (resuming_stage == STAGE_SOURCES || !resumed)
		// PJB left this in, was causing crashes.
		//if (currentrun_corners && currentrun_corners.len)
		//	to_chat(world, "we still have corners to do, but we're gonna override them?")

		src.currentrun_corners  = lighting_update_corners
		lighting_update_corners  = list()

		resuming_stage = STAGE_CORNERS

	var/list/currentrun_corners = src.currentrun_corners

	while (currentrun_corners.len)
		var/datum/lighting_corner/C = currentrun_corners[currentrun_corners.len]
		currentrun_corners.len--

		C.update_overlays()
		C.needs_update = FALSE
		if (MC_TICK_CHECK)
			return

	if (resuming_stage == STAGE_CORNERS || !resumed)
		src.currentrun_overlays = lighting_update_overlays
		lighting_update_overlays = list()

		resuming_stage = STAGE_OVERLAYS

	var/list/currentrun_overlays = src.currentrun_overlays

	while (currentrun_overlays.len)
		var/atom/movable/lighting_overlay/O = currentrun_overlays[currentrun_overlays.len]
		currentrun_overlays.len--

		O.update_overlay()
		O.needs_update = FALSE
		if (MC_TICK_CHECK)
			return

	resuming_stage = 0
