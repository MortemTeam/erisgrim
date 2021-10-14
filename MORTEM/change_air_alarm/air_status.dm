/obj/machinery/alarm/populate_status(var/data)
	var/turf/location = get_turf(src)
	var/datum/gas_mixture/environment = location.return_air()
	var/total = environment.total_moles

	var/list/environment_data = new
	data["has_environment"] = total
	if(total)
		var/pressure = environment.return_pressure()
		environment_data[++environment_data.len] = list("name" = "Pressure", "value" = pressure, "unit" = "kPa", "danger_level" = pressure_dangerlevel)
		environment_data[++environment_data.len] = list("name" = "Temperature", "value" = environment.temperature, "unit" = "K ([round(environment.temperature - T0C, 0.1)]C)", "danger_level" = temperature_dangerlevel)
		for(var/key in environment.gas)
			environment_data[++environment_data.len] = list("name" = gas_data.name[key], "value" = environment.gas[key] / total * 100, "unit" = "%", "danger_level" = 0)

	data["total_danger"] = danger_level
	data["environment"] = environment_data
	data["atmos_alarm"] = alarm_area.atmosalm
	data["fire_alarm"] = alarm_area.fire != null
	data["target_temperature"] = "[target_temperature - T0C]C"
