/datum/nano_module/program/trade/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = NANOUI_FOCUS, state = GLOB.default_state)
	var/list/data = ui_data()

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "trade.tmpl", name, 750, 700, state = state)
		//ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()
