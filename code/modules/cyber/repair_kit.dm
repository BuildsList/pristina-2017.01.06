/obj/item/weapon/repair_kit
	name = "Repair Kit"
	desc = "Helps you maintain your cyber stuff."

/obj/item/weapon/repair_kit/attack(mob/living/carbon/human/H as mob, mob/living/user as mob, def_zone)
	if(!istype(H))
		return ..()

	if(user.a_intent != I_HELP)
		return ..()

	var/obj/item/organ/external/organ = H.get_organ(user.zone_sel.selecting)
	if(!organ)
		world << "\red \b Shit again."
		return

	var/list/obj/item/cyber/modules = list()
	modules += organ.cyber_modules

	if(organ.internal_organs)
		for(var/obj/item/organ/O in organ.internal_organs)
			modules += organ.cyber_modules

	if(!modules.len)
		user << "<span class='notice'>There is no cyber modules in [def_zone].</span>"
		return

	var/obj/item/cyber/selected = input(user, "Select module to repair", "Repair kit") as null|anything in modules
	if(!selected)
		return

	if(!do_mob(user, H, 10))
		user << "<span class='warning'>You must stand still to use [name].</span>"
		return

	selected.take_damage(-selected.damage)
	user << "<span class='notice'>You repair [selected.name].</span>"
	return