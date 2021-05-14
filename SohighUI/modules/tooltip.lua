
	--* Tip (this is a modified tooltip mod based on FatalEntity work)
	local E, C, L, _ = select(2, shCore()):unpack()
	if C['tooltip'].enable ~= true then return end;
	
	local _G = _G
	local unpack = unpack
	local select = select
	local type = type
	local format = string.format
	
	local hooksecurefunc = hooksecurefunc
	local CreateFrame = CreateFrame
	
	local UnitExists = UnitExists
	local UnitRace = UnitRace
	local UnitClass = UnitClass
	local UnitClassification = UnitClassification
	local UnitCreatureType = UnitCreatureType
	local UnitLevel = UnitLevel
	local UnitIsPlayer = UnitIsPlayer
	
	local UnitName, UnitReaction = UnitName, UnitReaction
	local UnitCanAttack = UnitCanAttack
	local UnitIsDead = UnitIsDead
	local UnitIsAFK, UnitIsDND, UnitIsPVP = UnitIsAFK, UnitIsDND, UnitIsPVP
	local UnitIsTapped, UnitIsTappedByPlayer = UnitIsTapped, UnitIsTappedByPlayer

	local tooltips = {
		GameTooltip,
		ItemRefTooltip,
		ChatMenu,
		EmoteMenu,
		LanguageMenu,
		ShoppingTooltip1,
		ShoppingTooltip2,
		WorldMapTooltip,
		FriendsTooltip,
		QuestTip,
		DropDownList1MenuBackdrop,
		DropDownList2MenuBackdrop,
		DropDownList3MenuBackdrop,
	}

	for i = 1, #tooltips do
		tooltips[i]:SetBackdrop(nil)
		tooltips[i]:SetScale(1)
		tooltips[i]:SetLayout()
		tooltips[i]:SetShadow()
	end

	local gt = GameTooltip
	local unitExists, maxHealth

    GameTooltipHeaderText:SetShadowOffset(1, -1)
    GameTooltipHeaderText:SetShadowColor(0, 0, 0, 1)
	
    GameTooltipText:SetShadowOffset(1, -1)
    GameTooltipText:SetShadowColor(0, 0, 0, 1)
	
	ItemRefCloseButton:CloseTemplate()

	--* setup new health statusbar
	local StatusBar = CreateFrame('StatusBar', 'TooltipStatusBar', GameTooltip);
	StatusBar:SetSize(1, 5)
	StatusBar:ClearAllPoints()
	StatusBar:SetAnchor('BOTTOMLEFT', 10, 3);
	StatusBar:SetAnchor('BOTTOMRIGHT', -10, 6);
	StatusBar:SetStatusBarTexture(A.FetchMedia)
	StatusBar:SetLayout()
	StatusBar:Hide()

	--* setup Anchor/Healthbar/Instanthide
	local function gtUpdate(self, ...)
		local owner = self:GetOwner()

		--* update healthbar for world units
		if UnitExists('mouseover') and unitExists then
			local currentHealth = UnitHealth('mouseover')
			local green = currentHealth/maxHealth*2
			local red = 1-green
			StatusBar:SetValue(currentHealth)
			StatusBar:SetStatusBarColor(red+1, green, 0)
		else
			StatusBar:Hide()
			--StatusBar.owner = E.hoop
			E.hoop(StatusBar)
		end

		if (owner == UIParent) then 
			--* instantly hide World Unit tooltips
			if not UnitExists('mouseover') and unitExists then
				self:Hide()
				unitExists = false
			elseif (C['tooltip'].showUnits ~= false) and UnitExists('mouseover') or (C['tooltip'].showInCombat ~= false) and InCombatLockdown() then
				self:Hide()
				unitExists = false
			end
		end
	end

	--* get unitName
	local function unitName(unit)
		if not unit then return end
		local color
		local unitName, unitRealm	= UnitName(unit)
		local Reaction				= UnitReaction(unit, 'player') or 5
		local Attackable			= UnitCanAttack('player', unit)
		local Dead					= UnitIsDead(unit)
		local AFK					= UnitIsAFK(unit)
		local DND					= UnitIsDND(unit)
		local Tapped				= UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)
		local Class, engClass 		= UnitClass(unit)
		local Player				= UnitIsPlayer(unit)

		if unitRealm then
			unitName = unitName..' - '..unitRealm
		end
		
		if Attackable then
			if Tapped or Dead then
				return '|cff888888'..unitName..'|r'
			else
				if (Reaction < 4) then
					return '|cffff4444'..unitName..'|r'
				elseif (Reaction == 4) then
					return '|cffffff44'..unitName..'|r'
				end
			end
		else
			if AFK then Status = '[AFK]' elseif
				DND then Status = '[DND]' elseif
				Dead then Status = ' (Dead)' else
				Status = '' end
			
			if Player then
				color = E.oUF_colors.class[engClass]
				local r, g, b = color[1], color[2], color[3]
				local c = format('%02x%02x%02x', r*255, g*255, b*255)
				return '|cff'..c..unitName..'|r |cffe52b50'..Status..'|r'
			--else
				--return '|cff'..Color..unitName..'|r |cffe52b50'..Status..'|r'
			end
		end
	end

	--* get unit information
	local function unitInformation(unit)
		if not unit then return end
		local color
		local Race				= UnitRace(unit) or ''
		local Class, engClass 	= UnitClass(unit)
		local Classification	= UnitClassification(unit) or ''
		local creatureType		= UnitCreatureType(unit) or ''
		local Level				= UnitLevel(unit) or ''
		local Player			= UnitIsPlayer(unit)
		local Difficulty		= E.GetQuestDifficultyColor(Level)
		local LevelColor		= format('%02x%02x%02x', Difficulty.r*255, Difficulty.g*255, Difficulty.b*255)

		if Level == -1 then
			Level = '??'
			LevelColor = 'ff0000'
		end

		if Player then
			color = E.oUF_colors.class[engClass]
			local r, g, b = color[1], color[2], color[3]
			local c = format('%02x%02x%02x', r*255, g*255, b*255)
			return '|cff'..LevelColor..Level..'|r |cff'..c..Class..'|r '..'|cffefefef'..Race..'|r'
		else
			if (Classification == 'worldboss') then Type = '|cffAF5050Boss|r' elseif
				(Classification == 'rareelite') then Type = '|cffAF5050+ Rare|r' elseif
				(Classification == 'rare') then Type = '|cffAF5050Rare|r' elseif
				(Classification == 'elite') then Type = '|cffAF5050+|r' else
				Type = '' end
			return '|cff'..LevelColor..Level..'|r'..Type..' '..creatureType
		end
	end

	--* get unit guild
	local function unitGuild(unit)
		local GuildName = GameTooltipTextLeft2:GetText()
		if GuildName and not GuildName:find('^Level') then
			return '<'..'|cff00a86b'..GuildName..'|r'..'>'
		else
			return nil
		end
	end

	--* get unit target
	local function unitTarget(unit)	
		if UnitExists(unit..'target') then
			local color
			local _, targetClass = UnitClass(unit..'target')
			local mouseoverTarget, _ = UnitName(unit..'target')
			if (mouseoverTarget == E.Name) and not UnitIsPlayer(unit) then
				return 'Target: '..L_Tooltip_Target
			else
				if UnitCanAttack('player', unit..'target') or UnitIsPlayer(unit..'target') then
					color = E.oUF_colors.class[targetClass]
					local r, g, b = color[1], color[2], color[3]
					local c = format('%02x%02x%02x', r*255, g*255, b*255)
					return 'Target: |cff'..c..mouseoverTarget..'|r'
				else
					return 'Target: |cffffffff'..mouseoverTarget..'|r'
				end
			end
		else
			return nil
		end
	end

	--* set unit tooltip
	local function gtUnit(self, ...)
		
		--* make sure the unit exists
		local _, unit = self:GetUnit()
		if not unit then return end
		
		--* only show unit tooltips for world units, not frames
		if self:GetOwner() ~= UIParent then self:Hide(); return end
		unitExists = true
		
		--* setup statusbar
		maxHealth = UnitHealthMax(unit)
		StatusBar:SetMinMaxValues(0, maxHealth)
		StatusBar:Show()
		
		--* setup tooltip
		local gtUnitGuild, gtUnitTarget = unitGuild(unit), unitTarget(unit)
		local gtIdx, gtText = 1, {}
		GameTooltipTextLeft1:SetText(unitName(unit))
		
		if gtUnitGuild then
			GameTooltipTextLeft2:SetText(gtUnitGuild)
			GameTooltipTextLeft3:SetText(unitInformation(unit))
		else
			GameTooltipTextLeft2:SetText(unitInformation(unit))
		end

		for i=1, self:NumLines() do
			local gtLine = _G['GameTooltipTextLeft'..i]
			local gtLineText = gtLine:GetText()
			if not (gtLineText and UnitIsPVP(unit) and gtLineText:find('^'..PVP_ENABLED)) then
				gtText[gtIdx] = gtLineText
				gtIdx = gtIdx + 1
			end
		end

		self:ClearLines()

		for i = 1, gtIdx - 1 do
			local line = gtText[i]
			if line then
				self:AddLine(line, 1, 1, 1, 1)
			end
		end

		if gtUnitTarget then
			self:AddLine(gtUnitTarget, 1, 1, 1, 1)
		end
	end

	--* set default position for non world tooltips
	local function gtDefault(tooltip, parent)
		GameTooltipStatusBar:ClearAllPoints()
		GameTooltipStatusBar:SetAnchor('BOTTOMLEFT', 10, 3);
		GameTooltipStatusBar:SetAnchor('BOTTOMRIGHT', -10, 6);
		GameTooltipStatusBar:SetStatusBarTexture(A.FetchMedia)
		GameTooltipStatusBar:SetStatusBarColor(.3, .9, .3, 1)
		GameTooltipStatusBar:Height(2)
		GameTooltipStatusBar:SetLayout()
		
		if (C['tooltip'].cursor ~= false) then
			tooltip:SetOwner(parent, 'ANCHOR_CURSOR')
			tooltip.default = 1;
		else
			tooltip:SetOwner(parent, 'ANCHOR_NONE')
			tooltip:ClearAllPoints()
			tooltip:SetAnchor(M.ttposZ, M.ttposX, M.ttposY)
			tooltip.default = 1;
		end
	end

	gt:HookScript('OnUpdate', gtUpdate)
	gt:HookScript('OnTooltipSetUnit', gtUnit)
	hooksecurefunc('GameTooltip_SetDefaultAnchor', gtDefault)
