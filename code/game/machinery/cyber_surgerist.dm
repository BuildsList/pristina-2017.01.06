/obj/machinery/cyber_surgerist
	name = "Cyber surgerist"
	desc = "##TODO DESC"

	icon = 'icons/CyberpunkBeta/Limbs.dmi'
	icon_state = "implanter_off"

	var/mob/living/carbon/human/occupant
	var/list/obj/item/cyber/modules = list()

	New()
		..()
		for(var/p in typesof(/obj/item/cyber) - /obj/item/cyber)
			modules += new p(src)

/obj/machinery/cyber_surgerist/attack_hand(mob/user as mob)
	if(occupant)
		occupant.loc = src.loc
		occupant = null
		icon_state = "implanter_off"
	else
		occupant = user
		occupant.loc = src
		icon_state = "implanter_on"

/obj/machinery/cyber_surgerist/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/cyber))
		var/obj/item/cyber/C = I
		user.drop_item()
		C.loc = src
		modules += C

/obj/machinery/cyber_surgerist_console
	name = "Cyber surgerist console"
	desc = "##TODO DESC"

	icon = 'icons/CyberpunkBeta/Limbs.dmi'
	icon_state = "Battery"

	var/obj/machinery/cyber_surgerist/surgerist

	New()
		..()
		spawn(0)
			for(var/dir in cardinal)
				var/turf/T = get_step(src.loc, dir)
				var/obj/machinery/cyber_surgerist/CS = locate(/obj/machinery/cyber_surgerist) in T
				if(CS)
					surgerist = CS
					break

/obj/machinery/cyber_surgerist_console/attack_hand(mob/user as mob)
	if(!surgerist)
		user << "\red Ooops..."
		return

	if(!surgerist.occupant)
		user << "\red There is no victim"
		return

	if(!surgerist.modules.len)
		user << "\red Additional modules are required"
		return

	user << "\green All systems green"

	var/mode = input(user, "Select surgery mode", "Mode selection", null) as null|anything in list("External surgery", "Internal surgery")
	if(!mode)
		user << "\red No mode selected"
		return

	user << "\green Mode selected"

	var/obj/item/cyber/selected_module = input(user, "Select module", "Module selection", null) as null|anything in surgerist.modules
	if(!selected_module)
		user << "\red No module selected"
		return

	user << "\green Module selected"

	if(mode == "External surgery")
		var/obj/item/organ/selected_part = input(user, "Select organ", "Organ selection", null) as null|anything in surgerist.occupant.organs
		if(!selected_part)
			return

		var/result = selected_module.check_requirements(selected_part, surgerist.occupant)
		if(result)
			user << "\red Cannot install [selected_part.name]. Reason: [result]"
			return

		selected_module.install(selected_part, surgerist.occupant)
		modules -= selected_part
		user << "\blue Ready!"

	else if(mode == "Internal surgery")
		var/obj/item/organ/selected_part = input(user, "Select organ", "Organ selection", null) as null|anything in surgerist.occupant.internal_organs
		if(!selected_part)
			return

		var/result = selected_module.check_requirements(selected_part, surgerist.occupant)
		if(result)
			user << "\red Cannot install [selected_part.name]. Reason: [result]"
			return

		selected_module.install(selected_part, surgerist.occupant)
		modules -= selected_part
		user << "\blue Ready!"
	else
		user << "\red Oh god!"



