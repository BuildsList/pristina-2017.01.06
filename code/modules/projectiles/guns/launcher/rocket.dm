/obj/item/weapon/gun/launcher/rocket
	name = "rocket launcher"
	desc = "MAGGOT."
	icon_state = "rocket"
	item_state = "rocket"
	w_class = 4.0
	throw_speed = 2
	throw_range = 10
	force = 5.0
	flags =  CONDUCT | USEDELAY
	slot_flags = 0
	origin_tech = "combat=8;materials=5"
	fire_sound = 'sound/effects/bang.ogg'

	load_method = SINGLE_CASING
	recoil = 4

/obj/item/weapon/gun/launcher/rocket/examine(mob/user)
	if(!..(user, 2))
		return
	user << "\blue [rockets.len] / [max_rockets] rockets."

/obj/item/weapon/gun/launcher/rocket/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/ammo_casing/rocket))
		if(rockets.len < max_rockets)
			user.drop_item()
			I.loc = src
			rockets += I
			user << "\blue You put the rocket in [src]."
			user << "\blue [rockets.len] / [max_rockets] rockets."
		else
			usr << "\red [src] cannot hold more rockets."

/obj/item/weapon/gun/launcher/rocket/consume_next_projectile()
	if(rockets.len)
		var/obj/item/ammo_casing/rocket/I = rockets[1]
		var/obj/item/missile/he/M = new (src)
		M.primed = 1
		rockets -= I
		return M
	return null

/obj/item/weapon/gun/launcher/rocket/handle_post_fire(mob/user, atom/target)
	message_admins("[key_name_admin(user)] fired a rocket from a rocket launcher ([src.name]) at [target].")
	log_game("[key_name_admin(user)] used a rocket launcher ([src.name]) at [target].")

/obj/item/weapon/gun/launcher/rocket/one_use
	name = "one use rocket launcher"
	recoil = 4
	can_wield = 1
	must_wield = 1

	New()
		..()
		rockets += new /obj/item/ammo_casing/rocket(src)

/obj/item/weapon/gun/launcher/rocket/one_use/attackby(obj/item/I as obj, mob/user as mob)
	return

/obj/item/weapon/gun/launcher/rocket/one_use/attack_self(mob/user as mob)
	if(!wielded)
		wield(user)
	else
		unwield(user)

/obj/item/weapon/gun/launcher/rocket/one_use/update_icon()
	if(wielded)
		item_state = "rpg26_wielded"
	else
		item_state = "rpg26"
	update_held_icon()

/obj/item/weapon/gun/launcher/rocket/one_use/handle_post_fire(mob/user, atom/target)
	..()
	name += " (Used)"

/obj/item/weapon/gun/launcher/rocket/one_use/rpg26
	name = "RPG-26"
	slot_flags = SLOT_BACK
	icon_state = "rpg26"
	item_state = "rpg26"

/obj/item/weapon/gun/launcher/rocket/one_use/at4
	name = "AT-4"
	slot_flags = SLOT_BACK
	icon_state = "at4"
	item_state = "rpg26"


/obj/item/missile/he
	icon = 'icons/obj/grenade.dmi'
	icon_state = "missile"
	throwforce = 5

	throw_impact(atom/hit_atom)
		if(primed)
			explosion(hit_atom, 1, 1, 4, 8)
			qdel(src)
		else
			..()
		return