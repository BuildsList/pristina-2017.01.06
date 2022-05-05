/obj/structure/btr
	name = "BTR"
	desc = "Out of fuel. And ammo. And power. Just a pile of metal."
	icon = 'icons/obj/btr.dmi'
	icon_state = "BTR"
	anchored = 1
	opacity = 1
	density = 1
	bound_width = 160
	bound_height = 96
	var/health = 100

/obj/structure/btr/ex_act(severity)
	if(severity == 3)
		src.visible_message("<span class='warning'>The [name] exploded!</span>", "<span class='warning'>You hear an explosion!</span>")
		explosion(src.loc, -1, -1, 3, 6)
		qdel(src)
	if(severity == 2)
		health -= 25
		if(prob(25) || health <= 0)
			src.visible_message("<span class='warning'>The [name] exploded!</span>", "<span class='warning'>You hear an explosion!</span>")
			explosion(src.loc, -1, -1, 3, 6)
			qdel(src)
		else
			src.visible_message("<span class='warning'>The [name] has taken damage!</span>", "<span class='warning'>You hear an explosion!</span>")
	return