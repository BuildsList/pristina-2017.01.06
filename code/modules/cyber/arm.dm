/obj/item/cyber/arm
	name = "arm item"
	desc = "Debug stuff"

	use_types = CYBER_TOGGLE

	ext_hit_prob = 40
	size = 6

	possible_install_locations = list("l_arm", "r_arm")

	var/list/obj/item/items = list()
	var/obj/item/active_item = null
	var/obj/item/priority_item = null
	var/larm
	var/activation_sound

/obj/item/cyber/arm/New()
	..()
	for(var/obj/item/I in items)
		I.loc = src
		I.cyber_master = src

/obj/item/cyber/arm/check_requirements(var/obj/item/organ/target_organ, var/mob/living/carbon/target_mob = null)
	. = ..()
	if(.)
		return .

	var/obj/item/organ/external/limb = target_organ
	if(!istype(limb))
		return "[name] cannot be attached to [target_organ.name]"

	return 0

/obj/item/cyber/arm/install(var/obj/item/organ/external/target_organ, var/mob/living/carbon/target_mob)
	if(!..())
		return

	if(target_organ.limb_name == "l_arm")
		larm = 1
		name += " ([target_organ.name])"
	else if(target_organ.limb_name == "r_arm")
		larm = 0
		name += " ([target_organ.name])"
	else
		name += " (Bugged stuff) :C"
	return 1

/obj/item/cyber/arm/engage()
	if(!items.len)
		return 0
	if(enabled)
		return 0
	if(!priority_item)
		if(items.len == 1)
			activate_item(items[1])
		else
			var/obj/item/selected = input(owner, "Select item", name, null) as null|anything in items
			if(enabled)
				user_message("[name] is already enabled")
				return 0
			if(!(selected in items))
				user_message("Selected module is not exist.")
				return 0
			activate_item(selected)
	else
		if(priority_item.loc == src && priority_item in items)
			activate_item(priority_item)
		else
			priority_item = null

	return 1

/obj/item/cyber/arm/disengage()
	if(!enabled)
		return 0
	if(!active_item)
		user_message("No active item found. This is a bug", "danger", 0)
		return 0
	deactivate_item()

	return 1


/obj/item/cyber/arm/proc/activate_item(var/obj/item/I)
	if(enabled)
		return

	if(larm)
		if(!owner.l_arm)
			owner.put_in_l_arm(I)
			owner.activate_hand("la")
			active_item = I
			I.canremove = 0
			if(active_item.w_class > 2)
				rip_clothes()
			if(activation_sound)
				playsound(src.loc, activation_sound, 50, 1)
			ext_hit_prob = 80
		else
			user_message("Left arm slot is already full.")
	else
		if(!owner.r_arm)
			owner.put_in_r_arm(I)
			owner.activate_hand("ra")
			active_item = I
			I.canremove = 0
			if(active_item.w_class > 2)
				rip_clothes()
			if(activation_sound)
				playsound(src.loc, activation_sound, 50, 1)
			ext_hit_prob = 80
		else
			user_message("Right arm slot is already full.")

/obj/item/cyber/arm/proc/deactivate_item()
	if(!active_item)
		return
	active_item.canremove = 1
	owner.drop_from_inventory(active_item, src)
	playsound(src.loc, activation_sound, 50, 1)
	ext_hit_prob = 40

/obj/item/cyber/arm/Topic(mob/user as mob, list/href_list)
	if(href_list["activate"])
		if(enabled)
			return
		var/obj/item/I = href_list["module"]
		if(I)
			priority_item = I
		activate()
		return

	..()

/obj/item/cyber/arm/generate_ui_handlers()
	..()
	if(items.len <= 1)
		return

	for(var/obj/item/I in items)
		var/obj/cyber_stat_obj/command/C
		C = new("Activate [I.name]", src)
		C.href_list = list("activate" = 1, "module" = I)
		ui_activate.Add(C)


/obj/item/cyber/arm/is_bulk()
	return enabled


//Rename it.
/obj/item/cyber/arm/proc/get_hand()
	if(larm)
		return owner.l_hand
	else
		return owner.r_hand

/obj/item/cyber/arm/proc/get_arm()
	if(larm)
		return owner.l_arm
	else
		return owner.r_arm








/obj/item/cyber/arm/blade
	name = "Arm-blade"
	desc = "Overpowered chain-blade for debug purposes only."

	activation_power_cost = 100
	deactivation_power_cost = 20

	items = list(new /obj/item/weapon/melee/hand_blade)
	activation_sound = 'sound/weapons/flipblade.ogg'

////////////

/obj/item/weapon/melee/hand_blade
	name = "hand-blade"
	desc = "##TODO DESC Hand-blade"
	icon = 'icons/CyberpunkBeta/Limbs.dmi'
	icon_state = "hand_blade"
	item_state = "hand_blade"
	attack_verb = list("slices")
	canremove = 0
	w_class = 5
	force = 150

////////////////
////////////////

/obj/item/cyber/arm/engi_hand
	name = "engi-hand"
	desc = "Multipurposal Engineering Hand"

	activation_power_cost = 100
	deactivation_power_cost = 20

	items = list(	new/obj/item/weapon/wrench/cyber,\
					new/obj/item/weapon/screwdriver/cyber,\
					new/obj/item/weapon/wirecutters/cyber,\
					new/obj/item/weapon/weldingtool/cyber,\
					new/obj/item/weapon/crowbar/cyber,\
				  )

/obj/item/weapon/wrench/cyber
	icon = 'icons/obj/cyber.dmi'
	icon_state = "cyber_arm"
	w_class = 1.0

/obj/item/weapon/screwdriver/cyber
	icon = 'icons/obj/cyber.dmi'
	icon_state = "cyber_screwdriver"
	w_class = 3.0

/obj/item/weapon/screwdriver/cyber/New() //Say no to color change
	return

/obj/item/weapon/wirecutters/cyber
	icon = 'icons/obj/cyber.dmi'
	icon_state = "cyber_cutters"
	w_class = 3.0

/obj/item/weapon/weldingtool/cyber
	icon = 'icons/obj/cyber.dmi'
	icon_state = "cyber_welder"
	w_class = 3.0

/obj/item/weapon/weldingtool/cyber/update_icon()
	if(welding)
		icon_state = "cyber_welder1"
	else
		icon_state = "cyber_welder"
	//update icon on mob

/obj/item/weapon/crowbar/cyber
	icon = 'icons/obj/cyber.dmi'
	icon_state = "cyber_arm"
	w_class = 1.0

////////////////
////////////////

/obj/item/cyber/arm/gun
	name = "GUN!"

	use_types = CYBER_TOGGLE|CYBER_LOAD|CYBER_UNLOAD

	var/gun_type = /obj/item/weapon/gun/projectile/automatic/c20r

	var/obj/item/weapon/gun/gun
	var/obj/item/weapon/gun_emulator/emulator

	load_act_text = "Load ammo"
	unload_act_text = "Unload ammo"

/obj/item/cyber/arm/gun/New()
	emulator = new(src)
	gun = new gun_type(src)
	gun.cyber_master = src
	emulator.gun = gun
	emulator.update_icon()
	items = list(emulator)
	..()

/obj/item/cyber/arm/gun/item_load(mob/user as mob)
	var/obj/item/I = user.get_active_hand()
	if(I)
		emulator.attackby(I, user)

/obj/item/cyber/arm/gun/item_unload(mob/user as mob)
	if(user.get_active_hand())
		return
	emulator.attack_hand(user)

/obj/item/cyber/arm/gun/Topic(mob/user as mob, list/href_list)
	if(href_list["use_item"])
		var/obj/item/I = get_hand()
		emulator.attackby(I, user)
		return
	..()

////////////

/obj/item/weapon/gun_emulator
	var/obj/item/weapon/gun/gun

//obj/item/weapon/gun_emulator/New()
//	..()
//	gun = new /obj/item/weapon/gun/projectile/colt(src)
//	update_icon()

/obj/item/weapon/gun_emulator/update_icon()
	icon = gun.icon
	icon_state = gun.icon_state
	overlays.Cut()
	overlays += gun.overlays

/obj/item/weapon/gun_emulator/attack(atom/A, mob/living/user, def_zone)
	. = gun.attack(A, user, def_zone)
	update_icon()
	return .

/obj/item/weapon/gun_emulator/afterattack(atom/A, mob/living/user, adjacent, params)
	. = gun.afterattack(A, user, adjacent, params)
	update_icon()
	return .

//obj/item/weapon/gun_emulator/attack_hand(mob/user as mob)
//	. = gun.attack_hand(user)
//	update_icon()
//	return .

/obj/item/weapon/gun_emulator/attack_self(mob/user as mob)
	. = gun.attack_self(user)
	update_icon()
	return .

/obj/item/weapon/gun_emulator/attackby(obj/O, mob/user)
	. = gun.attackby(O, user)
	update_icon()
	return

/obj/item/weapon/gun_emulator/examine(mob/user)
	return gun.examine(user)

