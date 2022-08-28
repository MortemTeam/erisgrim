/datum/nano_module/program/trade/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = NANOUI_FOCUS, state = GLOB.default_state)
    var/list/data = ui_data()

    ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
    if (!ui)
        ui = new(user, src, ui_key, "trade.tmpl", name, 910, 800, state = state)

        // template keys starting with _ are not appended to the UI automatically and have to be called manually
        ui.add_template("_goods", "trade_goods.tmpl")
        ui.add_template("_offers", "trade_offers.tmpl")
        ui.add_template("_cart", "trade_cart.tmpl")
        ui.add_template("_orders", "trade_orders.tmpl")
        ui.add_template("_saved", "trade_saved.tmpl")

        //ui.set_auto_update(1)
        ui.set_initial_data(data)
        ui.open()
