// Pretty much everything here is stolen from the dna scanner FYI

/obj/machinery/bodyscanner
	name = "Body Scanner"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "body_scanner_0"
	density = 1
	anchored = 1
	circuit = /obj/item/weapon/circuitboard/body_scanner
	idle_power_usage = 60
	active_power_usage = 10000	//10 kW. It's a big all-body scanner.
	light_color = "#00FF00"
	var/locked
	var/datum/advanced_scanner/AS

/obj/machinery/bodyscanner/Initialize()
	. = ..()
	AS = new /datum/advanced_scanner()
	AS.BS = src

/obj/machinery/bodyscanner/Destroy()
	QDEL_NULL(AS)
	. = ..()

/obj/machinery/bodyscanner/attack_hand(mob/user)
	return AS.tgui_interact(user)

/obj/machinery/bodyscanner/attack_ai(mob/user)
	return AS.tgui_interact(user)

/obj/machinery/bodyscanner/attackby(var/obj/item/G, user as mob)
	if(istype(G, /obj/item/grab))
		var/obj/item/grab/H = G
		if(panel_open)
			to_chat(user, "<span class='notice'>Close the maintenance panel first.</span>")
			return
		if(!ismob(H.affecting))
			return
		if(!ishuman(H.affecting))
			to_chat(user, "<span class='warning'>\The [src] is not designed for that organism!</span>")
			return
		if(AS.occupant)
			to_chat(user, "<span class='notice'>\The [src] is already occupied!</span>")
			return
		var/mob/M = H.affecting
		if(M.abiotic())
			to_chat(user, "<span class='notice'>Subject cannot have abiotic items on.</span>")
			return
		M.forceMove(src)
		AS.occupant = M
		icon_state = "body_scanner_1"
		playsound(src, 'sound/machines/medbayscanner1.ogg', 50) // Beepboop you're being scanned. <3
		add_fingerprint(user)
		qdel(G)
		SStgui.update_uis(src)
	if(!AS.occupant)
		if(default_deconstruction_screwdriver(user, G))
			return
		if(default_deconstruction_crowbar(user, G))
			return

/obj/machinery/bodyscanner/MouseDrop_T(mob/living/carbon/human/O, mob/user as mob)
	if(!istype(O))
		return 0 //not a mob
	if(user.incapacitated())
		return 0 //user shouldn't be doing things
	if(O.anchored)
		return 0 //mob is anchored???
	if(get_dist(user, src) > 1 || get_dist(user, O) > 1)
		return 0 //doesn't use adjacent() to allow for non-cardinal (fuck my life)
	if(!ishuman(user) && !isrobot(user))
		return 0 //not a borg or human
	if(panel_open)
		to_chat(user, "<span class='notice'>Close the maintenance panel first.</span>")
		return 0 //panel open
	if(AS.occupant)
		to_chat(user, "<span class='notice'>\The [src] is already occupied.</span>")
		return 0 //occupied

	if(O.buckled)
		return 0
	if(O.abiotic())
		to_chat(user, "<span class='notice'>Subject cannot have abiotic items on.</span>")
		return 0

	if(O == user)
		visible_message("[user] climbs into \the [src].")
	else
		visible_message("[user] puts [O] into the body scanner.")

	O.forceMove(src)
	AS.occupant = O
	icon_state = "body_scanner_1"
	playsound(src, 'sound/machines/medbayscanner1.ogg', 50) // Beepboop you're being scanned. <3
	add_fingerprint(user)
	SStgui.update_uis(src)

/obj/machinery/bodyscanner/relaymove(mob/user as mob)
	if(user.incapacitated())
		return 0 //maybe they should be able to get out with cuffs, but whatever
	go_out()

/obj/machinery/bodyscanner/verb/eject()
	set src in oview(1)
	set category = "Object"
	set name = "Eject Body Scanner"

	if(usr.incapacitated())
		return
	go_out()
	add_fingerprint(usr)

/obj/machinery/bodyscanner/proc/go_out()
	if ((!(AS.occupant) || src.locked))
		return
	if (AS.occupant.client)
		AS.occupant.client.eye = AS.occupant.client.mob
		AS.occupant.client.perspective = MOB_PERSPECTIVE
	AS.occupant.loc = src.loc
	AS.occupant = null
	icon_state = "body_scanner_1"
	SStgui.update_uis(src)
	return

/obj/machinery/bodyscanner/ex_act(severity)
	switch(severity)
		if(1.0)
			for(var/atom/movable/A as mob|obj in src)
				A.loc = src.loc
				ex_act(severity)
				//Foreach goto(35)
			//SN src = null
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(108)
				//SN src = null
				qdel(src)
				return
		if(3.0)
			if (prob(25))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(181)
				//SN src = null
				qdel(src)
				return
		else
	return

/datum/advanced_scanner
	var/mob/living/carbon/human/occupant
	var/obj/machinery/bodyscanner/BS
	var/obj/item/device/adv_health_analyzer/AHA
	var/known_implants = list(/obj/item/weapon/implant/chem, /obj/item/weapon/implant/death_alarm, /obj/item/weapon/implant/tracking)

/datum/advanced_scanner/ui_host(mob/user)
	if(BS)
		return BS
	else if(AHA)
		return AHA
	return src

/datum/advanced_scanner/ui_status(user, state)
	if(BS)
		return ..()
	else if(AHA)
		. = ..()
		if(. != UI_INTERACTIVE||get_dist(occupant, AHA) > 1)
			occupant = null
	else
		return UI_INTERACTIVE

/datum/advanced_scanner/tgui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if(BS)
		if(!ui)
			ui = new(user, src, "BodyScanner", "Body Scanner")
			ui.open()

	else if(AHA)
		if(!ui)
			ui = new(user, src, "BodyScanner", "Advanced Health Analyzer")
			ui.open()

	else
		if(!ui)
			ui = new(user, src, "BodyScanner", "Health Scanner")
			ui.open()

/datum/advanced_scanner/ui_close(mob/user)
	if(!BS&&!AHA)
		qdel(src)

/datum/advanced_scanner/ui_data(mob/user)
	var/list/data = list()

	data["has_scanner"] = BS ? TRUE : FALSE

	data["portable_scanner"] = AHA ? TRUE : FALSE

	data["occupied"] = occupant ? TRUE : FALSE

	var/occupantData[0]
	if(occupant && ishuman(occupant))
		if(BS)
			BS.icon_state = "body_scanner_1"
		var/mob/living/carbon/human/H = occupant
		occupantData["name"] = H.name
		occupantData["stat"] = H.stat
		occupantData["health"] = H.health
		occupantData["maxHealth"] = H.get_max_health()

		occupantData["hasVirus"] = H.virus2.len

		occupantData["bruteLoss"] = H.getBruteLoss()
		occupantData["oxyLoss"] = H.getOxyLoss()
		occupantData["toxLoss"] = H.getToxLoss()
		occupantData["fireLoss"] = H.getFireLoss()

		occupantData["radLoss"] = H.radiation
		occupantData["cloneLoss"] = H.getCloneLoss()
		occupantData["brainLoss"] = H.getBrainLoss()
		occupantData["paralysis"] = H.paralysis
		occupantData["paralysisSeconds"] = round(H.paralysis / 4)
		occupantData["bodyTempC"] = H.bodytemperature-T0C
		occupantData["bodyTempF"] = (((H.bodytemperature-T0C) * 1.8) + 32)

		occupantData["hasBorer"] = H.has_brain_worms()

		var/bloodData[0]
		if(H.vessel)
			var/blood_volume = round(H.vessel.get_reagent_amount(/datum/reagent/blood))
			var/blood_max = H.species.blood_volume
			bloodData["volume"] = blood_volume
			bloodData["percent"] = round(((blood_volume / blood_max)*100))

		occupantData["blood"] = bloodData

		var/tracesData[0]
		if(H.chem_doses.len)
			for(var/A in H.chem_doses)
				var/datum/reagent/R = A
				tracesData[++tracesData.len] = list(
					"name" = initial(R.name),
					"amount" = H.chem_doses[A],
					"overdose" = (initial(R.overdose) && H.chem_doses[A] > initial(R.overdose)) ? TRUE : FALSE,
				)
		else
			tracesData = null

		occupantData["chem_traces"] = tracesData

		var/reagentData[0]
		if(H.bloodstr.reagent_list.len >= 1)
			for(var/datum/reagent/R in H.bloodstr.reagent_list)
				reagentData[++reagentData.len] = list(
					"name" = R.name,
					"amount" = R.volume,
					"overdose" = (R.overdose && R.volume > R.overdose) ? TRUE : FALSE,
				)
		else
			reagentData = null

		occupantData["reagents"] = reagentData

		var/ingestedData[0]
		if(H.ingested.reagent_list.len >= 1)
			for(var/datum/reagent/R in H.ingested.reagent_list)
				ingestedData[++ingestedData.len] = list(
					"name" = R.name,
					"amount" = R.volume,
					"overdose" = (R.overdose && R.volume > R.overdose) ? TRUE : FALSE,
				)
		else
			ingestedData = null

		occupantData["ingested"] = ingestedData

		var/extOrganData[0]
		for(var/obj/item/organ/external/E in H.organs)
			var/organData[0]
			organData["name"] = E.name
			var/datum/wound/cut/incision = E.get_incision()
			if(incision)
				if(incision.damage >= (E.min_broken_damage * DAMAGE_MULT_INCISION))
					organData["open"] = TRUE
			organData["germ_level"] = E.germ_level
			organData["bruteLoss"] = E.brute_dam
			organData["fireLoss"] = E.burn_dam
			organData["totalLoss"] = E.brute_dam + E.burn_dam
			organData["maxHealth"] = E.max_damage
			organData["broken"] = E.min_broken_damage

			var/implantData[0]
			for(var/obj/I in E.implants)
				var/implantSubData[0]
				implantSubData["name"] = I.name
				if(is_type_in_list(I, known_implants))
					implantSubData["known"] = 1

				implantData.Add(list(implantSubData))

			organData["implants"] = implantData
			organData["implants_len"] = implantData.len

			var/organStatus[0]
			if(E.status & ORGAN_BROKEN)
				organStatus["broken"] = E.broken_description
			if(E.status & ORGAN_ROBOTIC)
				organStatus["robotic"] = 1
			if(E.splinted)
				organStatus["splinted"] = 1
			if(E.status & ORGAN_BLEEDING)
				organStatus["bleeding"] = 1
			if(E.status & ORGAN_DEAD)
				organStatus["dead"] = 1

			organData["status"] = organStatus

			if(istype(E, /obj/item/organ/external/chest) && H.is_lung_ruptured())
				organData["lungRuptured"] = 1

			if(E.status & ORGAN_ARTERY_CUT)
				organData["internalBleeding"] = 1

			extOrganData.Add(list(organData))

		occupantData["extOrgan"] = extOrganData

		var/intOrganData[0]
		for(var/obj/item/organ/internal/I in H.internal_organs)
			var/organData[0]
			organData["name"] = I.name
			if(I.status & ORGAN_ASSISTED)
				organData["desc"] = "Assisted"
			else if(I.status & ORGAN_ROBOTIC)
				organData["desc"] = "Mechanical"
			else
				organData["desc"] = null
			organData["germ_level"] = I.germ_level
			organData["damage"] = I.damage
			organData["maxHealth"] = I.max_damage
			organData["bruised"] = I.min_bruised_damage
			organData["broken"] = I.min_broken_damage
			organData["robotic"] = (I.status & ORGAN_ROBOTIC)
			organData["dead"] = (I.status & ORGAN_DEAD)

			intOrganData.Add(list(organData))

		occupantData["intOrgan"] = intOrganData

		occupantData["blind"] = (H.sdisabilities & BLIND)
		occupantData["nearsighted"] = (H.disabilities & NEARSIGHTED)
	data["occupant"] = occupantData

	return data

/datum/advanced_scanner/ui_act(action, params)
	if(..())
		return TRUE

	. = TRUE
	switch(action)
		if("ejectify")
			BS.eject()
		if("print_p")
			BS.visible_message("<span class='notice'>[BS] rattles and prints out a sheet of paper.</span>")
			playsound(BS, 'sound/machines/printer.ogg', 50, 1)
			var/obj/item/weapon/paper/P = new /obj/item/weapon/paper(get_turf(BS))
			var/name = occupant ? occupant.name : "Unknown"
			P.info = "<CENTER><B>Body Scan - [name]</B></CENTER><BR>"
			P.info += "<b>Time of scan:</b> [worldtime2stationtime(world.time)]<br><br>"
			P.info += "[generate_printing_text()]"
			P.info += "<br><br><b>Notes:</b><br>"
			P.name = "Body Scan - [name] ([worldtime2stationtime(world.time)])"
		else
			return FALSE

/datum/advanced_scanner/proc/generate_printing_text()
	var/dat = ""

	dat = "<font color='blue'><b>Occupant Statistics:</b></font><br>" //Blah obvious
	if(istype(occupant)) //is there REALLY someone in there?
		var/t1
		switch(occupant.stat) // obvious, see what their status is
			if(0)
				t1 = "Conscious"
			if(1)
				t1 = "Unconscious"
			else
				t1 = "*dead*"
		dat += "<font color=[occupant.health > (occupant.get_max_health() / 2) ? "blue" : "red"]>\tHealth %: [(occupant.health / occupant.get_max_health())*100], ([t1])</font><br>"

		if(occupant.virus2.len)
			dat += "<font color='red'>Viral pathogen detected in blood stream.</font><BR>"

		var/extra_font = null
		extra_font = "<font color=[occupant.getBruteLoss() < 60 ? "blue" : "red"]>"
		dat += "[extra_font]\t-Brute Damage %: [occupant.getBruteLoss()]</font><br>"

		extra_font = "<font color=[occupant.getOxyLoss() < 60 ? "blue" : "red"]>"
		dat += "[extra_font]\t-Respiratory Damage %: [occupant.getOxyLoss()]</font><br>"

		extra_font = "<font color=[occupant.getToxLoss() < 60 ? "blue" : "red"]>"
		dat += "[extra_font]\t-Toxin Content %: [occupant.getToxLoss()]</font><br>"

		extra_font = "<font color=[occupant.getFireLoss() < 60 ? "blue" : "red"]>"
		dat += "[extra_font]\t-Burn Severity %: [occupant.getFireLoss()]</font><br>"

		extra_font = "<font color=[occupant.radiation < 10 ? "blue" : "red"]>"
		dat += "[extra_font]\tRadiation Level %: [occupant.radiation]</font><br>"

		extra_font = "<font color=[occupant.getCloneLoss() < 1 ? "blue" : "red"]>"
		dat += "[extra_font]\tGenetic Tissue Damage %: [occupant.getCloneLoss()]</font><br>"

		extra_font = "<font color=[occupant.getBrainLoss() < 1 ? "blue" : "red"]>"
		dat += "[extra_font]\tApprox. Brain Damage %: [occupant.getBrainLoss()]</font><br>"

		dat += "Paralysis Summary %: [occupant.paralysis] ([round(occupant.paralysis / 4)] seconds left!)<br>"
		dat += "Body Temperature: [occupant.bodytemperature-T0C]&deg;C ([occupant.bodytemperature*1.8-459.67]&deg;F)<br>"

		dat += "<hr>"

		if(occupant.has_brain_worms())
			dat += "Large growth detected in frontal lobe, possibly cancerous. Surgical removal is recommended.<br>"

		if(occupant.vessel)
			var/blood_volume = round(occupant.vessel.get_reagent_amount("blood"))
			var/blood_max = occupant.species.blood_volume
			var/blood_percent =  blood_volume / blood_max
			blood_percent *= 100

			extra_font = "<font color=[blood_volume > 448 ? "blue" : "red"]>"
			dat += "[extra_font]\tBlood Level %: [blood_percent] ([blood_volume] units)</font><br>"

		if(occupant.reagents)
			for(var/datum/reagent/R in occupant.reagents.reagent_list)
				dat += "Reagent: [R.name], Amount: [R.volume]<br>"

		if(occupant.ingested)
			for(var/datum/reagent/R in occupant.ingested.reagent_list)
				dat += "Stomach: [R.name], Amount: [R.volume]<br>"

		dat += "<hr><table border='1'>"
		dat += "<tr>"
		dat += "<th>Organ</th>"
		dat += "<th>Burn Damage</th>"
		dat += "<th>Brute Damage</th>"
		dat += "<th>Other Wounds</th>"
		dat += "</tr>"

		for(var/obj/item/organ/external/E in occupant.organs)
			dat += "<tr>"
			var/AN = ""
			var/open = ""
			var/infected = ""
			var/robot = ""
			var/imp = ""
			var/bled = ""
			var/splint = ""
			var/internal_bleeding = ""
			var/lung_ruptured = ""
			var/o_dead = ""
			if(E.status & ORGAN_ARTERY_CUT)
				internal_bleeding = "<br>Internal bleeding"
			if(istype(E, /obj/item/organ/external/chest) && occupant.is_lung_ruptured())
				lung_ruptured = "Lung ruptured:"
			if(E.splinted)
				splint = "Splinted:"
			if(E.status & ORGAN_BLEEDING)
				bled = "Bleeding:"
			if(E.status & ORGAN_BROKEN)
				AN = "[E.broken_description]:"
			if(E.status & ORGAN_ROBOTIC)
				robot = "Prosthetic:"
			if(E.status & ORGAN_DEAD)
				o_dead = "Necrotic:"
			var/datum/wound/cut/incision = E.get_incision()
			if(incision)
				if(incision.damage >= (E.min_broken_damage * DAMAGE_MULT_INCISION))
					open = "Open:"
			switch (E.germ_level)
				if (INFECTION_LEVEL_ONE to INFECTION_LEVEL_ONE + 200)
					infected = "Mild Infection:"
				if (INFECTION_LEVEL_ONE + 200 to INFECTION_LEVEL_ONE + 300)
					infected = "Mild Infection+:"
				if (INFECTION_LEVEL_ONE + 300 to INFECTION_LEVEL_ONE + 400)
					infected = "Mild Infection++:"
				if (INFECTION_LEVEL_TWO to INFECTION_LEVEL_TWO + 200)
					infected = "Acute Infection:"
				if (INFECTION_LEVEL_TWO + 200 to INFECTION_LEVEL_TWO + 300)
					infected = "Acute Infection+:"
				if (INFECTION_LEVEL_TWO + 300 to INFECTION_LEVEL_THREE - 50)
					infected = "Acute Infection++:"
				if (INFECTION_LEVEL_THREE -49 to INFINITY)
					infected = "Gangrene Detected:"

			var/unknown_body = 0
			for(var/I in E.implants)
				if(is_type_in_list(I,known_implants))
					imp += "[I] implanted:"
				else
					unknown_body++

			if(unknown_body)
				imp += "Unknown body present:"
			if(!AN && !open && !infected && !imp)
				AN = "None:"
			dat += "<td>[E.name]</td><td>[E.burn_dam]</td><td>[E.brute_dam]</td><td>[robot][bled][AN][splint][open][infected][imp][internal_bleeding][lung_ruptured][o_dead]</td>"
			dat += "</tr>"
		for(var/obj/item/organ/I in occupant.internal_organs)
			var/mech = ""
			var/i_dead = ""
			if(I.status & ORGAN_ASSISTED)
				mech = "Assisted:"
			if(I.status & ORGAN_ROBOTIC)
				mech = "Mechanical:"
			if(I.status & ORGAN_DEAD)
				i_dead = "Necrotic"
			var/infection = "None"
			switch (I.germ_level)
				if (INFECTION_LEVEL_ONE to INFECTION_LEVEL_ONE + 200)
					infection = "Mild Infection"
				if (INFECTION_LEVEL_ONE + 200 to INFECTION_LEVEL_ONE + 300)
					infection = "Mild Infection+"
				if (INFECTION_LEVEL_ONE + 300 to INFECTION_LEVEL_ONE + 400)
					infection = "Mild Infection++"
				if (INFECTION_LEVEL_TWO to INFECTION_LEVEL_TWO + 200)
					infection = "Acute Infection"
				if (INFECTION_LEVEL_TWO + 200 to INFECTION_LEVEL_TWO + 300)
					infection = "Acute Infection+"
				if (INFECTION_LEVEL_TWO + 300 to INFECTION_LEVEL_THREE - 50)
					infection = "Acute Infection++"
				if (INFECTION_LEVEL_THREE -49 to INFINITY)
					infection = "Necrosis Detected"

			dat += "<tr>"
			dat += "<td>[I.name]</td><td>N/A</td><td>[I.damage]</td><td>[infection]:[mech][i_dead]</td><td></td>"
			dat += "</tr>"
		dat += "</table>"
		if(occupant.sdisabilities & BLIND)
			dat += "<font color='red'>Cataracts detected.</font><BR>"
		if(occupant.disabilities & NEARSIGHTED)
			dat += "<font color='red'>Retinal misalignment detected.</font><BR>"
	else
		dat += "\The [src] is empty."

	return dat

/obj/item/device/adv_health_analyzer
	name = "advanced health analyzer"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject."
	icon_state = "health_adv"
	item_state = "analyzer_adv"
	item_flags = ITEM_FLAG_NO_BLUDGEON
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = ITEM_SIZE_SMALL
	throw_range = 10
	matter = list(MATERIAL_STEEL = 200)
	origin_tech = list(TECH_MAGNET = 3, TECH_BIO = 5)
	var/datum/advanced_scanner/AS

/obj/item/device/adv_health_analyzer/Initialize()
	. = ..()
	AS = new /datum/advanced_scanner()
	AS.AHA = src

/obj/item/device/adv_health_analyzer/Destroy()
	QDEL_NULL(AS)
	. = ..()

/obj/item/device/adv_health_analyzer/attack_self(mob/user)
	AS.tgui_interact(user)

/obj/item/device/adv_health_analyzer/afterattack(atom/target, mob/user, proximity_flag)
	if (!user.is_advanced_tool_user())
		to_chat(user, "<span class='warning'>You are not nimble enough to use this device.</span>")
		return

	if ((CLUMSY in user.mutations) && prob(50))
		user.visible_message("<span class='notice'>\The [user] runs \the [src] over the floor.")
		to_chat(user, "<span class='notice'><b>Scan results for the floor:</b></span>")
		to_chat(user, "Overall Status: Healthy</span>")
		return

	if(istype(target, /mob/living/carbon/human))
		AS.occupant = target
		AS.tgui_interact(user)

	else if (istype(target, /obj/structure/closet/body_bag))
		var/obj/structure/closet/body_bag/B = target
		if(!B.opened)
			var/list/scan_content = list()
			for(var/mob/living/L in B.contents)
				scan_content.Add(L)

			if(scan_content.len == 1)
				for(var/mob/living/carbon/human/L in scan_content)
					AS.occupant = L

			else if (scan_content.len > 1)
				to_chat(user, "<span class='warning'>\The [src] picks up multiple readings inside \the [target], too close together to scan properly.</span>")
				return

			else
				to_chat(user, "\The [src] does not detect anyone inside \the [target].")
				return

	else
		return
