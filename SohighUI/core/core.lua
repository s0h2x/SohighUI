	
	--* CORE
	local E, C, L, _ = select(2, shCore()):unpack()
	
	local unpack = unpack
	local select = select
	local type = type
	local format, strsub = string.format, string.sub
	local gsub = string.gsub
	local match = string.match
	
	E.Suitag = function(...)
		local text = '|cf2f3f4ffSohigh|r|cffff00ffUI|r:'
		for i = 1, select('#', ...) do
			text = text .. ' ' .. tostring(select(i, ...))
		end

		DEFAULT_CHAT_FRAME:AddMessage(text)
	end
	
	E.FormatMoney = function(value)
		if (value >= 1e4) then
			return format('|cffffd700%dg |r|cffc7c7cf%ds |r|cffeda55f%dc|r', value/1e4, strsub(value, -4) / 1e2, strsub(value, -2))
		elseif (value >= 1e2) then
			return format('|cffc7c7cf%ds |r|cffeda55f%dc|r', strsub(value, -4) / 1e2, strsub(value, -2))
		else
			return format('|cffeda55f%dc|r', strsub(value, -2))
		end
	end
	
	E.ShortValue = function(value)
		if (value >= 1e11) then
			return ('%.0fb'):format(value/1e9)
		elseif (value >= 1e10) then
			return ('%.1fb'):format(value/1e9):gsub('%.?0+([km])$', '%1')
		elseif (value >= 1e9) then
			return ('%.2fb'):format(value/1e9):gsub('%.?0+([km])$', '%1')
		elseif (value >= 1e8) then
			return ('%.0fm'):format(value/1e6)
		elseif (value >= 1e7) then
			return ('%.1fm'):format(value/1e6):gsub('%.?0+([km])$', '%1')
		elseif (value >= 1e6) then
			return ('%.2fm'):format(value/1e6):gsub('%.?0+([km])$', '%1')
		elseif (value >= 1e5) then
			return ('%.0fk'):format(value/1e3)
		elseif(value >= 1e4) then
			return ('%.1fk'):format(value/1e3):gsub('%.?0+([km])$', '%1')
		elseif (value >= 1e3) then
			return ('%.1fk'):format(value/1e3):gsub('%.?0+([km])$', '%1')
		else
			return value
		end
	end

	E.SpawnMenu = function(self)
		local unit = self.unit:gsub('(.)', string.upper, 1)
		if _G[unit..'FrameDropDown'] then
			ToggleDropDownMenu(1, nil, _G[unit..'FrameDropDown'], 'cursor')
		elseif (self.unit:match('party')) then
			ToggleDropDownMenu(1, nil, _G['PartyMemberFrame'..self.id..'DropDown'], 'cursor')
		else
			FriendsDropDown.unit = self.unit
			FriendsDropDown.id = self.id
			FriendsDropDown.initialize = RaidFrameDropDown_Initialize
			ToggleDropDownMenu(1, nil, FriendsDropDown, 'cursor')
		end
	end
	
	local QuestDifficultyColors = {
		trivial = {r = 0.5, g = 0.5, b = 0.43},
		standard = {r = 0, g = 0.87, b = 0},
		difficult = {r = 0.94, g = 0.75, b = 0.07},
		verydifficult = {r = 0.94, g = 0.5, b = 0},
		impossible = {r = 0.95, g = 0, b = 0}
	}

	local function GetRelativeDifficultyColor(unitLevel, challengeLevel)
		local levelDiff = challengeLevel - unitLevel;
		local color;
		if (levelDiff >= 5) then
			return QuestDifficultyColors['impossible'];
		elseif (levelDiff >= 3) then
			return QuestDifficultyColors['verydifficult'];
		elseif (levelDiff >= -2) then
			return QuestDifficultyColors['difficult'];
		elseif (-levelDiff <= GetQuestGreenRange()) then
			return QuestDifficultyColors['standard'];
		else
			return QuestDifficultyColors['trivial'];
		end
	end
	
	E.GetQuestDifficultyColor = function(level)
		return GetRelativeDifficultyColor(E.Level, level)
	end