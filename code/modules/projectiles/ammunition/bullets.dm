/obj/item/ammo_casing/a357
	desc = "A .357 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet/pistol/strong

/obj/item/ammo_casing/a50
	desc = "A .50AE bullet casing."
	caliber = ".50"
	projectile_type = /obj/item/projectile/bullet/pistol/strong

/obj/item/ammo_casing/a75
	desc = "A 20mm bullet casing."
	caliber = "75"
	projectile_type = /obj/item/projectile/bullet/gyro

/obj/item/ammo_casing/c38
	desc = "A .38 bullet casing."
	caliber = "38"
	projectile_type = /obj/item/projectile/bullet/pistol

/obj/item/ammo_casing/c38r
	desc = "A .38 rubber bullet casing."
	caliber = "38"
	projectile_type = /obj/item/projectile/bullet/pistol/rubber

/obj/item/ammo_casing/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/pistol

/obj/item/ammo_casing/c9mmf
	desc = "A 9mm flash shell casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/energy/flash

/obj/item/ammo_casing/c9mmr
	desc = "A 9mm rubber bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/pistol/rubber

/obj/item/ammo_casing/c9mmp
	desc = "A 9mm practice bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/pistol/practice


/obj/item/ammo_casing/c45
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/pistol/medium

/obj/item/ammo_casing/c45p
	desc = "A .45 practice bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/pistol/practice

/obj/item/ammo_casing/c45r
	desc = "A .45 rubber bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/pistol/rubber

/obj/item/ammo_casing/c45f
	desc = "A .45 flash shell casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/energy/flash

/obj/item/ammo_casing/a12mm
	desc = "A 12mm bullet casing."
	caliber = "12mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium


/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12 gauge slug."
	icon_state = "slshell"
	caliber = "shotgun"
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank shell."
	icon_state = "blshell"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(DEFAULT_WALL_MATERIAL = 90)

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun shell"
	desc = "A practice shell."
	icon_state = "pshell"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	matter = list("metal" = 90)

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A beanbag shell."
	icon_state = "bshell"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(DEFAULT_WALL_MATERIAL = 180)

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "A 12 gauge taser cartridge."
	icon_state = "stunshell"
	spent_icon = "stunshell-spent"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	matter = list(DEFAULT_WALL_MATERIAL = 360, "glass" = 720)

/obj/item/ammo_casing/shotgun/stunshell/emp_act(severity)
	if(prob(100/severity)) BB = null
	update_icon()

//Does not stun, only blinds, but has area of effect.
/obj/item/ammo_casing/shotgun/flash
	name = "flash shell"
	desc = "A chemical shell used to signal distress or provide illumination."
	icon_state = "fshell"
	projectile_type = /obj/item/projectile/energy/flash/flare
	matter = list(DEFAULT_WALL_MATERIAL = 90, "glass" = 90)

/obj/item/ammo_casing/a762
	desc = "A 7.62mm bullet casing."
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet/rifle/a762

/obj/item/ammo_casing/a145
	name = "shell casing"
	desc = "A 14.5mm shell."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = "14.5mm"
	projectile_type = /obj/item/projectile/bullet/rifle/a145
	matter = list(DEFAULT_WALL_MATERIAL = 1250)

/obj/item/ammo_casing/a556
	desc = "A 5.56mm bullet casing."
	caliber = "a556"
	projectile_type = /obj/item/projectile/bullet/rifle/a556

/obj/item/ammo_casing/a556p
	desc = "A 5.56mm practice bullet casing."
	caliber = "a556"
	projectile_type = /obj/item/projectile/bullet/rifle/a556/practice

/obj/item/ammo_casing/rocket
	name = "rocket shell"
	desc = "A high explosive designed to be fired from a launcher."
	icon_state = "rocketshell"
	projectile_type = /obj/item/missile
	caliber = "rocket"

/obj/item/ammo_casing/chameleon
	name = "chameleon bullets"
	desc = "A set of bullets for the Chameleon Gun."
	projectile_type = /obj/item/projectile/bullet/chameleon
	caliber = ".45"



/obj/item/ammo_casing/grenade
	name = "grenade"
	desc = "I hate descriptions."
	caliber = "grenade"

/obj/item/ammo_casing/grenade/he
	name = "he grenade"
	icon_state = "he_grenade"
	projectile_type = /obj/item/projectile/grenade/he
	caliber = "grenade"

/obj/item/ammo_casing/grenade/smoke
	name = "smoke grenade"
	icon_state = "smoke_grenade"
	projectile_type = /obj/item/projectile/grenade/smoke
	caliber = "grenade"

/obj/item/ammo_casing/grenade/tear
	name = "tear grenade"
	icon_state = "tear_grenade"
	projectile_type = /obj/item/projectile/grenade/tear
	caliber = "grenade"

/obj/item/ammo_casing/a9x39
	desc = "a 9x39 bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/a9x39
	caliber = "a9x39"

/obj/item/ammo_casing/a762x39
	name = "a 7.62x39 bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/a762x39
	caliber = "a762x39"

/obj/item/ammo_casing/a762x51
	name = "a 7.62x51 bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/a762x51
	caliber = "a762x51"

/obj/item/ammo_casing/rocket_he
	name = "a he rocket"
	desc = "High explosive rocket."
	projectile_type = /obj/item/projectile/missile/he
	caliber = "rocket"

/obj/item/ammo_casing/c4mm
	name = "a 4mm bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/c4mm
	caliber = "c4mm"

/obj/item/ammo_casing/a556x45
	name = "a 5.56x45 bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/a556x45
	caliber = "a556x45"

/obj/item/ammo_casing/a127x108
	name = "a 12.7x108 bullet casing"
	projectile_type = /obj/item/projectile/bullet/rifle/a127x108
	caliber = "a127x108"

/*
/obj/item/ammo_casing/a418
	desc = "A .418 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet/suffocationbullet

/obj/item/ammo_casing/a666
	desc = "A .666 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet/cyanideround
*/