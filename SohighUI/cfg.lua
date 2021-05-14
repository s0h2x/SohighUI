	
	local E, C, L, _ = select(2, shCore()):unpack()
	
	--//Config / modules [MAIN]
	--//Store value by default
	--//Changes are saved in Name/SavedVariables/SohighUI_Config.lua
	--//This is what you may change in game (/cfg or /sui)
	--//For additional settings, see assert.lua
	
	--// Main Options //--
	C['main'] = {
		['w'] = 'Media & Style',	--// Style Options //--
		----------------------------------------------------------------
		['spellAnnounce'] = true,	--// Announce (Chat/Screen) different Events Spells
		['durability'] = false,		--// Display Durability Items (%)
		['declineDuel'] = false,	--// Decline Duel Request
		['restyleUI'] = false,		--// Stylizes All Blizzard frames
		['maxUIScale'] = true,		--// Use UI Scale for PixelPerfect
		['misc'] = true,			--// Misc (Spam BG, Force Quit, Train All etc..)
		----------------------------------------------------------------
		['z'] = 'Automation',		--// Automation Options //--
		----------------------------------------------------------------
		['autoInvite'] = true,		--// Auto-Accept Invite
		['autoGreed'] = false,		--// Auto-Accept Greed green items
		['autoRelease'] = false,	--// Auto-Accept Release spirit
		['autoQuest'] = false,		--// Auto-Accept Quests + Auto Compelete
		['autoLoot'] = false,		--// Auto-Confirm Loot Roll
		['autoMerchant'] = true,	--// Auto-Sell Junk & Repair
		----------------------------------------------------------------
		['x'] = 'Chat Options',		--// Chat Options //--
		----------------------------------------------------------------
		['_chat'] = true,			--// Enable Chat
		['_chatOrient'] = false,	--// ChatBox Position TOP or BOTTOM
		['_chatEmote'] = true,		--// Display Chat Emotes Button
		['_chatTime'] = true,		--// Display Local Time in Chat
		['_chatTab'] = true,		--// Enable Fade Tab Mode
		['_chatCopy'] = true,		--// Сopyability Bottom-Right Icon
		----------------------------------------------------------------
		['y'] = 'Damage Meter',		--// DPS Meter Options //--
		----------------------------------------------------------------
		['_dpsMeter'] = true,		--// Enable Damage Meter (Dps,Heal,Inter,Dispel)
		['_dpsMeterFade'] = false,	--// Enable Fade Mode
		['_dpsMeterLayout'] = true,	--// Display Layout (Background)
		['_dpsMeterTitle'] = true,	--// Display title texts (all headers)
		['_dpsMeterCombat'] = false,--// Show Dps Meter only in combat
		['_dpsMeterLock'] = false,	--// Lock Frame
		----------------------------------------------------------------
		['font'] = 9,				--// Current Font (Expressway by default)
		----------------------------------------------------------------
		--// Widgets //--
		['shadow'] = {value = 20, min = 0, max = 100, step = 1},
		['fontSize'] = {value = 14, min = 9, max = 20, step = 1},
	}
	
	--// ActionBar Options //--
	C['bar'] = {
		['styleAB'] = 1,			--// Style Action Bar (Normal,Short,6x6)
		['macroName'] = true,		--// Display Macro Name on Buttons
		['background'] = true,		--// Display Background Buttons
		['stripArts'] = false,		--// Hide All Action Bar Arts
		['caps'] = true,			--// Display Endcaps (Gryphone)
		['_bpackIcon'] = true,		--// Display Bpack Icon (Right)
		['_menuIcon'] = true,		--// Display Menu Icon (Left)
		['scale'] = {value = 0.8, min = 0.4, max = 1.6, step = 0.01},
	}

	--// Unit Frame Options //--
	C['units'] = {
		['w'] = 'Unit Frames',
		----------------------------------------------------------------
		['classPortraits'] = true,	--// Class Portraits
		['unitStyleFat'] = true,	--// Unit Frames Improved Style
		['auraTimer'] = true,		--// Display Auras Time
		['auraAnchor'] = 1,			--// Position Auras 1-'TOP', 2-'BOTTOM', 3-'LEFT'
		['auraPlayer'] = false,		--// Display Self Auras
		['statusbar'] = 23,			--// Statusbar Texture
		['smoothing'] = true,		--// Smooth Health/Power Bar
		['enchantoUF'] = true,		--// Use Unit Frame Poisons Chant Style
		['combatText'] = true,		--// Display Combat Feedback Text
		----------------------------------------------------------------
		['z'] = 'Misc',
		----------------------------------------------------------------
		['threatGlow'] = true,		--// Show Units Combat Glow
		['statusFlash'] = true,		--// Show Player Combat Flash
		['statusCombat'] = true,	--// Show Swords (Combat Status) In Combat
		['comboPoints'] = true,		--// Enable Combo Points
		['cpAsNumber'] = false,		--// Combo Points As Numbers (1,2,3,4,5)
		['showParty'] = true,		--// Show Party Members
		----------------------------------------------------------------
		['x'] = 'Style Options',
		----------------------------------------------------------------
		['partyInRaid'] = true,		--// Show Party Members In Raid
		['castbarTicks'] = true,	--// Display Castbar Ticks
		['castbarColor'] = true,	--// Castbar Class Colors
		['absorbBar'] = true,		--// Show Absorb Bar (Blue Line)
		['healComm'] = false,		--// Enable HealComm Plugin
	}
	
	--// Bag Options //--
	C['bags'] = {
		['w'] = 'Bag Options',
		----------------------------------------------------------------
		['enable'] = true,
		['bagSize'] = {value = 30 , min = 24, max = 54, step = 1},
		['bagSpace'] = {value = 6 , min = 2, max = 10, step = 1},
		['bagColumns'] = {value = 12 , min = 8, max = 16, step = 1},
		['bankColumns'] = {value = 15 , min = 9, max = 17, step = 1},
	}
	
	--// Tooltip Options //--
	C['tooltip'] = {
		['w'] = 'Tooltips',
		----------------------------------------------------------------
		['enable'] = true,			--// Enable Tooltips
		['showInCombat'] = false,	--// Hide in Combat (Useful When Cursor is Active)
		['showUnits'] = false,		--// Always Hide Only Units (NPC, Players, etc)
		['cursor'] = false,			--// Anchor on Cursor Instead of Fix Position
	}
	
	--// CombatText Options //--
	C['ct'] = {
		['w'] = 'Combat Text',
		----------------------------------------------------------------
		['moduleEnable'] = true,	--// Enable Combat Text
		['showBlizzOut'] = false,	--// Use Blizzard Output(above mob/player head)
		['styleDps'] = true,		--// Change default Font(above mob/player heads)
		['shortNum'] = true,		--// Use Short Numbers ('25.3k' instead of '25342')
		['showKilling'] = false,	--// Tells About your Killing in Party Chat
		['scrollable'] = false,		--// Allows you to Scroll Frame Lines with Mousewheel
		----------------------------------------------------------------
		['z'] = 'Outgoings',
		----------------------------------------------------------------
		['icons'] = true,			--// Show Outgoing Damage Icons
		['dps'] = true,				--// Show Outgoing Damage in it's own Frame
		['healing'] = true,			--// Show Outgoing Healing in it's own Frame
		['healingOver'] = true,		--// Show Outgoing OverHealing
		['mergeAoE'] = true,		--// Merges multiple AoE Dmg Spam into Single Message
		['mergeMelee'] = true,		--// Merges multiple Auto-Attack Damage spam
		----------------------------------------------------------------
		['x'] = 'Misc',
		----------------------------------------------------------------
		['_dotDps'] = true,			--// Show Damage From your Dots
		['_hotDps'] = true,			--// Show Periodic Healing Effects in Healing Frame
		['_petDps'] = true,			--// Show your Pet Damage
		['_colorDps'] = true,		--// Damage Numbers Color depending on School of Magic
		['_tellDispel'] = true,		--// Tells About your Dispels(['dps'] = true)
		['_tellInter'] = true,		--// Tells About your Interrupts(['dps'] = true)

		----------------------------------------------------------------
		--// Widgets //--
		['iconSize'] = {value = 32 , min = 24, max = 64, step = 1},
	}
	
