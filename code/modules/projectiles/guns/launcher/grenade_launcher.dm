/obj/item/weapon/gun/launcher/grenade
	name = "m32"
	desc = "A bulky pump-action grenade launcher. Holds up to 6 grenades in a revolving magazine."
	icon_state = "m32_ready"
	item_state = "m32"
	w_class = 4
	force = 10

	handle_casings = REMOVE_CASING
	load_method = SINGLE_CASING
	max_shells = 6

	fire_sound = 'sound/weapons/m32_grenshoot.ogg'
	load_shell_sound = 'sound/weapons/m32_grenload.ogg'
	fire_sound_text = "a metallic thunk"
	recoil = 0

	slot_flags = SLOT_BACK
	var/opened = 0
	matter = list(DEFAULT_WALL_MATERIAL = 2000)

	can_wield = 1
	must_wield = 1

//revolves the magazine, allowing players to choose between multiple grenade types
/obj/item/weapon/gun/launcher/grenade/proc/pump(mob/M as mob)
	playsound(M, 'sound/weapons/shotgunpump.ogg', 50, 1)
	var/obj/item/weapon/grenade/next
	if(loaded.len)
		next = loaded[1] //get this first, so that the chambered grenade can still be removed if the grenades list is empty
	if(chambered)
		loaded += chambered //rotate the revolving magazine
		chambered = null
	if(next)
		loaded -= next //Remove grenade from loaded list.
		chambered = next
		M << "<span class='warning'>You pump [src], loading \a [next] into the chamber.</span>"
	else
		M << "<span class='warning'>You pump [src], but the magazine is empty.</span>"
	update_icon()

/obj/item/weapon/gun/launcher/grenade/examine(mob/user)
	if(..(user, 2))
		var/grenade_count = grenades.len + (chambered? 1 : 0)
		user << "Has [grenade_count] grenade\s remaining."
		if(chambered)
			user << "\A [chambered] is chambered."

/obj/item/weapon/gun/launcher/grenade/proc/load(obj/item/ammo_casing/grenade/G, mob/user)
	if(loaded.len >= max_grenades)
		user << "<span class='warning'>[src] is full.</span>"
		return
	playsound(user, 'sound/weapons/m32_grenload.ogg', 60, 1)
	user.remove_from_mob(G)
	G.loc = src
	grenades.Insert(1, G) //add to the head of the list, so that it is loaded on the next pump
	user.visible_message("[user] inserts \a [G] into [src].", "<span class='notice'>You insert \a [G] into [src].</span>")

/obj/item/weapon/gun/launcher/grenade/proc/unload(mob/user)
	if(grenades.len)
		var/obj/item/ammo_casing/grenade/G = grenades[grenades.len]
		grenades.len--
		user.put_in_hands(G)
		user.visible_message("[user] removes \a [G] from [src].", "<span class='notice'>You remove \a [G] from [src].</span>")
	else
		user << "<span class='warning'>[src] is empty.</span>"

/obj/item/weapon/gun/launcher/grenade/attack_self(mob/user)
	if(opened)
		user << "\red You closed the [name]'s loading chamber."
		opened = 0
		update_icon()
		return
	if(wielded)
		pump(user)
	else
		wield(user)
	return

/obj/item/weapon/gun/launcher/grenade/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/ammo_casing/grenade))
		if(opened)
			load(I, user)
		else
			user << "\red Open the chamber first."
	else
		..()

/obj/item/weapon/gun/launcher/grenade/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		if(opened)
			unload(user)
		else
			user << "\red You opened the [name]'s loading chamber."
			opened = 1
			update_icon()
	else
		..()

/obj/item/weapon/gun/launcher/grenade/consume_next_projectile()
	if(chambered)
		var/obj/item/gl_grenade/grenade = new chambered.projectile_type(src)
		grenade.primed = 1
		return grenade
	return null

/obj/item/weapon/gun/launcher/grenade/update_icon()
	if(opened)
		icon_state = "m32_opened"
		item_state = "m32"
	else
		icon_state = "m32_ready"
		if(wielded)
			item_state = "m32_wielded"
		else
			item_state = "m32"
	update_held_icon()

/obj/item/weapon/gun/launcher/grenade/handle_post_fire(mob/user)
	message_admins("[key_name_admin(user)] fired a grenade from a grenade launcher ([src.name]).")
	log_game("[key_name_admin(user)] used a grenade.")
	chambered = null
	if(grenades.len)
		chambered = grenades[1]
		grenades -= grenades[1]

//Underslung grenade launcher to be used with the Z8
/obj/item/weapon/gun/launcher/grenade/underslung
	name = "underslung grenade launcher"
	desc = "Not much more than a tube and a firing mechanism, this grenade launcher is designed to be fitted to a rifle."
	w_class = 3
	force = 5
	max_grenades = 0

/obj/item/weapon/gun/launcher/grenade/underslung/attack_self()
	return

//load and unload directly into chambered
/obj/item/weapon/gun/launcher/grenade/underslung/load(obj/item/weapon/grenade/G, mob/user)
	if(chambered)
		user << "<span class='warning'>[src] is already loaded.</span>"
		return
	user.remove_from_mob(G)
	G.loc = src
	chambered = G
	user.visible_message("[user] load \a [G] into [src].", "<span class='notice'>You load \a [G] into [src].</span>")

/obj/item/weapon/gun/launcher/grenade/underslung/unload(mob/user)
	if(chambered)
		user.put_in_hands(chambered)
		user.visible_message("[user] removes \a [chambered] from [src].", "<span class='notice'>You remove \a [chambered] from [src].</span>")
		chambered = null
	else
		user << "<span class='warning'>[src] is empty.</span>"