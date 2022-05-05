///////////////////////////////
/datum/job/commander_russian
	title = "Comandir Batalyona"
	flag = HOS
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	head_position = 1
	selection_color = "#530909"
	access = list(access_ru_soldier, access_ru_medic, access_ru_surgerist, access_ru_engineer, access_ru_heavy_weapon, access_ru_squad_leader, access_ru_cook, access_ru_commander)
	minimal_access = list(access_ru_soldier, access_ru_medic, access_ru_surgerist, access_ru_engineer, access_ru_heavy_weapon, access_ru_squad_leader, access_ru_cook, access_ru_commander)
	spawn_location = "JoinLateRussia"

/datum/job/commander_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	world << "<b>[H.name] is the [title] of the RuForce!</b>"
	return 1

/datum/job/commander_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.add_language("English")
	H.default_language = all_languages["Russian"]
	H << "<b>Yay! You know english language!</b>"

///////////////////////////////
/datum/job/sqaud_leader_russian
	title = "Sergant"
	flag = WARDEN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	head_position = 1
	selection_color = "#770e0e"
	access = list(access_ru_soldier, access_ru_medic, access_ru_surgerist, access_ru_engineer, access_ru_heavy_weapon, access_ru_squad_leader, access_ru_cook)
	minimal_access = list(access_ru_soldier, access_ru_medic, access_ru_surgerist, access_ru_engineer, access_ru_heavy_weapon, access_ru_squad_leader, access_ru_cook)
	spawn_location = "JoinLateRussia"

/datum/job/sqaud_leader_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/sqaud_leader_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(10))
		H.add_language("English")
		H << "<b>Yay! You know english language!</b>"

////////////////////////
/datum/job/medic_russian
	title = "Sanitar"
	flag = ENGINEER
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#770e0e"
	access = list(access_ru_soldier, access_ru_medic)
	minimal_access = list(access_ru_soldier, access_ru_medic)
	spawn_location = "JoinLateRussia"

/datum/job/medic_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/medic_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(5))
		H.add_language("English")
		H << "<b>Yay! You know english language!</b>"

////////////////////////////
/*
/datum/job/surgerist_russian
	title = "Russian Surgerist"
	flag = CYBORG
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = "#770e0e"
	access = list(access_ru_soldier, access_ru_medic, access_ru_surgerist)
	minimal_access = list(access_ru_soldier, access_ru_medic, access_ru_surgerist)
	spawn_location = "JoinLateRussia"

/datum/job/surgerist_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
	H.add_language("Russian")
	//H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack(H), slot_back)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1
*/
///////////////////////////
/datum/job/engineer_russian
	title = "Saper"
	flag = CHIEF
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#770e0e"
	access = list(access_ru_soldier, access_ru_engineer)
	minimal_access = list(access_ru_soldier, access_ru_engineer)
	spawn_location = "JoinLateRussia"

/datum/job/engineer_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	//H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack(H), slot_back)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/engineer_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(5))
		H.add_language("English")
		H << "<b>Yay! You know english language!</b>"

///////////////////////////////
/datum/job/heavy_weapon_russian
	title = "Pulemetchik"
	flag = OFFICER
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#770e0e"
	access = list(access_ru_soldier, access_ru_heavy_weapon)
	minimal_access = list(access_ru_soldier, access_ru_heavy_weapon)
	spawn_location = "JoinLateRussia"

/datum/job/heavy_weapon_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	//H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack(H), slot_back)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/heavy_weapon_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(5))
		H.add_language("English")
		H << "<b>Yay! You know english language!</b>"

///////////////////////
/datum/job/cook_russian
	title = "Povar"
	flag = CAPTAIN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#770e0e"
	access = list(access_ru_soldier, access_ru_cook)
	minimal_access = list(access_ru_soldier, access_ru_cook)
	spawn_location = "JoinLateRussia"

/datum/job/cook_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/chefhat(H), slot_head)
	return 1

/datum/job/cook_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(5))
		H.add_language("English")
		H << "<b>Yay! You know english language!</b>"

//////////////////////////
/datum/job/soldier_russian
	title = "Soldat"
	flag = ATMOSTECH
	department_flag = ENGSEC
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	selection_color = "#770e0e"
	access = list(access_ru_soldier)
	minimal_access = list(access_ru_soldier)
	spawn_location = "JoinLateRussia"

/datum/job/soldier_russian/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	//H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack(H), slot_back)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/soldier_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(5))
		H.add_language("English")
		H << "<b>Yay! You know english language!</b>"

//////////////
/datum/job/gru
	title = "Spetsnaz GRU"
	flag = DETECTIVE
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	selection_color = "#a8b800"
	access = list(access_ru_soldier)
	minimal_access = list(access_ru_soldier)
	spawn_location = "JoinLateGRU"

/datum/job/gru/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/gru_uniform(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/val(H), slot_back)

	var/obj/item/weapon/storage/belt/security/tactical/belt = new(H)
	new /obj/item/ammo_magazine/a9x39(belt)
	new /obj/item/ammo_magazine/a9x39(belt)
	new /obj/item/ammo_magazine/a9x39(belt)
	new /obj/item/ammo_magazine/a9x39(belt)
	new /obj/item/weapon/grenade/smokebomb(belt)
	new /obj/item/weapon/grenade/smokebomb(belt)
	H.equip_to_slot_or_del(belt, slot_belt)

	var/obj/item/clothing/suit/storage/vest/gru/suit = new(H)
	new /obj/item/weapon/storage/box/med_kit_ruforce/full(suit.pockets)
	new /obj/item/weapon/plastique(suit.pockets)
	new /obj/item/weapon/plastique(suit.pockets)
	H.equip_to_slot_or_del(suit, slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/radio/russia(H), slot_s_store)
	//H.equip_to_slot_or_del(new /obj/item/device/radio/headset/ru(H), slot_l_ear)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/night(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat(H), slot_gloves)

	H.equip_to_slot_or_del(new /obj/item/weapon/paper/map(H), slot_l_store)

	if(prob(50))
		var/head = pick(
			/obj/item/clothing/head/soft/gorka,
			/obj/item/clothing/head/soft/gru_bandana,
			)
		H.equip_to_slot_or_del(new head(H), slot_head)
	if(prob(25))
		var/mask = /obj/item/clothing/mask/gru_mask
		H.equip_to_slot_or_del(new mask(H), slot_wear_mask)
	return 1


/datum/job/gru/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.add_language("English")
	H.default_language = all_languages["Russian"]