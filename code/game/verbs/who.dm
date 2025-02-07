
/client/verb/who()
	set name = "Who"
	set category = "OOC"

	var/msg = "<b>Current Players:</b>\n"

	var/list/Lines = list()

	if(check_rights(R_INVESTIGATE, 0))
		for(var/client/C in GLOB.clients)
			var/entry = "\t[C.key]"
			if(!C.mob) //If mob is null, print error and skip rest of info for client.
				entry += " - <font color='red'><i>HAS NO MOB</i></font>"
				Lines += entry
				continue

			entry += " - Playing as [C.mob.real_name]"
			switch(C.mob.stat)
				if(UNCONSCIOUS)
					entry += " - <font color='darkgray'><b>Unconscious</b></font>"
				if(DEAD)
					if(isghost(C.mob))
						var/mob/dead/observer/ghost/O = C.mob
						if(O.started_as_observer)
							entry += " - <font color='gray'>Observing</font>"
						else
							entry += " - <font color='black'><b>DEAD</b></font>"
					else
						entry += " - <font color='black'><b>DEAD</b></font>"

			var/age
			if(isnum(C.player_age))
				age = C.player_age
			else
				age = 0

			if(age <= 1)
				age = "<font color='#ff0000'><b>[age]</b></font>"
			else if(age < 10)
				age = "<font color='#ff8c00'><b>[age]</b></font>"

			entry += " - [age]"

			if(is_special_character(C.mob))
				entry += " - <b><font color='red'>Antagonist</font></b>"
			if(C.is_afk())
				entry += " (AFK - [C.inactivity2text()])"
			entry += " (<A HREF='?_src_=holder;adminmoreinfo=\ref[C.mob]'>?</A>)"
			Lines += entry
	else
		for(var/client/C in GLOB.clients)
			if(!C.is_stealthed())
				Lines += C.key

	for(var/line in sortList(Lines))
		msg += "[line]\n"

	msg += "<b>Total Players: [length(Lines)]</b>"
	to_chat(src, msg)


// Staffwho verb. Displays online staff. Hides stealthed or AFK staff members automatically.
/client/verb/staffwho()
	set category = "Admin"
	set name = "StaffWho"
	var/adminwho = ""
	var/modwho = ""
	var/mentwho = ""
	var/devwho = ""
	var/admin_count = 0
	var/mod_count = 0
	var/ment_count = 0
	var/dev_count = 0

	for(var/client in GLOB.admins)
		var/client/C = client
		if(C.is_stealthed() && !check_rights(R_MOD|R_ADMIN, 0, src)) // Normal players and mentors can't see stealthmins
			continue

		var/extra = ""
		if(holder)
			if(C.is_stealthed())
				extra += " (Stealthed)"
			if(isobserver(C.mob))
				extra += " - Observing"
			else if(istype(C.mob,/mob/dead/new_player))
				extra += " - Lobby"
			else
				extra += " - Playing"
			if(C.is_afk())
				extra += " (AFK)"

		if(R_ADMIN & C.holder.rights)
			adminwho += "\t[C] is a <b>[C.holder.rank]</b>[extra]\n"
			admin_count++
		else if (R_MOD & C.holder.rights)
			modwho += "\t[C] is a <i>[C.holder.rank]</i>[extra]\n"
			mod_count++
		else if (R_MENTOR & C.holder.rights)
			mentwho += "\t[C] is a [C.holder.rank][extra]\n"
			ment_count++
		else if (R_DEBUG & C.holder.rights)
			devwho += "\t[C] is a [C.holder.rank][extra]\n"
			dev_count++

	to_chat(src, "<b><big>Online staff:</big></b>")
	to_chat(src, "<b>Current Admins ([admin_count]):</b><br>[adminwho]<br>")
	to_chat(src, "<b>Current Moderators ([mod_count]):</b><br>[modwho]<br>")
	to_chat(src, "<b>Current Mentors ([ment_count]):</b><br>[mentwho]<br>")
	to_chat(src, "<b>Current Developers ([dev_count]):</b><br>[devwho]<br>")