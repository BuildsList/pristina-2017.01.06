/obj/nano_module/cyber_modules
	name = "Cyber Modules Controller"
	var/mob/living/carbon/human/owner

/obj/nano_module/cyber_modules/New(var/location, var/mob/living/carbon/human/H)
	loc = location
	owner = H

/obj/nano_module/cyber_modules/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["module_index"])
		var/index = text2num(href_list["module_index"])
		if(index > 0 && index <= owner.cyber_modules.len)
			var/obj/item/cyber/C = owner.cyber_modules[index]
			var/act = href_list["act"]
			if(act)
				if(act == "activate")
					C.activate()
					return 1
				if(act == "deactivate")
					C.deactivate()
					return 1
				if(act == "use")
					C.use()
					return 1
				if(act == "load")
					C.item_load(owner)
					return 1
				if(act == "unload")
					C.item_unload(owner)
					return 1

	return 0

//##TODO CODE: update owner sometimes ;3
/obj/nano_module/cyber_modules/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/master_ui = null, var/datum/topic_state/state = default_state)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return

	if(!H.chip || !H.chip.check_damage(1))
		return

	var/list/data = list()

	data["chip"] = H.chip.name
	if(H.powersource)
		data["powersource"] = H.powersource.name
	else
		data["powersource"] = "none"

	var/i = 0
	var/list/modules = list()
	for(var/obj/item/cyber/C in owner.cyber_modules)
		i++

		var/list/module_data = list(
			"index" = i,
			"name" = C.name,
			"damage" = C.damage
			)
		if(C.use_types & CYBER_TOGGLE)
			if(C.enabled)
				module_data["deactivate"] = "Deactivate"
			else
				module_data["activate"] = "Activate"

		if(C.use_types & CYBER_ONESHOT)
			module_data["use"] = "Use"

		if(C.use_types & CYBER_LOAD)
			module_data["load"] = C.load_act_text

		if(C.use_types & CYBER_UNLOAD)
			module_data["unload"] = C.unload_act_text

		modules += list(module_data)

	data["modules"] = modules

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "cyber.tmpl", src.name, 480, 550)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)