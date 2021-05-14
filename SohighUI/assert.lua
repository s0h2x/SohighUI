	
	local E, C, _ = select(2, shCore()):unpack()
	
	--//Config (not main), store: values, strings, tables
	--//M.[module]
	C['Modules'] = {
		--// UI Scale //--
		['UIScaleMax'] = 0.88,		--// max, min for pixelperfect
		['UIScaleMin'] = 0.64,
		----------------------------------------------------------------
		--// CombatText Options //--
		['threshold'] = 1,			--// min damage to show in damage frame
		['healthreshold'] = 1,		--// min healing to show in inc/out heal messages
		['maxLines'] = 15,			--// max lines in scroll mode(more lines more memory)
		['timeShows'] = 3,			--// time(seconds) a single message will be visible
		['critPrefix'] = '*',		--// symbol that will be added before crit
		['critPostfix'] = '*',		--// symbol that will be added after crit
		['direction'] = 'TOP',		--// scrolling direction('TOP'goes down or 'BOTTOM'goes up)
		----------------------------------------------------------------
		--// Bag Options //--
		['bagSize'] = 30,			--// bag size
		['bagSpace'] = 6,			--// bag space between
		['bagScale'] = 1,			--// scale
		['bagColumns'] = 12,		--// bag per row
		['bankColumns'] = 15,		--// bank per row
		----------------------------------------------------------------
		--// Tooltip Options //--
		['ttposX'] = -32,			--// LEFT(-) and RIGHT(+) position via posZ anchor
		['ttposY'] = 48,			--// UP(+) and DOWN(-) position via posZ anchor
		['ttposZ'] = 'BOTTOMRIGHT',	--// align to
		----------------------------------------------------------------
		--// Damage Meter //--
		['barHeight'] = 14,
		['barSpace'] = 2,			--// spacing beetwen bars
		['barMax'] = 8,				--// max showing bars into one frame
		['maxFights'] = 10,			--// max fights boss/mobs
		['maxReports'] = 10,		--// number of strings in one report
		----------------------------------------------------------------
		--// Buffs & DeBuffs //--
		['buffSize'] = 28,			--// size of buffs (near minimap)
		['buffScale'] = 1,			--// scale buffs
		['buffFontSize'] = 14,		--// font size (timer)
		['buffCountSize'] = 16,
		['debuffSize'] = 28,		--// size of Debuffs
		['debuffScale'] = 1.2,		--// scale Debuffs
		['debuffFontSize'] = 14,	--// font size for debbufs (timer)
		['debuffCountSize'] = 16,
		['paddingX'] = 7,			--// spacing buffs by X
		['paddingY'] = 12,			--// anchored by Y
		['buffPerRow'] = 8,			--// row by row (exmpl: if = 8 then 8/8/8..)
		['buffColor'] = {1, 1, 1},	--// buffs border color
		['durationY'] = -8,			--// timer buffs/debuffs by Y positon
		----------------------------------------------------------------
		--// ActionBar //--
		['buttonSize'] = 36,		--// size of actionbar buttons
		--['buffScale'] = 1,			--// scale buffs
	}
	
	--//Fonts/StatusBar textures
	--//for add custom, you need replace/adding (through , ) file name in this table
	--//don't forget to add you custom file in folder 'styles/fonts' or 'styles/arts/sb'
	C['Modules'].assert = {
		['font'] = {
			'Default', 'Archangelsk', 'AvantGarde', 'Atarian', 'Brutality',
			'Cantora', 'Designer', 'DieDieDie', 'Expressway', 'Expressway_Rg',
			'Fishfingers', 'Gangof3', 'Levenim', 'MK 4', 'Monoalph',
			'Prototype', 'San Diego', 'wqy-zenhei', 'ympyroity'
		},
		['statusbar'] = {
			'DsmOpaqueV1', 'DsmV3', 'DsmV9', 'DukeA', 'DukeB',
			'DukeC', 'DukeD', 'DukeG', 'DukeH', 'DukeI',
			'DukeL', 'rainbowgradient', 'HalF', 'HalI', 'HalK',
			'HalL', 'HalM', 'HalN', 'HalR', 'Kait',
			'Ghost', 'Neal', 'NealDark', 'RenFeint', 'Paint',
			'pHishgradient', 'Smooth'
		},
		['auraAnchor'] = {
		--//  [1] 	 [2] 	  [3]		[4]			[5]
			'TOP', 'BOTTOM', 'LEFT', 'GAP TOP', 'GAP BOTTOM'
		},
		['styleAB'] = {
		--//  [1] 	 	[2] 	[3]
			'Normal', 'Short', 'Six'
		},
	}
	
	--// Chat stuff
	C['Modules'].index = {
		classcolor = {
			['WARRIOR']	= 'C79C6E',
			['WARLOCK']	= '8787ED',
			['SHAMAN']	= '0071DE',
			['ROGUE']	= 'FFF569',
			['PRIEST']	= 'FFFFFF',
			['PALADIN']	= 'F58CBA',
			['MAGE']	= '40C7EB',
			['HUNTER']	= 'ABD473',
			['DRUID']	= 'FF7D0A',
		},
		syscolor = {
			['selfcolor'] = 'ace5ee',
			['hlcolor']	  = '7a9ae2',
			['gicolor']	  = 'ffff00',
		},
		template = {
			['MsgLevel'] = 0, --// Ignoring message from low lvl [value 1-70] players, 0 = false
			['MsgChans'] = 0, --// Filter
		},
		cit = {
			['WARRIOR']     = {0, 0.25, 0, 0.25},
			['MAGE']        = {0.25, 0.49609375, 0, 0.25},
			['ROGUE']       = {0.49609375, 0.7421875, 0, 0.25},
			['DRUID']       = {0.7421875, 0.98828125, 0, 0.25},
			['HUNTER']      = {0, 0.25, 0.25, 0.5},
			['SHAMAN']      = {0.25, 0.49609375, 0.25, 0.5},
			['PRIEST']      = {0.49609375, 0.7421875, 0.25, 0.5},
			['WARLOCK']     = {0.7421875, 0.98828125, 0.25, 0.5},
			['PALADIN']     = {0, 0.25, 0.5, 0.75},
			['PETS']        = {0, 1, 0, 1},
			['MAINTANK']    = {0, 1, 0, 1},
			['MAINASSIST']  = {0, 1, 0, 1}
		},
	}
	
	M = C['Modules']