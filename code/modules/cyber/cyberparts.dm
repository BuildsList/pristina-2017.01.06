/obj/item/cyber
	name = "Cyberpart module"
	desc = "##TODO DESC"
	icon = 'icons/obj/cyber.dmi'

	var/enabled = 0
	var/use_types = 0

	var/damage = 0
	var/disable_damage = 30 //partially disabled
	var/maxdamage = 60

	var/emp_disable = 0
	var/emp_damage_mod = 10
	var/emp_protection = 0

	var/ext_hit_prob = 20
	var/next_damage_message = 0

	var/size = 2

	var/install_type = CYBER_BIOMECH
	var/mob/living/carbon/human/owner
	var/obj/item/organ/location
	var/last_location_name

	var/list/possible_install_locations = list()
	//var/rip_clothes = 0

	var/activation_power_cost = 0
	var/deactivation_power_cost = 0
	var/oneshot_power_cost = 0
	var/process_power_cost = 0

	var/enable_processing = 0 //automatically adds module to processing queue. Do not change it during runtime
	var/current_processing = 0 //change this if you want enable or disable processing

	var/max_msg_priority = 3

	var/madeby = "Luminous Associative Company"

	//UI stuff
	var/obj/cyber_stat_obj/select/ui_select = null
	var/list/obj/cyber_stat_obj/command/ui_activate = null
	var/list/obj/cyber_stat_obj/command/ui_deactivate = null

	var/load_act_text = "Load"
	var/unload_act_text = "Unload"

	var/no_spam = 0


/obj/item/cyber/New()
	..()
	generate_ui_handlers()


/obj/item/cyber/proc/check_requirements(var/obj/item/organ/target_organ, var/mob/living/carbon/human/target_mob = null)
	var/install_location
	if(istype(target_organ, /obj/item/organ/external))
		var/obj/item/organ/external/limb = target_organ
		install_location = limb.limb_name
	else
		install_location = target_organ.name

	if(possible_install_locations.len && !(install_location in possible_install_locations))
		return "[name] can't be installed in [target_organ.name]."

	if(install_type != CYBER_BIOMECH)
		if(target_organ.status & ORGAN_ROBOT)
			if(install_type == CYBER_BIO)
				return "[name] can be installed only to bio organs."
		else
			if(install_type == CYBER_MECH)
				return "[name] can be installed only to mech organs."

	for(var/obj/item/cyber/c in target_organ.cyber_modules)
		if(c.type == src.type)
			return "[name] is already installed in [install_location]"

	if(target_organ.get_free_space() - size < 0)
		return "[target_organ.name] have no space to place [name]."

	return 0

/obj/item/cyber/proc/install(var/obj/item/organ/target_organ, var/mob/living/carbon/human/target_mob = null)
	if(!istype(target_organ))
		world.log << "There is no target_organ"
		return

	if(owner)
		world.log << "Cyberpart [name] is already installed to [owner.name]."
		return

	location = target_organ
	location.cyber_modules += src
	src.loc = target_organ

	last_location_name = location.name
	if(target_mob)
		organ_attached(target_mob)

	return 1

/obj/item/cyber/proc/uninstall(var/atom/target = null)
	if(!canremove)
		return

	if(owner)
		organ_detached()

	if(istype(location))
		location.cyber_modules -= src

	src.loc = target
	location = null

	return 1

//only in surgery
/obj/item/cyber/proc/transfer(var/obj/item/organ/reciever_organ, var/mob/living/carbon/human/reciever_mob = null)
	var/old_canremove = canremove
	canremove = 0

	uninstall()
	install(reciever_organ, reciever_mob)

	canremove = old_canremove

/obj/item/cyber/proc/organ_attached(var/mob/living/carbon/human/host)
	if(owner)
		world.log << "Cyberpart [name] is already owned by [owner.name]."
		return
	owner = host
	owner.cyber_modules += src

	loc = host

	if(enable_processing)
		processing_objects += src

	spawn(rand(5, 15))
		user_message("New module is located...", "info", 1)
		sleep(rand(5, 15))
		user_message("Recieved basic info.", "info", 1)
		user_message("Module name: \"[name]\".", "info", 1)
		user_message("Purpose: \"[desc]\".", "info", 1)
		user_message("Manufacturer: <b>[madeby]</b>", "info", 1)
		sleep(rand(5, 15))
		user_message("Installation complete. Module is ready to go.", "info", 2)


/obj/item/cyber/proc/organ_detached()
	if(!owner)
		world.log << "Cyberpart [name] haven't owner but detached."
		return
	owner.cyber_modules -= src
	var/mob/living/carbon/mob_msg = owner
	owner = null

	loc = location

	if(enable_processing)
		processing_objects -= src

	spawn(rand(5, 15))
		user_message("Connection with module \"[name]\" lost.", "warning", 1, mob_msg)
		sleep(rand(5, 15))
		user_message("Connection with module \"[name]\" timed out.", "warning", 2, mob_msg)
		sleep(rand(5, 15))
		user_message("Module \"[name]\" was removed or broken.", "warning", 2, mob_msg)
		user_message("Please, report to nearest service center to solve this problem.", "warning", 3, mob_msg)


/obj/item/cyber/proc/activate(var/power_cost = activation_power_cost)
	if(!(use_types & CYBER_TOGGLE)) //You faggot don't touch my beautiful buttons, don't break it!
		user_message("[name] cannot be toggled.", "warning", 1)
		return 0
	if(enabled) //Oh wow how this just happened?
		user_message("[name] is already enabled.", "warning", 1)
		return 0
	if(!src.check_power_cost(power_cost)) //Magic call
		return 0
	if(!check_damage()) //method sends message by itself
		return 0
	if(!engage()) //internal error
		user_message("[name] got critical error. This is a bug.", "danger", 0)
		return 0
	enabled = 1 // we did it!
	return 1

/obj/item/cyber/proc/deactivate(var/power_cost = deactivation_power_cost)
	if(!(use_types & CYBER_TOGGLE))
		user_message("[name] cannot be toggled.", "warning", 1)
		return 0
	if(!enabled)
		user_message("[name] is already disabled.", "warning", 1)
		return 0
	if(!check_power_cost(power_cost))
		return 0
	if(!check_damage())
		return 0
	if(!disengage())
		user_message("[name] got critical error. This is a bug.", "danger", 0)
		return 0
	enabled = 0
	return 1

/obj/item/cyber/proc/oneshot(var/power_cost = oneshot_power_cost)
	if(!(use_types & CYBER_ONESHOT))
		user_message("[name] cannot be used.", "warning", 1)
		return 0
	if(!src.check_power_cost(power_cost))
		return 0
	if(!src.check_damage())
		return 0
	if(!use())
		user_message("[name] got critical error. This is a bug.", "danger", 0)
		return 0
	return 1

/obj/item/cyber/proc/engage()
	return 1

/obj/item/cyber/proc/disengage()
	return 1

/obj/item/cyber/proc/use()
	return 1

/obj/item/cyber/proc/disable()
	current_processing = 0

/obj/item/cyber/proc/toggle()
	if(enabled)
		deactivate()
	else
		activate()

/obj/item/cyber/proc/item_load(mob/user as mob, var/command)
	return

/obj/item/cyber/proc/item_unload(mob/user as mob, var/command)
	return

//System checks

/obj/item/cyber/proc/check_power_cost(var/amount, var/show_msg = 1)
	if(!owner)
		if(show_msg) user_message("Module [name] is not connected to neural network to be usable.", "warning", 1)
		return 0
	if(amount == 0)
		return 1
	if(!owner.powersource)
		if(show_msg) user_message("Powersource is not selected or exists.", "warning", 1)
		return 0
	if(!owner.powersource.can_use_power(amount))
		if(show_msg) user_message("Not enough energy to use [name].", "warning", 1)
		return 0
	owner.powersource.use_power(amount)
	return 1

/*
/obj/item/cyber/proc/check_clothing() //##TODO CODE Do not rip all the clothes instantly, check everything before
	if(!rip_clothes) return

	if(owner.wear_suit)
		var/obj/item/organ/external/O = location.get_external()
		if(O.body_part && owner.wear_suit.body_parts_covered)
			if(O.limb_name == "r_arm")
				if(istype(owner.wear_suit, /obj/item/clothing/suit))
					var/obj/item/clothing/suit/S = owner.wear_suit
					S.rip_sleeve("r")
					return 1
			if(O.limb_name == "l_arm")
				if(istype(owner.wear_suit, /obj/item/clothing/suit))
					var/obj/item/clothing/suit/S = owner.wear_suit
					S.rip_sleeve("l")
					return 1
			user_message("[owner.wear_suit.name] preventing you from using [src.name]", "warning", 1)
			return 0
	return 1
*/

/obj/item/cyber/rip_clothes() //##TODO CODE: rename
	if(owner.wear_suit)
		var/obj/item/organ/external/O = location.get_external()
		if(O.body_part && owner.wear_suit.body_parts_covered)
			if(O.limb_name == "r_arm")
				if(istype(owner.wear_suit, /obj/item/clothing/suit))
					var/obj/item/clothing/suit/S = owner.wear_suit
					S.rip_clothes(RIGHT_SLEEVE)
					return 1
			if(O.limb_name == "l_arm")
				if(istype(owner.wear_suit, /obj/item/clothing/suit))
					var/obj/item/clothing/suit/S = owner.wear_suit
					S.rip_clothes(LEFT_SLEEVE)
					return 1
			user_message("[owner.wear_suit.name] preventing you from using [src.name]", "warning", 1)
			return 0
	return 1


/obj/item/cyber/proc/can_interact()
	if(!owner)
		world << "HUGE shit happened"
		return 0
	if(owner != usr)
		world << "Not implemented shit happened"
		return 0
	return 1

//Interactions

/obj/item/cyber/Topic(mob/user as mob, list/href_list)
	if(href_list["activate"])
		activate()
		return
	if(href_list["deactivate"])
		deactivate()
		return
	if(href_list["oneshot"])
		oneshot()
		return
	if(href_list["stats"])
		show_stats()
		return
	if(href_list["load"])
		item_load(user, href_list["load"])
		return
	if(href_list["unload"])
		item_unload(user, href_list["unload"])
		return
	if(href_list["fuck"])
		if(!no_spam)
			world << "<span class='danger' size=48>[user.key] fucked up!</span>"
			no_spam = 1

	user_message("[src.name] topic fucked up", "danger", 0)

//DAMAGE CONTROL

/obj/item/cyber/proc/take_damage(var/amount)
	if(!amount)
		return

	var/prev_damage = damage
	damage = min(maxdamage, max(0, damage + amount))

	if(prev_damage > damage)
		user_message("[name] is repaired. Amount: [amount].", "notice", 0)
	else
		user_message("[name] is damaged. Amount:[amount].", "warning", 0)
	if(damage >= disable_damage && prev_damage < disable_damage)
		on_disable_damage()
	else if((damage > disable_damage / 2) && world.time >= next_damage_message)
		user_message("[name] is damaged and could become inoperable.", "danger", 2)
		next_damage_message = world.time + 100
	if(damage > maxdamage)
		damage = maxdamage
		user_message("[name] was overdamaged. This is a bug.", "warning", 0)

/obj/item/cyber/proc/can_absorb_damage(var/amount)
	return min(maxdamage - damage, amount)

/obj/item/cyber/proc/check_damage(var/hidden = 0)
	if(emp_disable)
		if(!hidden)
			user_message("[name] is temporary disabled due to emp shock.", "warning", 1)
		return 0
	if(damage >= disable_damage)
		if(!hidden)
			user_message("[name] is damaged too badly to be used.", "warning", 1)
			new	/obj/effect/effect/sparks(owner.loc)
		return 0
	return 1

/obj/item/cyber/emp_act(var/severity)
	severity -= emp_protection
	if(severity <= 0)
		return
	var/dmg = severity * emp_damage_mod
	take_damage(dmg)
	emp_disable = 10 //disable for 10 seconds
	return

//HELPERS
/*
Message priority
0 - debug
1 - inportant info
2 - info
3 - misc info
*/
/obj/item/cyber/proc/user_message(var/msg, var/msg_class = "warning", var/msg_priority = 1, var/target = null)
	if(msg_priority > max_msg_priority)
		return
	if(!target)
		target = owner
	target << "-<span class='[msg_class]'>[msg]</span>"

/obj/item/cyber/proc/is_bulk()
	return 0

/obj/item/cyber/proc/generate_ui_handlers()
	ui_select = new (src.name, src)

	ui_activate = list()
	ui_deactivate = list()

	var/obj/cyber_stat_obj/command/C

	if(use_types & CYBER_TOGGLE)
		C = new("Activate", src)
		C.href_list = list("activate" = 1)
		ui_activate.Add(C)

		C = new("Deactivate", src)
		C.href_list = list("deactivate" = 1)
		ui_deactivate.Add(C)

	if(use_types & CYBER_ONESHOT)
		C = new("Use", src)
		C.href_list = list("oneshot" = 1)
		ui_activate.Add(C)
		ui_deactivate.Add(C)

	if(use_types & CYBER_LOAD)
		C = new(load_act_text, src)
		C.href_list = list("load" = 1)
		ui_activate.Add(C)
		ui_deactivate.Add(C)

	if(use_types & CYBER_UNLOAD)
		C = new(unload_act_text, src)
		C.href_list = list("unload" = 1)
		ui_activate.Add(C)
		ui_deactivate.Add(C)

	C = new("Show info", src)
	C.href_list = list("stats" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)

	C = new("Just don't press. Debug feature", src)
	C.href_list = list("fuck" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)

/obj/item/cyber/proc/show_stats()
	user_message("Name: [name]", "info", 1)
	user_message("Desc: [desc]", "info", 1)
	user_message("Manufacturer: [madeby]", "info", 2)
	user_message("Damage: [damage]", "info", 1)


//EVENTS

/obj/item/cyber/proc/on_disable_damage()
	user_message("<b>[name] is critically damaged and become inoperable.</b>", "danger", 1)

/obj/item/cyber/dropped(mob/user as mob) //This shouldn't happens
	uninstall()

//PROCESSING

/obj/item/cyber/proc/c_process()
	return

/obj/item/cyber/process()
	if(!current_processing)
		return
	if(!check_power_cost(process_power_cost))
		disable()
		return
	c_process()

//////////////////////////













//////////////////////////
/*
/mob/living/carbon/human/verb/install_custom_module()
	set category = "Implants Debug"
	set name = "Install Custom Module"

	var/list/l = typesof(/obj/item/cyber) - /obj/item/cyber

	var/selected = input(src, "Select module", "Module installation", null) as null|anything in l
	if(!selected)
		return

	var/obj/item/cyber/module = new selected()

	var/target_organ_name
	if(!module.possible_install_locations.len)
		usr << "\red There is no possible install locations ofr [module.name]"
		return
	if(module.possible_install_locations.len == 1)
		target_organ_name = module.possible_install_locations[1]
	else
		target_organ_name = input(src, "Select organ", "Module installation", null) as null|anything in module.possible_install_locations
	if(!target_organ_name)
		return

	var/obj/item/organ/target_organ = organs_by_name[target_organ_name]
	if(!target_organ)
		target_organ = internal_organs_by_name[target_organ_name]
		if(!target_organ)
			usr << "\red Couldn't find acceptable organ to install [module.name]"
			del(module)
			return

	var/errors = module.check_requirements(target_organ, src)
	if(errors)
		usr << "\red [module.name] thrown error: [errors]"
		del(module)
		return

	module.install(target_organ, src)

/mob/living/carbon/human/verb/remove_custom_module()
	set category = "Implants Debug"
	set name = "Remove Custom Module"

	if(!cyber_modules.len)
		usr << "\red There is no modules in body."
		return

	var/obj/item/cyber/selected = input(src, "Select module", "Module removal", null) as null|anything in cyber_modules
	if(!selected)
		return

	selected.uninstall(src.loc)
	qdel(selected)

/mob/living/carbon/human/verb/activate_custom_module()
	set category = "Implants Debug"
	set name = "Activate Module"

	var/list/modules = list()
	for(var/obj/item/cyber/c in cyber_modules)
		if((c.use_types & CYBER_TOGGLE) && !c.enabled)
			modules.Add(c)

	if(modules.len <= 0)
		usr << "\red There is no modules which could be activated."
		return

	var/obj/item/cyber/selected = input(src, "Select module", "Module activation", null) as null|anything in modules
	if(!selected)
		return

	selected.activate()

/mob/living/carbon/human/verb/deactivate_custom_module()
	set category = "Implants Debug"
	set name = "Deactivate Module"

	var/list/modules = list()
	for(var/obj/item/cyber/c in cyber_modules)
		if((c.use_types & CYBER_TOGGLE) && c.enabled)
			modules.Add(c)

	if(modules.len <= 0)
		usr << "\red There is no modules which could be deactivated."
		return

	var/obj/item/cyber/selected = input(src, "Select module", "Module deactivation", null) as null|anything in modules
	if(!selected)
		return

	selected.deactivate()

/mob/living/carbon/human/verb/use_custom_module()
	set category = "Implants Debug"
	set name = "Use Module"

	var/list/modules = list()
	for(var/obj/item/cyber/c in cyber_modules)
		if(c.use_types & CYBER_ONESHOT)
			modules.Add(c)

	if(modules.len <= 0)
		usr << "\red There is no modules which could be used."
		return

	var/obj/item/cyber/selected = input(src, "Select module", "Module deactivation", null) as null|anything in modules
	if(!selected)
		return

	selected.oneshot()

/mob/living/carbon/human/verb/damage_module()
	set category = "Implants Debug"
	set name = "Damage Module"

	var/obj/item/cyber/selected = input(src, "Select module", "Module damaging", null) as null|anything in cyber_modules
	if(!selected)
		return

	var/damage = input(src, "Select damage", "Enter damage amount", null) as null|num
	if(damage && selected)
		selected.take_damage(damage)
*/
