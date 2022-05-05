/datum/game_mode/prishtina
	name = "Prishtina RP"
	round_description = "Russian soldiers (RuForce) has captured the important airport Slatino. NATO forces (EnForce) must recapture the airport and hold it while reinforcements arrive."
	config_tag = "prishtina"
	required_players = 0
	required_enemies = 0
	ert_disabled = 1
	deny_respawn = 0

	var/alive_en = 0
	var/alive_ru = 0
	var/alive_civ = 0

	var/heavily_injured_en = 0
	var/heavily_injured_ru = 0
	var/heavily_injured_civ = 0

	var/en_at_airport = 0
	var/ru_at_airport = 0

	var/started_capturing_at = -1
	var/airport_captured = 0
	var/capture_delay = 6000 //10 minutes

	var/last_siren = 0
	var/siren_delay = 2400 //4 minutes

/datum/game_mode/prishtina/proc/update_battle_report()
	alive_en = 0
	alive_ru = 0
	alive_civ = 0

	heavily_injured_en = 0
	heavily_injured_ru = 0
	heavily_injured_civ = 0

	for(var/mob/living/carbon/human/H in human_mob_list)
		if(H.stat == DEAD)
			continue
		var/datum/job/job = job_master.GetJob(H.mind.assigned_role)
		if(!job)
			continue
		switch(job.department_flag)
			if(ENFORCE)
				alive_en++
			if(RUFORCE)
				alive_ru++
			if(CIVILIAN)
				alive_civ++

		if(H.health > -30) //Almost hard-crit
			continue

		switch(job.department_flag)
			if(ENFORCE)
				heavily_injured_en++
			if(RUFORCE)
				heavily_injured_ru++
			if(CIVILIAN)
				heavily_injured_civ++

	en_at_airport = 0
	ru_at_airport = 0

	for(var/mob/living/carbon/human/H in human_mob_list)
		if(H.stat != CONSCIOUS)
			continue
		var/datum/job/job = job_master.GetJob(H.mind.assigned_role)
		if(!job)
			continue
		if(job.department_flag == ENFORCE)
			if(H.loc && H.loc.loc && (istype(H.loc.loc, /area/prishtina/aeroport_out) || istype(H.loc.loc, /area/prishtina/aeroport_in)))
				en_at_airport++
		else if(job.department_flag == RUFORCE)
			if(H.loc && H.loc.loc && (istype(H.loc.loc, /area/prishtina/aeroport_out) || istype(H.loc.loc, /area/prishtina/aeroport_in)))
				ru_at_airport++

/datum/game_mode/prishtina/check_finished()
	if(!mission_started)
		return 0

	update_battle_report()

	if(alive_en - heavily_injured_en <= 2 || alive_ru - heavily_injured_ru <= 2)
		return 1

	if(ru_at_airport <= 2 && en_at_airport >= 5)
		if(started_capturing_at >= 0)
			if(started_capturing_at + capture_delay <= world.time)
				log_debug("Airport has captured.")
				airport_captured = 1
				return 1
			if(last_siren + siren_delay <= world.time)
				log_debug("Game Mode Prishtina has player a sound 'siren'")
				last_siren = world.time
				world << sound('sound/effects/siren.ogg')
		else
			log_debug("Airport capturing has started.")
			started_capturing_at = world.time

		return 1
	else
		if(started_capturing_at >= 0)
			log_debug("Airport capturing has stopped.")
			started_capturing_at = -1

	return 0

/datum/game_mode/prishtina/declare_completion()
	update_battle_report()

	world << "<font size=3 color=red><b>The round has finished</b></font>"
	world << "<font size=2>There is [alive_en] alive EnForce soldiers. [heavily_injured_en] of them is heavily injured.</font>"
	world << "<font size=2>There is [alive_ru] alive RuForce soldiers. [heavily_injured_ru] of them is heavily injured.</font>"
	world << "<font size=2>There is [alive_civ] alive local civilians. [heavily_injured_civ] of them is heavily injured.</font>"


	if(airport_captured)
		world << "<font size=3>EnForce has won the battle due to capturing the airport!</font>"
		world << "<font size=2>There is [en_at_airport] EnForce soldiers and [ru_at_airport] RuForce soldiers at the airport.</font>"
	else if(alive_en - heavily_injured_en <= 2 && job_master.enforce_count >= 8)
		world << "<font size=3>RuForce has won the battle due to heavy losses of EnForce!</font>"
	else if(alive_ru - heavily_injured_ru <= 2 && job_master.ruforce_count >= 8)
		world << "<font size=3>EnForce has won the battle due to heavy losses of RuForce!</font>"
	else
		world << "<font size=3>No one has won the battle for some reasons!</font>"