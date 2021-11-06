/decl/xgm_gas
	var/tile_icon = 'icons/effects/tile_effects.dmi'

/hook/startup/generateGasData()
	gas_data = new
	for(var/p in (typesof(/decl/xgm_gas) - /decl/xgm_gas))
		var/decl/xgm_gas/gas = new p //avoid initial() because of potential New() actions

		if(gas.id in gas_data.gases)
			error("Duplicate gas id `[gas.id]` in `[p]`")

		gas_data.gases += gas.id
		gas_data.name[gas.id] = gas.name
		gas_data.specific_heat[gas.id] = gas.specific_heat
		gas_data.molar_mass[gas.id] = gas.molar_mass
		if(gas.tile_overlay) gas_data.tile_overlay[gas.id] = image(gas.tile_icon, gas.tile_overlay, FLY_LAYER)
		if(gas.overlay_limit) gas_data.overlay_limit[gas.id] = gas.overlay_limit
		gas_data.flags[gas.id] = gas.flags

	return 1

/turf/simulated/floor/exoplanet/snow
	nitrogen = MOLES_CELLSTANDARD * 36.28
	temperature = T20C - 193

/turf/simulated/floor/exoplanet/chlorine_sand
	nitrogen = MOLES_CELLSTANDARD * 36.28
	temperature = T20C - 193

/decl/xgm_gas/nitrogen
	tile_icon = 'MORTEM/add_planet_simulation/weather.dmi'
	tile_overlay = "snowfall_med"
	overlay_limit = 200
