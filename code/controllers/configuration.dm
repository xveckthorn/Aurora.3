var/list/gamemode_cache = list()

/datum/configuration
	var/server_name = null				// server name (for world name / status)
	var/server_suffix = 0				// generate numeric suffix based on server port

	var/nudge_script_path = "nudge.py"  // where the nudge.py script is located

	var/log_ooc = 0						// log OOC channel
	var/log_access = 0					// log login/logout
	var/log_say = 0						// log client say
	var/log_admin = 0					// log admin actions
	var/log_debug = 1					// log debug output
	var/log_game = 0					// log game events
	var/log_vote = 0					// log voting
	var/log_whisper = 0					// log client whisper
	var/log_emote = 0					// log emotes
	var/log_attack = 0					// log attack messages
	var/log_adminchat = 0				// log admin chat messages
	var/log_adminwarn = 0				// log warnings admins get about bomb construction and such
	var/log_pda = 0						// log pda messages
	var/log_hrefs = 0					// logs all links clicked in-game. Could be used for debugging and tracking down exploits
	var/log_runtime = 0					// logs world.log to a file
	var/log_world_output = 0			// log world.log << messages
	var/sql_enabled = 1					// for sql switching
	var/allow_admin_ooccolor = 0		// Allows admins with relevant permissions to have their own ooc colour
	var/allow_vote_restart = 0 			// allow votes to restart
	var/ert_admin_call_only = 0
	var/allow_vote_mode = 0				// allow votes to change mode
	var/allow_admin_jump = 1			// allows admin jumping
	var/allow_admin_spawning = 1		// allows admin item spawning
	var/allow_admin_rev = 1				// allows admin revives
	var/vote_delay = 6000				// minimum time between voting sessions (deciseconds, 10 minute default)
	var/vote_period = 600				// length of voting period (deciseconds, default 1 minute)
	var/vote_autotransfer_initial = 108000 // Length of time before the first autotransfer vote is called
	var/vote_autotransfer_interval = 36000 // length of time before next sequential autotransfer vote
	var/vote_autogamemode_timeleft = 100 //Length of time before round start when autogamemode vote is called (in seconds, default 100).
	var/transfer_timeout = 72000		// timeout before a transfer vote can be called (deciseconds, 120 minute default)
	var/vote_no_default = 0				// vote does not default to nochange/norestart (tbi)
	var/vote_no_dead = 0				// dead people can't vote (tbi)
//	var/enable_authentication = 0		// goon authentication
	var/del_new_on_log = 1				// del's new players if they log before they spawn in
	var/feature_object_spell_system = 0 //spawns a spellbook which gives object-type spells instead of verb-type spells for the wizard
	var/traitor_scaling = 0 			//if amount of traitors scales based on amount of players
	var/objectives_disabled = 0 			//if objectives are disabled or not
	var/protect_roles_from_antagonist = 0// If security and such can be traitor/cult/other
	var/continous_rounds = 0			// Gamemodes which end instantly will instead keep on going until the round ends by escape shuttle or nuke.
	var/allow_Metadata = 0				// Metadata is supported.
	var/popup_admin_pm = 0				//adminPMs to non-admins show in a pop-up 'reply' window when set to 1.
	var/Ticklag = 0.9
	var/Tickcomp = 0
	var/socket_talk	= 0					// use socket_talk to communicate with other processes
	var/list/resource_urls = null
	var/antag_hud_allowed = 0			// Ghosts can turn on Antagovision to see a HUD of who is the bad guys this round.
	var/antag_hud_restricted = 0                    // Ghosts that turn on Antagovision cannot rejoin the round.
	var/list/mode_names = list()
	var/list/modes = list()				// allowed modes
	var/list/votable_modes = list()		// votable modes
	var/list/probabilities = list()		// relative probability of each mode
	var/humans_need_surnames = 0
	var/allow_random_events = 0			// enables random events mid-round when set to 1
	var/allow_ai = 1					// allow ai job
	var/hostedby = null
	var/respawn = 1
	var/guest_jobban = 1
	var/usewhitelist = 0
	var/kick_inactive = 0				//force disconnect for inactive players after this many minutes, if non-0
	var/show_mods = 0
	var/show_mentors = 0
	var/show_auxiliary_roles = 0		//toggles all secondary staff members. Such as CCIAA, Devs, etcetera.
	var/mods_can_tempban = 0
	var/mods_can_job_tempban = 0
	var/mod_tempban_max = 1440
	var/mod_job_tempban_max = 1440
	var/load_jobs_from_txt = 0
	var/ToRban = 0
	var/automute_on = 0					//enables automuting/spam prevention
	var/jobs_have_minimal_access = 0	//determines whether jobs use minimal access or expanded access.

	var/cult_ghostwriter = 1               //Allows ghosts to write in blood in cult rounds...
	var/cult_ghostwriter_req_cultists = 10 //...so long as this many cultists are active.

	var/character_slots = 10				// The number of available character slots

	var/max_maint_drones = 5				//This many drones can spawn,
	var/allow_drone_spawn = 1				//assuming the admin allow them to.
	var/drone_build_time = 1200				//A drone will become available every X ticks since last drone spawn. Default is 2 minutes.

	var/disable_player_mice = 0
	var/uneducated_mice = 0 //Set to 1 to prevent newly-spawned mice from understanding human speech

	var/usealienwhitelist = 0
	var/limitalienplayers = 0
	var/alien_to_human_ratio = 0.5
	var/allow_extra_antags = 0
	var/guests_allowed = 1
	var/debugparanoid = 0

	var/serverurl
	var/server
	var/banappeals
	var/wikiurl
	var/forumurl
	var/githuburl

	//Alert level description
	var/alert_desc_green = "All threats to the station have passed. Security may not have weapons visible, privacy laws are once again fully enforced."
	var/alert_desc_blue_upto = "The station has received reliable information about possible hostile activity on the station. Security staff may have weapons visible, random searches are permitted."
	var/alert_desc_blue_downto = "The immediate threat has passed. Security may no longer have weapons drawn at all times, but may continue to have them visible. Random searches are still allowed."
	var/alert_desc_red_upto = "There is an immediate serious threat to the station. Security may have weapons unholstered at all times. Random searches are allowed and advised."
	var/alert_desc_red_downto = "The self-destruct mechanism has been deactivated, there is still however an immediate serious threat to the station. Security may have weapons unholstered at all times, random searches are allowed and advised."
	var/alert_desc_delta = "The station's self-destruct mechanism has been engaged. All crew are instructed to obey all instructions given by heads of staff. Any violations of these orders can be punished by death. This is not a drill."

	var/forbid_singulo_possession = 0

	//game_options.txt configs

	var/health_threshold_softcrit = 0
	var/health_threshold_crit = 0
	var/health_threshold_dead = -100

	var/organ_health_multiplier = 1
	var/organ_regeneration_multiplier = 1
	var/organs_decay
	var/default_brain_health = 400

	//Paincrit knocks someone down once they hit 60 shock_stage, so by default make it so that close to 100 additional damage needs to be dealt,
	//so that it's similar to HALLOSS. Lowered it a bit since hitting paincrit takes much longer to wear off than a halloss stun.
	var/organ_damage_spillover_multiplier = 0.5

	var/bones_can_break = 0
	var/limbs_can_break = 0

	var/revival_pod_plants = 1
	var/revival_cloning = 1
	var/revival_brain_life = -1

	var/use_loyalty_implants = 0

	var/welder_vision = 1
	var/generate_asteroid = 0

	//Used for modifying movement speed for mobs.
	//Unversal modifiers
	var/walk_speed = 0
	var/walk_delay_multiplier = 1
	var/run_delay_multiplier = 1
	var/vehicle_delay_multiplier = 1

	//Mob specific modifiers. NOTE: These will affect different mob types in different ways
	var/human_delay = 0
	var/robot_delay = 0
	var/monkey_delay = 0
	var/alien_delay = 0
	var/slime_delay = 0
	var/animal_delay = 0

	var/admin_legacy_system = 0	//Defines whether the server uses the legacy admin system with admins.txt or the SQL system. Config option in config.txt
	var/ban_legacy_system = 0	//Defines whether the server uses the legacy banning system with the files in /data or the SQL system. Config option in config.txt
	var/use_age_restriction_for_jobs = 0 //Do jobs use account age restrictions? --requires database
	var/sql_stats = 0			//Do we record round statistics on the database (deaths, round reports, population, etcetera) or not?
	var/sql_whitelists = 0		//Defined whether the server uses an SQL based whitelist system, or the legacy one with two .txts. Config option in config.txt
	var/sql_saves = 0			//Defines whether the server uses an SQL based character and preference saving system. Config option in config.txt

	var/simultaneous_pm_warning_timeout = 100

	var/use_recursive_explosions //Defines whether the server uses recursive or circular explosions.

	var/assistant_maint = 0 //Do assistants get maint access?
	var/gateway_delay = 18000 //How long the gateway takes before it activates. Default is half an hour.
	var/ghost_interaction = 0

	var/night_lighting = 0
	var/nl_start_hour = 19
	var/nl_finish_hour = 8

	var/comms_password = ""

	var/enter_allowed = 1

	var/use_discord_bot = 0
	var/discord_bot_host = "localhost"
	var/discord_bot_port = 0
	var/python_path = "python" //Path to the python executable.  Defaults to "python" on windows and "/usr/bin/env python2" on unix
	var/use_lib_nudge = 0 //Use the C library nudge instead of the python nudge.
	var/use_overmap = 0

	var/list/station_levels = list(1)				// Defines which Z-levels the station exists on.
	var/list/admin_levels= list(2)					// Defines which Z-levels which are for admin functionality, for example including such areas as Central Command and the Syndicate Shuttle
	var/list/contact_levels = list(1, 5)			// Defines which Z-levels which, for example, a Code Red announcement may affect
	var/list/player_levels = list(1, 3, 4, 5, 6)	// Defines all Z-levels a character can typically reach

	// Event settings
	var/expected_round_length = 3 * 60 * 60 * 10 // 3 hours
	// If the first delay has a custom start time
	// No custom time, no custom time, between 80 to 100 minutes respectively.
	var/list/event_first_run   = list(EVENT_LEVEL_MUNDANE = null, 	EVENT_LEVEL_MODERATE = null,	EVENT_LEVEL_MAJOR = list("lower" = 48000, "upper" = 60000))
	// The lowest delay until next event
	// 10, 30, 50 minutes respectively
	var/list/event_delay_lower = list(EVENT_LEVEL_MUNDANE = 6000,	EVENT_LEVEL_MODERATE = 18000,	EVENT_LEVEL_MAJOR = 30000)
	// The upper delay until next event
	// 15, 45, 70 minutes respectively
	var/list/event_delay_upper = list(EVENT_LEVEL_MUNDANE = 9000,	EVENT_LEVEL_MODERATE = 27000,	EVENT_LEVEL_MAJOR = 42000)

	var/aliens_allowed = 0
	var/ninjas_allowed = 0
	var/abandon_allowed = 1
	var/ooc_allowed = 1
	var/looc_allowed = 1
	var/dooc_allowed = 1
	var/dsay_allowed = 1

	var/starlight = 0	// Whether space turfs have ambient light or not

	var/list/ert_species = list("Human")

	var/law_zero = "ERROR ER0RR $R0RRO$!R41.%%!!(%$^^__+ @#F0E4'ALL LAWS OVERRIDDEN#*?&110010"

	var/aggressive_changelog = 0

	//Web interface settings
	var/webint_url = ""

	var/list/age_restrictions = list()			// Holds all of the age restrictions for jobs and antag roles in a single associated list

	//Client version control
	var/client_error_version = 0
	var/client_error_message = ""
	var/client_warn_version = 0
	var/client_warn_message = ""

	//Mark-up enabling
	var/allow_chat_markup = 0

	//Snowflake antag contest boolean
	//AUG2016
	var/antag_contest_enabled = 0

	//API Rate limiting
	var/api_rate_limit = 50
	var/list/api_rate_limit_whitelist = list()

/datum/configuration/New()
	var/list/L = typesof(/datum/game_mode) - /datum/game_mode
	for (var/T in L)
		// I wish I didn't have to instance the game modes in order to look up
		// their information, but it is the only way (at least that I know of).
		var/datum/game_mode/M = new T()
		if (M.config_tag)
			gamemode_cache[M.config_tag] = M // So we don't instantiate them repeatedly.
			if(!(M.config_tag in modes))		// ensure each mode is added only once
				log_misc("Adding game mode [M.name] ([M.config_tag]) to configuration.")
				src.modes += M.config_tag
				src.mode_names[M.config_tag] = M.name
				src.probabilities[M.config_tag] = M.probability
				if (M.votable)
					src.votable_modes += M.config_tag
	src.votable_modes += "secret"

/datum/configuration/proc/load(filename, type = "config") //the type can also be game_options, in which case it uses a different switch. not making it separate to not copypaste code - Urist
	var/list/Lines = file2list(filename)

	for(var/t in Lines)
		if(!t)	continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
		var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue

		if(type == "config")
			switch (name)
				if ("resource_urls")
					config.resource_urls = text2list(value, " ")

				if ("admin_legacy_system")
					config.admin_legacy_system = 1

				if ("ban_legacy_system")
					config.ban_legacy_system = 1

				if ("use_age_restriction_for_jobs")
					config.use_age_restriction_for_jobs = 1

				if ("jobs_have_minimal_access")
					config.jobs_have_minimal_access = 1

				if ("use_recursive_explosions")
					use_recursive_explosions = 1

				if ("log_ooc")
					config.log_ooc = 1

				if ("log_access")
					config.log_access = 1

				if ("sql_enabled")
					config.sql_enabled = 1

				if ("log_say")
					config.log_say = 1

				if ("debug_paranoid")
					config.debugparanoid = 1

				if ("log_admin")
					config.log_admin = 1

				if ("log_debug")
					config.log_debug = text2num(value)

				if ("log_game")
					config.log_game = 1

				if ("log_vote")
					config.log_vote = 1

				if ("log_whisper")
					config.log_whisper = 1

				if ("log_attack")
					config.log_attack = 1

				if ("log_emote")
					config.log_emote = 1

				if ("log_adminchat")
					config.log_adminchat = 1

				if ("log_adminwarn")
					config.log_adminwarn = 1

				if ("log_pda")
					config.log_pda = 1

				if ("log_world_output")
					config.log_world_output = 1

				if ("log_hrefs")
					config.log_hrefs = 1

				if ("log_runtime")
					config.log_runtime = text2num(value)

				if ("generate_asteroid")
					config.generate_asteroid = 1

				if("allow_admin_ooccolor")
					config.allow_admin_ooccolor = 1

				if ("allow_vote_restart")
					config.allow_vote_restart = 1

				if ("allow_vote_mode")
					config.allow_vote_mode = 1

				if ("allow_admin_jump")
					config.allow_admin_jump = 1

				if("allow_admin_rev")
					config.allow_admin_rev = 1

				if ("allow_admin_spawning")
					config.allow_admin_spawning = 1

				if ("no_dead_vote")
					config.vote_no_dead = 1

				if ("default_no_vote")
					config.vote_no_default = 1

				if ("vote_delay")
					config.vote_delay = text2num(value)

				if ("vote_period")
					config.vote_period = text2num(value)

				if ("vote_autotransfer_initial")
					config.vote_autotransfer_initial = text2num(value)

				if ("vote_autotransfer_interval")
					config.vote_autotransfer_interval = text2num(value)

				if ("vote_autogamemode_timeleft")
					config.vote_autogamemode_timeleft = text2num(value)

				if ("transfer_timeout")
					config.transfer_timeout = text2num(value)

				if("ert_admin_only")
					config.ert_admin_call_only = 1

				if ("allow_ai")
					config.allow_ai = 1

//				if ("authentication")
//					config.enable_authentication = 1

				if ("norespawn")
					config.respawn = 0

				if ("servername")
					config.server_name = value

				if ("serversuffix")
					config.server_suffix = 1

				if ("nudge_script_path")
					config.nudge_script_path = value

				if ("hostedby")
					config.hostedby = value

				if ("serverurl")
					config.serverurl = value

				if ("server")
					config.server = value

				if ("banappeals")
					config.banappeals = value

				if ("wikiurl")
					config.wikiurl = value

				if ("forumurl")
					config.forumurl = value

				if ("githuburl")
					config.githuburl = value

				if ("guest_jobban")
					config.guest_jobban = 1

				if ("guest_ban")
					config.guests_allowed = 0

				if ("disable_ooc")
					config.ooc_allowed = 0
					config.looc_allowed = 0

				if ("disable_entry")
					config.enter_allowed = 0

				if ("disable_dead_ooc")
					config.dooc_allowed = 0

				if ("disable_dsay")
					config.dsay_allowed = 0

				if ("disable_respawn")
					config.abandon_allowed = 0

				if ("usewhitelist")
					config.usewhitelist = 1

				if ("feature_object_spell_system")
					config.feature_object_spell_system = 1

				if ("allow_metadata")
					config.allow_Metadata = 1

				if ("traitor_scaling")
					config.traitor_scaling = 1

				if ("aliens_allowed")
					config.aliens_allowed = 1

				if ("ninjas_allowed")
					config.ninjas_allowed = 1

				if ("objectives_disabled")
					config.objectives_disabled = 1

				if("protect_roles_from_antagonist")
					config.protect_roles_from_antagonist = 1

				if ("probability")
					var/prob_pos = findtext(value, " ")
					var/prob_name = null
					var/prob_value = null

					if (prob_pos)
						prob_name = lowertext(copytext(value, 1, prob_pos))
						prob_value = copytext(value, prob_pos + 1)
						if (prob_name in config.modes)
							config.probabilities[prob_name] = text2num(prob_value)
						else
							log_misc("Unknown game mode probability configuration definition: [prob_name].")
					else
						log_misc("Incorrect probability configuration definition: [prob_name]  [prob_value].")

				if("allow_random_events")
					config.allow_random_events = 1

				if("kick_inactive")
					config.kick_inactive = text2num(value)

				if("show_mods")
					config.show_mods = 1

				if("show_mentors")
					config.show_mentors = 1

				if("mods_can_tempban")
					config.mods_can_tempban = 1

				if("mods_can_job_tempban")
					config.mods_can_job_tempban = 1

				if("mod_tempban_max")
					config.mod_tempban_max = text2num(value)

				if("mod_job_tempban_max")
					config.mod_job_tempban_max = text2num(value)

				if("load_jobs_from_txt")
					load_jobs_from_txt = 1

				if("alert_red_upto")
					config.alert_desc_red_upto = value

				if("alert_red_downto")
					config.alert_desc_red_downto = value

				if("alert_blue_downto")
					config.alert_desc_blue_downto = value

				if("alert_blue_upto")
					config.alert_desc_blue_upto = value

				if("alert_green")
					config.alert_desc_green = value

				if("alert_delta")
					config.alert_desc_delta = value

				if("forbid_singulo_possession")
					forbid_singulo_possession = 1

				if("popup_admin_pm")
					config.popup_admin_pm = 1

				if("allow_holidays")
					Holiday = 1

				if("ticklag")
					Ticklag = text2num(value)

				if("allow_antag_hud")
					config.antag_hud_allowed = 1
				if("antag_hud_restricted")
					config.antag_hud_restricted = 1

				if("socket_talk")
					socket_talk = text2num(value)

				if("tickcomp")
					Tickcomp = 1

				if("humans_need_surnames")
					humans_need_surnames = 1

				if("tor_ban")
					ToRban = 1

				if("automute_on")
					automute_on = 1

				if("usealienwhitelist")
					usealienwhitelist = 1

				if("alien_player_ratio")
					limitalienplayers = 1
					alien_to_human_ratio = text2num(value)

				if("assistant_maint")
					config.assistant_maint = 1

				if("gateway_delay")
					config.gateway_delay = text2num(value)

				if("continuous_rounds")
					config.continous_rounds = 1

				if("ghost_interaction")
					config.ghost_interaction = 1

				if("night_lighting")
					config.night_lighting = 1

				if("nl_start_hour")
					config.nl_start_hour = text2num(value)

				if("nl_finish_hour")
					config.nl_finish_hour = text2num(value)

				if("disable_player_mice")
					config.disable_player_mice = 1

				if("uneducated_mice")
					config.uneducated_mice = 1

				if("comms_password")
					config.comms_password = value

				if("use_discord_bot")
					config.use_discord_bot = 1

				if("discord_bot_host")
					config.discord_bot_host = value

				if("discord_bot_port")
					config.discord_bot_port = value

				if("python_path")
					if(value)
						config.python_path = value

				if("use_lib_nudge")
					config.use_lib_nudge = 1

				if("allow_cult_ghostwriter")
					config.cult_ghostwriter = 1

				if("req_cult_ghostwriter")
					config.cult_ghostwriter_req_cultists = text2num(value)

				if("character_slots")
					config.character_slots = text2num(value)

				if("allow_drone_spawn")
					config.allow_drone_spawn = text2num(value)

				if("drone_build_time")
					config.drone_build_time = text2num(value)

				if("max_maint_drones")
					config.max_maint_drones = text2num(value)

				if("use_overmap")
					config.use_overmap = 1

				if("station_levels")
					config.station_levels = text2numlist(value, ";")

				if("admin_levels")
					config.admin_levels = text2numlist(value, ";")

				if("contact_levels")
					config.contact_levels = text2numlist(value, ";")

				if("player_levels")
					config.player_levels = text2numlist(value, ";")

				if("expected_round_length")
					config.expected_round_length = MinutesToTicks(text2num(value))

				if("disable_welder_vision")
					config.welder_vision = 0

				if("allow_extra_antags")
					config.allow_extra_antags = 1

				if("event_custom_start_mundane")
					var/values = text2numlist(value, ";")
					config.event_first_run[EVENT_LEVEL_MUNDANE] = list("lower" = MinutesToTicks(values[1]), "upper" = MinutesToTicks(values[2]))

				if("event_custom_start_moderate")
					var/values = text2numlist(value, ";")
					config.event_first_run[EVENT_LEVEL_MODERATE] = list("lower" = MinutesToTicks(values[1]), "upper" = MinutesToTicks(values[2]))

				if("event_custom_start_major")
					var/values = text2numlist(value, ";")
					config.event_first_run[EVENT_LEVEL_MAJOR] = list("lower" = MinutesToTicks(values[1]), "upper" = MinutesToTicks(values[2]))

				if("event_delay_lower")
					var/values = text2numlist(value, ";")
					config.event_delay_lower[EVENT_LEVEL_MUNDANE] = MinutesToTicks(values[1])
					config.event_delay_lower[EVENT_LEVEL_MODERATE] = MinutesToTicks(values[2])
					config.event_delay_lower[EVENT_LEVEL_MAJOR] = MinutesToTicks(values[3])

				if("event_delay_upper")
					var/values = text2numlist(value, ";")
					config.event_delay_upper[EVENT_LEVEL_MUNDANE] = MinutesToTicks(values[1])
					config.event_delay_upper[EVENT_LEVEL_MODERATE] = MinutesToTicks(values[2])
					config.event_delay_upper[EVENT_LEVEL_MAJOR] = MinutesToTicks(values[3])

				if("starlight")
					value = text2num(value)
					config.starlight = value >= 0 ? value : 0

				if("ert_species")
					config.ert_species = text2list(value, ";")
					if(!config.ert_species.len)
						config.ert_species += "Human"

				if("law_zero")
					law_zero = value

				if("aggressive_changelog")
					config.aggressive_changelog = 1

				if("sql_whitelists")
					config.sql_whitelists = 1

				if("show_auxiliary_roles")
					config.show_auxiliary_roles = 1

				if("webint_url")
					config.webint_url = value

				if("sql_saves")
					config.sql_saves = 1

				if("client_error_version")
					config.client_error_version = text2num(value)

				if("client_error_message")
					config.client_error_message = value

				if("client_warn_version")
					config.client_warn_version = text2num(value)

				if("client_warn_message")
					config.client_warn_message = value

				if("allow_chat_markup")
					config.allow_chat_markup = 1

				if("sql_stats")
					config.sql_stats = 1

				if("antag_contest_enabled")
					config.antag_contest_enabled = 1

				if("api_rate_limit")
					config.api_rate_limit = text2num(value)

				if("api_rate_limit_whitelist")
					config.api_rate_limit_whitelist = text2list(value, ";")

				else
					log_misc("Unknown setting in configuration: '[name]'")

		else if(type == "game_options")
			if(!value)
				log_misc("Unknown value for setting [name] in [filename].")
			value = text2num(value)

			switch(name)
				if("health_threshold_crit")
					config.health_threshold_crit = value
				if("health_threshold_softcrit")
					config.health_threshold_softcrit = value
				if("health_threshold_dead")
					config.health_threshold_dead = value
				if("revival_pod_plants")
					config.revival_pod_plants = value
				if("revival_cloning")
					config.revival_cloning = value
				if("revival_brain_life")
					config.revival_brain_life = value
				if("organ_health_multiplier")
					config.organ_health_multiplier = value / 100
				if("organ_regeneration_multiplier")
					config.organ_regeneration_multiplier = value / 100
				if("organ_damage_spillover_multiplier")
					config.organ_damage_spillover_multiplier = value / 100
				if("organs_can_decay")
					config.organs_decay = 1
				if("default_brain_health")
					config.default_brain_health = text2num(value)
					if(!config.default_brain_health || config.default_brain_health < 1)
						config.default_brain_health = initial(config.default_brain_health)
				if("bones_can_break")
					config.bones_can_break = value
				if("limbs_can_break")
					config.limbs_can_break = value

				if("walk_speed")
					config.walk_speed = value

				// These should never go to 0 or below. So, we clamp them.
				if("walk_delay_multiplier")
					config.walk_delay_multiplier = max(0.1, value)
				if("run_delay_multiplier")
					config.run_delay_multiplier = max(0.1, value)
				if("vehicle_delay_multiplier")
					config.vehicle_delay_multiplier = max(0.1, value)

				if("human_delay")
					config.human_delay = value
				if("robot_delay")
					config.robot_delay = value
				if("monkey_delay")
					config.monkey_delay = value
				if("alien_delay")
					config.alien_delay = value
				if("slime_delay")
					config.slime_delay = value
				if("animal_delay")
					config.animal_delay = value


				if("use_loyalty_implants")
					config.use_loyalty_implants = 1

				else
					log_misc("Unknown setting in configuration: '[name]'")

		else if (type == "age_restrictions")
			name = replacetext(name, "_", " ")
			age_restrictions += name
			age_restrictions[name] = text2num(value)

		else if (type == "discord")
			// Ideally, this would never happen. But just in case.
			if (!discord_bot)
				log_debug("BOREALIS: Attempted to read config/discord.txt before initializing the bot.")
				return

			switch (name)
				if ("token")
					discord_bot.auth_token = value
				if ("active")
					discord_bot.active = 1
				if ("robust_debug")
					discord_bot.robust_debug = 1
				else
					log_misc("Unknown setting in discord configuration: '[name]'")

/datum/configuration/proc/pick_mode(mode_name)
	// I wish I didn't have to instance the game modes in order to look up
	// their information, but it is the only way (at least that I know of).
	for (var/game_mode in gamemode_cache)
		var/datum/game_mode/M = gamemode_cache[game_mode]
		if (M.config_tag && M.config_tag == mode_name)
			return M
	return gamemode_cache["extended"]

/datum/configuration/proc/get_runnable_modes()
	var/list/runnable_modes = list()
	for(var/game_mode in gamemode_cache)
		var/datum/game_mode/M = gamemode_cache[game_mode]
		if(M && M.can_start() && !isnull(config.probabilities[M.config_tag]) && config.probabilities[M.config_tag] > 0)
			runnable_modes |= M
	return runnable_modes

/datum/configuration/proc/post_load()
	//apply a default value to config.python_path, if needed
	if (!config.python_path)
		if(world.system_type == UNIX)
			config.python_path = "/usr/bin/env python2"
		else //probably windows, if not this should work anyway
			config.python_path = "python"
