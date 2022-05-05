var/list/possible_random_stuff = list(
		list(/obj/item/weapon/storage/fancy/cigarettes/dromedaryco, /obj/item/weapon/storage/fancy/cigarettes),
		list(/obj/item/weapon/storage/box/matches, /obj/item/weapon/flame/lighter),
		/obj/item/weapon/paper/map,
		list(/obj/item/weapon/reagent_containers/food/drinks/flask/barflask, /obj/item/weapon/reagent_containers/food/drinks/flask/vacuumflask),
		/obj/item/weapon/material/butterfly/switchblade,
		/obj/item/weapon/book/convention,
		list(/obj/item/weapon/spacecash/c200, /obj/item/weapon/spacecash/c100, /obj/item/weapon/spacecash/c50, /obj/item/weapon/spacecash/c20)
		)

/proc/get_random_stuff(var/amount = 4)
	if(amount <= 0)
		return list()

	var/list/items = list()
	var/list/picked_items = list()

	for(var/i = 1 to amount)
		var/item
		for(var/j = 1 to 3)
			item = pick(possible_random_stuff)
			if(!(item in picked_items))
				break

		picked_items += item

		if(islist(item))
			var/list/item_set = item
			item = pick(item_set)

		var/obj/item/weapon/stuff = new item()

		if(istype(stuff, /obj/item/weapon/reagent_containers/food/drinks/flask))
			var/obj/item/weapon/reagent_containers/food/drinks/flask/flask = stuff
			var/reagent_type = pick("vodka", "atomicbomb", "water", "tea", "icetea", "coffee")
			flask.reagents.add_reagent(reagent_type, 60)
			flask.name += " ([reagent_type])"

		items += stuff
	return items