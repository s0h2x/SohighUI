
	local E, C, L, _ = select(2, shCore()):unpack()
	
	local oUFSohigh, ns = 'SohighUI', oUF
	local oUF = ns.oUF or _G.oUF
	
	local _G = _G
	local unpack = unpack
	local setmetatable = setmetatable
	
	local CreateFrame = CreateFrame

	ns.fontstrings = {} 	-- For fonstrings
	ns.fontstringsB = {}	-- For big fonstrings
	ns.statusbars = {}  	-- For statusbars
	ns.paintframes = {} 	-- For coloring frames

	E.oUF_colors = setmetatable({
		tapped = {0.55, 0.57, 0.61},
		disconnected = {0.84, 0.75, 0.65},
		power = setmetatable({
			[0] = {0.31, 0.45, 0.63},
			[1] = {0.69, 0.31, 0.31},
			[2] = {0.71, 0.43, 0.27},
			[3] = {0.65, 0.63, 0.35},
			[5] = {0.55, 0.57, 0.61},
			[6] = {0, 0.82, 1},
			['MANA'] = {0.00, 0.5, 1.00},
			['RAGE'] = {1.00, 0.00, 0.00},
			['FOCUS'] = {1.00, 0.50, 0.25},
			['ENERGY'] = {1.00, 1.00, 0.00},
			['AMMOSLOT'] = {0.8, 0.6, 0},
			['FUEL'] = {0, 0.55, 0.5},
			['POWER_TYPE_STEAM'] = {0.55, 0.57, 0.61},
			['POWER_TYPE_PYRITE'] = {0.60, 0.09, 0.17},
		}, {__index = oUF.colors.power}),
		happiness = setmetatable({
			[1] = {.69,.31,.31},
			[2] = {.65,.63,.35},
			[3] = {.33,.59,.33},
		}, {__index = oUF.colors.happiness}),
		reaction = setmetatable({
			[1] = { 222/255, 95/255,  95/255 }, -- Hated
			[2] = { 222/255, 95/255,  95/255 }, -- Hostile
			[3] = { 222/255, 95/255,  95/255 }, -- Unfriendly
			[4] = { 218/255, 197/255, 92/255 }, -- Neutral
			[5] = { 75/255,  175/255, 76/255 }, -- Friendly
			[6] = { 75/255,  175/255, 76/255 }, -- Honored
			[7] = { 75/255,  175/255, 76/255 }, -- Revered
			[8] = { 75/255,  175/255, 76/255 }, -- Exalted	
		}, {__index = oUF.colors.reaction}),
		class = setmetatable({
			['DRUID']       = { 255/255, 125/255,  10/255 },
			['HUNTER']      = { 171/255, 214/255, 116/255 },
			['MAGE']        = { 104/255, 205/255, 255/255 },
			['PALADIN']     = { 245/255, 140/255, 186/255 },
			['PRIEST']      = { 212/255, 212/255, 212/255 },
			['ROGUE']       = { 255/255, 243/255,  82/255 },
			['SHAMAN']      = {  41/255,  79/255, 155/255 },
			['WARLOCK']     = { 148/255, 130/255, 201/255 },
			['WARRIOR']     = { 199/255, 156/255, 110/255 },
		}, {__index = oUF.colors.class}),
	}, {__index = oUF.colors})
	
	------------------------------------------------------------------
	--					Init Layout Unit Frames						--
	------------------------------------------------------------------
	local shUF = CreateFrame('frame', 'shUF')
	shUF:RegisterEvent('ADDON_LOADED')
	shUF:SetScript('OnEvent', function(self, event, ...)
		return self[event] and self[event](self, event, ...)
	end);

	function shUF:ADDON_LOADED(event, addon)
		if (addon == oUFSohigh) then
			
			self:SetupSettings()
			
			-- Focus Key
			if (ns.config.focBut ~= 'NONE') then
				local foc = CreateFrame('CheckButton', 'Focuser', UIParent, 'SecureActionButtonTemplate')
				foc:SetAttribute('type1', 'macro')
				foc:SetAttribute('macrotext', '/focus mouseover')
				SetOverrideBindingClick(Focuser, true, ns.config.focMod..'BUTTON'..ns.config.focBut, 'Focuser')
			end

			self:UnregisterEvent(event)
			self:RegisterEvent('PLAYER_LOGOUT') -- For cleaning DB on logout
			self:RegisterEvent('PLAYER_TARGET_CHANGED') --  Target sounds
			self:RegisterEvent('PLAYER_FOCUS_CHANGED') -- Focus Sounds

			-- Setup Options
			self:SetupOptions()

			self.ADDON_LOADED = nil
		else
			E.Suitag(L_AddonNotLoaded)
		end
	end
	----------------------------------------------------------------------
	
	-- Target changed sounds
	local memory = { }
	local function PlayTargetSounds(unit)
		if ( UnitExists(unit) ) then
			memory[unit] = true
			if ( UnitIsEnemy(unit, 'player') ) then
				PlaySound('igCreatureAggroSelect');
			elseif ( UnitIsFriend('player', unit) ) then
				PlaySound('igCharacterNPCSelect');
			else
				PlaySound('igCreatureNeutralSelect');
			end
		elseif memory[unit] then
			memory[unit] = false
			PlaySound('INTERFACESOUND_LOSTTARGETUNIT');
		end
	end

	function shUF:PLAYER_TARGET_CHANGED(self, event, ...)
		CloseDropDownMenus()
		PlayTargetSounds('target')
	end

	function shUF:PLAYER_FOCUS_CHANGED(self, event, ...)
		PlayTargetSounds('focus')
	end
	
	-- Init anchor
	function shUF:SetupOptions()
		_G.SLASH_shUF1 = '/unlock'
		_G.SLASH_shUF2 = '/moveui'
		SlashCmdList['shUF'] = function(...) self:ToggleAllAnchors() end
	end

	function ns.Print(...)
		if (...) then
			return E.Suitag(select(1, ...), select(2, ...))
		end
	end

	function shUF:Print(...)
		return ns.Print(...)
	end