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

	var/obj/item/weapon/storage/belt/security/belt = new(H)
	var/obj/item/clothing/under/ru_uniform/uniform = new(H)
	var/obj/item/clothing/suit/storage/vest/heavy/ru/armor = new(H)
	var/obj/item/weapon/storage/internal/armor_pockets = armor.pockets
	var/obj/item/clothing/accessory/holster/holster = new(H)

	H.equip_to_slot_or_del(uniform, slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/soft/ru_beret(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/akm(H), slot_back)
	H.equip_to_slot_or_del(belt, slot_belt)
	H.equip_to_slot_or_del(armor, slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/radio/russia(H), slot_s_store)

	holster.holstered = new /obj/item/weapon/gun/projectile/pistol(holster)
	uniform.attach_accessory(holster)

	for(var/i = 1 to 4)
		new /obj/item/ammo_magazine/a762/akm(belt)
	new /obj/item/device/flashlight/flare(belt)
	new /obj/item/weapon/storage/box/med_kit_ruforce/full(belt)
	new /obj/item/device/radio/russia(belt)

	new /obj/item/ammo_magazine/mc9mm(armor_pockets)
	new /obj/item/weapon/grenade/smokebomb(armor_pockets)
	new /obj/item/device/binoculars(armor_pockets)
	new /obj/item/clothing/glasses/night(armor_pockets)


	var/list/random_stuff = get_random_stuff(rand(1, 2))

	if(random_stuff.len >= 1)
		H.equip_to_slot_or_del(random_stuff[1], slot_r_store)
	if(random_stuff.len >= 2)
		H.equip_to_slot_or_del(random_stuff[2], slot_l_store)

	return 1
	return 1

/datum/job/commander_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(50))
		H.add_language("English")
		H << "<b>You know English language!</b>"
	if(prob(10))
		var lang = pick("Serbian", "Bosnian", "Albanian")
		H.add_language(lang)
		H << "<b>You know [lang] language!</b>"

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

	var/obj/item/weapon/storage/belt/security/belt = new(H)
	var/obj/item/clothing/under/ru_uniform/uniform = new(H)
	var/obj/item/clothing/suit/storage/vest/heavy/ru/armor = new(H)
	var/obj/item/weapon/storage/internal/armor_pockets = armor.pockets
	var/obj/item/clothing/accessory/holster/holster = new(H)

	H.equip_to_slot_or_del(uniform, slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/soft/ru_beret(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/akm(H), slot_back)
	H.equip_to_slot_or_del(belt, slot_belt)
	H.equip_to_slot_or_del(armor, slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/radio/russia(H), slot_s_store)

	holster.holstered = new /obj/item/weapon/gun/projectile/pistol(holster)
	uniform.attach_accessory(holster)

	for(var/i = 1 to 4)
		new /obj/item/ammo_magazine/a762/akm(belt)
	new /obj/item/device/flashlight/flare(belt)
	new /obj/item/weapon/storage/box/med_kit_ruforce/full(belt)
	new /obj/item/device/radio/russia(belt)

	new /obj/item/ammo_magazine/mc9mm(armor_pockets)
	new /obj/item/weapon/grenade/smokebomb(armor_pockets)
	new /obj/item/device/binoculars(armor_pockets)
	new /obj/item/clothing/glasses/night(armor_pockets)


	var/list/random_stuff = get_random_stuff(rand(1, 2))

	for(var/i = 1 to random_stuff.len)
		var/obj/item/item = random_stuff[i]
		switch(i)
			if(1)
				H.equip_to_slot_or_del(item, slot_r_store)
			if(2)
				item.loc = armor_pockets
			if(3)
				H.equip_to_slot_or_del(item, slot_l_store)

	return 1

/datum/job/sqaud_leader_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(40))
		H.add_language("English")
		H << "<b>You know English language!</b>"
	if(prob(10))
		var lang = pick("Serbian", "Bosnian", "Albanian")
		H.add_language(lang)
		H << "<b>You know [lang] language!</b>"

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

	var/obj/item/weapon/storage/belt/medical/belt = new(H)
	var/obj/item/clothing/under/ru_uniform/uniform = new(H)
	var/obj/item/weapon/storage/backpack/medic/backpack = new(H)
	var/obj/item/clothing/suit/storage/vest/heavy/ru/armor = new(H)
	var/obj/item/weapon/storage/internal/armor_pockets = armor.pockets
	var/obj/item/clothing/accessory/holster/holster = new(H)

	H.equip_to_slot_or_del(uniform, slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/tactical/ru(H), slot_head)
	H.equip_to_slot_or_del(backpack, slot_back)
	H.equip_to_slot_or_del(belt, slot_belt)
	H.equip_to_slot_or_del(armor, slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/radio/russia(H), slot_s_store)

	holster.holstered = new /obj/item/weapon/gun/projectile/pistol(holster)
	uniform.attach_accessory(holster)

	for(var/i = 1 to 4)
		new /obj/item/weapon/storage/box/med_kit_ruforce/full(backpack)
	var/obj/item/weapon/storage/box/med_kit_ruforce/medkit = new(backpack)
	medkit.name = "peridaxon bezotlagatel'ni komplekt"
	medkit.color = "#AAAAAA" //T_T
	for(var/i = 1 to 7)
		new /obj/item/weapon/reagent_containers/hypospray/autoinjector/survival/peridaxon(medkit)

	new /obj/item/device/healthanalyzer(belt)
	new /obj/item/stack/medical/splint(belt)
	new /obj/item/weapon/pill_pack/antitox(belt)
	new /obj/item/weapon/pill_pack/dexalin(belt)
	new /obj/item/weapon/pill_pack/bicaridine(belt)

	for(var/i = 1 to 3)
		new /obj/item/ammo_magazine/mc9mm(armor_pockets)

	var/list/random_stuff = get_random_stuff(rand(1, 3))

	for(var/i = 1 to random_stuff.len)
		var/obj/item/item = random_stuff[i]
		switch(i)
			if(1)
				H.equip_to_slot_or_del(item, slot_r_store)
			if(2)
				item.loc = armor_pockets
			if(3)
				H.equip_to_slot_or_del(item, slot_l_store)

	return 1

/datum/job/medic_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(30))
		H.add_language("English")
		H << "<b>You know English language!</b>"
	if(prob(5))
		var lang = pick("Serbian", "Bosnian", "Albanian")
		H.add_language(lang)
		H << "<b>You know [lang] language!</b>"

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

	var/obj/item/weapon/storage/belt/utility/full/belt = new(H)
	var/obj/item/clothing/under/ru_uniform/uniform = new(H)
	var/obj/item/weapon/storage/backpack/industrial/backpack = new(H)
	var/obj/item/clothing/suit/storage/vest/heavy/ru/armor = new(H)
	var/obj/item/weapon/storage/internal/armor_pockets = armor.pockets

	H.equip_to_slot_or_del(uniform, slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/welding(H), slot_head)
	H.equip_to_slot_or_del(backpack, slot_back)
	H.equip_to_slot_or_del(belt, slot_belt)
	H.equip_to_slot_or_del(armor, slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/radio/russia(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/akm(H), pick(slot_r_hand, slot_l_hand))
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(H), slot_gloves)

	for(var/i = 1 to 2)
		new /obj/item/ammo_magazine/a762/akm(armor_pockets)

	new /obj/item/device/multitool(belt)

	var/obj/item/stack/material/steel/R = new(backpack)
	R.amount = 50
	R = new(backpack)
	R.amount = 50
	var/obj/item/stack/material/glass/G = new(backpack)
	G.amount = 50
	new /obj/item/weapon/plastique(backpack)
	new /obj/item/weapon/plastique(backpack)
	new /obj/item/weapon/plastique(backpack)
	new /obj/item/weapon/shovel/spade/russia(backpack)

	new /obj/item/ammo_magazine/mc9mm(armor_pockets)

	var/list/random_stuff = get_random_stuff(rand(1, 3))

	for(var/i = 1 to random_stuff.len)
		var/obj/item/item = random_stuff[i]
		switch(i)
			if(1)
				H.equip_to_slot_or_del(item, slot_r_store)
			if(2)
				item.loc = armor_pockets
			if(3)
				H.equip_to_slot_or_del(item, slot_l_store)

	return 1


/datum/job/engineer_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(20))
		H.add_language("English")
		H << "<b>You know English language!</b>"
	if(prob(5))
		var lang = pick("Serbian", "Bosnian", "Albanian")
		H.add_language(lang)
		H << "<b>You know [lang] language!</b>"

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

	var/obj/item/clothing/suit/storage/vest/heavy/ru/armor = new(H)
	var/obj/item/weapon/storage/internal/armor_pockets = armor.pockets
	var/obj/item/weapon/storage/backpack/backpack = new(H)

	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/tactical/ru(H), slot_head)
	H.equip_to_slot_or_del(backpack, slot_back)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/pkm(H), pick(slot_l_hand, slot_r_hand))
	H.equip_to_slot_or_del(armor, slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/radio/russia(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/pistol(H), slot_belt)

	for(var/i = 1 to 5)
		new /obj/item/ammo_magazine/a762/pkm(backpack)
	new /obj/item/ammo_magazine/mc9mm(backpack)

	new /obj/item/weapon/grenade/explosive/f1(armor_pockets)
	new /obj/item/weapon/grenade/explosive/f1(armor_pockets)
	new /obj/item/weapon/grenade/explosive/f1(armor_pockets)

	var/list/random_stuff = get_random_stuff(rand(1, 3))

	for(var/i = 1 to random_stuff.len)
		var/obj/item/item = random_stuff[i]
		switch(i)
			if(1)
				H.equip_to_slot_or_del(item, slot_r_store)
			if(2)
				item.loc = armor_pockets
			if(3)
				H.equip_to_slot_or_del(item, slot_l_store)

	return 1
	return 1

/datum/job/heavy_weapon_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(20))
		H.add_language("English")
		H << "<b>You know English language!</b>"
	if(prob(5))
		var lang = pick("Serbian", "Bosnian", "Albanian")
		H.add_language(lang)
		H << "<b>You know [lang] language!</b>"

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

	var/obj/item/weapon/storage/belt/security/belt = new(H)
	var/obj/item/clothing/suit/storage/vest/heavy/ru/armor = new(H)
	var/obj/item/weapon/storage/internal/armor_pockets = armor.pockets

	H.equip_to_slot_or_del(new /obj/item/clothing/under/ru_uniform(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/tactical/ru(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/akm(H), slot_back)
	H.equip_to_slot_or_del(belt, slot_belt)
	H.equip_to_slot_or_del(armor, slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/device/radio/russia(H), slot_s_store)

	for(var/i = 1 to 5)
		new /obj/item/ammo_magazine/a762/akm(belt)
	new /obj/item/device/flashlight/flare(belt)
	new /obj/item/weapon/shovel/spade/russia(belt)

	new /obj/item/weapon/storage/box/med_kit_ruforce/full(armor_pockets)
	new /obj/item/weapon/grenade/explosive/f1(armor_pockets)
	new /obj/item/weapon/grenade/explosive/f1(armor_pockets)

	var/list/random_stuff = get_random_stuff(rand(1, 3))

	for(var/i = 1 to random_stuff.len)
		var/obj/item/item = random_stuff[i]
		switch(i)
			if(1)
				H.equip_to_slot_or_del(item, slot_r_store)
			if(2)
				item.loc = armor_pockets
			if(3)
				H.equip_to_slot_or_del(item, slot_l_store)

	return 1

/datum/job/soldier_russian/update_character(var/mob/living/carbon/human/H)
	H.add_language("Russian")
	H.default_language = all_languages["Russian"]
	if(prob(20))
		H.add_language("English")
		H << "<b>You know English language!</b>"
	if(prob(5))
		var lang = pick("Serbian", "Bosnian", "Albanian")
		H.add_language(lang)
		H << "<b>You know [lang] language!</b>"


//////////////
/datum/job/gru
	title = "Spetsnaz GRU"
	flag = DETECTIVE
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
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
	H.default_language = all_languages["Russian"]
	if(prob(50))
		H.add_language("English")
		H << "<b>You know English language!</b>"
	if(prob(10))
		var lang = pick("Serbian", "Bosnian", "Albanian")
		H.add_language(lang)
		H << "<b>You know [lang] language!</b>"