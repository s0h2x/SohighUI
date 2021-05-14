	
	--* config UF
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	ns.defaultConfig = {
		fontNormal = A.font,
		fontNormalOutline = A.fontStyle,
		fontNormalSize = 1, --// relative size

		fontBig = A.fontBig,
		fontBigOutline = A.fontStyle,
		fontBigSize = 1, --// relative size

		--// Castbar
		castbars = true,
		castbarSafezoneColor = {.8, 0.4, 0, 1},
		
		portraitTimer = false,
		
		--// Combo Points Color
		numComboPointsColor = {0.9, 0, 0}, 

		healthcolormode = 'CLASS',
		healthcolor = {0.0, 0.1, 0.0},

		powercolormode = 'TYPE',
		powercolor = {0.0, 0.1, 0.0},

		backdropColor = {0, 0, 0, 0.55},

		TextHealthColor = {1, 1, 1},
		TextHealthColorMode = 'CUSTOM',
		
		TextPowerColor = {1, 1, 1},
		TextPowerColorMode = 'CUSTOM',
		
		TextNameColor = {1, 1, 1},
		TextNameColorMode = 'CUSTOM',

		showArena = false,
		showBoss = false,

		statusbar = A.status,
		playerStyle = 'normal',
		customPlayerTexture = A.custom,
		frameStyle = 'normal',

		focMod = 'shift-',
		focBut = '1',
		
		clickThrough = false,

		--// Blizzard Class stuff
		SHAMAN = true,

		player = {
			style = 'fat',
			scale = 1,
			enableAura = true,
			enableEnchant = true,
			cbshow = true,
			HealthTag = 'BOTH',--'NUMERIC',
			PowerTag = 'PERCENT',
			buffPos = 'TOP',
			debuffPos = 'TOP',
			cbwidth = 200,
			cbheight = 18,
			cbicon = 'LEFT',
			position = 'CENTER/-205/-100',
			cbposition = 'CENTER/4/-176',
		},

		pet = {
			style = 'normal',
			scale = 1,
			HealthTag = 'MINIMAL',
			PowerTag = 'DISABLE',
			cbshow = true,
			cbwidth = 200,
			cbheight = 18,
			cbicon = 'NONE',
			position = 'CENTER/-195/-147',
			cbposition = 'BOTTOM/-191/180',
		},

		target = {
			style = 'fat',
			scale = 1,
			HealthTag = 'BOTH',
			PowerTag = 'PERCENT',
			buffPos = 'BOTTOM',
			debuffPos = 'TOP',
			cbshow = true,
			cbwidth = 200,
			cbheight = 18,
			cbicon = 'LEFT',
			position = 'CENTER/205/-100',
			cbposition = 'CENTER/211/-46',
		},
		
		targettarget = {
			style = 'fat',
			scale = 1,
			enableAura = false,
			HealthTag = 'DISABLE',
	   },
		
		focus = {
			style = 'fat',
			scale = 1.1,
			HealthTag = 'BOTH',
			PowerTag = 'PERCENT',
			buffPos = 'RIGHT',
			debuffPos = 'BOTTOM',
			cbshow = true,
			cboffset = {5, 4},
			cbwidth = 160,
			cbheight = 15,
			cbicon = 'LEFT',
			position = 'LEFT/300/80',
		},
		
		focustarget = {
			style = 'normal',
			scale = 1.2,
			enableAura = false,
			HealthTag = 'DISABLE',
		},
		
		party = {
			style = 'normal',
			scale = 1.3,
			cbshow = true,
			cboffset = {0, 0},
			cbwidth = 110,
			cbheight = 9,
			cbicon = 'RIGHT',
			HealthTag = 'PERCENT',
			PowerTag = 'PERCENT',
			position = 'LEFT/80/290'
		},
		
		--[[raid = {
			--style = 'normal',
			--scale = 1.3,
			--cbshow = true,
			--cboffset = {0, 0},
			--cbwidth = 110,
			--cbheight = 9,
			--cbicon = 'RIGHT',
			HealthTag = 'PERCENT',
			PowerTag = 'PERCENT',
			--position = 'LEFT/80/290',
			
			nameLength = 6,
			width = 42,
			height = 40,
			scale = 1.1,

			layout = {
				frameSpacing = 7,
				numGroups = 8,

				initialAnchor = 'TOPLEFT',			-- 'TOPLEFT' 'BOTTOMLEFT' 'TOPRIGHT' 'BOTTOMRIGHT'
				orientation = 'HORIZONTAL',			-- 'VERTICAL' 'HORIZONTAL'
			},

			smoothUpdates = false,					-- Enable smooth updates for all bars
			showThreatText = false,					-- Show a red 'AGGRO' text on the raidframes in addition to the glow
			showRolePrefix = false,					-- A simple role abbrev..tanks = '>'..healer = '+'..dds = '-'
			showNotHereTimer = false,				-- A afk and offline timer
			showMainTankIcon = false,				-- A little shield on the top of a raidframe if the unit is marked as maintank
			showResurrectText = false,				-- Not working atm. just a placeholder
			showMouseoverHighlight = false,

			showTargetBorder = true,				-- Ahows a little border on the raid/party frame if this unit is your target
			targetBorderColor = {1, 1, 1},

			iconSize = 22,							-- The size of the debufficon
			indicatorSize = 7,

			horizontalHealthBars = false,
			deficitThreshold = 0.95,

			manabarShow = false,
			manabarHorizontalOrientation = false,
		},--]]
	}
	
	----------------------------------------------------------------
	ns.defaultProfiles = {
		auraprofile = 'Default',
		profile = 'Default',
	}