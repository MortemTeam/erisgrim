// 0 - No signal, 1 - Low signal, 2 - High signal. 3 - Wired Connection
/obj/item/computer_hardware/network_card/get_signal(specific_action = 0)
	if(!holder2) // Hardware is not installed in anything. No signal. How did this even get called?
		return 0

	if(!enabled)
		return 0

	if(!check_functionality() || !ntnet_global || is_banned())
		return 0

	if(!ntnet_global.check_function(specific_action)) // NTNet is down and we are not connected via wired connection. No signal.
		if(!ethernet || specific_action) // Wired connection ensures a basic connection to NTNet, however no usage of disabled network services.
			return 0

	if(ethernet) // Computer is connected via wired connection.
		return 3

	return 1
