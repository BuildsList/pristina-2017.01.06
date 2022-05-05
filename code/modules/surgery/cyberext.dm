/datum/surgery_step/cyber_ext
	can_infect = 0
	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!hasorgans(target))
			return 0

		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if (!affected)
			return 0

		return 1

/datum/surgery_step/cyber_ext/install
	allowed_tools = list(/obj/item/cyber = 100)

	min_duration = 90
	max_duration = 110

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		var/obj/item/cyber/c = tool
		var/text = c.check_requirements(affected, target)
		if(text)
			user << text
			return 0
		return ..()

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/cyber/c = tool
		user.visible_message("[user] starts to install the [c.name].", \
		"You start to install the [c.name].")
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/cyber/c = tool
		user.visible_message("\blue [user] has installed the [c.name]." , \
		"\blue You have installed the [c.name].",)

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/cyber/c = tool
		user.visible_message("\red [user]'s damaged [c.name]!" , \
		"\red Your hand slips, damaging [c.name]!" )
		c.take_damage(10)