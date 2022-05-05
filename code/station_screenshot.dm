var/chunk_side = 15 //Recommend 15. Bigger numbers could be cause of crash
var/building_screenshots = 0

var/tiles_total = -1
var/tiles_processed = -1
var/last_message_time = 0
var/building_started_at = 0

/mob/verb/get_screenshot()
	if(building_screenshots)
		usr << "\red Already working on it."
		return
	var/zLevel = input(usr, "Select Z level", "z level", 1) as num
	if(zLevel <= 0 || locate(1, 1, zLevel) == null)
		usr << "Can't process this z-level"
		return
	building_screenshots = 1
	//master_controller.processing = 0
	building_started_at = world.time
	usr << "Building screenshots are started. Master controller turned off."
	for(var/gx = 0; gx < world.maxx / chunk_side; gx++)
		for(var/gy = 0; gy < world.maxy / chunk_side; gy++)
			//usr << "Trying to build chunk [gx], [gy], 1"
			get_chunk_image(gx, gy, zLevel)

			usr << "\blue Breathing..."

			sleep(10)//Let GC a chance to get all this trash

			if(!building_screenshots) //Someone or something stopped us
				return

	usr << "\blue Builing finished in [round((world.time - building_started_at) / 10)] seconds."
	//master_controller.processing = 1
	building_screenshots = 0

/mob/verb/crash_test()
	building_screenshots = 1
	//master_controller.processing = 0
	usr << "Building screenshots are started. Master controller turned off."
	get_chunk_image(1, 1, 1)
	//master_controller.processing = 1
	building_screenshots = 0

/mob/verb/stop_building()
	building_screenshots = 0

/mob/verb/set_chunk_side_size()
	set name = "Set Chunk Side Size (FOR DEBUG PURPOSES ONLY)"
	if(building_screenshots)
		usr << "\red Can't change chunk side size while building screenshots."
		return
	var/new_side = input(usr, "Set new chunk side (1-128)", "Chunk side", chunk_side)
	new_side = max(1, min(128, new_side))
	chunk_side = new_side

/proc/progress_ticker()
	/* Damn it
	world << "Progress ticker turned on"
	spawn(0)
		set background = BACKGROUND_ENABLED //Push it into background
		while(1)
			if(building_screenshots == 0)
				world << "Progress ticker turned off"
				return
			if(tiles_total == -1 || tiles_processed == -1)
				world << "Progress ticker turned off"
				return

			world << "Working... [round(tiles_processed/tiles_total)]% of current tiles bunch processed."
			sleep(20)
	*/
	//if(world.time - last_message_time < 10)
	//	return

	//last_message_time = world.time
	if(building_screenshots == 0)
		return
	if(tiles_total == -1 || tiles_processed == -1)
		return

	if(tiles_processed % 512 == 0)
		usr << "Working... [round(tiles_processed/tiles_total * 100)]% of current tiles bunch processed."


/proc/get_chunk_image(var/gx, var/gy, var/z)
	var/real_gy = gy
	gy = world.maxy / chunk_side - gy - 1 //Flip vertically

	spawn(0)
		var/user = usr
		user << "Started working with chunk [gx], [real_gy], [z]."

		var/t_offsetx = gx * chunk_side + 1
		var/t_offsety = gy * chunk_side + 1
		var/icon/I = icon('effects/effects.dmi', "nothing")
		I.Scale(32 * chunk_side, 32 * chunk_side)

		user << "Started tiles building"

		tiles_total = chunk_side * chunk_side
		tiles_processed = 0

		for(var/x = 0; x < chunk_side; x++) //Build tile map before to reduce amount of artefacts
			for(var/y = 0; y < chunk_side; y++)
				tiles_processed++
				var/turf/T = locate(x + t_offsetx, y + t_offsety, z)
				var/icon/turf_icon
				turf_icon = getFlatIcon(T)
				I.Blend(turf_icon, blendMode2iconMode(T.blend_mode), x * 32 + 1, y * 32 + 1)

				del(turf_icon)
			progress_ticker()

		user << "Tiling finished. Starting items building..."
		tiles_processed = 0
		//var/objects_processed = 0
		for(var/x = 0; x < chunk_side; x++)
			for(var/y = 0; y < chunk_side; y++)
				tiles_processed++
				var/turf/T = locate(x + t_offsetx, y + t_offsety, z)

				if(T.interior)
					continue

				var/list/atoms = list()
				atoms.Add(T)
				for(var/atom/A in T)
					atoms.Add(A)

				var/list/sorted = list()
				var/j
				for(var/i = 1 to atoms.len)
					var/atom/c = atoms[i]
					for(j = sorted.len, j > 0, --j)
						var/atom/c2 = sorted[j]
						if(c2.layer <= c.layer)
							break
					sorted.Insert(j+1, c)

				for(var/atom/A in sorted)
					var/icon/img = getFlatIcon(A)

					var/offX = x * 32 + A.pixel_x + 1
					var/offY = y * 32 + A.pixel_y + 1
					if(istype(A, /atom/movable))
						offX += A:step_x
						offY += A:step_y

					I.Blend(img, blendMode2iconMode(A.blend_mode), offX, offY)

					del(img)

				//objects_processed += atoms.len
				//
				//if(objects_processed > 1000)
				//	world << "\blue Breathing in items building cycle..."
				//	sleep(10)
				//	objects_processed = 0

			progress_ticker()

		spawn(0)
			user << browse_rsc(I, "chunk[gx]-[real_gy]-[z].png")
			//user << browse("<html><head><title>chunk[gx]-[gy]-[z].png</title></head>" \
				+ "<body style='overflow:hidden;margin:0;text-align:center'>" \
				+ "<img src='chunk[gx]-[gy]-[z].png' width='800' style='-ms-interpolation-mode:nearest-neighbor' />" \
				+ "</body></html>", "window=book;size=800x800")

			user << "chunk[gx]-[real_gy]-[z].png pushed into cache"
			del(I)

/*
Uncomment if you haven't this
/proc/blendMode2iconMode(blend_mode)
	switch(blend_mode)
		if(BLEND_MULTIPLY) return ICON_MULTIPLY
		if(BLEND_ADD)      return ICON_ADD
		if(BLEND_SUBTRACT) return ICON_SUBTRACT
		else               return ICON_OVERLAY
*/