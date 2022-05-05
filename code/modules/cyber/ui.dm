/mob/living/carbon/human
	var/obj/item/cyber/ui_selected_module = null
	var/obj/cyber_stat_obj/unselect/ui_unselect_module = null //KOCTN/\6

/mob/living/carbon/human/New()
	..()
	ui_unselect_module = new("Back", null, src)

/mob/living/carbon/human/Stat()
	if(src == usr && cyber_modules && cyber_modules.len && statpanel("Implants") && chip && chip.check_damage())
		if(ui_selected_module)
			statpanel("Implants", "", ui_unselect_module)
			statpanel("Implants", ui_selected_module.name)
			if(ui_selected_module.enabled)
				for(var/obj/cyber_stat_obj/O in ui_selected_module.ui_deactivate)
					statpanel("Implants", "", O)
			else
				for(var/obj/cyber_stat_obj/O in ui_selected_module.ui_activate)
					statpanel("Implants", "", O)
		else
			for(var/obj/item/cyber/C in cyber_modules)
				statpanel("Implants", "", C.ui_select)

	..()

/obj/cyber_stat_obj
	name = "Error"
	var/obj/item/cyber/owner

/obj/cyber_stat_obj/New(var/s_name, var/obj/item/cyber/s_owner)
	name = s_name
	owner = s_owner
	..()

/obj/cyber_stat_obj/DblClick()
	return Click()

/obj/cyber_stat_obj/select

/obj/cyber_stat_obj/select/Click()
	owner.owner.ui_selected_module = owner

/obj/cyber_stat_obj/unselect
	var/mob/living/carbon/human/human

/obj/cyber_stat_obj/unselect/New(var/s_name, var/obj/item/cyber/s_owner, var/mob/living/carbon/human/H)
	..()
	human = H

/obj/cyber_stat_obj/unselect/Click()
	human.ui_selected_module = null

/obj/cyber_stat_obj/command
	var/list/href_list

/obj/cyber_stat_obj/command/Click()
	owner.Topic(usr, href_list)