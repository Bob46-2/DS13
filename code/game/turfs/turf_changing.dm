/turf/proc/ReplaceWithLattice()
	src.ChangeTurf(get_base_turf_by_area(src))
	spawn()
		new /obj/structure/lattice( locate(src.x, src.y, src.z) )

// Removes all signs of lattice on the pos of the turf -Donkieyo
/turf/proc/RemoveLattice()

	for (var/obj/structure/lattice/L in src)
		qdel(L)

// Called after turf replaces old one
/turf/proc/post_change()
	levelupdate()

	//Rebuild blocking atoms
	for (var/atom/movable/A in contents)
		if (A.can_block_movement)
			LAZYADD(movement_blocking_atoms, A)

//Creates a new turf
/turf/proc/ChangeTurf(turf/N, tell_universe = TRUE, force_lighting_update = FALSE, keep_air = FALSE)
	if (!N)
		return

	// This makes sure that turfs are not changed to space when one side is part of a zone
	if(N == /turf/space)
		var/turf/below = GetBelow(src)
		if(istype(below) && !istype(below,/turf/space))
			N = /turf/simulated/open

	var/old_air = air
	var/old_fire = fire
	var/old_opacity = opacity
	var/old_dynamic_lighting = dynamic_lighting
	var/old_affecting_lights = affecting_lights
	var/old_lighting_overlay = lighting_overlay
	var/old_corners = corners

//	log_debug("Replacing [src.type] with [N]")

	changing_turf = TRUE

	if(connections) connections.erase_all()

	overlays.Cut()
	underlays.Cut()
	if(istype(src,/turf/simulated))
		//Yeah, we're just going to rebuild the whole thing.
		//Despite this being called a bunch during explosions,
		//the zone will only really do heavy lifting once.
		var/turf/simulated/S = src
		if(S.zone) S.zone.rebuild()

	// Run the Destroy() chain.
	qdel(src)

	var/old_opaque_counter = opaque_counter
	var/turf/simulated/W = new N(src)

	W.opaque_counter = old_opaque_counter



	if (keep_air)
		W.air = old_air

	if(ispath(N, /turf/simulated))
		if(old_fire)
			fire = old_fire
		if (istype(W,/turf/simulated/floor))
			W.RemoveLattice()
	else if(old_fire)
		qdel(old_fire)

	if(tell_universe)
		GLOB.universe.OnTurfChange(W)

	SSair.mark_for_update(src) //handle the addition of the new turf.

	for(var/turf/space/S in range(W,1))
		S.update_starlight()

	W.post_change()
	. = W

	if(lighting_overlays_initialised)
		lighting_overlay = old_lighting_overlay
		affecting_lights = old_affecting_lights
		corners = old_corners
		if((old_opacity != opacity) || (dynamic_lighting != old_dynamic_lighting))
			reconsider_lights()
		if(dynamic_lighting != old_dynamic_lighting)
			if(dynamic_lighting)
				lighting_build_overlay()
			else
				lighting_clear_overlay()

	for(var/turf/T in RANGE_TURFS(src, 1))
		T.update_icon()

	INVOKE_ASYNC(GLOBAL_PROC, /proc/updateVisibility, W, FALSE)

/turf/proc/transport_properties_from(turf/other)
	if(!istype(other, src.type))
		return 0
	src.set_dir(other.dir)
	src.icon_state = other.icon_state
	src.icon = other.icon
	src.overlays = other.overlays.Copy()
	src.underlays = other.underlays.Copy()
	if(other.decals)
		src.decals = other.decals.Copy()
		src.update_icon()
	return 1

//I would name this copy_from() but we remove the other turf from their air zone for some reason
/turf/simulated/transport_properties_from(turf/simulated/other)
	if(!..())
		return 0

	if(other.zone)
		if(!src.air)
			src.make_air()
		src.air.copy_from(other.zone.air)
		other.zone.remove(other)
	return 1


//No idea why resetting the base appearence from New() isn't enough, but without this it doesn't work
/turf/simulated/shuttle/wall/corner/transport_properties_from(turf/simulated/other)
	. = ..()
	reset_base_appearance()
