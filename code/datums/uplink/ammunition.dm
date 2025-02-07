/*************
* Ammunition *
*************/
/datum/uplink_item/item/ammo
	item_cost = 4
	category = /datum/uplink_category/ammunition

/datum/uplink_item/item/ammo/c45m
	name = ".45"
	path = /obj/item/ammo_magazine/c45m

/datum/uplink_item/item/ammo/mc9mm
	name = "9mm"
	item_cost = 3
	path = /obj/item/ammo_magazine/mc9mm

/datum/uplink_item/item/ammo/darts
	name = "Darts"
	path = /obj/item/ammo_magazine/chemdart

/datum/uplink_item/item/ammo/mc9mmds
	name = "9mm double-stack"
	item_cost = 6
	path = /obj/item/ammo_magazine/mc9mmds

/datum/uplink_item/item/ammo/a357
	name = ".357"
	item_cost = 8
	path = /obj/item/ammo_magazine/a357

/datum/uplink_item/item/ammo/a556
	name = "5.56mm"
	item_cost = 8
	path = /obj/item/ammo_magazine/c556

/datum/uplink_item/item/ammo/sniperammo
	name = "14.5mm"
	item_cost = 8
	path = /obj/item/weapon/storage/box/sniperammo

/datum/uplink_item/item/ammo/sniperammo/apds
	name = "14.5mm APDS"
	item_cost = 12
	path = /obj/item/weapon/storage/box/sniperammo/apds

/datum/uplink_item/item/ammo/shotgun_shells
	name = "Shotgun Shells box"
	item_cost = 8
	path = /obj/item/weapon/storage/box/shotgunshells

/datum/uplink_item/item/ammo/shotgun_slugs
	name = "Shotgun Slugs box"
	item_cost = 8
	path = /obj/item/weapon/storage/box/shotgunammo

/datum/uplink_item/item/ammo/c45uzi
	name = ".45 SMG Magazine"
	item_cost = 8
	path = /obj/item/ammo_magazine/c45uzi

/datum/uplink_item/item/ammo/c45uzi/special
	item_cost = 2
	is_special = TRUE

/datum/uplink_item/item/ammo/a10mm
	name = "10mm SMG Magazine"
	item_cost = 8
	path = /obj/item/ammo_magazine/a10mm

/datum/uplink_item/item/ammo/a10mm/special
	item_cost = 2
	is_special = TRUE

/datum/uplink_item/item/ammo/bullpup/special
	item_cost = 8
	path = /obj/item/ammo_magazine/bullpup
	is_special = TRUE
	antag_roles = list(MODE_UNITOLOGIST, MODE_UNITOLOGIST_SHARD)

/datum/uplink_item/item/ammo/a50
	name = ".50 AE magazine"
	item_cost = 8
	path = /obj/item/ammo_magazine/a50

/datum/uplink_item/item/ammo/c50
	name = ".50 AE speedloader"
	item_cost = 8
	path = /obj/item/ammo_magazine/c50

/datum/uplink_item/item/ammo/c38
	name = ".38 speedloader"
	item_cost = 8
	path = /obj/item/ammo_magazine/c38

/datum/uplink_item/item/ammo/flechette
	name = "Flechette Magazine"
	item_cost = 8
	path = /obj/item/weapon/magnetic_ammo

/datum/uplink_item/item/ammo/divet
	name = "Divet Magazine (standard)"
	item_cost = 2
	path = /obj/item/ammo_magazine/divet
	is_special = TRUE
	antag_roles = list(MODE_EARTHGOV_AGENT)


/datum/uplink_item/item/ammo/divet/HP
	name = "Divet Magazine (hollowpoint)"
	item_cost = 3
	path = /obj/item/ammo_magazine/divet/hollow_point


/datum/uplink_item/item/ammo/divet/AP
	name = "Divet Magazine (armor piercing)"
	item_cost = 3
	path = /obj/item/ammo_magazine/divet/ap

/datum/uplink_item/item/ammo/divet/incendiary
	name = "Divet Magazine (incendiary)"
	item_cost = 4
	path = /obj/item/ammo_magazine/divet/incendiary