/*
/obj/item/cyber/limb_connector
	name = "Universal limb connector"

	size = 2 //External part

/obj/item/cyber/limb_connector/check_requirements(var/target_loc, var/mob/living/carbon/target_mob = null)
	if(!target_mob)
		return "\red [name] cannot be attached to single organ."

	if(!target_loc)
		return "\red Target is not found. This is a bug."

	if(target_organ)
		if(!istype(target_organ, /obj/item/organ/external))
			return "\red [name] cannot be attached to internal organ."
		var/obj/item/organ/external/ext = target_organ
		if(!(ext.limb_name in list("r_leg", "r_arm", "l_leg", "l_arm"))
			return "\red [name] can be attached only to shoulder or groin"
		return "\red Area of [target_organ.name] must be cleared before installing [name]"
*/