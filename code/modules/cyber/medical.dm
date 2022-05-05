/obj/item/cyber/chem_injector
	name = "Automated Medical System"

	possible_install_locations = list("heart")

	enable_processing = 1
	current_processing = 1

	var/highest_oxyloss = 0
	var/oxyloss_increased_times = 0

	var/injector_recharge = 0
	var/charge = 30


/obj/item/cyber/chem_injector/c_process()
	var/oxyloss = owner.getOxyLoss()
	if(charge <= 0 || oxyloss < 10 || world.time < injector_recharge)
		return

	if(oxyloss > highest_oxyloss)
		highest_oxyloss = oxyloss + 1
		oxyloss_increased_times++
	else if(oxyloss + 5 < highest_oxyloss)
		highest_oxyloss = oxyloss
		oxyloss_increased_times = 0

	if(oxyloss_increased_times > 3 || oxyloss > 90)
		var/oxyloss_medicine_amount = 0
		oxyloss_medicine_amount += owner.reagents.get_reagent_amount("dexalin")
		oxyloss_medicine_amount += owner.reagents.get_reagent_amount("dexalinp")

		if(oxyloss_medicine_amount <= 0)
			user_message("Oxygen deprivation detected. Injecting medicine...", "info", 1)
			owner.reagents.add_reagent("dexalin", 10)
			charge -= 10
			injector_recharge = world.time + REM * 10 * 10




/obj/item/cyber/breath
	name = "Internal Breath Module"

	use_types = CYBER_TOGGLE

	possible_install_locations = list("lungs")

	var/obj/item/weapon/tank/emergency_oxygen/gas_tank

/obj/item/cyber/breath/New()
	..()
	gas_tank = new(src)

/obj/item/cyber/breath/activate()
	if(owner.cyber_breath_source && !owner.cyber_breath_source.deactivate())
		//We can't deactivate other module so we can't engage this one
		return 0
	return ..()

/obj/item/cyber/breath/engage()
	if(owner.internals)
		owner.internals.icon_state = "internal_cyber"
	return 1

/obj/item/cyber/breath/disengage()
	if(owner.internals)
		if(owner.internal)
			owner.internals.icon_state = "internal_tank"
		else
			owner.internals.icon_state = "internal_off"

	return 1


/obj/item/cyber/breath/proc/handle_breathe(var/volume_needed=BREATH_VOLUME)
	if(!enabled)
		return null

	return gas_tank.remove_air_volume(volume_needed)