/obj/item/weapon/spacecash/ewallet
	name = "Credit Chip"
	desc = "A digital store of EarthGov ration seals, the universally recognized unit of exchange in EarthGov territories, ships, colonies and stations. "
	icon = 'icons/obj/economy.dmi'
	icon_state = "grey"
	var/owner_name = "" //So the ATM can set it so the EFTPOS can put a valid name on transactions.

/obj/item/weapon/spacecash/ewallet/examine(mob/user)
	. = ..(user)
	if (!(user in view(2)) && user!=src.loc) return
	to_chat(user, "<span class='notice'>Chip's owner: [src.owner_name]. Credits remaining: [src.worth].</span>")

/obj/item/weapon/spacecash/ewallet/proc/set_worth(var/newval)
	worth = newval
	update_icon()

/obj/item/weapon/spacecash/ewallet/proc/modify_worth(var/newval)
	worth += newval
	update_icon()


/obj/item/weapon/spacecash/ewallet/update_icon()
	icon_state = "grey"
	switch(worth)
		if (1 to 500)
			icon_state = "gold"
		if (501 to 1000)
			icon_state = "green"
		if (1001 to 5000)
			icon_state = "blue"
		if (5001 to 10000)
			icon_state = "purple"
		if (10001 to INFINITY)
			icon_state = "orange"

/*
	Random credit chips used in loot
*/
/obj/item/weapon/spacecash/ewallet/random/Initialize()
	.=..()
	set_worth(round(rand_between(initial(worth)*0.5, initial(worth)*1.5), 1))

/obj/item/weapon/spacecash/ewallet/random/c200
	worth = 200

/obj/item/weapon/spacecash/ewallet/random/c500
	worth = 500

/obj/item/weapon/spacecash/ewallet/random/c1000
	worth = 1000

/obj/item/weapon/spacecash/ewallet/random/c5000
	worth = 5000

/obj/item/weapon/spacecash/ewallet/random/c10000
	worth = 10000









//Helpers
/datum/proc/credits_recieved(var/balance, var/datum/source)
	return TRUE