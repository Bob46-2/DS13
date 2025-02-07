/mob/living/simple_animal
	name = "animal"
	icon = 'icons/mob/animal.dmi'
	health = 20
	max_health = 20

	mob_bump_flag = SIMPLE_ANIMAL
	mob_swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	mob_push_flags = MONKEY|SLIME|SIMPLE_ANIMAL

	var/show_stat_health = 1	//does the percentage health show in the stat panel for the mob

	var/icon_living = ""
	var/icon_dead = ""
	var/icon_gib = null	//We only try to show a gibbing animation if this exists.

	var/list/speak = list("...")
	var/speak_chance = 0
	var/list/emote_hear = list()	//Hearable emotes
	var/list/emote_see = list()		//Unlike speak_emote, the list of things in this variable only show by themselves with no spoken text. IE: Ian barks, Ian yaps

	var/turns_per_move = 1
	var/turns_since_move = 0
	universal_speak = 0		//No, just no.
	var/meat_amount = 0
	var/meat_type
	var/stop_automated_movement = 0 //Use this to temporarely stop random movement or to if you write special movement code for animals.
	var/wander = 1	// Does the mob wander around when idle?
	var/stop_automated_movement_when_pulled = 1 //When set to 1 this stops the animal from moving when someone is pulling it.

	//Interaction
	var/response_help   = "tries to help"
	var/response_disarm = "tries to disarm"
	var/response_harm   = "tries to hurt"
	var/response_stomp = "stomps on"
	var/harm_intent_damage = 3
	var/can_escape = 0 // 'smart' simple animals such as human enemies, or things small, big, sharp or strong enough to power out of a net
	var/stompable = FALSE

	//Temperature effect
	var/minbodytemp = 250
	var/maxbodytemp = 350
	var/heat_damage_per_tick = 3	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	var/cold_damage_per_tick = 2	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp
	var/fire_alert = 0

	//Atmos effect - Yes, you can make creatures that require phoron or co2 to survive. N2O is a trace gas and handled separately, hence why it isn't here. It'd be hard to add it. Hard and me don't mix (Yes, yes make all the dick jokes you want with that.) - Errorage
	var/min_gas = list("oxygen" = 5)
	var/max_gas = list(MATERIAL_PHORON = 1, "carbon_dioxide" = 5)
	var/unsuitable_atoms_damage = 2	//This damage is taken when atmos doesn't fit all the requirements above
	var/speed = 4 //Metres per second

	//LETTING SIMPLE ANIMALS ATTACK? WHAT COULD GO WRONG. Defaults to zero so Ian can still be cuddly
	var/melee_damage_lower = 0
	var/melee_damage_upper = 0
	var/attacktext = "attacked"
	var/attack_sound = null
	var/friendly = "nuzzles"
	var/environment_smash = 0
	var/resistance		  = 0	// Damage reduction
	var/damtype = BRUTE
	var/defense = "melee" //what armor protects against its attacks

	//Null rod stuff
	var/supernatural = 0
	var/purge = 0

	// contained in a cage
	var/in_stasis = 0

/mob/living/simple_animal/New(var/atom/location)
	health = max_health
	.=..()

/mob/living/simple_animal/Life()
	..()
	if(!living_observers_present(GetConnectedZlevels(z)))
		return
	//Health
	if(stat == DEAD)
		if(health > 0)
			icon_state = icon_living
			switch_from_dead_to_living_mob_list()
			set_stat(CONSCIOUS)
			set_density(1)
		return 0

	if(health <= 0)
		death()
		return

	if(health > max_health)
		health = max_health


	handle_stunned()
	handle_weakened()
	handle_paralysed()
	handle_confused()
	handle_supernatural()
	handle_impaired_vision()

	if(buckled && can_escape)
		if(istype(buckled, /obj/effect/energy_net))
			var/obj/effect/energy_net/Net = buckled
			Net.escape_net(src)
		else if(prob(50))
			escape(src, buckled)
		else if(prob(50))
			visible_message("<span class='warning'>\The [src] struggles against \the [buckled]!</span>")

	//Movement
	if(!client && !stop_automated_movement && wander && !anchored)
		if(isturf(src.loc) && !resting)		//This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				if(!(stop_automated_movement_when_pulled && pulledby)) //Some animals don't move when pulled
					SelfMove(pick(GLOB.cardinal))
					turns_since_move = 0

	//Speaking
	if(!client && speak_chance)
		if(rand(0,200) < speak_chance)
			var/action = pick(
				speak.len;      "speak",
				emote_hear.len; "emote_hear",
				emote_see.len;  "emote_see"
				)

			switch(action)
				if("speak")
					say(pick(speak))
				if("emote_hear")
					audible_emote("[pick(emote_hear)].")
				if("emote_see")
					visible_emote("[pick(emote_see)].")

	if(in_stasis)
		return 1 // return early to skip atmos checks

	//Atmos
	var/atmos_suitable = 1

	var/atom/A = loc
	if(!loc)
		return 1
	var/datum/gas_mixture/environment = A.return_air()

	if(!(SPACERES in mutations) && environment)
		if( abs(environment.temperature - bodytemperature) > 40 )
			bodytemperature += (environment.temperature - bodytemperature) / 5
		if(min_gas)
			for(var/gas in min_gas)
				if(environment.gas[gas] < min_gas[gas])
					atmos_suitable = 0
		if(max_gas)
			for(var/gas in max_gas)
				if(environment.gas[gas] > max_gas[gas])
					atmos_suitable = 0

	//Atmos effect
	if(bodytemperature < minbodytemp)
		fire_alert = 2
		adjustBruteLoss(cold_damage_per_tick)
	else if(bodytemperature > maxbodytemp)
		fire_alert = 1
		adjustBruteLoss(heat_damage_per_tick)
	else
		fire_alert = 0

	if(!atmos_suitable)
		adjustBruteLoss(unsuitable_atoms_damage)
	return 1

/mob/living/simple_animal/proc/escape(mob/living/M, obj/O)
	O.unbuckle_mob(M)
	visible_message("<span class='danger'>\The [M] escapes from \the [O]!</span>")

/mob/living/simple_animal/proc/handle_supernatural()
	if(purge)
		purge -= 1

/mob/living/simple_animal/gib()
	..(icon_gib,1)

/mob/living/simple_animal/proc/visible_emote(var/act_desc)
	custom_emote(1, act_desc)

/mob/living/simple_animal/proc/audible_emote(var/act_desc)
	custom_emote(2, act_desc)

/mob/living/simple_animal/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj || Proj.nodamage)
		return

	var/damage = Proj.damage
	if(Proj.damtype == STUN)
		damage = (Proj.damage / 8)

	adjustBruteLoss(damage)
	Proj.on_hit(src)
	return 0

/mob/living/simple_animal/attack_hand(mob/living/M as mob)
	..()
	var/mob/living/carbon/human/H = null
	if (ishuman(M))
		H = M
	switch(M.a_intent)

		if(I_HELP)
			if (health > 0)
				M.visible_message("<span class='notice'>[M] [response_help] \the [src].</span>")

		if(I_GRAB)
			if (H)//Only humans can grab
				if (!H.can_grasp_with_selected())
					to_chat(H, "<span class='warning'>You can't use your hand.</span>")
					return
				return H.grab(src)

		if(I_DISARM)
			M.visible_message("<span class='notice'>[M] [response_disarm] \the [src].</span>")
			M.do_attack_animation(src)
			//TODO: Push the mob away or something

		if(I_HURT)
			//Small animals on the floor can be stomped on
			if (stompable && !is_mounted() && isturf(loc) && H && !H.lying)
				var/damage = harm_intent_damage
				if (H && H.shoes && H.shoes.force)
					damage += H.shoes.force


				shake_animation(30)
				shake_camera(src, 6, 1.5)

				shake_camera(H, 3, 1)

				var/turf/T = get_turf(src)
				T.shake_animation(30)
				adjustBruteLoss(damage)
				M.visible_message("<span class='warning'>[M] [response_stomp] \the [src]!</span>")
				M.do_attack_animation(src)
				M.add_click_cooldown(DEFAULT_ATTACK_COOLDOWN*1.5)
				//TODO Here: Stomping audio
			else
				adjustBruteLoss(harm_intent_damage)
				M.visible_message("<span class='warning'>[M] [response_harm] \the [src]!</span>")
				M.do_attack_animation(src)



	return

/mob/living/simple_animal/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/stack/medical))
		if(stat != DEAD)
			var/obj/item/stack/medical/MED = O
			if(!MED.animal_heal)
				to_chat(user, "<span class='notice'>That [MED] won't help \the [src] at all!</span>")
				return
			if(health < max_health)
				if(MED.can_use(1))
					adjustBruteLoss(-MED.animal_heal)
					visible_message("<span class='notice'>[user] applies the [MED] on [src].</span>")
					MED.use(1)
		else
			to_chat(user, "<span class='notice'>\The [src] is dead, medical items won't bring \him back to life.</span>")
		return
	if(meat_type && (stat == DEAD))	//if the animal has a meat, and if it is dead.
		if(O.edge)
			harvest(user)
	else
		if(!O.force)
			visible_message("<span class='notice'>[user] gently taps [src] with \the [O].</span>")
		else
			O.attack(src, user, get_zone_sel(user))

/mob/living/simple_animal/standard_weapon_hit_effects(obj/item/O, mob/living/user, var/effective_force, var/blocked, var/hit_zone)



	if(effective_force <= resistance)
		to_chat(user, "<span class='danger'>This weapon is ineffective; it does no damage.</span>")
		return 2

	visible_message("<span class='danger'>\The [src] has been attacked with \the [O] by [user]!</span>")

	if (O.damtype == PAIN)
		effective_force = 0
	if (O.damtype == STUN)
		effective_force /= 8
	adjustBruteLoss(effective_force)

	return 0

/mob/living/simple_animal/movement_delay()
	var/tally = 1 SECOND
	if (speed)
		tally /= speed
	if (move_speed_factor)
		tally /= move_speed_factor

	set_glide_size(DELAY2GLIDESIZE(tally))

	return tally



/mob/living/simple_animal/update_icon()
	icon_state = icon_living
	if (icon_dead && (lying || stat))
		var/list/icons = list()
		icons += icon_dead //This accounts for the dead icon being single or list
		icon_state = pick(icons)
		return



/mob/living/simple_animal/death(gibbed, deathmessage = "dies!", show_dead_message)
	update_icon()
	density = 0
	walk_to(src,0)
	.= ..(gibbed,deathmessage,show_dead_message)

/mob/living/simple_animal/ex_act(severity)
	if(!blinded)
		flash_eyes()

	var/damage
	switch (severity)
		if (1.0)
			damage = 500
			if(!prob(getarmor(null, "bomb")))
				gib()

		if (2.0)
			damage = 120

		if(3.0)
			damage = 30

	adjustBruteLoss(damage * blocked_mult(getarmor(null, "bomb")))

/mob/living/simple_animal/adjustBruteLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/adjustFireLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/adjustToxLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/adjustOxyLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/proc/SA_attackable(target_mob)
	if (isliving(target_mob))
		var/mob/living/L = target_mob
		if(!L.stat && L.health >= 0)
			return (0)
	if (istype(target_mob,/obj/mecha))
		var/obj/mecha/M = target_mob
		if (M.occupant)
			return (0)
	return 1

/mob/living/simple_animal/say(var/message)
	var/verb = "says"
	if(speak_emote.len)
		verb = pick(speak_emote)

	message = sanitize(message)

	..(message, null, verb)

/mob/living/simple_animal/get_speech_ending(verb, var/ending)
	return verb

/mob/living/simple_animal/put_in_hands(var/obj/item/W) // No hands.
	W.loc = get_turf(src)
	return 1

// Harvest an animal's delicious byproducts
/mob/living/simple_animal/proc/harvest(var/mob/user)
	var/actual_meat_amount = max(1,(meat_amount/2))
	if(meat_type && actual_meat_amount>0 && (stat == DEAD))
		for(var/i=0;i<actual_meat_amount;i++)
			var/obj/item/meat = new meat_type(get_turf(src))
			meat.SetName("[src.name] [meat.name]")
		if(issmall(src))
			user.visible_message("<span class='danger'>[user] chops up \the [src]!</span>")
			new/obj/effect/decal/cleanable/blood/splatter(get_turf(src))
			qdel(src)
		else
			user.visible_message("<span class='danger'>[user] butchers \the [src] messily!</span>")
			gib()

/mob/living/simple_animal/handle_fire()
	return

/mob/living/simple_animal/update_fire()
	return
/mob/living/simple_animal/IgniteMob()
	return
/mob/living/simple_animal/ExtinguishMob()
	return

/mob/living/simple_animal/is_burnable()
	return heat_damage_per_tick


/*
	Animals
*/
/mob/living/simple_animal/UnarmedAttack(var/atom/A, var/proximity)

	if(!..())
		return
	do_attack_animation(A)
	if(istype(A,/mob/living))
		if(melee_damage_upper == 0)
			custom_emote(1,"[friendly] [A]!")
			return
		if(ckey)
			admin_attack_log(src, A, "Has [attacktext] its victim.", "Has been [attacktext] by its attacker.", attacktext)
	set_click_cooldown(DEFAULT_ATTACK_COOLDOWN)
	var/damage = rand(melee_damage_lower, melee_damage_upper)
	launch_strike(target = A, damage = damage, used_weapon = src, damage_flags = 0, armor_penetration = 0, damage_type = BRUTE, armor_type = "melee", target_zone = get_zone_sel(src), difficulty = 0)
	playsound(loc, attack_sound, VOLUME_MID, TRUE)

	//if(A.attack_generic(src, damage, attacktext, environment_smash, damtype, defense) && loc && attack_sound)



/*
	Temperature handling
*/

/mob/living/simple_animal/get_cold_protection(var/temperature)
	if (temperature > minbodytemp)
		return 1

	else if (temperature != 0)
		return temperature / maxbodytemp

	else
		return 1 //Special case for 0 temperature

/mob/living/simple_animal/get_heat_protection(var/temperature)
	var/limit = get_heat_limit()
	if (temperature < limit)
		return 1
	else if (temperature != 0)
		return limit / temperature
	else
		return 1 //Special case for 0 temperature

/mob/living/simple_animal/get_heat_limit()
	return maxbodytemp