/mob/pipeholder
	name = "Holder"
	density = 0

	sight = SEE_MOBS|SEE_TURFS

	var/mob/owner

	var/list/image/shown_images = list()
	var/list/can_pass = list(/obj/machinery/atmospherics/pipe/simple)

/mob/pipeholder/Move(newLoc, dir = 0)
	if(!..())
		return 0
	var/obj/machinery/atmospherics/pipe/location = src.loc
	if(!istype(location))
		world << "Something bad happened"
		return 0

	var/turf/T = get_step(src, dir)
	if(!T)
		world << "Uh... Oh..."
		return 0

	var/list/obj/machinery/atmospherics/pipe/connected_to = location.pipeline_expansion()
	for(var/obj/machinery/atmospherics/pipe/head_to in T)
		if(!(head_to.type in can_pass))
			world << "Sadly"
			continue
		if(head_to in connected_to)
			loc = head_to
			return 0 //We don't want to trigger turf's Enter or Exit events

	world << "Ooops."
	return 0

/mob/pipeholder/Life()
	..()
	if(!client)
		return
	if(shown_images.len > 0)
		client.images -= shown_images
		shown_images.Cut()
	//Get pipe network
	for(var/obj/machinery/atmospherics/pipe/pipe in range(src, 3))
		var/image/pipe_image = image(icon = pipe.icon, icon_state = pipe.icon_state, loc = get_turf(pipe))
		client.images += pipe_image
		shown_images += pipe_image

/mob/verb/get_into_pipe()
	var/turf/T = get_turf(src)
	world << T
	for(var/obj/o in T)
		world << o
	var/obj/machinery/atmospherics/pipe/pipe = locate(/obj/machinery/atmospherics/pipe) in T.contents
	if(!pipe)
		world << ":C"
		return

	var/mob/pipeholder/holder = new(pipe)
	holder.owner = src
	src.loc = holder
	holder.client = src.client