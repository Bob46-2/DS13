/obj/item/device/personal_shield
	name = "personal shield"
	desc = "Truely a life-saver: this device protects its user from being hit by objects moving very, very fast, though only for a few shots."
	icon = 'icons/obj/device.dmi'
	icon_state = "batterer"
	var/uses = 5
	var/obj/aura/personal_shield/device/shield

/obj/item/device/personal_shield/attack_self(var/mob/living/user)
	if(uses)
		shield = new(user,src)
	else
		QDEL_NULL(shield)

/obj/item/device/personal_shield/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, var/glide_size_override = 0)
	QDEL_NULL(shield)
	return ..()

/obj/item/device/personal_shield/forceMove(atom/destination, var/special_event, glide_size_override=0)
	QDEL_NULL(shield)
	return ..()

/obj/item/device/personal_shield/proc/take_charge()
	if(!--uses)
		QDEL_NULL(shield)
		to_chat(loc,"<span class='danger'>\The [src] begins to spark as it breaks!</span>")
		update_icon()
		return

/obj/item/device/personal_shield/update_icon()
	if(uses)
		icon_state = "batterer"
	else
		icon_state = "battererburnt"

/obj/item/device/personal_shield/Destroy()
	QDEL_NULL(shield)
	return ..()