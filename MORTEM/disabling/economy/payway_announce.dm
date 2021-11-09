/pay_wages()
	var/total_paid = 0
	for (var/d in GLOB.all_departments)
		var/datum/department/department = GLOB.all_departments[d]
		if (!department.pending_wage_total)
			//No need to do anything if nobody's being paid here
			continue

		//Get our account
		var/datum/money_account/account = department_accounts[department.id]
		if (!account)
			continue

		//Check again that the department has enough. Because some departments, like guild, didnt request funds
		if (account.money < department.pending_wage_total)
			//TODO Here: Email the account owner warning them that wages can't be paid
			//Ok we can't pay wages, this is bad. Lets tell the account owner
			var/ownername = account.owner_name
			if (ownername)
				//Lets pull up the records for this person
				var/datum/computer_file/report/crew_record/OR = get_crewmember_record(ownername)
				if (OR)
					payroll_failure_mail(OR, account, department.pending_wage_total)
			continue

		//Here we go, lets pay them!
		for (var/datum/computer_file/report/crew_record/R in department.pending_wages)
			var/paid = FALSE
			//Get the crewman's account that we'll pay to
			var/crew_account_num = R.get_account()
			var/amount = department.pending_wages[R]
			paid = transfer_funds(department.account_number, crew_account_num, "Payroll", "CEV Eris payroll system", amount)
			if (paid)
				total_paid += amount
				var/sender = "[department.name] account"
				if (department.funding_type == FUNDING_INTERNAL)
					//If this wage was funded internally, make sure the recipient knows that
					sender = "CEV Eris via [sender]"

				payroll_mail_account_holder(R, sender, amount)
		department.pending_wages = list() //All pending wages paid off
	command_announcement.Announce("Hourly crew wages have been paid, please check your email for details. In total the crew of CEV Eris have earned [total_paid] credits.\n Please contact your Department Heads in case of errors or missing payments.", "Dispensation")
