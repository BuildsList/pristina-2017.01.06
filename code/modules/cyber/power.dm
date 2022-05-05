/obj/item/cyber/power
	name = "Power source."
	desc = "Unlimited source of power for debug purposes. Do not use it in game. Seriously."

	use_types = CYBER_ONESHOT|CYBER_LOAD|CYBER_UNLOAD

	load_act_text = "Load cell"
	unload_act_text = "Unload cell"

/obj/item/cyber/power/cell/organ_detached()
	if(owner.powersource == src)
		owner.powersource = null
		user_message("[name] powersource was removed.", "danger", 1)
	..()

/obj/item/cyber/power/proc/use_power(var/amount)
	return

/obj/item/cyber/power/proc/can_use_power(var/amount)
	return 1

/obj/item/cyber/power/proc/get_power()
	return -1


/obj/item/cyber/power/cell
	name = "Internal Power Cell Module"
	desc = "Simple and useful power source for all your need. Comes without recharger."
	var/obj/item/weapon/cell/cell

	possible_install_locations = list("chest")

/obj/item/cyber/power/cell/New()
	..()
	cell = new /obj/item/weapon/cell/high(src)

/obj/item/cyber/power/cell/organ_attached(var/mob/living/carbon/human/host)
	..()
	if(!host.powersource)
		use()

/obj/item/cyber/power/cell/use_power(var/amount)
	if(cell)
		cell.use(amount)

/obj/item/cyber/power/cell/can_use_power(var/amount)
	if(!cell)
		return 0
	return cell.check_charge(amount)

/obj/item/cyber/power/cell/get_power()
	if(!cell)
		return 0
	return cell.charge

/obj/item/cyber/power/cell/item_load(mob/user as mob)
	if(user != owner)
		return
	if(cell)
		user_message("Cell is already installed.", "notice", 1)
		return
	var/obj/item/weapon/cell/C = owner.get_active_hand()
	if(!istype(C))
		return
	owner.drop_item()
	C.loc = src
	cell = C
	return

/obj/item/cyber/power/cell/item_unload(mob/user as mob)
	if(!cell)
		user_message("There is no cell in [name]", "warning", 1, user)
		return
	if(user != owner || !owner.put_in_active_hand(cell)) //If someone else is trying to remove your cell - well you fucked up
		cell.loc = owner.loc
		user_message("[name] splitted out [cell.name].", "notice", 2)
	cell.update_icon()
	cell = null
	if(owner.powersource == src)
		owner.powersource = null
	return

/obj/item/cyber/power/cell/use()
	if(owner.powersource == src)
		owner.powersource = null
		user_message("Powersource is unset now.", "notice", 1)
		return 1
	if(!cell)
		user_message("[name] could not be set as powersource without cell.", "warning", 1)
	user_message("Current powersource is [name] now.", "notice", 1)
	owner.powersource = src
	return 1
/*
/obj/item/cyber/power/cell/Topic(mob/user as mob, list/href_list)
	if(href_list["unload"])
		if(!cell)
			user_message("There is no cell in [name]", "warning", 1, user)
			return
		if(user != owner || !owner.put_in_active_hand(cell)) //If someone else is trying to remove your cell - well you fucked up
			cell.loc = owner.loc
			user_message("[name] splitted out [cell.name].", "notice", 2)
		cell.update_icon()
		cell = null
		return
	if(href_list["load"])
		if(user != owner)
			return
		if(cell)
			user_message("Cell is already installed.", "notice", 1)
			return
		var/obj/item/weapon/cell/C = owner.get_active_hand()
		if(!istype(C))
			return
		owner.drop_item()
		C.loc = src
		cell = C
		return
	..()
*/
/*
/obj/item/cyber/power/cell/generate_ui_handlers()
	..()

	var/obj/cyber_stat_obj/command/C

	C = new("Install cell", src)
	C.href_list = list("load" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)

	C = new("Remove cell", src)
	C.href_list = list("unload" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)
*/
/*
/obj/item/cyber/power/grid
	name = "Internal Powergrid"
	desc = "Power supply for all your cyber needs."

	possible_install_locations = list("chest")

/obj/item/cyber/power/grid/check_requirements(var/obj/item/organ/target_organ, var/mob/living/carbon/human/target_mob = null)
	if(target_mob && target_mob.powergrid)
		return "[target_mob] already has a [name]"
	return ..()

/obj/item/cyber/power/grid/organ_attached(var/mob/living/carbon/human/host)
	if(host.powergrid)
		world.log << "Cyberpart [name] is already installed in [host.name]."
	else
		host.powergrid = src
	..()

/obj/item/cyber/power/grid/organ_detached()
	owner.powergrid = null
	..()
*/