//DEFINITIONS FOR ASSET DATUMS START HERE.

/datum/asset/simple/nanoui
	keep_local_name = TRUE

	var/list/asset_dirs = list(
		"nano/css/",
		"nano/images/",
		"nano/images/modular_computers/",
		"nano/js/",
		"nano/templates/"
	)

/datum/asset/simple/nanoui/register()
	var/list/filenames = null
	for (var/path in asset_dirs)
		filenames = flist(path)
		for(var/filename in filenames)
			if(copytext(filename, length(filename)) == "/") // filenames which end in "/" are actually directories, which we want to ignore
				continue
			if(fexists(path + filename))
				assets[filename] = file(path + filename)
	. = ..()

/datum/asset/simple/jquery
	legacy = TRUE
	assets = list(
		"jquery.min.js" = 'html/jquery.min.js',
	)


/datum/asset/simple/tgui
	keep_local_name = TRUE
	assets = list(
		"tgui.css"	= 'tgui/assets/tgui.css',
		"tgui.js"	= 'tgui/assets/tgui.js'
	)

/datum/asset/simple/craft
	keep_local_name = TRUE

/datum/asset/simple/craft/register()
	for(var/name in SScraft.categories)
		for(var/datum/craft_recipe/CR in SScraft.categories[name])
			if(CR.result)
				var/filename = sanitizeFileName("[CR.result].png")
				var/icon/I = getFlatTypeIcon(CR.result)
				assets[filename] = I

			var/list/steplist = CR.steps + CR.passive_steps

			for(var/datum/craft_step/CS in steplist)
				if(CS.icon_type)
					var/filename = sanitizeFileName("[CS.icon_type].png")
					var/icon/I = getFlatTypeIcon(CS.icon_type)
					assets[filename] = I

	. = ..()

/datum/asset/simple/research_designs
	keep_local_name = TRUE

/datum/asset/simple/research_designs/register()
	for(var/R in subtypesof(/datum/design))
		var/datum/design/design = new R

		design.AssembleDesignInfo()

		if(!design.build_path)
			continue

		//Cache the icons
		var/filename = sanitizeFileName("[design.build_path].png")
		var/icon/I = getFlatTypeIcon(design.build_path)
		assets[filename] = I

		design.ui_data["icon"] = filename
		design.ui_data["icon_width"] = I.Width()
		design.ui_data["icon_height"] = I.Height()

		SSresearch.all_designs += design

		// Design ID is string
		SSresearch.design_ids["[design.id]"] = design

	SSresearch.generate_integrated_circuit_designs()

	for(var/D in SSresearch.design_ids)
		var/datum/design/design = SSresearch.design_ids[D]
		var/datum/computer_file/binary/design/design_file = new
		design_file.design = design
		design_file.on_design_set()
		design.file = design_file

	SSresearch.designs_initialized = TRUE

	// Initialize design files that were created before
	for(var/file in SSresearch.design_files_to_init)
		SSresearch.initialize_design_file(file)
	SSresearch.design_files_to_init = list()


	SSdatabase.update_store_designs()

	. = ..()