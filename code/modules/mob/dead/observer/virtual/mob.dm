/mob/dead/observer/virtual/mob
	host_type = /mob

/mob/dead/observer/virtual/mob/New(var/location, var/mob/host)
	..()

	GLOB.sight_set_event.register(host, src, /mob/dead/observer/virtual/mob/proc/sync_sight)
	GLOB.see_invisible_set_event.register(host, src, /mob/dead/observer/virtual/mob/proc/sync_sight)
	GLOB.see_in_dark_set_event.register(host, src, /mob/dead/observer/virtual/mob/proc/sync_sight)

	sync_sight(host)

/mob/dead/observer/virtual/mob/Destroy()
	GLOB.sight_set_event.unregister(host, src, /mob/dead/observer/virtual/mob/proc/sync_sight)
	GLOB.see_invisible_set_event.unregister(host, src, /mob/dead/observer/virtual/mob/proc/sync_sight)
	GLOB.see_in_dark_set_event.unregister(host, src, /mob/dead/observer/virtual/mob/proc/sync_sight)
	. = ..()

/mob/dead/observer/virtual/mob/proc/sync_sight(var/mob/mob_host)
	sight = mob_host.sight
	see_invisible = mob_host.see_invisible

