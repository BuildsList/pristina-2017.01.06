var/roundstart_time = 0

/hook/roundstart/proc/game_start()
	roundstart_time = world.time
	world << "<font size=3>Don't forget to change the weather.</font>"
	return 1

var/wlg_total = 0
var/wlg_rejected = 0
var/wlg_selected_none = 0
var/wlg_selected_grass = 0
var/wlg_selected_bush = 0
var/wlg_selected_border_tree = 0

/hook/startup/proc/spawn_bushes()
	world << "<b>Generating wild life. Experimental.</b>"
	wlg_total = 0
	wlg_rejected = 0
	wlg_selected_none = 0
	wlg_selected_grass = 0
	wlg_selected_bush = 0
	wlg_selected_border_tree = 0
	spawn(100)
		for(var/turf/T in world)
			if(T.z != 1)
				continue
			if(!istype(T, /turf/simulated/floor/plating/grass))
				continue

			wlg_total++
			if(T.contents.len > 1)
				wlg_rejected++
				continue

			for(var/dir in cardinal)
				var/turf/C = get_step(T, dir)
				if(istype(C, /turf/unsimulated/wall))
					wlg_selected_border_tree++
					new /obj/structure/wild/tree(T)
					break

			var/rn = rand(1, 100)
			switch(rn)
				if(1 to 80)
					wlg_selected_none++
					continue
				if(81 to 99)
					wlg_selected_grass++
					var/grass = pick(/obj/structure/flora/ausbushes/sparsegrass,
									/obj/structure/flora/ausbushes/sparsegrass,
									/obj/structure/flora/ausbushes/fullgrass,
									/obj/structure/flora/ausbushes/lavendergrass)
					new grass(T)
				//if(97 to 99)
				//	var/flowers = pick(/obj/structure/flora/ausbushes/ywflowers,
				//					/obj/structure/flora/ausbushes/brflowers,
				//					/obj/structure/flora/ausbushes/ppflowers)
				//	new flowers(T)
				else
					wlg_selected_bush++
					var/bushes = pick(/obj/structure/flora/ausbushes,
									/obj/structure/flora/ausbushes/reedbush,
									/obj/structure/flora/ausbushes/leafybush,
									/obj/structure/flora/ausbushes/palebush,
									/obj/structure/flora/ausbushes/stalkybush,
									/obj/structure/flora/ausbushes/grassybush,
									/obj/structure/flora/ausbushes/fernybush,
									/obj/structure/flora/ausbushes/sunnybush,
									/obj/structure/flora/ausbushes/genericbush,
									/obj/structure/flora/ausbushes/pointybush)
					new bushes(T)
	return 1

/hook/shuttle_move/proc/announce_mission_start()
	if(!ticker || !ticker.mode || ticker.mode.mission_started)
		return 1
	ticker.mode.mission_started = 1
	ticker.mode.mission_start_time = world.time

	var/preparation_time = world.time - roundstart_time

	world << "<font size=4>The NATO mission has started after [round(preparation_time / 600)] minutes of preparation.</font>"
	world << "<font size=3>Both sides are locked for joining.</font>."
	ticker.can_latejoin_ruforce = 0
	ticker.can_latejoin_enforce = 0
	world << "<font size=3>Balance report: [job_master.enforce_count] EnForce, [job_master.ruforce_count] RuForce and [job_master.civilian_count] civilians.</font>"
	var/ru_fireteams = 0
	var/en_fireteams = 0
	for(var/datum/fireteam/ft in job_master.all_fireteams)
		if(!ft.is_full())
			continue
		if(ft.side == RUFORCE)
			ru_fireteams++
		if(ft.side == ENFORCE)
			en_fireteams++
	world << "<font size=3>Fireteams report: [en_fireteams] EnForce full fireteams, [ru_fireteams] RuForce full otdeleniy and spec otryadov."
	for(var/datum/fireteam/ft in job_master.all_fireteams)
		var/text = "[get_side_name(ft.side)] - [ft.code]"
		if(ft.name)
			text += " called as \"[ft.name]\"."
		world << "<font size=2>-[text]</font>"
	return 1

/proc/get_side_name(var/side)
	if(side == CIVILIAN)
		return "Civilian"
	if(side == RUFORCE)
		return "RuForce"
	if(side == ENFORCE)
		return "EnForce"
	return null