

/datum/design/item
	build_type = PROTOLATHE | STORE

/datum/design/item/powernode
	name = "power node"
	id = "powernode"
	req_tech = list(TECH_MATERIAL = 6, TECH_BLUESPACE = 4)
	materials = list(MATERIAL_GOLD = 4000, MATERIAL_SILVER = 4000)
	build_path = /obj/item/stack/power_node
	sort_string = "AAAAA"
	price = 10000

/datum/design/item/stock_part
	category = "Parts"
	build_type = PROTOLATHE | STORE

/datum/design/item/stock_part/AssembleDesignName()
	..()
	name = "Component design ([item_name])"

/datum/design/item/stock_part/AssembleDesignDesc()
	if(!desc)
		desc = "A stock part used in the construction of various devices."

/datum/design/item/stock_part/basic_capacitor
	name = "basic capacitor"
	id = "basic_capacitor"
	req_tech = list(TECH_POWER = 1)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/stock_parts/capacitor
	sort_string = "CAAAA"
	price = 100

/datum/design/item/stock_part/adv_capacitor
	name = "advanced capacitor"
	id = "adv_capacitor"
	req_tech = list(TECH_POWER = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/stock_parts/capacitor/adv
	sort_string = "CAAAB"
	price = 500

/datum/design/item/stock_part/super_capacitor
	name = "super capacitor"
	id = "super_capacitor"
	req_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50, MATERIAL_GOLD = 20)
	build_path = /obj/item/weapon/stock_parts/capacitor/super
	sort_string = "CAAAC"

/datum/design/item/stock_part/micro_mani
	name = "micro-manipulator"
	id = "micro_mani"
	req_tech = list(TECH_MATERIAL = 1, TECH_DATA = 1)
	materials = list(MATERIAL_STEEL = 30)
	build_path = /obj/item/weapon/stock_parts/manipulator
	sort_string = "CAABA"
	price = 100

/datum/design/item/stock_part/nano_mani
	name = "nano-manipulator"
	id = "nano_mani"
	req_tech = list(TECH_MATERIAL = 3, TECH_DATA = 2)
	materials = list(MATERIAL_STEEL = 30)
	build_path = /obj/item/weapon/stock_parts/manipulator/nano
	sort_string = "CAABB"
	price = 500

/datum/design/item/stock_part/pico_mani
	name = "pico-manipulator"
	id = "pico_mani"
	req_tech = list(TECH_MATERIAL = 5, TECH_DATA = 2)
	materials = list(MATERIAL_STEEL = 30)
	build_path = /obj/item/weapon/stock_parts/manipulator/pico
	sort_string = "CAABC"

/datum/design/item/stock_part/basic_matter_bin
	name = "matter bin"
	id = "basic_matter_bin"
	req_tech = list(TECH_MATERIAL = 1)
	materials = list(MATERIAL_STEEL = 80)
	build_path = /obj/item/weapon/stock_parts/matter_bin
	sort_string = "CAACA"
	price = 100

/datum/design/item/stock_part/adv_matter_bin
	name = "advanced matter bin"
	id = "adv_matter_bin"
	req_tech = list(TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 80)
	build_path = /obj/item/weapon/stock_parts/matter_bin/adv
	sort_string = "CAACB"
	price = 500

/datum/design/item/stock_part/super_matter_bin
	name = "super matter bin"
	id = "super_matter_bin"
	req_tech = list(TECH_MATERIAL = 5)
	materials = list(MATERIAL_STEEL = 80)
	build_path = /obj/item/weapon/stock_parts/matter_bin/super
	sort_string = "CAACC"

/datum/design/item/stock_part/basic_micro_laser
	name = "micro-laser"
	id = "basic_micro_laser"
	req_tech = list(TECH_MAGNET = 1)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/micro_laser
	sort_string = "CAADA"
	price = 100

/datum/design/item/stock_part/high_micro_laser
	name = "high-power micro-laser"
	id = "high_micro_laser"
	req_tech = list(TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/micro_laser/high
	sort_string = "CAADB"
	price = 500

/datum/design/item/stock_part/ultra_micro_laser
	name = "ultra-high-power micro-laser"
	id = "ultra_micro_laser"
	req_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 5)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GLASS = 20, "uranium" = 10)
	build_path = /obj/item/weapon/stock_parts/micro_laser/ultra
	sort_string = "CAADC"

/datum/design/item/stock_part/basic_sensor
	name = "scanning module"
	id = "basic_sensor"
	req_tech = list(TECH_MAGNET = 1)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/scanning_module
	sort_string = "CAAEA"
	price = 100

/datum/design/item/stock_part/adv_sensor
	name = "advanced scanning module"
	id = "adv_sensor"
	req_tech = list(TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 20)
	build_path = /obj/item/weapon/stock_parts/scanning_module/adv
	sort_string = "CAAEB"
	price = 500

/datum/design/item/stock_part/phasic_sensor
	name = "phasic scanning module"
	id = "phasic_sensor"
	req_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 20, MATERIAL_SILVER = 10)
	build_path = /obj/item/weapon/stock_parts/scanning_module/phasic
	sort_string = "CAAEC"

/datum/design/item/stock_part/RPED
	name = "Rapid Part Exchange Device"
	desc = "Special mechanical module made to store, sort, and apply standard machine parts."
	id = "rped"
	req_tech = list(TECH_ENGINEERING = 3, TECH_MATERIAL = 3)
	materials = list(MATERIAL_STEEL = 15000, MATERIAL_GLASS = 5000)
	build_path = /obj/item/weapon/storage/part_replacer
	sort_string = "CBAAA"
	price = 500

/datum/design/item/powercell
	build_type = PROTOLATHE | STORE | MECHFAB
	category = "Power"

/datum/design/item/powercell/AssembleDesignName()
	.=..()
	name = "Power cell model ([item_name])"

/datum/design/item/powercell/device/AssembleDesignName()
	.=..()
	name = "Device cell model ([item_name])"

/datum/design/item/powercell/AssembleDesignDesc()
	.=..()
	if(build_path)
		var/obj/item/weapon/cell/C = build_path
		desc = "Allows the construction of power cells that can hold [initial(C.maxcharge)] units of energy."

/datum/design/item/powercell/basic
	name = "basic power cell"
	id = "basic_cell"
	req_tech = list(TECH_POWER = 1)
	materials = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/cell
	sort_string = "DAAAA"
	price = 100

/datum/design/item/powercell/high
	name = "advanced power cell"
	id = "high_cell"
	req_tech = list(TECH_POWER = 2)
	materials = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 60)
	build_path = /obj/item/weapon/cell/high
	sort_string = "DAAAB"
	price = 500

/datum/design/item/powercell/super
	name = "enhanced power cell"
	id = "super_cell"
	req_tech = list(TECH_POWER = 3, TECH_MATERIAL = 2)
	materials = list(MATERIAL_STEEL = 700, MATERIAL_GLASS = 70)
	build_path = /obj/item/weapon/cell/super
	sort_string = "DAAAC"

/datum/design/item/powercell/hyper
	name = "hyper-capacity power cell"
	id = "hyper_cell"
	req_tech = list(TECH_POWER = 5, TECH_MATERIAL = 4)
	materials = list(MATERIAL_STEEL = 400, MATERIAL_GOLD = 150, MATERIAL_SILVER = 150, MATERIAL_GLASS = 70)
	build_path = /obj/item/weapon/cell/hyper
	sort_string = "DAAAD"
	price = 1500

/datum/design/item/powercell/device/standard
	name = "device power cell"
	id = "device_cell_standard"
	req_tech = list(TECH_POWER = 1)
	materials = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 5)
	build_path = /obj/item/weapon/cell/device/standard
	sort_string = "DAAAE"
	price = 50

/datum/design/item/powercell/device/high
	name = "advanced device power cell"
	id = "device_cell_high"
	req_tech = list(TECH_POWER = 2)
	materials = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 6)
	build_path = /obj/item/weapon/cell/device/high
	sort_string = "DAAAF"
	price = 100

/datum/design/item/hud
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_type = PROTOLATHE | STORE
	category = "Optics"

/datum/design/item/hud/AssembleDesignName()
	..()
	name = "HUD glasses design ([item_name])"

/datum/design/item/hud/AssembleDesignDesc()
	desc = "Allows for the construction of \a [item_name] HUD glasses."

/datum/design/item/hud/health
	name = "health scanner hud"
	id = "health_hud"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 3)
	build_path = /obj/item/clothing/glasses/hud/health
	sort_string = "GAAAA"
	price = 500

/datum/design/item/hud/security
	name = "security scanner hud"
	id = "security_hud"
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 2)
	build_path = /obj/item/clothing/glasses/hud/security
	sort_string = "GAAAB"
	price = 500

/datum/design/item/optical
	build_type = PROTOLATHE | STORE
	category = "Optics"

/datum/design/item/optical/AssembleDesignName()
	..()
	name = "Optical glasses design ([item_name])"

/datum/design/item/optical/mesons
	name = "meson goggles"
	desc = "Using the meson-scanning technology those glasses allow you to see through walls, floor or anything else."
	id = "mesons"
	req_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/clothing/glasses/meson
	sort_string = "GBAAA"
	price = 750

/datum/design/item/optical/material
	name = "material goggles"
	id = "mesons_material"
	req_tech = list(TECH_MAGNET = 3, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_path = /obj/item/clothing/glasses/material
	sort_string = "GAAAB"
	price = 750

/datum/design/item/optical/tactical
	name = "tactical goggles"
	id = "tactical_goggles"
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 5)
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50, MATERIAL_SILVER = 50, MATERIAL_GOLD = 50)
	build_path = /obj/item/clothing/glasses/tacgoggles
	sort_string = "GAAAC"
	price = 750

/datum/design/item/mining
	build_type = PROTOLATHE | STORE
	category = "Mining"

/datum/design/item/mining/AssembleDesignName()
	..()
	name = "Mining equipment design ([item_name])"

/datum/design/item/mining/rocksaw
	name = "Rock Saw"
	id = "Rock Saw"
	req_tech = list(TECH_MATERIAL = 3, TECH_POWER = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 2000, MATERIAL_PLASTEEL = 1300, MATERIAL_GLASS = 500, MATERIAL_DIAMOND = 750)
	build_path = /obj/item/weapon/tool/pickaxe/laser
	sort_string = "KAAAA"
	price = 2000

/datum/design/item/mining/plasmasaw
	name = "SH-B1 Plasma Saw"
	id = "SH-B1 Plasma Saw"
	req_tech = list(TECH_MATERIAL = 2, TECH_POWER = 2, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 1500, MATERIAL_GLASS = 500, MATERIAL_DIAMOND = 500)
	build_path = /obj/item/weapon/tool/saw/plasma
	sort_string = "KAAAB"
	price = 1000

/datum/design/item/mining/depth_scanner
	name = "depth scanner"
	desc = "Used to check spatial depth and density of rock outcroppings."
	id = "depth_scanner"
	req_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 1000,MATERIAL_GLASS = 1000)
	build_path = /obj/item/device/depth_scanner
	sort_string = "KAAAC"
	price = 300

/datum/design/item/mining/ano_scanner
	name = "Alden-Saraspova counter"
	id = "ano_scanner"
	desc = "Aids in triangulation of exotic particles."
	req_tech = list(TECH_BLUESPACE = 3, TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 10000,MATERIAL_GLASS = 5000)
	build_path = /obj/item/device/ano_scanner
	sort_string = "KAAAD"
	price = 300

/datum/design/item/medical
	build_type = PROTOLATHE | STORE
	materials = list(MATERIAL_STEEL = 30, MATERIAL_GLASS = 20)
	category = "Medical"

/datum/design/item/medical/AssembleDesignName()
	..()
	name = "Biotech device prototype ([item_name])"

/datum/design/item/medical/mass_spectrometer
	name = "mass spectrometer"
	desc = "A device for analyzing chemicals in blood."
	id = "mass_spectrometer"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 2)
	build_path = /obj/item/device/mass_spectrometer
	sort_string = "MACAA"
	price = 300

/datum/design/item/medical/adv_mass_spectrometer
	name = "advanced mass spectrometer"
	desc = "A device for analyzing chemicals in blood and their quantities."
	id = "adv_mass_spectrometer"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 4)
	build_path = /obj/item/device/mass_spectrometer/adv
	sort_string = "MACAB"
	price = 500

/datum/design/item/medical/reagent_scanner
	name = "reagent scanner"
	desc = "A device for identifying chemicals."
	id = "reagent_scanner"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 2)
	build_path = /obj/item/device/reagent_scanner
	sort_string = "MACBA"
	price = 300

/datum/design/item/medical/adv_reagent_scanner
	name = "advanced reagent scanner"
	desc = "A device for identifying chemicals and their proportions."
	id = "adv_reagent_scanner"
	req_tech = list(TECH_BIO = 2, TECH_MAGNET = 4)
	build_path = /obj/item/device/reagent_scanner/adv
	sort_string = "MACBB"
	price = 500

/datum/design/item/medical/nanopaste
	name = "nanopaste"
	desc = "A tube of paste containing swarms of repair nanites. Very effective in repairing robotic machinery."
	id = "nanopaste"
	req_tech = list(TECH_MATERIAL = 4, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 7000, MATERIAL_GLASS = 7000)
	build_path = /obj/item/stack/nanopaste
	sort_string = "MADAA"
	price = 750

/datum/design/item/medical/hypospray
	name = "hypospray"
	desc = "A sterile, air-needle autoinjector for rapid administration of drugs"
	id = "hypospray"
	req_tech = list(TECH_MATERIAL = 4, TECH_BIO = 5)
	materials = list(MATERIAL_STEEL = 8000, MATERIAL_GLASS = 8000, MATERIAL_SILVER = 2000)
	build_path = /obj/item/weapon/reagent_containers/hypospray/vial
	build_type = PROTOLATHE	//No appearing in store
	sort_string = "MAEAA"

/datum/design/item/surgery
	build_type = PROTOLATHE | STORE
	category = "Medical"

/datum/design/item/surgery/AssembleDesignName()
	..()
	name = "Surgical tool design ([item_name])"

/datum/design/item/surgery/scalpel_laser1
	name = "Basic Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field. This one looks basic and could be improved."
	id = "scalpel_laser1"
	req_tech = list(TECH_BIO = 2, TECH_MATERIAL = 2, TECH_MAGNET = 2)
	materials = list(MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500)
	build_path = /obj/item/weapon/scalpel/laser1
	sort_string = "MBEAA"
	price = 750

/datum/design/item/surgery/scalpel_laser2
	name = "Improved Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field. This one looks somewhat advanced."
	id = "scalpel_laser2"
	req_tech = list(TECH_BIO = 3, TECH_MATERIAL = 4, TECH_MAGNET = 4)
	materials = list(MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500, MATERIAL_SILVER = 2500)
	build_path = /obj/item/weapon/scalpel/laser2
	sort_string = "MBEAB"

/datum/design/item/surgery/scalpel_laser3
	name = "Advanced Laser Scalpel"
	desc = "A scalpel augmented with a directed laser, for more precise cutting without blood entering the field. This one looks to be the pinnacle of precision energy cutlery!"
	id = "scalpel_laser3"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 6, TECH_MAGNET = 5)
	materials = list(MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500, MATERIAL_SILVER = 2000, MATERIAL_GOLD = 1500)
	build_path = /obj/item/weapon/scalpel/laser3
	sort_string = "MBEAC"
	price = 1500

/datum/design/item/surgery/scalpel_manager
	name = "Incision Management System"
	desc = "A true extension of the surgeon's body, this marvel instantly and completely prepares an incision allowing for the immediate commencement of therapeutic steps."
	id = "scalpel_manager"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 7, TECH_MAGNET = 5, TECH_DATA = 4)
	materials = list (MATERIAL_STEEL = 12500, MATERIAL_GLASS = 7500, MATERIAL_SILVER = 1500, MATERIAL_GOLD = 1500, MATERIAL_DIAMOND = 750)
	build_path = /obj/item/weapon/scalpel/manager
	sort_string = "MBEAD"
	price = 2500

/datum/design/item/beaker/AssembleDesignName()
	.=..()
	name = "Beaker prototype ([item_name])"

/datum/design/item/beaker
	name = "beaker"
	id = "beaker"
	materials = list(MATERIAL_GLASS = 250)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker
	sort_string = "MCAAA"
	price = 150

/datum/design/item/beaker/large
	name = "large beaker"
	id = "large beaker"
	materials = list(MATERIAL_GLASS = 500)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/large
	sort_string = "MCAAB"
	price = 300

/datum/design/item/beaker/noreact
	name = "cryostasis beaker"
	desc = "A cryostasis beaker that allows for chemical storage without reactions. Can hold up to 50 units."
	id = "splitbeaker"
	req_tech = list(TECH_MATERIAL = 2)
	materials = list(MATERIAL_STEEL = 3000)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/noreact
	sort_string = "MCAAC"

/datum/design/item/beaker/bluespace
	name = "bluespace beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology and Element Cuban combined with the Compound Pete. Can hold up to 300 units."
	id = "bluespacebeaker"
	req_tech = list(TECH_BLUESPACE = 2, TECH_MATERIAL = 6)
	materials = list(MATERIAL_STEEL = 3000, MATERIAL_PHORON = 3000, MATERIAL_DIAMOND = 500)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/bluespace
	sort_string = "MCAAD"
	price = 1500

/datum/design/item/implant
	materials = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	build_type = PROTOLATHE

/datum/design/item/implant/AssembleDesignName()
	..()
	name = "Implantable biocircuit design ([item_name])"

/datum/design/item/implant/chemical
	name = "chemical implant"
	id = "implant_chem"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3)
	build_path = /obj/item/weapon/implantcase/chem
	sort_string = "MFAAA"

/datum/design/item/implant/death_alarm
	name = "death alarm"
	id = "implant_death"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_DATA = 2)
	build_path = /obj/item/weapon/implantcase/death_alarm
	sort_string = "MFAAB"

/datum/design/item/implant/tracking
	name = "tracking implant"
	id = "implant_tracking"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_BLUESPACE = 3)
	build_path = /obj/item/weapon/implantcase/tracking
	sort_string = "MFAAC"

/datum/design/item/implant/imprinting
	name = "imprinting implant"
	id = "implant_imprinting"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_DATA = 4)
	build_path = /obj/item/weapon/implantcase/imprinting
	sort_string = "MFAAD"

/datum/design/item/implant/adrenaline
	name = "adrenaline implant"
	id = "implant_adrenaline"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_ILLEGAL = 3)
	build_path = /obj/item/weapon/implantcase/adrenalin
	sort_string = "MFAAE"

/datum/design/item/implant/freedom
	name = "freedom implant"
	id = "implant_free"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_ILLEGAL = 3)
	build_path = /obj/item/weapon/implantcase/freedom
	sort_string = "MFAAF"

/datum/design/item/implant/explosive
	name = "explosive implant"
	id = "implant_explosive"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_ILLEGAL = 4)
	build_path = /obj/item/weapon/implantcase/explosive
	sort_string = "MFAAG"

/datum/design/item/tcomm/AssembleDesignName()
	..()
	name = "Tele-communication part ([item_name])"

/datum/design/item/tcomm
	build_type = PROTOLATHE

/datum/design/item/tcomm/subspace_ansible
	name = "subspace ansible"
	id = "s-ansible"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 80, MATERIAL_SILVER = 20)
	build_path = /obj/item/weapon/stock_parts/subspace/ansible
	sort_string = "UAAAA"

/datum/design/item/tcomm/hyperwave_filter
	name = "hyperwave filter"
	id = "s-filter"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 3)
	materials = list(MATERIAL_STEEL = 40, MATERIAL_SILVER = 10)
	build_path = /obj/item/weapon/stock_parts/subspace/filter
	sort_string = "UAAAB"

/datum/design/item/tcomm/subspace_amplifier
	name = "subspace amplifier"
	id = "s-amplifier"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GOLD = 30, "uranium" = 15)
	build_path = /obj/item/weapon/stock_parts/subspace/amplifier
	sort_string = "UAAAC"

/datum/design/item/tcomm/subspace_treatment
	name = "subspace treatment disk"
	id = "s-treatment"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 2, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_SILVER = 20)
	build_path = /obj/item/weapon/stock_parts/subspace/treatment
	sort_string = "UAAAD"

/datum/design/item/tcomm/subspace_analyzer
	name = "subspace wavelength analyzer"
	id = "s-analyzer"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 10, MATERIAL_GOLD = 15)
	build_path = /obj/item/weapon/stock_parts/subspace/analyzer
	sort_string = "UAAAE"

/datum/design/item/tcomm/subspace_crystal
	name = "ansible crystal"
	id = "s-crystal"
	req_tech = list(TECH_MAGNET = 4, TECH_MATERIAL = 4, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_GLASS = 1000, MATERIAL_SILVER = 20, MATERIAL_GOLD = 20)
	build_path = /obj/item/weapon/stock_parts/subspace/crystal
	sort_string = "UAAAF"

/datum/design/item/tcomm/subspace_transmitter
	name = "subspace transmitter"
	id = "s-transmitter"
	req_tech = list(TECH_MAGNET = 5, TECH_MATERIAL = 5, TECH_BLUESPACE = 3)
	materials = list(MATERIAL_GLASS = 100, MATERIAL_SILVER = 10, "uranium" = 15)
	build_path = /obj/item/weapon/stock_parts/subspace/transmitter
	sort_string = "UAAAG"

/datum/design/item/biostorage/AssembleDesignName()
	..()
	name = "Biological intelligence storage ([item_name])"

/datum/design/item/bluespace/AssembleDesignName()
	..()
	name = "Bluespace device ([item_name])"

/datum/design/item/bluespace/beacon
	name = "tracking beacon"
	id = "beacon"
	req_tech = list(TECH_BLUESPACE = 1)
	materials = list (MATERIAL_STEEL = 20, MATERIAL_GLASS = 10)
	build_path = /obj/item/device/radio/beacon
	sort_string = "VADAA"
	price = 100

/datum/design/item/bluespace/gps
	name = "triangulating device"
	desc = "Triangulates approximate co-ordinates using a nearby satellite network."
	id = "gps"
	req_tech = list(TECH_MATERIAL = 2, TECH_DATA = 2, TECH_BLUESPACE = 2)
	materials = list(MATERIAL_STEEL = 500)
	build_path = /obj/item/device/gps
	sort_string = "VADAB"
	price = 100

/datum/design/item/bluespace/beacon_locator
	name = "beacon tracking pinpointer"
	desc = "Used to scan and locate signals on a particular frequency."
	id = "beacon_locator"
	req_tech = list(TECH_MAGNET = 3, TECH_ENGINEERING = 2, TECH_BLUESPACE = 3)
	materials = list(MATERIAL_STEEL = 1000,MATERIAL_GLASS = 500)
	build_path = /obj/item/weapon/pinpointer/radio
	sort_string = "VADAC"
	price = 200

// tools

/datum/design/item/tool/AssembleDesignName()
	..()
	name = "Tool design ([item_name])"

/datum/design/item/tool/light_replacer
	name = "light replacer"
	desc = "A device to automatically replace lights. Refill with working lightbulbs."
	id = "light_replacer"
	req_tech = list(TECH_MAGNET = 3, TECH_MATERIAL = 4)
	materials = list(MATERIAL_STEEL = 1500, MATERIAL_SILVER = 150, MATERIAL_GLASS = 3000)
	build_path = /obj/item/device/lightreplacer
	sort_string = "VAGAB"
	price = 500

/datum/design/item/tool/airlock_brace
	name = "airlock brace"
	desc = "Special door attachment that can be used to provide extra security."
	id = "brace"
	req_tech = list(TECH_ENGINEERING = 3, TECH_MATERIAL = 2)
	materials = list(MATERIAL_STEEL = 2000, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/airlock_brace
	sort_string = "VAGAC"

/datum/design/item/tool/brace_jack
	name = "maintenance jack"
	desc = "A special maintenance tool that can be used to remove airlock braces."
	id = "bracejack"
	req_tech = list(TECH_ENGINEERING = 3, TECH_MATERIAL = 2)
	materials = list(MATERIAL_STEEL = 120)
	build_path = /obj/item/weapon/tool/crowbar/brace_jack
	sort_string = "VAGAD"
	price = 1500

/datum/design/item/tool/clamp
	name = "stasis clamp"
	desc = "A magnetic clamp which can halt the flow of gas in a pipe, via a localised stasis field."
	id = "stasis_clamp"
	req_tech = list(TECH_ENGINEERING = 4, TECH_MAGNET = 4)
	materials = list(MATERIAL_STEEL = 500, MATERIAL_GLASS = 500)
	build_path = /obj/item/clamp
	sort_string = "VAGAE"
	price = 600

/datum/design/item/tool/price_scanner
	name = "price scanner"
	desc = "Using an up-to-date database of various costs and prices, this device estimates the market price of an item up to 0.001% accuracy."
	id = "price_scanner"
	req_tech = list(TECH_MATERIAL = 2, TECH_MAGNET = 1) // Why was this as high as it was anyway?
	materials = list(MATERIAL_STEEL = 3000, MATERIAL_GLASS = 3000, MATERIAL_SILVER = 250)
	build_path = /obj/item/device/price_scanner
	sort_string = "VAGAF"
	price = 750

/datum/design/item/tool/advanced_welder
	name = "advanced welding tool"
	desc = "This welding tool feels heavier in your possession than is normal."
	id = "experimental_welder"
	req_tech = list(TECH_ENGINEERING = 5, TECH_PHORON = 4)
	materials = list(MATERIAL_STEEL = 120, MATERIAL_GLASS = 50)
	build_path = /obj/item/weapon/tool/weldingtool/advanced
	sort_string = "VAGAG"
	price = 250

/datum/design/item/tool/oxycandle
	name = "oxycandle"
	desc = "a device which, via a chemical reaction, can pressurise small areas."
	id="oxycandle"
	req_tech = list(TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 3000)
	chemicals = list(/datum/reagent/sodiumchloride = 20, /datum/reagent/acetone = 20)
	build_path = /obj/item/device/oxycandle
	sort_string = "VAGAI"
	price = 500

/datum/design/item/encryptionkey/AssembleDesignName()
	..()
	name = "Encryption key design ([item_name])"

/datum/design/item/camouflage/AssembleDesignName()
	..()
	name = "Camouflage design ([item_name])"

// Superconductive magnetic coils
/datum/design/item/smes_coil/AssembleDesignName()
	..()
	name = "Superconductive magnetic coil ([item_name])"

/datum/design/item/smes_coil
	desc = "A superconductive magnetic coil used to store power in magnetic fields."
	build_type = PROTOLATHE
	materials = list(MATERIAL_STEEL = 2000, MATERIAL_GLASS = 2000, MATERIAL_GOLD = 1000, MATERIAL_SILVER = 1000)

/datum/design/item/smes_coil/standard
	name = "superconductive magnetic coil"
	id = "smes_coil_standard"
	req_tech = list(TECH_MATERIAL = 7, TECH_POWER = 7, TECH_ENGINEERING = 5)
	build_path = /obj/item/weapon/smes_coil
	sort_string = "VAXAA"

/datum/design/item/smes_coil/super_capacity
	name = "superconductive capacitance coil"
	id = "smes_coil_super_capacity"
	req_tech = list(TECH_MATERIAL = 7, TECH_POWER = 8, TECH_ENGINEERING = 6)
	build_path = /obj/item/weapon/smes_coil/super_capacity
	sort_string = "VAXAB"

/datum/design/item/smes_coil/super_io
	name = "superconductive transmission coil"
	id = "smes_coil_super_io"
	req_tech = list(TECH_MATERIAL = 7, TECH_POWER = 8, TECH_ENGINEERING = 6)
	build_path = /obj/item/weapon/smes_coil/super_io
	sort_string = "VAXAC"


// Modular computer components
// Hard drives
/datum/design/item/modularcomponent/disk/AssembleDesignName()
	..()
	name = "Hard drive design ([item_name])"

/datum/design/item/modularcomponent/disk/micro
	name = "micro hard drive"
	id = "hdd_micro"
	req_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	materials = list(MATERIAL_STEEL = 400, MATERIAL_GLASS = 100)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/micro
	sort_string = "VBAAA"
	price = 100

/datum/design/item/modularcomponent/disk/small
	name = "small hard drive"
	id = "hdd_small"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 800, MATERIAL_GLASS = 200)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/small
	sort_string = "VBAAB"
	price = 150

/datum/design/item/modularcomponent/disk/normal
	name = "basic hard drive"
	id = "hdd_basic"
	req_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	materials = list(MATERIAL_STEEL = 400, MATERIAL_GLASS = 100)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/
	sort_string = "VBAAC"
	price = 100

/datum/design/item/modularcomponent/disk/advanced
	name = "advanced hard drive"
	id = "hdd_advanced"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 800, MATERIAL_GLASS = 200)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/advanced
	sort_string = "VBAAD"
	price = 250

/datum/design/item/modularcomponent/disk/super
	name = "super hard drive"
	id = "hdd_super"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 1600, MATERIAL_GLASS = 400)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/super
	sort_string = "VBAAE"
	price = 500

/datum/design/item/modularcomponent/disk/cluster
	name = "cluster hard drive"
	id = "hdd_cluster"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4)
	materials = list(MATERIAL_STEEL = 3200, MATERIAL_GLASS = 800)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/cluster
	sort_string = "VBAAF"

// Network cards
/datum/design/item/modularcomponent/netcard/AssembleDesignName()
	..()
	name = "Network card design ([item_name])"

/datum/design/item/modularcomponent/netcard/basic
	name = "basic network card"
	id = "netcard_basic"
	req_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	materials = list(MATERIAL_STEEL = 250, MATERIAL_GLASS = 100)
	build_path = /obj/item/weapon/computer_hardware/network_card
	sort_string = "VBABA"
	price = 250

/datum/design/item/modularcomponent/netcard/advanced
	name = "advanced network card"
	id = "netcard_advanced"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 500, MATERIAL_GLASS = 200)
	build_path = /obj/item/weapon/computer_hardware/network_card/advanced
	sort_string = "VBABB"
	price = 500

/datum/design/item/modularcomponent/netcard/wired
	name = "wired network card"
	id = "netcard_wired"
	req_tech = list(TECH_DATA = 5, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 2500, MATERIAL_GLASS = 400)
	build_path = /obj/item/weapon/computer_hardware/network_card/wired
	sort_string = "VBABC"
	price = 250

// Data crystals (USB flash drives)
/datum/design/item/modularcomponent/portabledrive/AssembleDesignName()
	..()
	name = "Portable drive design ([item_name])"

/datum/design/item/modularcomponent/portabledrive/basic
	name = "basic data crystal"
	id = "portadrive_basic"
	req_tech = list(TECH_DATA = 1)
	materials = list(MATERIAL_GLASS = 800)
	chemicals = list(/datum/reagent/acid = 20)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/portable
	sort_string = "VBACA"
	price = 100

/datum/design/item/modularcomponent/portabledrive/advanced
	name = "advanced data crystal"
	id = "portadrive_advanced"
	req_tech = list(TECH_DATA = 2)
	materials = list(MATERIAL_GLASS = 1600)
	chemicals = list(/datum/reagent/acid = 20)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/portable/advanced
	sort_string = "VBACB"
	price = 250

/datum/design/item/modularcomponent/portabledrive/super
	name = "super data crystal"
	id = "portadrive_super"
	req_tech = list(TECH_DATA = 4)
	materials = list(MATERIAL_GLASS = 3200)
	chemicals = list(/datum/reagent/acid = 20)
	build_path = /obj/item/weapon/computer_hardware/hard_drive/portable/super
	sort_string = "VBACC"
	price = 500

// Card slot
/datum/design/item/modularcomponent/accessory/AssembleDesignName()
	..()
	name = "Computer accessory ([item_name])"

/datum/design/item/modularcomponent/accessory/cardslot
	name = "RFID card slot"
	id = "cardslot"
	req_tech = list(TECH_DATA = 2)
	materials = list(MATERIAL_STEEL = 600)
	build_path = /obj/item/weapon/computer_hardware/card_slot
	sort_string = "VBADA"
	price = 250

// Nano printer
/datum/design/item/modularcomponent/accessory/nanoprinter
	name = "nano printer"
	id = "nanoprinter"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 600)
	build_path = /obj/item/weapon/computer_hardware/nano_printer
	sort_string = "VBADB"
	price = 250

// Tesla Link
/datum/design/item/modularcomponent/accessory/teslalink
	name = "tesla link"
	id = "teslalink"
	req_tech = list(TECH_DATA = 2, TECH_POWER = 3, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 2000)
	build_path = /obj/item/weapon/computer_hardware/tesla_link
	sort_string = "VBADC"
	price = 400

//Scanners
/datum/design/item/modularcomponent/accessory/reagent_scanner
	name = "reagent scanner module"
	id = "scan_reagent"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2, TECH_BIO = 2, TECH_MAGNET = 2)
	materials = list(MATERIAL_STEEL = 600, MATERIAL_GLASS = 200)
	build_path = /obj/item/weapon/computer_hardware/scanner/reagent
	sort_string = "VBADD"
	price = 250

/datum/design/item/modularcomponent/accessory/paper_scanner
	name = "paper scanner module"
	id = "scan_paper"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 600, MATERIAL_GLASS = 200)
	build_path = /obj/item/weapon/computer_hardware/scanner/paper
	sort_string = "VBADE"
	price = 250

/datum/design/item/modularcomponent/accessory/atmos_scanner
	name = "atmospheric scanner module"
	id = "scan_atmos"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2, TECH_MAGNET = 2)
	materials = list(MATERIAL_STEEL = 600, MATERIAL_GLASS = 200)
	build_path = /obj/item/weapon/computer_hardware/scanner/atmos
	sort_string = "VBADF"
	price = 250

/datum/design/item/modularcomponent/accessory/medical_scanner
	name = "medical scanner module"
	id = "scan_medical"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2, TECH_MAGNET = 2, TECH_BIO = 2)
	materials = list(MATERIAL_STEEL = 600, MATERIAL_GLASS = 200)
	build_path = /obj/item/weapon/computer_hardware/scanner/medical
	sort_string = "VBADG"
	price = 250

// Batteries
/datum/design/item/modularcomponent/battery/AssembleDesignName()
	..()
	name = "Battery design ([item_name])"

/datum/design/item/modularcomponent/battery/normal
	name = "standard battery module"
	id = "bat_normal"
	req_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 1)
	materials = list(MATERIAL_STEEL = 400)
	build_path = /obj/item/weapon/computer_hardware/battery_module
	sort_string = "VBAEA"
	price = 50

/datum/design/item/modularcomponent/battery/advanced
	name = "advanced battery module"
	id = "bat_advanced"
	req_tech = list(TECH_POWER = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 800)
	build_path = /obj/item/weapon/computer_hardware/battery_module/advanced
	sort_string = "VBAEB"
	price = 75

/datum/design/item/modularcomponent/battery/super
	name = "super battery module"
	id = "bat_super"
	req_tech = list(TECH_POWER = 3, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 1600)
	build_path = /obj/item/weapon/computer_hardware/battery_module/super
	sort_string = "VBAEC"
	price = 100

/datum/design/item/modularcomponent/battery/ultra
	name = "ultra battery module"
	id = "bat_ultra"
	req_tech = list(TECH_POWER = 5, TECH_ENGINEERING = 4)
	materials = list(MATERIAL_STEEL = 3200)
	build_path = /obj/item/weapon/computer_hardware/battery_module/ultra
	sort_string = "VBAED"
	price = 125

/datum/design/item/modularcomponent/battery/nano
	name = "nano battery module"
	id = "bat_nano"
	req_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 1)
	materials = list(MATERIAL_STEEL = 200)
	build_path = /obj/item/weapon/computer_hardware/battery_module/nano
	sort_string = "VBAEE"
	price = 40

/datum/design/item/modularcomponent/battery/micro
	name = "micro battery module"
	id = "bat_micro"
	req_tech = list(TECH_POWER = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 400)
	build_path = /obj/item/weapon/computer_hardware/battery_module/micro
	sort_string = "VBAEF"
	price = 50

// Processor unit
/datum/design/item/modularcomponent/cpu/AssembleDesignName()
	..()
	name = "CPU design ([item_name])"

/datum/design/item/modularcomponent/cpu/small
	name = "computer microprocessor unit"
	id = "cpu_small"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 800)
	chemicals = list(/datum/reagent/acid = 20)
	build_path = /obj/item/weapon/computer_hardware/processor_unit/small
	sort_string = "VBAFA"
	price = 90

/datum/design/item/modularcomponent/cpu/
	name = "computer processor unit"
	id = "cpu_normal"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 2)
	materials = list(MATERIAL_STEEL = 1600)
	build_path = /obj/item/weapon/computer_hardware/processor_unit
	sort_string = "VBAFB"
	price = 100

/datum/design/item/modularcomponent/cpu/photonic
	name = "computer photonic processor unit"
	id = "pcpu_normal"
	req_tech = list(TECH_DATA = 5, TECH_ENGINEERING = 4)
	materials = list(MATERIAL_STEEL = 6400, glass = 2000)
	build_path = /obj/item/weapon/computer_hardware/processor_unit/photonic
	sort_string = "VBAFC"
	price = 250

/datum/design/item/modularcomponent/cpu/photonic/small
	name = "computer photonic microprocessor unit"
	id = "pcpu_small"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 3200, glass = 1000)
	build_path = /obj/item/weapon/computer_hardware/processor_unit/photonic/small
	sort_string = "VBAFD"
	price = 500




/*
CIRCUITS BELOW
*/

/datum/design/circuit
	build_type = IMPRINTER
	req_tech = list(TECH_DATA = 2)
	materials = list(MATERIAL_GLASS = 2000)
	chemicals = list(/datum/reagent/acid = 20)
	time = 5

/datum/design/circuit/AssembleDesignName()
	..()
	if(build_path)
		var/obj/item/weapon/circuitboard/C = build_path
		if(initial(C.board_type) == "machine")
			name = "Machine circuit design ([item_name])"
		else if(initial(C.board_type) == "computer")
			name = "Computer circuit design ([item_name])"
		else
			name = "Circuit design ([item_name])"

/datum/design/circuit/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a [item_name] circuit board."

/datum/design/circuit/arcademachine
	name = "battle arcade machine"
	id = "arcademachine"
	req_tech = list(TECH_DATA = 1)
	build_path = /obj/item/weapon/circuitboard/arcade/battle
	sort_string = "MAAAA"

/datum/design/circuit/oriontrail
	name = "orion trail arcade machine"
	id = "oriontrail"
	req_tech = list(TECH_DATA = 1)
	build_path = /obj/item/weapon/circuitboard/arcade/orion_trail
	sort_string = "MABAA"

/datum/design/circuit/prisonmanage
	name = "prisoner management console"
	id = "prisonmanage"
	build_path = /obj/item/weapon/circuitboard/prisoner
	sort_string = "DACAA"

/datum/design/circuit/operating
	name = "patient monitoring console"
	id = "operating"
	build_path = /obj/item/weapon/circuitboard/operating
	sort_string = "FACAA"

/datum/design/circuit/crewconsole
	name = "crew monitoring console"
	id = "crewconsole"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 2, TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/crew
	sort_string = "FAGAI"

/datum/design/circuit/rdconsole
	name = "R&D control console"
	id = "rdconsole"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/rdconsole
	sort_string = "HAAAA"

/datum/design/circuit/comm_monitor
	name = "telecommunications monitoring console"
	id = "comm_monitor"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/comm_monitor
	sort_string = "HAACA"

/datum/design/circuit/comm_server
	name = "telecommunications server monitoring console"
	id = "comm_server"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/comm_server
	sort_string = "HAACB"

/datum/design/circuit/comm_traffic
	name = "telecommunications traffic control console"
	id = "comm_traffic"
	req_tech = list(TECH_DATA = 6)
	build_path = /obj/item/weapon/circuitboard/comm_traffic
	sort_string = "HAACC"

/datum/design/circuit/message_monitor
	name = "messaging monitor console"
	id = "message_monitor"
	req_tech = list(TECH_DATA = 5)
	build_path = /obj/item/weapon/circuitboard/message_monitor
	sort_string = "HAACD"

/datum/design/circuit/destructive_analyzer
	name = "destructive analyzer"
	id = "destructive_analyzer"
	req_tech = list(TECH_DATA = 2, TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/destructive_analyzer
	sort_string = "HABAA"

/datum/design/circuit/protolathe
	name = "protolathe"
	id = "protolathe"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/protolathe
	sort_string = "HABAB"

/datum/design/circuit/circuit_imprinter
	name = "circuit imprinter"
	id = "circuit_imprinter"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/circuit_imprinter
	sort_string = "HABAC"

/datum/design/circuit/autolathe
	name = "autolathe board"
	id = "autolathe"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/autolathe
	sort_string = "HABAD"

/datum/design/circuit/rdservercontrol
	name = "R&D server control console"
	id = "rdservercontrol"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/rdservercontrol
	sort_string = "HABBA"

/datum/design/circuit/rdserver
	name = "R&D server"
	id = "rdserver"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/rdserver
	sort_string = "HABBB"

/*Useless until someone will add robots
/datum/design/circuit/mechfab
	name = "exosuit fabricator"
	id = "mechfab"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/mechfab
	sort_string = "HABAE"
*/

/datum/design/circuit/atmosalerts
	name = "atmosphere alert console"
	id = "atmosalerts"
	build_path = /obj/item/weapon/circuitboard/atmos_alert
	sort_string = "JAAAA"

/datum/design/circuit/air_management
	name = "atmosphere monitoring console"
	id = "air_management"
	build_path = /obj/item/weapon/circuitboard/air_management
	sort_string = "JAAAB"

/datum/design/circuit/rcon_console
	name = "RCON remote control console"
	id = "rcon_console"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 3, TECH_POWER = 5)
	build_path = /obj/item/weapon/circuitboard/rcon_console
	sort_string = "JAAAC"

/datum/design/circuit/powermonitor
	name = "power monitoring console"
	id = "powermonitor"
	build_path = /obj/item/weapon/circuitboard/powermonitor
	sort_string = "JAAAD"

/datum/design/circuit/solarcontrol
	name = "solar control console"
	id = "solarcontrol"
	build_path = /obj/item/weapon/circuitboard/solar_control
	sort_string = "JAAAE"

/datum/design/circuit/pacman
	name = "PACMAN-type generator"
	id = "pacman"
	req_tech = list(TECH_DATA = 3, TECH_PHORON = 3, TECH_POWER = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/pacman
	sort_string = "JBAAA"

/datum/design/circuit/superpacman
	name = "SUPERPACMAN-type generator"
	id = "superpacman"
	req_tech = list(TECH_DATA = 3, TECH_POWER = 4, TECH_ENGINEERING = 4)
	build_path = /obj/item/weapon/circuitboard/pacman/super
	sort_string = "JBAAB"

/datum/design/circuit/mrspacman
	name = "MRSPACMAN-type generator"
	id = "mrspacman"
	req_tech = list(TECH_DATA = 3, TECH_POWER = 5, TECH_ENGINEERING = 5)
	build_path = /obj/item/weapon/circuitboard/pacman/mrs
	sort_string = "JBAAC"

/datum/design/circuit/batteryrack
	name = "cell rack PSU"
	id = "batteryrack"
	req_tech = list(TECH_POWER = 3, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/batteryrack
	sort_string = "JBABA"

/datum/design/circuit/smes_cell
	name = "'SMES' superconductive magnetic energy storage"
	desc = "Allows for the construction of circuit boards used to build a SMES."
	id = "smes_cell"
	req_tech = list(TECH_POWER = 7, TECH_ENGINEERING = 5)
	build_path = /obj/item/weapon/circuitboard/smes
	sort_string = "JBABB"

/datum/design/circuit/gas_heater
	name = "gas heating system"
	id = "gasheater"
	req_tech = list(TECH_POWER = 2, TECH_ENGINEERING = 1)
	build_path = /obj/item/weapon/circuitboard/unary_atmos/heater
	sort_string = "JCAAA"

/datum/design/circuit/gas_cooler
	name = "gas cooling system"
	id = "gascooler"
	req_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/unary_atmos/cooler
	sort_string = "JCAAB"

/datum/design/circuit/secure_airlock
	name = "secure airlock electronics"
	desc =  "Allows for the construction of a tamper-resistant airlock electronics."
	id = "securedoor"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/airlock_electronics/secure
	sort_string = "JDAAA"

/datum/design/circuit/biogenerator
	name = "biogenerator"
	id = "biogenerator"
	req_tech = list(TECH_DATA = 2)
	build_path = /obj/item/weapon/circuitboard/biogenerator
	sort_string = "KBAAA"

/datum/design/circuit/miningdrill
	name = "mining drill head"
	id = "mining drill head"
	req_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	build_path = /obj/item/weapon/circuitboard/miningdrill
	sort_string = "KCAAA"

/datum/design/circuit/miningdrillbrace
	name = "mining drill brace"
	id = "mining drill brace"
	req_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	build_path = /obj/item/weapon/circuitboard/miningdrillbrace
	sort_string = "KCAAB"

/datum/design/circuit/tcom
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4)

/datum/design/circuit/tcom/AssembleDesignName()
	name = "Telecommunications machinery circuit design ([name])"
/datum/design/circuit/tcom/AssembleDesignDesc()
	desc = "Allows for the construction of a telecommunications [name] circuit board."

/datum/design/circuit/tcom/server
	name = "server mainframe"
	id = "tcom-server"
	build_path = /obj/item/weapon/circuitboard/telecomms/server
	sort_string = "PAAAA"

/datum/design/circuit/tcom/processor
	name = "processor unit"
	id = "tcom-processor"
	build_path = /obj/item/weapon/circuitboard/telecomms/processor
	sort_string = "PAAAB"

/datum/design/circuit/tcom/bus
	name = "bus mainframe"
	id = "tcom-bus"
	build_path = /obj/item/weapon/circuitboard/telecomms/bus
	sort_string = "PAAAC"

/datum/design/circuit/tcom/hub
	name = "hub mainframe"
	id = "tcom-hub"
	build_path = /obj/item/weapon/circuitboard/telecomms/hub
	sort_string = "PAAAD"

/datum/design/circuit/tcom/relay
	name = "relay mainframe"
	id = "tcom-relay"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 4, TECH_BLUESPACE = 3)
	build_path = /obj/item/weapon/circuitboard/telecomms/relay
	sort_string = "PAAAE"

/datum/design/circuit/tcom/broadcaster
	name = "subspace broadcaster"
	id = "tcom-broadcaster"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4, TECH_BLUESPACE = 2)
	build_path = /obj/item/weapon/circuitboard/telecomms/broadcaster
	sort_string = "PAAAF"

/datum/design/circuit/tcom/receiver
	name = "subspace receiver"
	id = "tcom-receiver"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 3, TECH_BLUESPACE = 2)
	build_path = /obj/item/weapon/circuitboard/telecomms/receiver
	sort_string = "PAAAG"

/datum/design/circuit/shield_generator
	name = "Shield Generator"
	desc = "Allows for the construction of a shield generator circuit board."
	id = "shield_generator"
	req_tech = list(TECH_MAGNET = 3, TECH_POWER = 4)
	build_path = /obj/item/weapon/circuitboard/shield_generator
	sort_string = "VAAAC"

/datum/design/circuit/shield_diffuser
	name = "Shield Diffuser"
	desc = "Allows for the construction of a shield generator circuit board."
	id = "shield_diffuser"
	req_tech = list(TECH_MAGNET = 3, TECH_POWER = 4)
	build_path = /obj/item/weapon/circuitboard/shield_diffuser
	sort_string = "VAAAB"

/datum/design/circuit/ntnet_relay
	name = "SolNet Quantum Relay"
	id = "ntnet_relay"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/ntnet_relay
	sort_string = "WAAAA"




/datum/design/item/integrated_printer
	name = "Integrated Circuit Printer"
	desc = "This machine provides all the necessary things for circuitry."
	id = "icprinter"
	req_tech = list(TECH_MATERIAL = 2, TECH_ENGINEERING = 1)
	materials = list(MATERIAL_STEEL = 10000, "glass" = 5000)
	build_type = PROTOLATHE
	build_path = /obj/item/device/integrated_circuit_printer
	sort_string = "WCLAC"

/datum/design/item/integrated_printer_upgrade_advanced
	name = "Integrated Circuit Printer Upgrade Disk"
	desc = "This disk allows for integrated circuit printers to print advanced circuitry designs."
	id = "icupgradv"
	req_tech = list(TECH_MATERIAL = 3, TECH_ENGINEERING = 3)
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_GLASS = 10000)
	build_type = PROTOLATHE
	build_path = /obj/item/disk/integrated_circuit/upgrade/advanced
	sort_string = "WCLAD"

/datum/design/item/integrated_printer_upgrade_clone
	name = "Integrated Circuit Printer Clone Disk"
	desc = "This disk allows for integrated circuit printers to copy and clone designs instantaneously."
	id = "icupclo"
	req_tech = list(TECH_DATA = 3, TECH_MATERIAL = 5)
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_GLASS = 10000)
	build_type = PROTOLATHE
	build_path = /obj/item/disk/integrated_circuit/upgrade/clone
	sort_string = "WCLAE"