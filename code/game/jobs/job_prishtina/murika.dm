/////////////////////////////
/datum/job/commander_american
	title = "Field Officer"
	flag = CMO
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	head_position = 1
	selection_color = "#2d2d63"
	access = list(access_nato_soldier, access_nato_medic, access_nato_surgerist, access_nato_engineer, access_nato_heavy_weapon, access_nato_cook, access_nato_squad_leader, access_nato_commander)
	minimal_access = list(access_nato_soldier, access_nato_medic, access_nato_surgerist, access_nato_engineer, access_nato_heavy_weapon, access_nato_cook, access_nato_squad_leader, access_nato_commander)
	spawn_location = "JoinLateNATO"

/datum/job/commander_american/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
	H.equip_to_slot_or_del(new /obj/item/clothing/under/nato_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/commander_american/update_character(var/mob/living/carbon/human/H)
	H.add_language("English")
	if(prob(20))
		H.add_language("Russian")
	H.default_language = all_languages["English"]
	H << "<b>Yay! You know russian language!</b>"

////////////////////////////////
/datum/job/squad_leader_american
	title = "Squad Leader"
	flag = XENOBIOLOGIST
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	head_position = 1
	selection_color = "#4c4ca5"
	access = list(access_nato_soldier, access_nato_medic, access_nato_surgerist, access_nato_engineer, access_nato_heavy_weapon, access_nato_cook, access_nato_squad_leader)
	minimal_access = list(access_nato_soldier, access_nato_medic, access_nato_surgerist, access_nato_engineer, access_nato_heavy_weapon, access_nato_cook, access_nato_squad_leader)
	spawn_location = "JoinLateNATO"

/datum/job/squad_leader_american/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/nato_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/squad_leader_american/update_character(var/mob/living/carbon/human/H)
	H.add_language("English")
	H.default_language = all_languages["English"]
	if(prob(5))
		H.add_language("Russian")
		H << "<b>Yay! You know russian language!</b>"

////////////////////////////////
/datum/job/medic_american
	title = "Field Medic"
	flag = DOCTOR
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#4c4ca5"
	access = list(access_nato_soldier, access_nato_medic)
	minimal_access = list(access_nato_soldier, access_nato_medic)
	spawn_location = "JoinLateNATO"

/datum/job/medic_american/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/nato_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/medic_american/update_character(var/mob/living/carbon/human/H)
	H.add_language("English")
	H.default_language = all_languages["English"]
	if(prob(1))
		H.add_language("Russian")
		H << "<b>Yay! You know russian language!</b>"

/////////////////////////
/datum/job/engineer_american
	title = "Combat Engineer"
	flag = ROBOTICIST
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#4c4ca5"
	access = list(access_nato_soldier, access_nato_engineer)
	minimal_access = list(access_nato_soldier, access_nato_engineer)
	spawn_location = "JoinLateNATO"

/datum/job/engineer_american/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/nato_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/engineer_american/update_character(var/mob/living/carbon/human/H)
	H.add_language("English")
	H.default_language = all_languages["English"]
	if(prob(1))
		H.add_language("Russian")
		H << "<b>Yay! You know russian language!</b>"

/////////////////////////
/datum/job/heavy_weapon_american
	title = "Specialist"
	flag = CHEMIST
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#4c4ca5"
	access = list(access_nato_soldier, access_nato_heavy_weapon)
	minimal_access = list(access_nato_soldier, access_nato_heavy_weapon)
	spawn_location = "JoinLateNATO"

/datum/job/heavy_weapon_american/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/nato_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/heavy_weapon_american/update_character(var/mob/living/carbon/human/H)
	H.add_language("English")
	H.default_language = all_languages["English"]
	if(prob(1))
		H.add_language("Russian")
		H << "<b>Yay! You know russian language!</b>"

///////////////////////////
/datum/job/soldier_american
	title = "Soldier"
	flag = PARAMEDIC
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#4c4ca5"
	access = list(access_nato_soldier)
	minimal_access = list(access_nato_soldier)
	spawn_location = "JoinLateNATO"

/datum/job/soldier_american/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/nato_uniform(H), slot_w_uniform)
	//H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	return 1

/datum/job/soldier_american/update_character(var/mob/living/carbon/human/H)
	H.add_language("English")
	H.default_language = all_languages["English"]
	if(prob(1))
		H.add_language("Russian")
		H << "<b>Yay! You know russian language!</b>"

var/first_75th = 1

/datum/job/the75th_recon
	title = "75th Rangers"
	flag = GENETICIST
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	selection_color = "#4c4ca5"
	access = list(access_nato_soldier)
	minimal_access = list(access_nato_soldier)
	spawn_location = "75Recon"

/datum/job/the75th_recon/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0

	H.equip_to_slot_or_del(new /obj/item/clothing/under/the75th_uniform(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/the75th_ghillie(H), slot_head)
	if(first_75th)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/mk12(H), slot_back)
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/m4(H), slot_back)

	if(first_75th)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/colt(H), slot_belt)
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/bag/medical_bag_nato/full(H), slot_belt)

	var/obj/item/clothing/suit/storage/vest/the75th_ghillie/G = new(H)
	if(first_75th)
		for(var/i = 1 to 4)
			new /obj/item/ammo_magazine/a556x45(G.pockets)
		for(var/i = 1 to 2)
			new /obj/item/ammo_magazine/c45m(G.pockets)
	else
		for(var/i = 1 to 6)
			new /obj/item/ammo_magazine/a556/m4(G.pockets)

	H.equip_to_slot_or_del(new /obj/item/weapon/paper/map(H), slot_l_store)

	H.equip_to_slot_or_del(G, slot_wear_suit)

	H.equip_to_slot_or_del(new /obj/item/device/radio/nato(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/night(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat(H), slot_gloves)

	first_75th = 0


/datum/job/the75th_recon/update_character(var/mob/living/carbon/human/H)
	H.add_language("English")
	H.add_language("Russian")
	H.default_language = all_languages["English"]
	H << "<b>Yay! You know russian language!</b>"