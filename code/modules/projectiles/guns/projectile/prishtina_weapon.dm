/*
Hit table for firemodes.
list(name="semiauto", burst=1, fire_delay=0)
list(name="3-round bursts", burst=3, move_delay=4, accuracy = list(0,-1,-1,-2,-2), dispersion = list(0.0, 0.6, 1.0))
list(name="short bursts", 	burst=5, move_delay=4, accuracy = list(0,-1,-1,-2,-2), dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		Distance:	3	5	7	9	11
"semiauto"
"3-round bursts"
"short bursts"


*/
/obj/item/weapon/gun/projectile/automatic/akm
	name = "\improper AKM"
	desc = "A durable, efficient weapon."
	icon_state = "akm_loaded"
	item_state = "akm_loaded"
	load_method = MAGAZINE
	slot_flags = SLOT_BACK
	w_class = 5
	caliber = "a762"
	magazine_type = /obj/item/ammo_magazine/a762/akm

	can_wield = 1
	//must_wield = 1

/obj/item/weapon/gun/projectile/automatic/akm/update_icon()
	if(ammo_magazine)
		icon_state = "akm_loaded"
		if(wielded)
			item_state = "akm_loaded_wielded"
		else
			item_state = "akm_loaded"
	else
		icon_state = "akm_empty"
		if(wielded)
			item_state = "akm_empty_wielded"
		else
			item_state = "akm_empty"
	update_held_icon()
	return

/obj/item/weapon/gun/projectile/automatic/m4
	name = "\improper m4a1"
	desc = "NATO 5.56 carbine."
	icon_state = "m4_loaded"
	item_state = "m4_loaded"
	load_method = MAGAZINE
	slot_flags = SLOT_BACK
	w_class = 5
	fire_sound = 'sound/weapons/m16.ogg'
	caliber = "a556"
	magazine_type = /obj/item/ammo_magazine/a556/m4

	can_wield = 1
	//must_wield = 1

/obj/item/weapon/gun/projectile/automatic/m4/update_icon()
	if(ammo_magazine)
		icon_state = "m4_loaded"
		if(wielded)
			item_state = "m4_loaded_wielded"
		else
			item_state = "m4_loaded"
	else
		icon_state = "m4_empty"
		if(wielded)
			item_state = "m4_empty_wielded"
		else
			item_state = "m4_empty"
	update_held_icon()
	return

/obj/item/weapon/gun/projectile/automatic/pkm
	name = "\improper PKM"
	desc = "A durable, efficient weapon."
	icon_state = "pkm_loaded"
	item_state = "l6closedmag"
	load_method = MAGAZINE
	w_class = 5
	caliber = "a762x39"
	magazine_type = /obj/item/ammo_magazine/a762/pkm

	can_wield = 1
	must_wield = 1

	firemodes = list(
		list(name="short bursts",	burst=5, move_delay=6, accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(name="long bursts",	burst=8, move_delay=8, accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		)

/obj/item/weapon/gun/projectile/automatic/pkm/update_icon()
	if(ammo_magazine)
		icon_state = "pkm_loaded"
		if(wielded)
			item_state = "pkm_loaded_wielded"
		else
			item_state = "pkm_loaded"
	else
		icon_state = "pkm_empty"
		if(wielded)
			item_state = "pkm_empty_wielded"
		else
			item_state = "pkm_empty"
	update_held_icon()
	return

/obj/item/weapon/gun/projectile/automatic/l6_saw/m240
	name = "M240"
	caliber = "a762x51"
	max_shells = 100
	magazine_type = /obj/item/ammo_magazine/a762/m240


/obj/item/weapon/gun/projectile/automatic/val
	name = "\improper AS Val"
	desc = "A durable, efficient weapon."
	icon_state = "val_loaded"
	item_state = "val_loaded"
	load_method = MAGAZINE
	slot_flags = SLOT_BACK
	w_class = 5
	caliber = "a9x39"
	fire_sound = 'sound/weapons/val.ogg'
	magazine_type = /obj/item/ammo_magazine/a9x39
	silenced = 1

	can_wield = 1
	//must_wield = 1

/obj/item/weapon/gun/projectile/automatic/val/update_icon()
	if(ammo_magazine)
		icon_state = "val_loaded"
		if(wielded)
			item_state = "val_loaded_wielded"
		else
			item_state = "val_loaded"
	else
		icon_state = "val_empty"
		if(wielded)
			item_state = "val_empty_wielded"
		else
			item_state = "val_empty"
	update_held_icon()
	return

/obj/item/weapon/gun/projectile/mk12
	name = "\improper MK12"
	desc = "Heavy scoped rifle."
	icon_state = "mk12_loaded"
	item_state = "mk12_loaded"
	load_method = MAGAZINE
	slot_flags = SLOT_BACK
	w_class = 5
	caliber = "a556x45"
	magazine_type = /obj/item/ammo_magazine/a556x45

	accuracy = -2
	scoped_accuracy = 4

	can_wield = 1
	must_wield = 1
	can_scope = 1

	firemodes = list(
		list(name="single shot",	burst=1, move_delay=4, fire_delay=10, accuracy = list(0), dispersion = list(0))
		)

/obj/item/weapon/gun/projectile/mk12/update_icon()
	if(ammo_magazine)
		icon_state = "mk12_loaded"
		if(wielded)
			item_state = "mk12_loaded_wielded"
		else
			item_state = "mk12_loaded"
	else
		icon_state = "mk12_empty"
		if(wielded)
			item_state = "mk12_empty_wielded"
		else
			item_state = "mk12_empty"
	update_held_icon()
	return

