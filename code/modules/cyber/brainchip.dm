/obj/item/cyber/brainchip
	name = "Neurochip"
	desc = "Neural chip which controls... Oh, Milkes, napishi opisanie, cho ti."

	install_type = CYBER_BIO

	possible_install_locations = list("brain")

	disable_damage = 2
	maxdamage = 4
	ext_hit_prob = 1

	var/obj/nano_module/cyber_modules/controls

/obj/item/cyber/brainchip/New()
	name += pick(" Dert 3", " Dert 4", " Dert 5", " Dert 6") // :3
	..()

/obj/item/cyber/brainchip/check_requirements(var/obj/item/organ/target_organ, var/mob/living/carbon/human/target_mob = null)
	if(!target_mob)
		return "[name] cannot be installed in organ without host."
	if(target_mob.chip)
		return "Host already have installed brainchip"
	return ..()

/obj/item/cyber/brainchip/organ_attached(var/mob/living/carbon/human/host)
	..()
	host.chip = src

/obj/item/cyber/brainchip/organ_detached()
	owner.chip = null
	..()

/obj/item/cyber/brainchip/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/master_ui = null, var/datum/topic_state/state = default_state)
	if(!controls)
		controls = new(src, owner)
	controls.ui_interact(user, ui_key, ui, force_open, master_ui, state)

/obj/item/cyber/brainchip/verb/show_ui()
	set name = "Show UI"
	set category = "Implants Debug"
	set src in usr.contents

	var/mob/living/carbon/human/H = usr
	if(!istype(H))
		return

	if(H.chip != src)
		return

	ui_interact(H)