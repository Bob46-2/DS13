var/global/datum/controller/gameticker/ticker

/datum/controller/gameticker
	var/const/restart_timeout = 600
	var/current_state = GAME_STATE_PREGAME
	var/force_ending = FALSE
	var/delay = 50

	var/start_ASAP = FALSE		  //the game will start as soon as possible, bypassing all pre-game nonsense


	var/hide_mode = 0
	var/datum/game_mode/mode = null
	var/post_game = 0
	var/event_time = null
	var/event = 0

	var/list/datum/mind/minds = list()//The people in the game. Used for objective tracking.

	var/Bible_icon_state	// icon_state the chaplain has chosen for his bible
	var/Bible_item_state	// item_state the chaplain has chosen for his bible
	var/Bible_name			// name of the bible
	var/Bible_deity_name

	var/random_players = 0 	// if set to nonzero, ALL players who latejoin or declare-ready join will have random appearances/genders

	var/list/syndicate_coalition = list() // list of traitor-compatible factions
	var/list/factions = list()			  // list of all factions
	var/list/availablefactions = list()	  // list of factions with openings

	var/pregame_timeleft = 0
	var/gamemode_voted = 0

	var/delay_end = 0	//if set to nonzero, the round will not restart on it's own

	var/triai = 0//Global holder for Triumvirate

	var/round_end_announced = 0 // Spam Prevention. Announce round end only once.

	var/looking_for_antags = 0
	var/bypass_gamemode_vote = FALSE

	var/round_start_time = 0

	var/totalPlayers = 0 //used for pregame stats on statpanel
	var/totalPlayersReady = 0 //used for pregame stats on statpanel

/datum/controller/gameticker/proc/pregame()
	do
		if(!gamemode_voted)
			pregame_timeleft = 180
		else
			pregame_timeleft = 15
			if(!isnull(secondary_mode))
				master_mode = secondary_mode
				secondary_mode = null
			else if(!isnull(tertiary_mode))
				master_mode = tertiary_mode
				tertiary_mode = null
			else
				master_mode = "extended"

		to_chat(world, "<span class='infoplain'><b>Trying to start [master_mode]...</b></span>")
		if (CONFIG_GET(flag/auto_start))
			start_ASAP = TRUE
		else
			to_chat(world, "<span class='infoplain'><B><FONT color='blue'>Welcome to the pre-game lobby!</FONT></B></span>")
			to_chat(world, "<span class='infoplain'>Please, setup your character and select ready. Game will start in [pregame_timeleft] seconds</span>")


		while(current_state == GAME_STATE_PREGAME)
			if(start_ASAP)
				start_now()
			for(var/i=0, i<10, i++)
				sleep(1)
				vote.process()
			if(round_progressing)
				pregame_timeleft--
			if(pregame_timeleft == CONFIG_GET(number/vote_autogamemode_timeleft) && !gamemode_voted && !bypass_gamemode_vote)
				gamemode_voted = 1
				if(!vote.time_remaining)
					vote.autogamemode()	//Quit calling this over and over and over and over.
					while(vote.time_remaining)
						for(var/i=0, i<10, i++)
							sleep(1)
							vote.process()

			totalPlayers = LAZYLEN(GLOB.new_player_list)
			totalPlayersReady = 0
			for(var/i in GLOB.new_player_list)
				var/mob/dead/new_player/player = i
				if(player.ready)
					++totalPlayersReady

			if(pregame_timeleft <= 0 || ((initialization_stage & INITIALIZATION_NOW_AND_COMPLETE) == INITIALIZATION_NOW_AND_COMPLETE))
				current_state = GAME_STATE_SETTING_UP
				Master.SetRunLevel(RUNLEVEL_SETUP)

	while (!setup())


/datum/controller/gameticker/proc/start_now(mob/user)

	initialization_stage |= INITIALIZATION_NOW
	bypass_gamemode_vote = TRUE
	vote.reset()

	return TRUE

/datum/controller/gameticker/proc/setup()
	//Create and announce mode
	if(master_mode=="secret")
		src.hide_mode = 1
	else
		src.hide_mode = 0

	if(master_mode=="secret")
		if(secret_force_mode != "secret")
			src.mode = config.pick_mode(secret_force_mode)
		if(!src.mode)
			src.mode = config.pick_mode(master_mode)
	else
		src.mode = config.pick_mode(master_mode)

	if(!src.mode)
		current_state = GAME_STATE_PREGAME
		Master.SetRunLevel(RUNLEVEL_LOBBY)
		to_chat(world, "<span class='danger'>Serious error in mode setup!</span> Reverting to pre-game lobby.")

		return FALSE

	job_master.ResetOccupations()
	src.mode.create_antagonists()
	src.mode.pre_setup()
	job_master.DivideOccupations() // Apparently important for new antagonist system to register specific job antags properly.

	var/t = src.mode.startRequirements()
	if(t)
		to_chat(world, "<span class='infoplain'><B>Unable to start [mode.name].</B> [t] Reverting to pre-game lobby.</span>")

		current_state = GAME_STATE_PREGAME
		Master.SetRunLevel(RUNLEVEL_LOBBY)
		mode.fail_setup()
		mode = null
		job_master.ResetOccupations()
		return FALSE

	if(hide_mode)
		to_chat(world, "<span class='infoplain'><B>The current game mode is - Secret!</B></span>")

	else
		src.mode.announce()

	GLOB.using_map.setup_economy()
	current_state = GAME_STATE_PLAYING
	Master.SetRunLevel(RUNLEVEL_GAME)
	create_characters() //Create player characters and transfer them
	collect_minds()
	equip_characters()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!H.mind || player_is_antag(H.mind, only_offstation_roles = 1) || !job_master.ShouldCreateRecords(H.mind.assigned_role))
			continue
		CreateModularRecord(H)

	callHook("roundstart")

	round_start_time = world.time

	//Here we will trigger the auto-observe and auto bst debug things
	if (CONFIG_GET(flag/auto_observe))
		for(var/client/C in GLOB.clients)
			if (C.mob)
				make_observer(C.mob)
	spawn(5)
		if (CONFIG_GET(flag/auto_bst))
			for(var/client/C in GLOB.clients)
				if (C.mob)
					C.cmd_dev_bst(TRUE)

		if (CONFIG_GET(flag/debug_verbs))
			for(var/client/C in GLOB.clients)
				C.enable_debug_verbs(TRUE)

	spawn(0)//Forking here so we dont have to wait for this to finish
		mode.post_setup()
		to_chat(world, "<span class='infoplain'><FONT color='blue'><B>Enjoy the game!</B></FONT></span>")
		SEND_SOUND(world, sound(GLOB.using_map.welcome_sound))

		//Holiday Round-start stuff	~Carn
		Holiday_Game_Start()

	var/admins_number = 0
	for(var/client/C)
		if(C.holder)
			admins_number++
	if(admins_number == 0)
		send2adminirc("Round has started with no admins online.")


	processScheduler.start()

	if(CONFIG_GET(flag/sql_enabled))
		statistic_cycle() // Polls population totals regularly and stores them in an SQL DB -- TLE

	return TRUE

/datum/controller/gameticker
	//station_explosion used to be a variable for every mob's hud. Which was a waste!
	//Now we have a general cinematic centrally held within the gameticker....far more efficient!
	var/atom/movable/screen/cinematic = null

	//Plus it provides an easy way to make cinematics for other events. Just use this as a template :)
	proc/station_explosion_cinematic(var/station_missed=0, var/override = null)
		if( cinematic )	return	//already a cinematic in progress!

		//initialise our cinematic screen object
		cinematic = new(src)
		cinematic.icon = 'icons/effects/station_explosion.dmi'
		cinematic.icon_state = "station_intact"
		cinematic.plane = HUD_PLANE
		cinematic.layer = HUD_ABOVE_ITEM_LAYER
		cinematic.mouse_opacity = 0
		cinematic.screen_loc = "1,0"

		var/obj/structure/bed/temp_buckle = new(src)
		//Incredibly hackish. It creates a bed within the gameticker (lol) to stop mobs running around
		if(station_missed)
			for(var/mob/living/M in GLOB.living_mob_list)
				M.buckled = temp_buckle				//buckles the mob so it can't do anything
				if(M.client)
					M.client.screen += cinematic	//show every client the cinematic
		else	//nuke kills everyone on z-level 1 to prevent "hurr-durr I survived"
			for(var/mob/living/M in GLOB.living_mob_list)
				M.buckled = temp_buckle
				if(M.client)
					M.client.screen += cinematic

				switch(M.z)
					if(0)	//inside a crate or something
						var/turf/T = get_turf(M)
						if(T && (T.z in GLOB.using_map.station_levels))				//we don't use M.death(0) because it calls a for(/mob) loop and
							M.health = 0
							M.set_stat(DEAD)
					if(1)	//on a z-level 1 turf.
						M.health = 0
						M.set_stat(DEAD)

		//Now animate the cinematic
		switch(station_missed)
			if(1)	//nuke was nearby but (mostly) missed
				if( mode && !override )
					override = mode.name
				switch( override )
					if("mercenary") //Nuke wasn't on station when it blew up
						flick("intro_nuke",cinematic)
						sleep(35)
						SEND_SOUND(world, sound('sound/effects/explosionfar.ogg'))
						flick("station_intact_fade_red",cinematic)
						cinematic.icon_state = "summary_nukefail"
					else
						flick("intro_nuke",cinematic)
						sleep(35)
						SEND_SOUND(world, sound('sound/effects/explosionfar.ogg'))
						//flick("end",cinematic)


			if(2)	//nuke was nowhere nearby	//TODO: a really distant explosion animation
				sleep(50)
				SEND_SOUND(world, sound('sound/effects/explosionfar.ogg'))
			else	//station was destroyed
				if( mode && !override )
					override = mode.name
				switch( override )
					if("mercenary") //Nuke Ops successfully bombed the station
						flick("intro_nuke",cinematic)
						sleep(35)
						flick("station_explode_fade_red",cinematic)
						SEND_SOUND(world, sound('sound/effects/explosionfar.ogg'))
						cinematic.icon_state = "summary_nukewin"
					if("AI malfunction") //Malf (screen,explosion,summary)
						flick("intro_malf",cinematic)
						sleep(76)
						flick("station_explode_fade_red",cinematic)
						SEND_SOUND(world, sound('sound/effects/explosionfar.ogg'))
						cinematic.icon_state = "summary_malf"
					if("blob") //Station nuked (nuke,explosion,summary)
						flick("intro_nuke",cinematic)
						sleep(35)
						flick("station_explode_fade_red",cinematic)
						SEND_SOUND(world, sound('sound/effects/explosionfar.ogg'))
						cinematic.icon_state = "summary_selfdes"
					else //Station nuked (nuke,explosion,summary)
						flick("intro_nuke",cinematic)
						sleep(35)
						flick("station_explode_fade_red", cinematic)
						SEND_SOUND(world, sound('sound/effects/explosionfar.ogg'))
						cinematic.icon_state = "summary_selfdes"
				for(var/mob/living/M in GLOB.living_mob_list)
					if(is_station_turf(get_turf(M)))
						M.death()//No mercy
		//If its actually the end of the round, wait for it to end.
		//Otherwise if its a verb it will continue on afterwards.
		sleep(300)

		if(cinematic)	qdel(cinematic)		//end the cinematic
		if(temp_buckle)	qdel(temp_buckle)	//release everybody
		return


	proc/create_characters()
		for(var/i in GLOB.new_player_list)
			var/mob/dead/new_player/player = i
			if(player?.ready && player?.mind)
				if(player.mind.assigned_role=="AI")
					player.close_spawn_windows()
					player.AIize()
				else if(!player.mind.assigned_role)
					continue
				else
					if(player.create_character())
						player.client?.init_verbs()
						qdel(player)


	proc/collect_minds()
		for(var/mob/living/player in GLOB.player_list)
			if(player.mind)
				ticker.minds += player.mind


	proc/equip_characters()
		var/captainless=1
		for(var/mob/living/carbon/human/player in GLOB.player_list)
			if(player && player.mind && player.mind.assigned_role)
				if(player.mind.assigned_role == "Captain")
					captainless=0
				if(!player_is_antag(player.mind, only_offstation_roles = 1))
					job_master.EquipRank(player, player.mind.assigned_role, 0)
					//equip_custom_items(player)
					equip_loadout(player, player.mind.assigned_role, player.client.prefs)
		if(captainless)
			for(var/mob/M in GLOB.player_list)
				if(!istype(M,/mob/dead/new_player))
					to_chat(M, "<span class='infoplain'>Captainship not forced on anyone.</span>")


	proc/process()
		if(current_state != GAME_STATE_PLAYING)
			return FALSE

		mode.process()

//		emergency_shuttle.process() //handled in scheduler

		var/game_finished = 0
		var/mode_finished = 0

		if (CONFIG_GET(flag/continous_rounds))
			game_finished = (evacuation_controller.round_over() || mode.station_was_nuked)
			mode_finished = (!post_game && mode.check_finished())
		else
			game_finished = (mode.check_finished() || (evacuation_controller.round_over() && evacuation_controller.emergency_evacuation) || universe_has_ended)
			mode_finished = game_finished

		if(!mode.explosion_in_progress && game_finished && (mode_finished || post_game) || force_ending)
			current_state = GAME_STATE_FINISHED
			Master.SetRunLevel(RUNLEVEL_POSTGAME)

			spawn
				declare_completion()


			spawn
				var/start_wait = world.time
				sleep(delay - (world.time - start_wait))

				if(CONFIG_GET(flag/allow_map_switching) && CONFIG_GET(flag/auto_map_vote) && GLOB.all_maps.len > 1)
					vote.automap()
					while(vote.time_remaining)
						sleep(50)

				callHook("roundend")
				if (universe_has_ended)
					if(mode.station_was_nuked)
						feedback_set_details("end_proper","nuke")
					else
						feedback_set_details("end_proper","universe destroyed")
					if(!delay_end)
						to_chat(world, "<span class='notice'><b>Rebooting due to destruction of [station_name()] in [restart_timeout/10] seconds</b></span>")

				else
					feedback_set_details("end_proper","proper completion")
					if(!delay_end)
						to_chat(world, "<span class='notice'><b>Restarting in [restart_timeout/10] seconds</b></span>")

				if(blackbox)
					blackbox.save_all_data_to_sql()

				var/wait_for_tickets
				var/delay_notified = 0
				do
					wait_for_tickets = 0
					for(var/datum/ticket/ticket in tickets)
						if(ticket.is_active())
							wait_for_tickets = 1
							break
					if(wait_for_tickets)
						if(!delay_notified)
							delay_notified = 1
							message_staff("<span class='warning'><b>Automatically delaying restart due to active tickets.</b></span>")
							to_chat(world, "<span class='notice'><b>An admin has delayed the round end</b></span>")
						sleep(15 SECONDS)
					else if(delay_notified)
						message_staff("<span class='warning'><b>No active tickets remaining, restarting in [restart_timeout/10] seconds if an admin has not delayed the round end.</b></span>")
				while(wait_for_tickets)

				if(!delay_end)
					sleep(restart_timeout)
					if(!delay_end)
						world.Reboot(ping=TRUE)
					else if(!delay_notified)
						to_chat(world, "<span class='notice'><b>An admin has delayed the round end</b></span>")
				else if(!delay_notified)
					to_chat(world, "<span class='notice'><b>An admin has delayed the round end</b></span>")


		else if (mode_finished)
			post_game = 1

			mode.cleanup()

			//call a transfer shuttle vote
			spawn(50)
				if(!round_end_announced) // Spam Prevention. Now it should announce only once.
					log_and_message_admins(": All antagonists are deceased or the gamemode has ended.") //Outputs as "Event: All antagonists are deceased or the gamemode has ended."
				vote.autotransfer()

		return TRUE

/datum/controller/gameticker/proc/declare_completion()
	to_chat(world, "<span class='infoplain'><br><br><br><span class='big bold'>A round of [mode.name] has ended!</span></span>")
	for(var/client/C)
		if(!C.credits)
			C.RollCredits()
	for(var/mob/Player in GLOB.player_list)
		if(Player.mind && !isnewplayer(Player))
			if(Player.stat != DEAD)
				var/turf/playerTurf = get_turf(Player)
				if(evacuation_controller.round_over() && evacuation_controller.emergency_evacuation)
					if(isNotAdminLevel(playerTurf.z))
						to_chat(Player, "<span class='infoplain'><font color='blue'><b>You managed to survive, but were marooned on [station_name()] as [Player.real_name]...</b></font></span>")
					else
						to_chat(Player, "<span class='infoplain'><font color='green'><b>You managed to survive the events on [station_name()] as [Player.real_name].</b></font></span>")
				else if(isAdminLevel(playerTurf.z))
					to_chat(Player, "<span class='infoplain'><font color='green'><b>You successfully underwent crew transfer after events on [station_name()] as [Player.real_name].</b></font></span>")
				else if(issilicon(Player))
					to_chat(Player, "<span class='infoplain'><font color='green'><b>You remain operational after the events on [station_name()] as [Player.real_name].</b></font></span>")
				else
					to_chat(Player, "<span class='infoplain'><font color='blue'><b>You got through just another workday on [station_name()] as [Player.real_name].</b></font></span>")
			else
				if(isghost(Player))
					var/mob/dead/observer/ghost/O = Player
					if(!O.started_as_observer)
						to_chat(Player, "<span class='infoplain'><font color='red'><b>You did not survive the events on [station_name()]...</b></font></span>")
				else
					to_chat(Player, "<span class='infoplain'><font color='red'><b>You did not survive the events on [station_name()]...</b></font></span>")
	to_chat(world, "<br>")


	for (var/mob/living/silicon/ai/aiPlayer in SSmobs.mob_list)
		if (aiPlayer.stat != 2)
			to_chat(world, "<span class='infoplain'><b>[aiPlayer.name] (Played by: [aiPlayer.key])'s laws at the end of the round were:</b></span>")

		else
			to_chat(world, "<span class='infoplain'><b>[aiPlayer.name] (Played by: [aiPlayer.key])'s laws when it was deactivated were:</b></span>")

		aiPlayer.show_laws(1)

		if (aiPlayer.connected_robots.len)
			var/robolist = "<span class='infoplain'><b>The AI's loyal minions were:</b></span> "
			for(var/mob/living/silicon/robot/robo in aiPlayer.connected_robots)
				robolist += "[robo.name][robo.stat?" (Deactivated) (Played by: [robo.key]), ":" (Played by: [robo.key]), "]"
			to_chat(world, "<span class='infoplain'>[robolist]</span>")


	var/dronecount = 0

	for (var/mob/living/silicon/robot/robo in SSmobs.mob_list)

		if(istype(robo,/mob/living/silicon/robot/drone))
			dronecount++
			continue

		if (!robo.connected_ai)
			if (robo.stat != 2)
				to_chat(world, "<span class='infoplain'><b>[robo.name] (Played by: [robo.key]) survived as an AI-less synthetic! Its laws were:</b></span>")

			else
				to_chat(world, "<span class='infoplain'><b>[robo.name] (Played by: [robo.key]) was unable to survive the rigors of being a synthetic without an AI. Its laws were:</b></span>")


			if(robo) //How the hell do we lose robo between here and the world messages directly above this?
				robo.laws.show_laws(world)

	if(dronecount)
		to_chat(world, "<span class='infoplain'><b>There [dronecount>1 ? "were" : "was"] [dronecount] industrious maintenance [dronecount>1 ? "drones" : "drone"] at the end of this round.</b></span>")

	if(all_money_accounts.len)
		var/datum/money_account/max_profit = all_money_accounts[1]
		var/datum/money_account/max_loss = all_money_accounts[1]
		for(var/datum/money_account/D in all_money_accounts)
			if(D == vendor_account) //yes we know you get lots of money
				continue
			var/saldo = D.get_balance()
			if(saldo >= max_profit.get_balance())
				max_profit = D
			if(saldo <= max_loss.get_balance())
				max_loss = D
		to_chat(world, "<span class='infoplain'><b>[max_profit.owner_name]</b> received most <font color='green'><B>PROFIT</B></font> today, with net profit of <b>T[max_profit.get_balance()]</b>.")
		to_chat(world, "<span class='infoplain'>On the other hand, <b>[max_loss.owner_name]</b> had most <font color='red'><B>LOSS</B></font>, with total loss of <b>T[max_loss.get_balance()]</b>.")

	mode.declare_completion()//To declare normal completion.

	//Ask the event manager to print round end information
	SSevent.RoundEnd()

	//Print a list of antagonists to the server log
	var/list/total_antagonists = list()
	//Look into all mobs in world, dead or alive
	for(var/datum/mind/Mind in minds)
		var/temprole = Mind.special_role
		if(temprole)							//if they are an antagonist of some sort.
			if(temprole in total_antagonists)	//If the role exists already, add the name to it
				total_antagonists[temprole] += ", [Mind.name]([Mind.key])"
			else
				total_antagonists.Add(temprole) //If the role doesnt exist in the list, create it and add the mob
				total_antagonists[temprole] += ": [Mind.name]([Mind.key])"

	//Now print them all into the log!
	log_game("Antagonists at round end were...")
	for(var/i in total_antagonists)
		log_game("[i]s[total_antagonists[i]].")

	return TRUE

/datum/controller/gameticker/proc/attempt_late_antag_spawn(var/list/antag_choices)
	var/datum/antagonist/antag = antag_choices[1]
	while(antag_choices.len && antag)
		var/needs_ghost = antag.flags & (ANTAG_OVERRIDE_JOB | ANTAG_OVERRIDE_MOB)
		if (needs_ghost)
			looking_for_antags = 1
			to_chat(world, "<b>A ghost is needed to spawn \a [antag.role_text].</b>\nGhosts may enter the antag pool by making sure their [antag.role_text] preference is set to high, then using the toggle-add-antag-candidacy verb. You have 3 minutes to enter the pool.")

			sleep(3 MINUTES)
			looking_for_antags = 0
			antag.update_current_antag_max()
			antag.build_candidate_list(needs_ghost)
			/*
			for(var/datum/mind/candidate in antag.candidates)
				if(!(candidate in antag_pool))
					antag.candidates -= candidate
					log_debug("[candidate.key] was not in the antag pool and could not be selected.")
			*/
		else
			antag.update_current_antag_max()
			antag.build_candidate_list(needs_ghost)
			for(var/datum/mind/candidate in antag.candidates)
				if(isghostmind(candidate))
					antag.candidates -= candidate
					log_debug("[candidate.key] is a ghost and can not be selected.")
		if(length(antag.candidates) >= antag.initial_spawn_req)
			antag.attempt_spawn()
			antag.finalize_spawn()
			GLOB.additional_antag_types.Add(antag.id)
			return TRUE
		else
			if(antag.initial_spawn_req > 1)
				to_chat(world, "Failed to find enough [antag.role_text_plural].")

			else
				to_chat(world, "Failed to find a [antag.role_text].")

			antag_choices -= antag
			if(length(antag_choices))
				antag = antag_choices[1]
				if(antag)
					to_chat(world, "Attempting to spawn [antag.role_text_plural].")

	return FALSE

/datum/controller/gameticker/proc/HasRoundStarted()
	return current_state >= GAME_STATE_PLAYING


/datum/controller/gameticker/proc/IsRoundInProgress()
	return current_state == GAME_STATE_PLAYING