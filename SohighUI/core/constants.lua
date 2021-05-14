
	--* Initiation / Engine of SohighUI

	local _G = _G
	local unpack, select, tonumber = unpack, select, tonumber
	local UnitName = UnitName
	local UnitClass = UnitClass
	local UnitRace = UnitRace
	local UnitLevel = UnitLevel
	local UnitFactionGroup = UnitFactionGroup
	local UnitAffectingCombat = UnitAffectingCombat
	local CUSTOM_CLASS_COLORS = CUSTOM_CLASS_COLORS
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS
	local GetRealmName = GetRealmName
	local GetLocale = GetLocale
	local GetCVar = GetCVar
	local GetAddOnMetadata = GetAddOnMetadata
	local GetBuildInfo = GetBuildInfo
	local IsMacClient = IsMacClient

	--* Build the Engine
	local AddOn, shEngine = 'SohighUI', {}
	shCore = function() return AddOn, shEngine end

	shEngine[1] = {}	-- E, Engine
	shEngine[2] = {}	-- C, Config
	shEngine[3] = {}	-- L, Localization
	shEngine[4] = {}	-- ET, Engine Template
	shEngine[4][AddOn] = {} -- Insert Skins Template
	
	function shEngine:unpack()
		return self[1], self[2], self[3], self[4]
	end
	
	shEngine[1].Name = UnitName('player')
	shEngine[1].Class = select(2, UnitClass('player'))
	shEngine[1].Faction = select(2, UnitFactionGroup('player'))
	shEngine[1].LocalizedRace, shEngine[1].Race = UnitRace('player')
	shEngine[1].Level = UnitLevel('player')
	shEngine[1].Combat = UnitAffectingCombat('player')
	shEngine[1].Color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[shEngine[1].Class]
	shEngine[1].Realm = GetRealmName()
	shEngine[1].Region = GetLocale()
	shEngine[1].TexCoords = { 0.08, 0.92, 0.08, 0.92 }
	
	shEngine[1].Resolution = GetCVar('gxResolution')
	shEngine[1].ScreenHeight = tonumber(string.match(shEngine[1].Resolution, '%d+x(%d+)'))
	shEngine[1].ScreenWidth = tonumber(string.match(shEngine[1].Resolution, '(%d+)x+%d'))
	
	shEngine[1].Version = GetAddOnMetadata(AddOn, 'Version')
	shEngine[1].WoWPatch, shEngine[1].WoWBuild, shEngine[1].TocVersion = GetBuildInfo()
	shEngine[1].IsMacClient = IsMacClient()
	shEngine[1].hoop = function() end
	
	SohighUI = shEngine