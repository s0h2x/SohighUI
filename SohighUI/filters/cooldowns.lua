
	local E, C, _ = select(2, shCore()):unpack()

	----------------------------------------------------------------------------------------
	--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
	--	Example: Rebirth -> http://www.wowhead.com/spell=20484
	--	Take the number ID at the end of the URL, and add it to the list
	----------------------------------------------------------------------------------------
	--if C.raidcooldown.enable == true then
		E.raid_spells = {
			-- Battle resurrection
			[20484] = 1200,	-- Rebirth
			[27740] = 3600,	-- Reincarnation (3600sec base / -1200sec from talents)
			-- Jumper Cables
			-- [8342] = 1800,	-- Goblin Jumper Cables
			-- [22999] = 1800,	-- Goblin Jumper Cables XL
			-- Heroism
			[2825] = 600,	-- Bloodlust
			[32182] = 600,	-- Heroism
			-- Healing
			[740] = 600,	-- Tranquility
			[724] = 360,	-- Lightwell
			-- Defense
			[1022] = 300,	-- Blessing of Protection (300sec base / -120sec from talents)
			-- [6940] = 30,	-- Blessing of Sacrifice
			[633] = 3600,	-- Lay on Hands (3600sec base / -1200sec from talents)
			[33206] = 120,	-- Pain Suppression
			[871] = 1800,	-- Shield Wall
			[12975] = 480,	-- Last Stand
			-- Taunts
			[5209] = 600,	-- Challenging Roar
			[1161] = 600,	-- Challenging Shout
			[694] = 120,	-- Mocking Blow
			-- Mana Regeneration
			[29166] = 360,	-- Innervate (360sec base / -48sec from 4pc T4)
			[32548] = 300,	-- Symbol of Hope
			[16190] = 300,	-- Mana Tide Totem
			-- Other
			[34477] = 120,	-- Misdirection
			[6346] = 180,	-- Fear Ward
			[10060] = 180,	-- Power Infusion
			-- [29858] = 300,	-- Soulshatter
		}
	--end

	--if C.units.enemyCD ~= false then
		E.enemy_spells = {
			-- Interrupts and Silences
			[34490] = 20,	-- Silencing Shot
			[2139] = 24,	-- Counterspell
			[15487] = 45,	-- Silence
			[1766] = 10,	-- Kick
			[8042] = 5,		-- Earth Shock (5sec base / -1sec from talents)
			[19244] = 24,	-- Spell Lock (Felhunter)
			[6552] = 10,	-- Pummel
			-- Crowd Controls
			[1499] = 24,	-- Freezing Trap (30sec base / -6sec from talents / -4sec from 2pc D3)
			[19503] = 30,	-- Scatter Shot
			[19386] = 180,	-- Wyvern Sting
			[11113] = 20,	-- Dragon's Breath
			[853] = 50,		-- Hammer of Justice (60sec base / -10sec from 4pc PvP / -15sec from talents)
			[20066] = 60,	-- Repentance
			[6789] = 120,	-- Death Coil (120sec base / -18sec from ZG Set)
			[8122] = 23,	-- Psychic Scream (30sec base / -3sec from gloves / -4sec from talents)
			[2094] = 90,	-- Blind (180sec base / -90sec from talents)
			[5484] = 40,	-- Howl of Terror
			[30283] = 20,	-- Shadowfury
			[12809] = 45,	-- Concussion Blow
			-- Defense abilities
			[22812] = 60,	-- Barkskin
			[19263] = 300,	-- Deterrence
			[45438] = 240,	-- Ice Block (300sec base / -60sec from talents / -40sec from 4pc T4)
			[66] = 300,		-- Invisibility
			[1044] = 25,	-- Blessing of Freedom
			[1022] = 180,	-- Blessing of Protection (300sec base / -120sec from talents)
			-- [6940] = 30,	-- Blessing of Sacrifice
			[498] = 300,	-- Divine Protection
			[642] = 300,	-- Divine Shield (300sec base / -60sec from talents)
			[6346] = 180,	-- Fear Ward
			[33206] = 120,	-- Pain Suppression
			[31224] = 60,	-- Cloak of Shadows
			[5277] = 210,	-- Evasion (-90sec from talents)
			[1856] = 210,	-- Vanish (300sec base / -90sec from talents)
			-- [8178] = 11,	-- Grounding Totem (15sec base / -2sec from talents / -1.5sec from 4pc PvP)
			[18499] = 30,	-- Berserker Rage
			-- [23920] = 10,	-- Spell Reflection
			[20600] = 180,	-- Perception
			[20594] = 180,	-- Stoneform
			[7744] = 120,	-- Will of the Forsaken
			-- Heals
			-- [28880] = 180,	-- Gift of the Naaru
			-- Disarms
			-- [14251] = 6,		-- Riposte
			[676] = 60,		-- Disarm
			-- Mana Regeneration
			[29166] = 360,	-- Innervate (360sec base / -48sec from 4pc T4)
			[32548] = 300,	-- Symbol of Hope
			[16190] = 300,	-- Mana Tide Totem
			-- Trinket (TEMPORARY)
			[42292] = 120,	-- PvP Trinket
		}
--	end

	--[[if C.pulsecooldown.enable ~= false then
		E.pulse_ignored_spells = {
			--GetSpellInfo(6807),	-- Maul
			--GetSpellInfo(35395),	-- Crusader Strike
		}
	end--]]