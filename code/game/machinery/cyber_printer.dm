/obj/machinery/cyberparts_printer
	name = "Cyberparts Printer"
	desc = "##TODO DESC"

/obj/machinery/cyberparts_printer/attack_hand(mob/user)
	var/list/parts = typesof(/obj/item/cyber) - /obj/item/cyber

	var/path = input(src, "Select part to print", name) as null|anything in parts
	if(!path)
		return

	var/obj/item/cyber/part = new path(src.loc)
	user.put_in_hands(part)
	user << "<span class='info'>[path] part is printed.</span>"