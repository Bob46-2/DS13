GLOBAL_LIST_EMPTY(skills)

/decl/hierarchy/skill
	var/ID = "none"					// ID of this skill. Needs to be unique.
	name = "None" 				// Name of the skill. This is what the player sees.
	var/desc = "Placeholder skill" 	// Generic description of this skill.

   	// Names for different skill values, in order from 1 up.
	var/levels = list( 		"Unskilled"			= "Unskilled Description",
							"Basic"				= "Basic Description",
							"Trained"			= "Trained Description",
							"Experienced"		= "Experienced Description",
							"Master"		= "Professional Description")
	var/difficulty = SKILL_AVERAGE   //Used to compute how expensive the skill is
	var/default_max = SKILL_ADEPT    //Makes the skill capped at this value in selection unless overriden at job level.

/decl/hierarchy/skill/proc/get_cost(var/level)
	switch(level)
		if(SKILL_BASIC, SKILL_ADEPT)
			return difficulty
		if(SKILL_EXPERT, SKILL_PROF)
			return 2*difficulty
		else
			return 0

//Do not attempt to get_decl any of these except /decl/hierarchy/skill from decls_repository. Use the children variable or GLOB.skills instead.
/decl/hierarchy/skill/New(var/full_init = TRUE)
	..(full_init)
	if(full_init)
		if(!GLOB.skills.len)
			for(var/decl/hierarchy/skill/C in children)
				GLOB.skills += C.children
		else
			log_debug("<span class='warning'>Warning: multiple instances of /decl/hierarchy/skill have been created!</span>")

/decl/hierarchy/skill/dd_SortValue()
	return ID

/decl/hierarchy/skill/general
	name = "General"
	ID	 = "1"
	default_max = SKILL_MAX //these are all set to max as placeholders for now, will be adjusted once we setup the jobs specifically for the ds13 maps.

/decl/hierarchy/skill/service
	name = "Service"
	ID	 = "service"
	default_max = SKILL_MAX

/decl/hierarchy/skill/security
	name = "Security"
	ID	 = "security"
	default_max = SKILL_MAX

/decl/hierarchy/skill/engineering
	name = "Engineering"
	ID	 = "engineering"
	default_max = SKILL_MAX

/decl/hierarchy/skill/medical
	name = "Medical"
	ID	 = "medical"
	default_max = SKILL_MAX

/decl/hierarchy/skill/research
	name = "Research"
	ID	 = "research"
	default_max = SKILL_MAX

// ONLY SKILL DEFINITIONS BELOW THIS LINE
// Category: General

/decl/hierarchy/skill/general/EVA
	ID = "EVA"
	name = "Rig Zero Gravity Manipulation"
	desc = "This skill describes your skill and knowledge of rig-suits and their operation in the void of space."
	levels = list( "Unskilled"			= "You have basic safety training common to people who work in space: You know how to put on and seal your internals, and you can probably struggle into a spaceworthy rig suit if you really need to, though you'll be clumsy at it. You're still prone to mistakes that may leave you trying to breathe vacuum.",
						"Basic"				= "You have had thorough basic training in EVA operations, and are unlikely to make novice mistakes. However, you have little experience working in vacuum.",
						"Trained"			= "You can comfortably use a spaceworthy rig suit and do so regularly in the course of your work. Checking your internals is second nature to you, and you don't panic in an emergency.",
						"Experienced"		= "You can use all kinds of spaceworthy rig suits, including specialized versions. Your years of experience in EVA keep you from being disoriented in space, and you have experience using a jetpack to move around.",
						"Master"		= "You are just as much at home in a vacuum as in atmosphere. You have probably seen some form of military service in a zero gravity environment, or worked in a zero gravity environment fulltime for several years.")
	difficulty = SKILL_AVERAGE

/decl/hierarchy/skill/general/hauling
	ID = "hauling"
	name = "Athletics"
	desc = "Your ability to perform tasks requiring great strength, dexterity, or endurance. Affects work speed and failure chance when mining"
	levels = list( "Unskilled"			= "You are not used to manual labor, tire easily, and are likely not in great shape. Extended heavy labor may be dangerous for you.",
						"Basic"				= "You have some familiarity with manual labor, and are in reasonable physical shape. Tasks requiring great dexterity or strength may still elude you.",
						"Trained"			= "You have sufficient strength and dexterity for even very strenuous tasks, and can work for a long time without tiring.",
						"Experienced"		= "You have experience with heavy work in trying physical conditions, and are in excellent shape. You visit the gym frequently.",
						"Master"		= "In addition to your excellent strength and endurance, you have a lot of experience with the specific physical demands of your job. You may have competitive experience with some form of athletics.")
	difficulty = SKILL_EASY

/decl/hierarchy/skill/general/computer
	ID = "computer"
	name = "Information Technology"
	desc = "Describes your understanding of computers, software and communication technologies."
	levels = list( "Unskilled"			= "You know how to use the computers and communication devices that you grew up with. You can use a computer console, a handheld or wall-mounted radio, and your headset, as well as your PDA.",
						"Basic"				= "You know the basics of programming, but you're not very good at it and couldn't do it professionally. You understand how information is stored in a computer, and you can fix simple computer problems. You're computer-literate, but you still make mistakes.",
						"Trained"			= "At this level, you're probably working with computers on a daily basis. You understand and can repair an internal telecommunications network.",
						"Experienced"		= "You have years of experience with computer networks, telecommunications, and sysadmin tasks. You know the systems used on a daily basis intimately, and can diagnose complex problems.",
						"Master"		= "People are probably starting to wonder whether you might be a computer yourself. Computer code is your first language; You could build a telecommunications network from the ground up using only spare parts.")
	difficulty = SKILL_EASY


/decl/hierarchy/skill/research/devices
	ID = "devices"
	name = "Complex Devices"
	desc = "Describes the ability to assemble complex devices, such as computers, circuits, printers, robots or gas tank assemblies (bombs). Note that if a device requires electronics or programming, those skills are also required in addition to this skill."
	levels = list( "Unskilled"			= "You know how to use the technology that was present in whatever society you grew up in. You know how to tell when something is malfunctioning, but you have to call tech support to get it fixed.",
						"Basic"				= "You use and repair high-tech equipment in the course of your daily work. You can fix simple problems, and you know how to use a circuit printer or autolathe. You can build simple robots such as cleanbots and medibots.",
						"Trained"			= "You can build or repair an exosuit or cyborg chassis, use a protolathe and destructive analyzer, and build prosthetic limbs. You can safely transfer an MMI or posibrain into a cyborg chassis.<br>- You can attach robotic limbs. Its speed increases with level.",
						"Experienced"		= "You have years of experience building or reverse-engineering complex devices. Your use of the lathes and destructive analyzers is efficient and methodical. You can design contraptions to order, and likely sell those designs at a profit.",
						"Master"		= "You are an inventor or researcher. You can design, build, and modify equipment that most people don't even know exists. You are at home in the lab and the workshop and you've never met a gadget you couldn't take apart, put back together, and replicate.")
	difficulty = SKILL_EASY


// Category: Service

/decl/hierarchy/skill/service/cooking
	ID = "cooking"
	name = "Cooking"
	desc = "Describes a character's skill at preparing meals and other consumable goods. This includes mixing alcoholic beverages."
	levels = list( "Unskilled"			= "You barely know anything about cooking, and stick to vending machines when you can. The microwave is a device of black magic to you, and you avoid it when possible.",
						"Basic"				= "You can make simple meals and do the cooking for your family. Things like spaghetti, grilled cheese, or simple mixed drinks are your usual fare.",
						"Trained"			= "You can make most meals while following instructions, and they generally turn out well. You have some experience with hosting, catering, and/or bartending.",
						"Experienced"		= "You can cook professionally, keeping an entire crew fed easily. Your food is tasty and you don't have a problem with tricky or complicated dishes. You can be depended on to make just about any commonly-served drink.",
						"Master"		= "Not only are you good at cooking and mixing drinks, but you can manage a kitchen staff and cater for special events. You can safely prepare exotic foods and drinks that would be poisonous if prepared incorrectly.")
	difficulty = SKILL_AVERAGE

/decl/hierarchy/skill/service/botany
	ID = "botany"
	name = "Botany"
	desc = "Describes how good a character is at growing and maintaining plants."
	levels = list( "Unskilled"			= "You know next to nothing about plants. While you can attempt to plant, weed, or harvest, you are just as likely to kill the plant instead.",
						"Basic"				= "You've done some gardening. You can water, weed, fertilize, plant, and harvest, and you can recognize and deal with pests. You may be a hobby gardener.<br>- You can safely plant and weed normal plants.<br>- You can tell weeds and pests apart from each other.",
						"Trained"			= "You are proficient at botany, and can grow plants for food or oxygen production. Your plants will generally survive and prosper. You know the basics of manipulating plant genes.<br>- You can safely plant and weed exotic plants.<br>- You can operate xenoflora machines. The sample's degradation decreases with skill level.",
						"Experienced"		= "You're a botanist or farmer, capable of running a facility's hydroponics farms or doing botanical research. You are adept at creating custom hybrids and modified strains.",
						"Master"		= "You're a specialized botanist. You can care for even the most exotic, fragile, or dangerous plants. You can use gene manipulation machinery with precision, and are often able to avoid the degradation of samples.")


// Category: Security

/decl/hierarchy/skill/security/combat
	ID = "combat"
	name = "Close Combat"
	desc = "This skill describes your training in hand-to-hand combat or melee weapon usage. While expertise in this area is rare in the era of firearms, experts still exist among athletes."
	levels = list( "Unskilled"			= "You can throw a punch or a kick, but it'll knock you off-balance. You're inexperienced and have probably never been in a serious hand-to-hand fight. In a fight, you might panic and run, grab whatever's nearby and blindly strike out with it, or (if the other guy is just as much of a beginner as you are) make a fool out of yourself.",
						"Basic"				= "You either have some experience with fistfights, or you have some training in a martial art. You can handle yourself if you really have to, and if you're a security officer, can handle a stun baton at least well enough to get the handcuffs onto a criminal.",
						"Trained"			= "You have had close-combat training, and can easily defeat unskilled opponents. Close combat may not be your specialty, and you don't engage in it more than needed, but you know how to handle yourself in a fight.",
						"Experienced"		= "You're good at hand-to-hand combat. You've trained explicitly in a martial art or as a close combatant as part of a military or police unit. You can use weaponry competently and you can think strategically and quickly in a melee. You're in good shape and you spend time training.",
						"Master"		= "You specialize in hand-to-hand combat. You're well-trained in a practical martial art, and in good shape. You spend a lot of time practicing. You can take on just about anyone, use just about any weapon, and usually come out on top. You may be a professional athlete or special forces member.")
	difficulty = SKILL_AVERAGE

/decl/hierarchy/skill/security/weapons
	ID = "weapons"
	name = "Weapons Expertise"
	desc = "This skill describes your expertise with and knowledge of weapons. A low level in this skill implies knowledge of simple weapons, for example flashes. A high level in this skill implies knowledge of complex weapons, such as unconfigured grenades, riot shields, pulse rifles or bombs. A low-medium level in this skill is typical for security officers, a high level of this skill is typical for special agents and soldiers."
	levels = list( "Unskilled"			= "You know how to recognize a weapon when you see one. You can point a gun and shoot it, though results vary wildly. You might forget the safety, you can't control burst recoil well, and you don't have trained reflexes for gun fighting.",
						"Basic"				= "You know how to handle weapons safely, and you're comfortable using simple weapons. Your aim is decent and you can usually be trusted not to do anything stupid with a weapon you are familiar with, but your training isn't automatic yet and your performance will degrade in high-stress situations.",
						"Trained"			= "You have had extensive weapons training, or have used weapons in combat. Your aim is better now. You are familiar with most types of weapons and can use them in a pinch. You have an understanding of tactics, and can be trusted to stay calm under fire. You may have military or police experience and you probably carry a weapon on the job.",
						"Experienced"		= "You've used firearms and other ranged weapons in high-stress situations, and your skills have become automatic. Your aim is good. You are likely a part of some paramilitary group or a former member of the Earth Defense Force.",
						"Master"		= "You are an exceptional shot with a variety of military-grade weapons, you can field strip, clean and reassemble any modern weapon placed before you in a matter of minutes. You use a weapon as naturally as though it were a part of your own body. You are likely an active member of the Earth Defense Force.")
	difficulty = SKILL_AVERAGE

/decl/hierarchy/skill/security/weapons/get_cost(var/level)
	switch(level)
		if(SKILL_BASIC)
			return difficulty
		if(SKILL_ADEPT)
			return 2*difficulty
		if(SKILL_EXPERT, SKILL_PROF)
			return 4*difficulty
		else
			return 0

/decl/hierarchy/skill/security/forensics
	ID = "forensics"
	name = "Forensics"
	desc = "Describes your skill at performing forensic examinations and identifying vital evidence. Does not cover analytical abilities, and as such isn't the only indicator for your investigation skill. Note that in order to perform autopsy, the surgery skill is also required."
	levels = list( "Unskilled"			= "You know that detectives solve crimes. You may have some idea that it's bad to contaminate a crime scene, but you're not too clear on the details.",
						"Basic"				= "You know how to avoid contaminating a crime scene. You know how to bag the evidence without contaminating it unduly.",
						"Trained"			= "You are trained in collecting forensic evidence - fibers, fingerprints, the works. You know how autopsies are done, and might've assisted performing one.<br>- You can more easily detect fingerprints.<br>- You no longer contaminate evidence.",
						"Experienced"		= "You're a pathologist, or detective. You've seen your share of bizarre cases, and spent a lot of time putting pieces of forensic puzzle together, so you're faster now.<br>- You can notice additional details upon examining, such as fibers, partial prints, and gunshot residue.",
						"Master"		= "You're a big name in forensic science. You might be an investigator who cracked a famous case, or you published papers on new methods of forensics. Either way, if there's a forensic trail, you will find it, period.<br>- You can notice traces of wiped off blood.")


/decl/hierarchy/skill/security/forensics/get_cost(var/level)
	switch(level)
		if(SKILL_BASIC, SKILL_ADEPT, SKILL_EXPERT)
			return difficulty * 2
		if(SKILL_PROF)
			return 3 * difficulty
		else
			return 0

// Category: Engineering

/decl/hierarchy/skill/engineering/construction
	ID = "construction"
	name = "Construction"
	desc = "Your ability to construct various buildings, such as walls, floors, tables and so on. Note that constructing devices such as APCs additionally requires the Electronics skill. A low level of this skill is typical for janitors, a high level of this skill is typical for engineers. Affects workspeed and success rate of tool operations during crafting"
	levels = list( "Unskilled"			= "You can move furniture, assemble or disassemble chairs and tables (sometimes they even stay assembled), bash your way through a window, open a crate, or pry open an unpowered airlock. You can recognize and use basic hand tools and inflatable barriers, though not very well.",
						"Basic"				= "You can dismantle or build a wall or window, build furniture, redecorate a room, and replace floor tiles and carpeting. You can safely use a welder without burning your eyes, and using hand tools is second nature to you.",
						"Trained"			= "You can build, repair, or dismantle most things, but will occasionally make mistakes and have things not come out the way you expected.",
						"Experienced"		= "You know how to seal a breach, rebuild broken piping, and repair major damage. You know the basics of structural engineering.",
						"Master"		= "You are a construction worker or engineer. You could pretty much rebuild the installation or ship from the ground up, given supplies, and you're efficient and skilled at repairing damage.")
	difficulty = SKILL_HARD

/decl/hierarchy/skill/engineering/electrical
	ID = "electrical"
	name = "Electrical Engineering"
	desc = "This skill describes your knowledge of electronics and the underlying physics. A low level of this skill implies you know how to lay out wiring and configure powernets, a high level of this skill is required for working complex electronic devices such as circuits"
	levels = list( "Unskilled"			= "You know that electrical wires are dangerous and getting shocked is bad; you can see and report electrical malfunctions such as broken wires or malfunctioning APCs. You can change a light bulb, and you know how to replace a battery or charge up the equipment you normally use.",
						"Basic"				= "You can do basic wiring; you can lay cable for solars or the engine. You can repair broken wiring and build simple electrical equipment like light fixtures or APCs. You know the basics of circuits and understand how to protect yourself from electrical shock. You can probably hack a vending machine.",
						"Trained"			= "You can repair and build electrical equipment and do so on a regular basis. You can troubleshoot an electrical system and monitor the installation power grid. You can probably hack an airlock.",
						"Experienced"		= "You can repair, build, and diagnose any electrical devices with ease. You know your way around APCs, SMES units, and monitoring software, and take apart or hack most objects.",
						"Master"		= "You are an electrical engineer or the equivalent. You can design, upgrade, and modify electrical equipment and you are good at maximizing the efficiency of your power network. You can hack anything on the installation you can deal with power outages and electrical problems easily and efficiently.")
	difficulty = SKILL_HARD

// Category: Medical

/decl/hierarchy/skill/medical/medical
	ID = "medical"
	name = "Medicine"
	desc = "Covers an understanding of the human body and medicine. At a low level, this skill gives a basic understanding of applying common types of medicine, and a rough understanding of medical devices like the health analyzer. At a high level, this skill grants exact knowledge of all the medicine available on the installation, as well as the ability to use complex medical devices like the body scanner or mass spectrometer."
	levels = list( "Unskilled"			= "You know basic first aid, such as how to apply a bandage or ointment to an injury. You can use an autoinjector designed for civilian use, probably by reading the directions printed on it. You can tell when someone is badly hurt and needs a doctor; you can see whether someone has a badly broken bone, is having trouble breathing, or is unconscious. You may not be able to tell the difference between unconscious and dead.",
						"Basic"				= "You've taken a first-aid training, nursing, or EMT course. You can stop bleeding, do CPR, apply a splint, take someone's pulse, apply trauma and burn treatments, and read a handheld health scanner. You probably know that Dylovene helps poisoning and Dexalin helps people with breathing problems; you can use a syringe or start an IV. You've been briefed on the symptoms of common emergencies like a punctured lung, appendicitis, alcohol poisoning, or broken bones, and though you can't treat them, you know that they need a doctor's attention. You can recognize most emergencies as emergencies and safely stabilize and transport a patient.",
						"Trained"			= "You are an experienced EMT or a medical resident. You know how to treat most illnesses and injuries, though exotic illnesses and unusual injuries may still stump you. You have probably begun to specialize in some sub-field of medicine. In emergencies, you can think fast enough to keep your patients alive, and even when you can't treat a patient, you know how to find someone who can. You can use a full-body scanner, and you know something's off about a patient with a parasite.",
						"Experienced"		= "You are a practicing doctor or EMT. You know how to use all of the medical devices available to treat a patient. Your deep knowledge of the body and medications will let you diagnose and come up with a course of treatment for most ailments. You can perform a full-body scan thoroughly and find important information.",
						"Master"		= "You are an experienced doctor or EMT. You've seen almost everything there is to see when it comes to injuries and illness and even when it comes to something you haven't seen, you can apply your wide knowledge base to put together a treatment. In a pinch, you can do just about any medicine-related task, but your specialty, whatever it may be, is where you really shine.")
	difficulty = SKILL_HARD

/decl/hierarchy/skill/medical/anatomy
	ID = "anatomy"
	name = "Anatomy"
	desc = "Gives you a detailed insight of the human body. A high skill in this is required to perform surgery. This skill may also help in examining alien biology."
	levels = list( "Unskilled"			= "You know what organs, bones, and such are, and you know roughly where they are. You know that someone who's badly hurt or sick may need surgery.",
						"Basic"				= "You've taken an anatomy class and you've spent at least some time poking around inside actual people. You know where everything is, more or less. You could assist in surgery, if you have the required medical skills. If you have the forensics knowledge, you could perform an autopsy. If you really had to, you could probably perform basic surgery such as an appendectomy, but you're not yet a qualified surgeon and you really shouldn't--not unless it's an emergency.",
						"Trained"			= "You have some training in anatomy. Diagnosing broken bones, damaged ligaments, shrapnel wounds, and other trauma is straightforward for you. You can splint limbs with a good chance of success, operate a defibrillator competently, and perform CPR well. Surgery is still outside your training.",
						"Experienced"		= "You're a surgical resident, or an experienced medical doctor. You can put together broken bones, fix a damaged lung, patch up a liver, or remove an appendix without problems. But tricky surgeries, with an unstable patient or delicate manipulation of vital organs like the heart and brain, are at the edge of your ability, and you prefer to leave them to specialized surgeons. You can recognize when someone's anatomy is noticeably unusual.",
						"Master"		= "You are an experienced surgeon. You can handle anything that gets rolled, pushed, or dragged into the OR, and you can keep a patient alive and stable even if there's no one to assist you. You can handle severe trauma cases or multiple organ failure, repair brain damage, and perform heart surgery. By now, you've probably specialized in one field, where you may have made new contributions to surgical technique. You can detect even small variations in the anatomy of a patient.")
	difficulty = SKILL_HARD
