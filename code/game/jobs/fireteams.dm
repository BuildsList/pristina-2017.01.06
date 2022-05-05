/datum/fireteam
	var/name = null
	var/code = null
	var/list/members = list()
	var/list/required = list()
	var/side = CIVILIAN

	var/can_set_name = null
	var/name_set = 0
	var/id = 1
	var/squad_type
	var/max_fireteams = -1

	var/list/fireteam_codes = list()
	var/list/fireteam_access = list()

/datum/fireteam/proc/add_member(var/mob/living/carbon/human/H, var/datum/job/job)
	if(!(job.type in required))
		return 0
	required -= job.type
	members += H
	greet_and_equip_member(H)
	if(required.len <= 0)
		trigger_full()
	if(!name_set && job.type == can_set_name)
		name_set = 1
		var/new_name = input(H, "Enter new squad name. Leave empty to use default.", "Name", "") as text
		new_name = sanitizeName(new_name)
		if(new_name && new_name != code)
			name = new_name
			for(var/member in members)
				member << "<b>Your fireteam [code] is now called \"[name]\".</b>"
	return 1

/datum/fireteam/proc/greet_and_equip_member(var/mob/living/carbon/human/H)
	if(!name)
		H << "You are now in the [squad_type] [code]"
	else
		H << "You are now in the [squad_type] [code] \"[name]\""
	var/obj/item/weapon/card/id/id_card = H.wear_id
	if(istype(id_card))
		if(id > 0 & fireteam_access.len >= id)
			id_card.access.Add(fireteam_access[id])
		if(code)
			id_card.name = "[id_card.registered_name]'s ID Card ([code]'s [id_card.assignment])"
		else
			id_card.name = "[id_card.registered_name]'s ID Card ([id_card.assignment])"

/datum/fireteam/proc/init()
	for(var/type_name in required)
		for(var/datum/job/job in job_master.occupations)
			if(job.type == type_name)
				job.total_positions++
				break

	code = get_code()

/datum/fireteam/proc/trigger_full()
	job_master.not_full_fireteams -= src

	job_master.add_fireteam(type)
	return 1

/datum/fireteam/proc/is_full()
	return required.len <= 0

/datum/fireteam/proc/get_code()
	var/c = fireteam_codes[id]
	if(!c)
		return ""
	return c

/datum/fireteam/american_squad
	required = list(/datum/job/squad_leader_american,
					/datum/job/medic_american,
					/datum/job/engineer_american,
					/datum/job/heavy_weapon_american
					)

	can_set_name = /datum/job/squad_leader_american
	squad_type = "fireteam"
	side = ENFORCE
	max_fireteams = 9

	fireteam_codes = list(
		1 = "Alpha",
		2 = "Bravo",
		3 = "Charlie",
		4 = "Delta",
		5 = "Echo",
		6 = "Foxtrot",
		7 = "Golf",
		8 = "Hotel",
		9 = "India"
		)

	fireteam_access = list(1, 2, 3, 4, 5, 6, 7, 8, 9)

/datum/fireteam/russian_squad
	required = list(/datum/job/sqaud_leader_russian,
					/datum/job/medic_russian,
					/datum/job/engineer_russian,
					/datum/job/heavy_weapon_russian,
					/datum/job/heavy_weapon_russian,
					/datum/job/soldier_russian,
					/datum/job/soldier_russian,
					/datum/job/soldier_russian,
					/datum/job/soldier_russian
					)

	can_set_name = /datum/job/sqaud_leader_russian
	squad_type = "otdeleniye"
	side = RUFORCE
	max_fireteams = 4

	fireteam_codes = list(
		1 = "Anna",
		2 = "Boris",
		3 = "Vasiliy",
		4 = "Grigoriy"
		)

/datum/fireteam/russian_gru
	required = list(/datum/job/gru,
					/datum/job/gru,
					/datum/job/gru
					)
	can_set_name = /datum/job/gru
	squad_type = "spec otryad"
	max_fireteams = 1
	side = RUFORCE

	fireteam_codes = list(
		1 = "Spetsnaz"
		)

/datum/fireteam/american_recon
	required = list(/datum/job/the75th_recon,
					/datum/job/the75th_recon
					)
	can_set_name = /datum/job/the75th_recon
	squad_type = "recon squad"
	max_fireteams = 1
	side = ENFORCE

	fireteam_codes = list(
		1 = "Recons"
		)