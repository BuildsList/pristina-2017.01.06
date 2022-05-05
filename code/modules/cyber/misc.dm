/obj/item/cyber/hair_color_changer //##TODO CODE update
	name = "Dynamic Hair Coler"

	use_types = CYBER_ONESHOT
	install_type = CYBER_BIO

	possible_install_locations = list("head")

	oneshot_power_cost = 200

	enable_processing = 1

	var/target_r_color = 0
	var/target_g_color = 0
	var/target_b_color = 0
	var/steps_left = 10

	var/changing = 0

/obj/item/cyber/hair_color_changer/oneshot()
	var/new_hair = input(owner, "Choose new hair colour:", name, rgb(owner.r_hair, owner.g_hair, owner.b_hair)) as color|null

	target_r_color = hex2num(copytext(new_hair, 2, 4))
	target_g_color = hex2num(copytext(new_hair, 4, 6))
	target_b_color = hex2num(copytext(new_hair, 6, 8))

	current_processing = 1
	steps_left = 10

/obj/item/cyber/hair_color_changer/c_process()
	var/delta_r_color = (target_r_color - owner.r_hair) / steps_left
	var/delta_g_color = (target_g_color - owner.g_hair) / steps_left
	var/delta_b_color = (target_b_color - owner.b_hair) / steps_left

	if(!owner.change_hair_color(owner.r_hair + delta_r_color, owner.g_hair + delta_g_color, owner.b_hair + delta_b_color))
		changing = 0

	steps_left--
	if(steps_left <= 0)
		current_processing = 0
		user_message("[name] finished working.", "info", 3)
		return

//obj/item/cyber/hair_color_changer/disable()
//	..()
//	steps_left = 0




/obj/item/cyber/voice_changer
	name = "Voice Changer"

	use_types = CYBER_TOGGLE
	install_type = CYBER_BIO

	possible_install_locations = list("head")

	activation_power_cost = 100

	var/current_voice
	var/list/saved_voices = list()

/obj/item/cyber/voice_changer/Topic(mob/user as mob, list/href_list)
	if(href_list["change"])
		var/voice_name = input(owner, "Change voice name", name, current_voice) as null|text
		if(!voice_name || !can_interact())
			return
		change_voice(voice_name)
		return
	if(href_list["set"])
		var/voice_name = input(owner, "Set voice name", name, current_voice) as null|text
		if(!can_interact())
			return
		current_voice = voice_name
		saved_voices |= voice_name
		return
	if(href_list["select"])
		var/voice_name = input(owner, "Select voice name", name, null) as null|anything in saved_voices
		if(!voice_name || !can_interact())
			return
		change_voice(voice_name)
		return
	if(href_list["add"])
		var/voice_name = input(owner, "Add voice name", name, current_voice) as null|text
		if(!voice_name || !can_interact())
			return
		saved_voices |= voice_name
		return
	if(href_list["remove"])
		var/voice_name = input(owner, "Remove voice name", name, null) as null|anything in saved_voices
		if(!voice_name || !can_interact())
			return
		saved_voices &= !voice_name
		return
	..()

/obj/item/cyber/voice_changer/activate()
	if(!current_voice)
		user_message("Please, select voice", "warning", 1)
		return 0
	return ..()

/obj/item/cyber/voice_changer/engage()
	owner.SetSpecialVoice(current_voice)
	return 1

/obj/item/cyber/voice_changer/disengage()
	owner.SetSpecialVoice()
	return 1

/obj/item/cyber/voice_changer/show_stats()
	..()
	user_message("Voice changer: [(enabled) ? "<font color='green'>enabled</font>" : "<font color='red'>disabled</font>"].", "notice", 1)
	user_message("Selected voice: [(current_voice) ? current_voice : "none"].", "notice", 1)

/obj/item/cyber/voice_changer/generate_ui_handlers()
	..()

	var/obj/cyber_stat_obj/command/C

	C = new("Change Voice", src)
	C.href_list = list("change" = 1)
	ui_deactivate.Add(C)

	C = new("Set Voice", src)
	C.href_list = list("set" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)

	C = new("Select Voice", src)
	C.href_list = list("select" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)

	C = new("Add Voice", src)
	C.href_list = list("add" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)

	C = new("Remove Voice", src)
	C.href_list = list("remove" = 1)
	ui_activate.Add(C)
	ui_deactivate.Add(C)

/obj/item/cyber/voice_changer/proc/change_voice(var/voice_name)
	if(enabled)
		if(deactivate())
			current_voice = voice_name
			if(current_voice)
				activate()
	else
		current_voice = voice_name