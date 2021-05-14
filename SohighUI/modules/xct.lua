
	--*	Combat Text(xCT by Affli)
	
	local E, C, L, _ = select(2, shCore()):unpack()
	if C['ct'].moduleEnable ~= true then return end
	
	local _G = _G
	local format = string.format
	
	local CreateFrame = CreateFrame
	local hooksecurefunc = hooksecurefunc
	
	--* Justify messages in frames
	local ct = {
		['justify_1'] = 'LEFT',			--* Incoming damage justify
		['justify_2'] = 'RIGHT',		--* Incoming healing justify
		['justify_3'] = 'CENTER',		--* Various messages justify
		['justify_4'] = 'RIGHT',		--* Outgoing damage/healing justify
	}

	local function SetUnit()
		ct.unit = 'player'
	end

	--* Do not edit below unless you know what you are doing
	local numf
	if C['ct'].dps or C['ct'].healing then
		numf = 4
	else
		numf = 3
	end

	--* Limit lines
	local function LimitLines()
		for i = 1, #ct.frames do
			f = ct.frames[i]
			if i == 4 and C['ct'].icons then
				f:SetMaxLines(floor(f:GetHeight()/(C['ct'].iconSize.value * 1.5))* 2)
			else
				f:SetMaxLines(floor(f:GetHeight()/A.fontSize - 1)* 2)
			end
		end
	end

	--* Scrollable frames
	local function SetScroll()
		for i = 1, #ct.frames do
			ct.frames[i]:EnableMouseWheel(true)
			ct.frames[i]:SetScript('OnMouseWheel', function(self, delta)
				if delta > 0 then
					self:ScrollUp()
				elseif delta < 0 then
					self:ScrollDown()
				end
			end);
		end
	end

	--* Partial resists styler
	local part = '-%s [%s %s]'
	local r, g, b

	--* Function, handles everything
	local function OnEvent(self, event, subevent, ...)
		if event == 'COMBAT_TEXT_UPDATE' then
			local arg2, arg3 = ...
			if SHOW_COMBAT_TEXT == '0' then
				return
			else
				if subevent == 'DAMAGE' then
					if C['ct'].shortNum == true then
						arg2 = E.ShortValue(arg2)
					end
					xCT1:AddMessage('-'..arg2, 0.75, 0.1, 0.1)
				elseif subevent == 'DAMAGE_CRIT' then
					if C['ct'].shortNum == true then
						arg2 = E.ShortValue(arg2)
					end
					xCT1:AddMessage('|cffFF0000'..M.critPrefix..'|r'..'-'..arg2..'|cffFF0000'..M.critPostfix..'|r', 1, 0.1, 0.1)
				elseif subevent == 'SPELL_DAMAGE' then
					if C['ct'].shortNum == true then
						arg2 = E.ShortValue(arg2)
					end
					xCT1:AddMessage('-'..arg2, 0.75, 0.3, 0.85)
				elseif subevent == 'SPELL_DAMAGE_CRIT' then
					if C['ct'].shortNum == true then
						arg2 = E.ShortValue(arg2)
					end
					xCT1:AddMessage('|cffFF0000'..M.critPrefix..'|r'..'-'..arg2..'|cffFF0000'..M.critPostfix..'|r', 1, 0.3, 0.5)
				elseif subevent == 'HEAL' then
					if arg3 >= M.healthreshold then
						if C['ct'].shortNum == true then
							arg3 = E.ShortValue(arg3)
						end
						if arg2 then
							if COMBAT_TEXT_SHOW_FRIENDLY_NAMES == '1' then
								xCT2:AddMessage(arg2..' +'..arg3, 0.1, 0.75, 0.1)
							else
								xCT2:AddMessage('+'..arg3, 0.1, 0.75, 0.1)
							end
						end
					end
				elseif subevent == 'HEAL_CRIT' then
					if arg3 >= M.healthreshold then
						if C['ct'].shortNum == true then
							arg3 = E.ShortValue(arg3)
						end
						if arg2 then
							if COMBAT_TEXT_SHOW_FRIENDLY_NAMES == '1' then
								xCT2:AddMessage(arg2..' +'..arg3, 0.1, 1, 0.1)
							else
								xCT2:AddMessage('+'..arg3, 0.1, 1, 0.1)
							end
						end
					end
				elseif subevent == 'PERIODIC_HEAL' then
					if arg3 >= M.healthreshold then
						if C['ct'].shortNum == true then
							arg3 = E.ShortValue(arg3)
						end
						xCT2:AddMessage('+'..arg3, 0.1, 0.5, 0.1)
					end
				elseif subevent == 'SPELL_CAST' then
					xCT3:AddMessage(arg2, 1, 0.82, 0)
				elseif subevent == 'MISS' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(MISS, 0.5, 0.5, 0.5)
				elseif subevent == 'DODGE' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(DODGE, 0.5, 0.5, 0.5)
				elseif subevent == 'PARRY' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(PARRY, 0.5, 0.5, 0.5)
				elseif subevent == 'EVADE' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(EVADE, 0.5, 0.5, 0.5)
				elseif subevent == 'IMMUNE' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(IMMUNE, 0.5, 0.5, 0.5)
				elseif subevent == 'DEFLECT' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(DEFLECT, 0.5, 0.5, 0.5)
				elseif subevent == 'REFLECT' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(REFLECT, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_MISS' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(MISS, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_DODGE'and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(DODGE, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_PARRY' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(PARRY, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_EVADE' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(EVADE, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_IMMUNE' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(IMMUNE, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_DEFLECT' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(DEFLECT, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_REFLECT' and COMBAT_TEXT_SHOW_DODGE_PARRY_MISS == '1' then
					xCT1:AddMessage(REFLECT, 0.5, 0.5, 0.5)
				elseif subevent == 'RESIST' then
					if arg3 then
						if C['ct'].shortNum == true then
							arg2 = E.ShortValue(arg2)
							arg3 = E.ShortValue(arg3)
						end
						if COMBAT_TEXT_SHOW_RESISTANCES == '1' then
							xCT1:AddMessage(part:format(arg2, RESIST, arg3), 0.75, 0.5, 0.5)
						else
							xCT1:AddMessage('-'..arg2, 0.75, 0.1, 0.1)
						end
					elseif COMBAT_TEXT_SHOW_RESISTANCES == '1' then
						xCT1:AddMessage(RESIST, 0.5, 0.5, 0.5)
					end
				elseif subevent == 'BLOCK' then
					if arg3 then
						if C['ct'].shortNum == true then
							arg2 = E.ShortValue(arg2)
							arg3 = E.ShortValue(arg3)
						end
						if COMBAT_TEXT_SHOW_RESISTANCES == '1' then
							xCT1:AddMessage(part:format(arg2, BLOCK, arg3), 0.75, 0.5, 0.5)
						else
							xCT1:AddMessage('-'..arg2, 0.75, 0.1, 0.1)
						end
					elseif COMBAT_TEXT_SHOW_RESISTANCES == '1' then
						xCT1:AddMessage(BLOCK, 0.5, 0.5, 0.5)
					end
				elseif subevent == 'ABSORB' then
					if arg3 then
						if C['ct'].shortNum == true then
							arg2 = E.ShortValue(arg2)
							arg3 = E.ShortValue(arg3)
						end
						if COMBAT_TEXT_SHOW_RESISTANCES == '1' then
							xCT1:AddMessage(part:format(arg2, ABSORB, arg3), 0.75, 0.5, 0.5)
						else
							xCT1:AddMessage('-'..arg2, 0.75, 0.1, 0.1)
						end
					elseif COMBAT_TEXT_SHOW_RESISTANCES == '1' then
						xCT1:AddMessage(ABSORB, 0.5, 0.5, 0.5)
					end
				elseif subevent == 'SPELL_RESIST' then
					if arg3 then
						if C['ct'].shortNum == true then
							arg2 = E.ShortValue(arg2)
							arg3 = E.ShortValue(arg3)
						end
						if COMBAT_TEXT_SHOW_RESISTANCES == '1' then
							xCT1:AddMessage(part:format(arg2, RESIST, arg3), 0.5, 0.3, 0.5)
						else
							xCT1:AddMessage('-'..arg2, 0.75, 0.3, 0.85)
						end
					elseif COMBAT_TEXT_SHOW_RESISTANCES == '1' then
						xCT1:AddMessage(RESIST, 0.5, 0.5, 0.5)
					end
				elseif subevent == 'SPELL_BLOCK' then
					if arg3 then
						if C['ct'].shortNum == true then
							arg2 = E.ShortValue(arg2)
							arg3 = E.ShortValue(arg3)
						end
						if COMBAT_TEXT_SHOW_RESISTANCES == '1' then
							xCT1:AddMessage(part:format(arg2, BLOCK, arg3), 0.5, 0.3, 0.5)
						else
							xCT1:AddMessage('-'..arg2, 0.75, 0.3, 0.85)
						end
					elseif COMBAT_TEXT_SHOW_RESISTANCES == '1' then
						xCT1:AddMessage(BLOCK, 0.5, 0.5, 0.5)
					end
				elseif subevent == 'SPELL_ABSORB' then
					if arg3 then
						if C['ct'].shortNum == true then
							arg2 = E.ShortValue(arg2)
							arg3 = E.ShortValue(arg3)
						end
						if COMBAT_TEXT_SHOW_RESISTANCES == '1' then
							xCT1:AddMessage(part:format(arg2, ABSORB, arg3), 0.5, 0.3, 0.5)
						else
							xCT1:AddMessage('-'..arg2, 0.75, 0.3, 0.85)
						end
					elseif COMBAT_TEXT_SHOW_RESISTANCES == '1' then
						xCT1:AddMessage(ABSORB, 0.5, 0.5, 0.5)
					end
				elseif subevent == 'MANA' and COMBAT_TEXT_SHOW_MANA == '1' then
					if tonumber(arg2) > 0 then
						local PowerBarColor = E.oUF_colors.power[0]
						xCT3:AddMessage('+'..arg2..' '.._G[subevent], PowerBarColor[1], PowerBarColor[2], PowerBarColor[3])
					end
				elseif subevent == 'RAGE' and COMBAT_TEXT_SHOW_MANA == '1' then
					if tonumber(arg2) > 0 then
						local PowerBarColor = E.oUF_colors.power[1]
						xCT3:AddMessage('+'..arg2..' '.._G[subevent], PowerBarColor[1], PowerBarColor[2], PowerBarColor[3])
					end
				elseif subevent == 'FOCUS' and COMBAT_TEXT_SHOW_MANA == '1' then
					if tonumber(arg2) > 0 then
						local PowerBarColor = E.oUF_colors.power[2]
						xCT3:AddMessage('+'..arg2..' '.._G[subevent], PowerBarColor[1], PowerBarColor[2], PowerBarColor[3])
					end
				elseif subevent == 'ENERGY' and COMBAT_TEXT_SHOW_MANA == '1' then
					if tonumber(arg2) > 0 then
						local PowerBarColor = E.oUF_colors.power[3]
						xCT3:AddMessage('+'..arg2..' '.._G[subevent], PowerBarColor[1], PowerBarColor[2], PowerBarColor[3])
					end
				elseif subevent == 'SPELL_AURA_START' and COMBAT_TEXT_SHOW_AURAS == '1' then
					xCT3:AddMessage('+'..arg2, 1, 0.5, 0.5)
				elseif subevent == 'SPELL_AURA_END' and COMBAT_TEXT_SHOW_AURAS == '1' then
					xCT3:AddMessage('-'..arg2, 0.5, 0.5, 0.5)
				elseif subevent == 'SPELL_AURA_START_HARMFUL' and COMBAT_TEXT_SHOW_AURAS == '1' then
					xCT3:AddMessage('+'..arg2, 1, 0.1, 0.1)
				elseif subevent == 'SPELL_AURA_END_HARMFUL' and COMBAT_TEXT_SHOW_AURAS == '1' then
					xCT3:AddMessage('-'..arg2, 0.1, 1, 0.1)
				elseif subevent == 'HONOR_GAINED' and COMBAT_TEXT_SHOW_HONOR_GAINED == '1' then
					arg2 = tonumber(arg2)
					if arg2 and abs(arg2) > 1 then
						arg2 = floor(arg2)
						if arg2 > 0 then
							xCT3:AddMessage(HONOR..' +'..arg2, 0.1, 0.1, 1)
						end
					end
				elseif subevent == 'FACTION' and COMBAT_TEXT_SHOW_REPUTATION == '1' then
					xCT3:AddMessage(arg2..' +'..arg3, 0.1, 0.1, 1)
				elseif subevent == 'SPELL_ACTIVE' and COMBAT_TEXT_SHOW_REACTIVES == '1' then
					xCT3:AddMessage(arg2, 1, 0.82, 0)
				end
			end
		elseif event == 'UNIT_HEALTH' and COMBAT_TEXT_SHOW_LOW_HEALTH_MANA == '1' then
			if subevent == ct.unit then
				if UnitHealth(ct.unit) / UnitHealthMax(ct.unit) <= COMBAT_TEXT_LOW_HEALTH_THRESHOLD then
					if not lowHealth then
						xCT3:AddMessage(HEALTH_LOW, 1, 0.1, 0.1)
						lowHealth = true
					end
				else
					lowHealth = nil
				end
			end
		elseif event == 'UNIT_MANA' and COMBAT_TEXT_SHOW_LOW_HEALTH_MANA == '1' then
			if subevent == ct.unit then
				local powerType = UnitPowerType(ct.unit)
				if powerType == 0 and (UnitMana(ct.unit) / UnitManaMax(ct.unit)) <= COMBAT_TEXT_LOW_MANA_THRESHOLD then
					if not lowMana then
						xCT3:AddMessage(MANA_LOW, 1, 0.1, 0.1)
						lowMana = true
					end
				else
					lowMana = nil
				end
			end
		elseif event == 'PLAYER_REGEN_ENABLED' and COMBAT_TEXT_SHOW_COMBAT_STATE == '1' then
				xCT3:AddMessage('-'..LEAVING_COMBAT, 0.1, 1, 0.1)
		elseif event == 'PLAYER_REGEN_DISABLED' and COMBAT_TEXT_SHOW_COMBAT_STATE == '1' then
				xCT3:AddMessage('+'..ENTERING_COMBAT, 1, 0.1, 0.1)
		elseif event == 'UNIT_COMBO_POINTS' and COMBAT_TEXT_SHOW_COMBO_POINTS == '1' then
			if subevent == ct.unit then
				local cp = GetComboPoints(ct.unit, 'target')
				if cp > 0 then
					r, g, b = 1, 0.82, 0
					if cp == MAX_COMBO_POINTS then
						r, g, b = 0, 0.82, 1
					end
					xCT3:AddMessage(format(COMBAT_TEXT_COMBO_POINTS, cp), r, g, b)
				end
			end
		elseif event == 'PLAYER_ENTERING_WORLD' then
			SetUnit()
			if C['ct'].scrollable then
				SetScroll()
			else
				LimitLines()
			end
			if C['ct'].dps or C['ct'].healing then
				ct.pguid = UnitGUID('player')
			end
		end
	end

	--* Change damage font
	if C['ct'].styleDps then
		DAMAGE_TEXT_FONT = A.font
	end

	--* Hide blizzard combat text
	if C['ct'].showBlizzOut ~= true then
		SetCVar('CombatHealing', 0)
		SetCVar('CombatDamage', 0)
	else
		SetCVar('CombatHealing', 1)
		SetCVar('CombatDamage', 1)
	end

	local frame = CreateFrame('frame')
	frame:RegisterEvent('PLAYER_LOGOUT')
	frame:SetScript('OnEvent', function(self, event)
		if (event == 'PLAYER_LOGOUT') then
			SetCVar('CombatHealing', 1)
			SetCVar('CombatDamage', 1)
		end
	end)

	--* Frames
	ct.locked = true
	ct.frames = {}
	for i = 1, numf do
		local f = CreateFrame('ScrollingMessageFrame', 'xCT'..i, UIParent)
		f:SetFont(A.font, A.fontSize, A.fontStyle)
		f:SetShadowColor(0, 0, 0, A.fontShadow and 1 or 0)
		f:SetShadowOffset(A.fontShadow and 1 or 0, A.fontShadow and -1 or 0)
		f:SetTimeVisible(M.timeShows)
		f:SetMaxLines(M.maxLines)
		f:SetSpacing(1)
		f:SetSize(128, 112)
		f:SetAnchor('CENTER', 0, 0)
		f:SetMovable(true)
		f:SetResizable(true)
		f:SetMinResize(128, 128)
		f:SetMaxResize(768, 768)
		f:SetClampedToScreen(true)
		f:SetClampRectInsets(0, 0, A.fontSize, 0)
		f:SetInsertMode(M.direction or 'BOTTOM')
		if i == 1 then
			f:SetJustifyH(ct.justify_1)
			if _G.SohighUIPlayer then
				f:SetAnchor('BOTTOMLEFT', 'SohighUIPlayer', 'TOPLEFT', -3, 60)
			else
				f:SetAnchor('CENTER', -192, -32)
			end
		elseif i == 2 then
			f:SetJustifyH(ct.justify_2)
			if _G.SohighUIPlayer then
				f:SetAnchor('BOTTOMRIGHT', 'SohighUIPlayer', 'TOPRIGHT', 5, 60)
			else
				f:SetAnchor('CENTER', 192, -32)
			end
		elseif i == 3 then
			f:SetJustifyH(ct.justify_3)
			f:Width(256)
			f:SetAnchor('CENTER', 0, 205)
		else
			f:SetJustifyH(ct.justify_4)
			f:Width(200)
			if C['ct'].icons then
				f:Height(150)
			end
			if _G.SohighUITarget then
				f:SetAnchor('BOTTOMRIGHT', 'SohighUITarget', 'TOPRIGHT', 2, 278)
			else
				f:SetAnchor('CENTER', 330, 205)
			end
			local a, _, c = f:GetFont()
			if (A.fontSize == 'auto') then
				if C['ct'].icons then
					f:SetFont(a, C['ct'].iconSize.value / 2, c)
				end
			elseif type(A.fontSize) == 'number' then
				f:SetFont(a, A.fontSize, c)
			end
		end
		ct.frames[i] = f
	end

	--* Register events
	local xCT = CreateFrame('frame')
	xCT:RegisterEvent('COMBAT_TEXT_UPDATE')
	xCT:RegisterEvent('UNIT_HEALTH')
	xCT:RegisterEvent('UNIT_MANA')
	xCT:RegisterEvent('PLAYER_REGEN_DISABLED')
	xCT:RegisterEvent('PLAYER_REGEN_ENABLED')
	xCT:RegisterEvent('UNIT_COMBO_POINTS')
	xCT:RegisterEvent('RUNE_POWER_UPDATE')
	xCT:RegisterEvent('PLAYER_ENTERING_WORLD')
	xCT:SetScript('OnEvent', OnEvent)
	
	LoadAddOn('Blizzard_CombatText')

	--* turn off blizz ct
	CombatText:UnregisterAllEvents()
	CombatText:SetScript('OnLoad', nil)
	CombatText:SetScript('OnEvent', nil)
	CombatText:SetScript('OnUpdate', nil)

	--* Steal external messages sent by other addons using CombatText_AddMessage
	hooksecurefunc('CombatText_AddMessage', function(message, scrollFunction, r, g, b, displayType, isStaggered)
		local lastEntry = COMBAT_TEXT_TO_ANIMATE[#COMBAT_TEXT_TO_ANIMATE]
		CombatText_RemoveMessage(lastEntry)
		xCT3:AddMessage(message, r, g, b)
	end)

	--* Color printer
	local pr = function(msg)
		E.Suitag(tostring(msg))
	end

	--* Configmode and testmode
	local StartConfigmode = function()
		if not InCombatLockdown()then
			for i = 1, #ct.frames do
				f = ct.frames[i]
				--*f:SetTemplate('Transparent')
				f:SetBackdrop({
					bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
					edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
					tile = false, tileSize = 0, edgeSize = 2,
					insets = {left = 0, right = 0, top = 0, bottom = 0}
				})
				f:SetBackdropColor(.1, .1, .1, .8)
				--*f:SetBackdropBorderColor(.1, .1, .1, .5)
				f:SetBackdropBorderColor(1, 0, 0, 1)

				f.fs = f:CreateFontString(nil, 'OVERLAY')
				f.fs:SetFont(A.font, A.fontSize, A.fontStyle)
				f.fs:SetAnchor('BOTTOM', f, 'TOP', 0, 0)
				if i == 1 then
					f.fs:SetText(DAMAGE)
					f.fs:SetTextColor(1, 0.1, 0.1, 0.9)
				elseif i == 2 then
					f.fs:SetText(SHOW_COMBAT_HEALING)
					f.fs:SetTextColor(0.1, 1, 0.1, 0.9)
				elseif i == 3 then
					f.fs:SetText(COMBAT_TEXT_LABEL)
					f.fs:SetTextColor(0.1, 0.1, 1, 0.9)
				else
					f.fs:SetText(SCORE_DAMAGE_DONE..' / '..SCORE_HEALING_DONE)
					f.fs:SetTextColor(1, 1, 0, 0.9)
				end

				f.t = f:CreateTexture('ARTWORK')
				f.t:SetAnchor('TOPLEFT', f, 'TOPLEFT', 1, -1)
				f.t:SetAnchor('TOPRIGHT', f, 'TOPRIGHT', -1, -19)
				f.t:Height(20)
				f.t:SetTexture(0.5, 0.5, 0.5)
				f.t:SetAlpha(0.3)

				f.d = f:CreateTexture('ARTWORK')
				f.d:SetSize(16)
				f.d:SetAnchor('BOTTOMRIGHT', f, 'BOTTOMRIGHT', -1, 1)
				f.d:SetTexture(0.5, 0.5, 0.5)
				f.d:SetAlpha(0.3)

				if not f.tr then
					f.tr = CreateFrame('Frame', nil, f)
					f.tr:SetScript('OnDragStart', function(self, button)
						self:GetParent():StartMoving()
					end)
					f.tr:SetScript('OnDragStop', function(self)
						self:GetParent():StopMovingOrSizing()
					end)
					f.tr:EnableMouse(true)
					f.tr:RegisterForDrag('LeftButton')
					f.tr:SetAnchor('TOPLEFT', f, 'TOPLEFT', 0, 0)
					f.tr:SetAnchor('TOPRIGHT', f, 'TOPRIGHT', 0, 0)
					f.tr:Height(20)
				end

				f:EnableMouse(true)
				f:RegisterForDrag('LeftButton')
				f:SetScript('OnDragStart', f.StartSizing)
				if not C['ct'].scrollable then
					if i == 4 and C['ct'].icons then
						f:SetScript('OnSizeChanged', function(self)
							self:SetMaxLines(floor(self:GetHeight() / (C['ct'].iconSize.value * 1.5)) * 2)
							self:Clear()
						end)
					else
						f:SetScript('OnSizeChanged', function(self)
							self:SetMaxLines(floor(self:GetHeight() / A.fontSize - 1) * 2)
							self:Clear()
						end)
					end
				end

				f:SetScript('OnDragStop', f.StopMovingOrSizing)
				ct.locked = false
			end
			pr('|cffffefd5'..L_Combattext_Unlocked..'|r')
		else
			pr('|cffffefd5'..L_SystemError..'|r')
		end
	end

	local function EndConfigmode()
		for i = 1, #ct.frames do
			f = ct.frames[i]
			f:SetBackdrop(nil)
			f:Hide()
			f.fs:Hide()
			f.fs = nil
			f.t:Hide()
			f.t = nil
			f.d:Hide()
			f.d = nil
			f.tr = nil
			f:EnableMouse(false)
			f:SetScript('OnDragStart', nil)
			f:SetScript('OnDragStop', nil)
		end
		ct.locked = true
		pr('|cffffefd5'..L_Combattext_Decline..'|r')
	end

	local function StartTestMode()
		--* Init random number generator
		local random = random
		random(time()); random(); random(time())

		local TimeSinceLastUpdate = 0
		local UpdateInterval
		if C['ct']._colorDps then
			ct.dmindex = {}
			ct.dmindex[1] = 1
			ct.dmindex[2] = 2
			ct.dmindex[3] = 4
			ct.dmindex[4] = 8
			ct.dmindex[5] = 16
			ct.dmindex[6] = 32
			ct.dmindex[7] = 64
		end

		for i = 1, #ct.frames do
			ct.frames[i]:SetScript('OnUpdate', function(self, elapsed)
				UpdateInterval = random(65, 1000) / 250
				TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate > UpdateInterval then
					if i == 1 then
						ct.frames[i]:AddMessage('-'..random(100000), 1, random(255) / 255, random(255) / 255)
					elseif i == 2 then
						ct.frames[i]:AddMessage('+'..random(50000), 0.1, random(128, 255) / 255, 0.1)
					elseif i == 3 then
						ct.frames[i]:AddMessage(COMBAT_TEXT_LABEL, random(255) / 255, random(255) / 255, random(255) / 255)
					elseif i == 4 then
						local msg
						local icon
						local color = {}
						msg = random(40000)
						if C['ct'].icons then
							_, _, icon = GetSpellInfo(msg)
							if not icon then
								_, _, icon = GetSpellInfo(6603)
							end
						end
						if icon then
							msg = msg..' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
							if C['ct']._colorDps then
								color = ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
							else
								color = {1, 1, 0}
							end
						elseif C['ct']._colorDps and not C['ct'].icons then
							color = ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
						elseif not C['ct']._colorDps then
							color = {1, 1, random(0, 1)}
						end
						ct.frames[i]:AddMessage(msg, unpack(color))
					end
					TimeSinceLastUpdate = 0
				end
			end)
			ct.testmode = true
		end
	end

	local function EndTestMode()
		for i = 1, #ct.frames do
			ct.frames[i]:SetScript('OnUpdate', nil)
			ct.frames[i]:Clear()
		end
		if C['ct']._colorDps then
			ct.dmindex = nil
		end
		ct.testmode = false
	end

	--* Popup dialog
	StaticPopupDialogs.XCT_LOCK = {
		text = L_Combattext_Popup,
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function() if not InCombatLockdown() then ReloadUI() else EndConfigmode() end end,
		OnCancel = EndConfigmode,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = true,
		showAlert = true,
		preferredIndex = 5,
	}

	local placed = {
		'xCT1',
		'xCT2',
		'xCT3',
		'xCT4'
	}

	--* Slash commands
	SlashCmdList.XCT = function(input)
		input = strlower(input)
		if input == 'unlock' then
			if ct.locked then
				StartConfigmode()
			else
				pr('|cffffefd5'..L_Combattext_AlreadyUnlock..'|r')
			end
		elseif input == 'lock' then
			if ct.locked then
				pr('|cffffefd5'..L_Combattext_AlreadyLock..'|r')
			else
				StaticPopup_Show('XCT_LOCK')
			end
		elseif input == 'test' then
			if ct.testmode then
				EndTestMode()
				pr('|cffffefd5'..L_Combattext_TestOff..'|r')
			else
				StartTestMode()
				pr('|cffffefd5'..L_Combattext_TestOn..'|r')
			end
		elseif input == 'reset' then
			for i, v in pairs(placed) do
				if _G[v] then
					_G[v]:SetUserPlaced(false)
				end
			end
			ReloadUI()
		else
			pr('|cffffefd5'..L_Combattext_Unlock..'|r')
			pr('|cffffefd5'..L_Combattext_Locked..'|r')
			pr('|cffffefd5'..L_Combattext_Test..'|r')
			pr('|cffffefd5'..L_Combattext_Reset..'|r')
		end
	end
	SLASH_XCT1 = '/xct'
	SLASH_XCT2 = '/чсе'

	--* Spam merger
	local SQ
	if C['ct'].mergeAoE then
		if C['ct'].dps or C['ct'].healing then
			local pairs = pairs
			SQ = {}
			for k, v in pairs(E.aoespam) do
				SQ[k] = {queue = 0, msg = '', color = {}, count = 0, utime = 0, locked = false}
			end
			ct.SpamQueue = function(spellId, add)
				local amount
				local spam = SQ[spellId]['queue']
				if spam and type(spam) == 'number' then
					amount = spam + add
				else
					amount = add
				end
				return amount
			end
			local tslu = 0
			local xCTspam = CreateFrame('Frame')
			xCTspam:SetScript('OnUpdate', function(self, elapsed)
				local count
				tslu = tslu + elapsed
				if tslu > 0.5 then
					tslu = 0
					local utime = time()
					for k, v in pairs(SQ) do
						if not SQ[k]['locked'] and SQ[k]['queue'] > 0 and SQ[k]['utime'] <= utime then
							if SQ[k]['count'] > 1 then
								count = ' |cffFFFFFF x '..SQ[k]['count']..'|r'
							else
								count = ''
							end
							if C['ct'].shortNum == true then
								SQ[k]['queue'] = E.ShortValue(SQ[k]['queue'])
							end
							xCT4:AddMessage(SQ[k]['queue']..count..SQ[k]['msg'], unpack(SQ[k]['color']))
							SQ[k]['queue'] = 0
							SQ[k]['count'] = 0
						end
					end
				end
			end)
		end
	end

	--* Damage
	if C['ct'].dps then
		local unpack, select, time = unpack, select, time
		local gflags = bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE,
			COMBATLOG_OBJECT_REACTION_FRIENDLY,
			COMBATLOG_OBJECT_CONTROL_PLAYER,
			COMBATLOG_OBJECT_TYPE_GUARDIAN
		)
		local xCTd = CreateFrame('Frame')
		if C['ct']._colorDps then
			ct.dmgcolor = {}
			ct.dmgcolor[1] = {1, 1, 0}		--* Physical
			ct.dmgcolor[2] = {1, 0.9, 0.5}	--* Holy
			ct.dmgcolor[4] = {1, 0.5, 0}	--* Fire
			ct.dmgcolor[8] = {0.3, 1, 0.3}	--* Nature
			ct.dmgcolor[16] = {0.5, 1, 1}	--* Frost
			ct.dmgcolor[32] = {0.5, 0.5, 1}	--* Shadow
			ct.dmgcolor[64] = {1, 0.5, 1}	--* Arcane
		end
		
		if C['ct'].icons then
			--[[local f = CreateFrame('frame')
			f:SetLayout()
			ct.blank = f:CreateTexture('ARTWORK')
			ct.blank:SetTexture(A.solid)
			ct.blank:SetTexCoord(unpack(E.TexCoords))
			ct.blank:SetParent(f)--]]
			ct.blank = [[Interface\AddOns\SohighUI\styles\arts\solid]]
		end
		
		local misstypes = {ABSORB = ABSORB, BLOCK = BLOCK, DEFLECT = DEFLECT, DODGE = DODGE, EVADE = EVADE, IMMUNE = IMMUNE, MISS = MISS, PARRY = PARRY, REFLECT = REFLECT, RESIST = RESIST}
		local dmg = function(self, event, ...)
			local msg, icon
			local eventType, sourceGUID, _, sourceFlags, destGUID = select(2, ...)
			if (sourceGUID == ct.pguid and destGUID ~= ct.pguid) or (sourceGUID == UnitGUID('pet') and C['ct']._petDps) or (sourceFlags == gflags) then
				if eventType == 'SWING_DAMAGE' then
					local amount, _, _, _, _, critical = select(9, ...)
					if amount >= M.threshold then
						local rawamount = amount
						if C['ct'].shortNum == true then
							amount = E.ShortValue(amount)
						end
						if critical then
							amount = '|cffFF0000'..M.critPrefix..'|r'..amount..'|cffFF0000'..M.critPostfix..'|r'
						end
						if C['ct'].icons then
							if (sourceGUID == UnitGUID('pet')) or (sourceFlags == gflags) then
								icon = PET_ATTACK_TEXTURE
							else
								_, _, icon = GetSpellInfo(6603)
							end
							msg = ' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
						end
						local color = {1, 1, 1}
						if C['ct'].mergeAoE and C['ct'].mergeMelee then
							local spellId = 6603
							SQ[spellId]['locked'] = true
							SQ[spellId]['queue'] = ct.SpamQueue(spellId, rawamount)
							SQ[spellId]['msg'] = msg
							SQ[spellId]['color'] = color
							SQ[spellId]['count'] = SQ[spellId]['count'] + 1
							if SQ[spellId]['count'] == 1 then
								SQ[spellId]['utime'] = time() + E.aoespam[spellId]
							end
							SQ[spellId]['locked'] = false
							return
						end
						xCT4:AddMessage(amount..''..msg, unpack(color))
					end
				elseif eventType == 'RANGE_DAMAGE' then
					local spellId, _, _, amount, _, _, _, _, critical = select(9, ...)
					if amount >= M.threshold then
						local rawamount = amount
						if C['ct'].shortNum == true then
							amount = E.ShortValue(amount)
						end
						if critical then
							amount = '|cffFF0000'..M.critPrefix..'|r'..amount..'|cffFF0000'..M.critPostfix..'|r'
						end
						if C['ct'].icons then
							_, _, icon = GetSpellInfo(spellId)
							msg = ' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
						end
						if C['ct'].mergeAoE then
							spellId = E.merge[spellId] or spellId
							if E.aoespam[spellId] then
								SQ[spellId]['locked'] = true
								SQ[spellId]['queue'] = ct.SpamQueue(spellId, rawamount)
								SQ[spellId]['msg'] = msg
								SQ[spellId]['count'] = SQ[spellId]['count'] + 1
								if SQ[spellId]['count'] == 1 then
									SQ[spellId]['utime'] = time() + E.aoespam[spellId]
								end
								SQ[spellId]['locked'] = false
								return
							end
						end
						xCT4:AddMessage(amount..''..msg)
					end
				elseif eventType == 'SPELL_DAMAGE' or (eventType == 'SPELL_PERIODIC_DAMAGE' and C['ct']._dotDps) then
					local spellId, _, spellSchool, amount, _, _, _, _, critical = select(9, ...)
					if amount >= M.threshold then
						local color = {}
						local rawamount = amount
						if C['ct'].shortNum == true then
							amount = E.ShortValue(amount)
						end
						if critical then
							amount = '|cffFF0000'..M.critPrefix..'|r'..amount..'|cffFF0000'..M.critPostfix..'|r'
						end
						if C['ct'].icons then
							_, _, icon = GetSpellInfo(spellId)
						end
						if C['ct']._colorDps then
							if ct.dmgcolor[spellSchool] then
								color = ct.dmgcolor[spellSchool]
							else
								color = ct.dmgcolor[1]
							end
						else
							color = {1, 1, 0}
						end
						if icon then
							msg = ' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
						elseif C['ct'].icons then
							msg = ' \124T'..ct.blank..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
						else
							msg = ''
						end
						if C['ct'].mergeAoE then
							spellId = E.merge[spellId] or spellId
							if bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= COMBATLOG_OBJECT_AFFILIATION_MINE then
								spellId = 6603
							end
							if E.aoespam[spellId] then
								SQ[spellId]['locked'] = true
								SQ[spellId]['queue'] = ct.SpamQueue(spellId, rawamount)
								SQ[spellId]['msg'] = msg
								SQ[spellId]['color'] = color
								SQ[spellId]['count'] = SQ[spellId]['count'] + 1
								if SQ[spellId]['count'] == 1 then
									SQ[spellId]['utime'] = time() + E.aoespam[spellId]
								end
								SQ[spellId]['locked'] = false
								return
							end
						end
						xCT4:AddMessage(amount..''..msg, unpack(color))
					end
				elseif eventType == 'SWING_MISSED' then
					local missType = select(9, ...)
					if C['ct'].icons then
						if sourceGUID == UnitGUID('pet') or sourceFlags == gflags then
							icon = PET_ATTACK_TEXTURE
						else
							_, _, icon = GetSpellInfo(6603)
						end
						missType = misstypes[missType]..' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					else
						missType = misstypes[missType]
					end
					xCT4:AddMessage(missType)
				elseif eventType == 'SPELL_MISSED' or eventType == 'RANGE_MISSED' then
					local spellId, _, _, missType = select(9, ...)
					if C['ct'].icons then
						_, _, icon = GetSpellInfo(spellId)
						missType = misstypes[missType]..' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					else
						missType = misstypes[missType]
					end
					xCT4:AddMessage(missType)
				elseif eventType == 'SPELL_AURA_DISPELLED' and C['ct']._tellDispel then
					local id, effect, _, etype = select(12, ...)
					local color
					if C['ct'].icons then
						_, _, icon = GetSpellInfo(id)
					end
					if icon then
						msg = ' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					elseif C['ct'].icons then
						msg = ' \124T'..ct.blank..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					else
						msg = ''
					end
					if etype == 'BUFF' then
						color = {0, 1, 0.5}
					else
						color = {1, 0, 0.5}
					end
					xCT3:AddMessage(ACTION_SPELL_DISPEL..': '..effect..msg, unpack(color))
				elseif eventType == 'SPELL_AURA_STOLEN' and C['ct']._tellDispel then
					local id, effect = select(12, ...)
					local color = {1, 0.5, 0}
					if C['ct'].icons then
						_, _, icon = GetSpellInfo(id)
					end
					if icon then
						msg = ' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					elseif C['ct'].icons then
						msg = ' \124T'..ct.blank..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					else
						msg = ''
					end
					xCT3:AddMessage(ACTION_SPELL_AURA_STOLEN..': '..effect..msg, unpack(color))
				elseif eventType == 'SPELL_INTERRUPT' and C['ct']._tellInter then
					local id, effect = select(12, ...)
					local color = {1, 0.5, 0}
					if C['ct'].icons then
						_, _, icon = GetSpellInfo(id)
					end
					if icon then
						msg = ' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					elseif C['ct'].icons then
						msg = ' \124T'..ct.blank..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
					else
						msg = ''
					end
					xCT3:AddMessage(ACTION_SPELL_INTERRUPT..': '..effect..msg, unpack(color))
				elseif eventType == 'PARTY_KILL' and C['ct'].showKilling then
					local tname = ...
					xCT3:AddMessage('|cff33FF33'..ACTION_PARTY_KILL..': |r'..tname, 0.2, 1, 0.2)
				end
			end
		end

		xCTd:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
		xCTd:SetScript('OnEvent', dmg)
	end

	--* Healing
	if C['ct'].healing then
		local unpack, select, time = unpack, select, time
		local xCTh = CreateFrame('frame')
		
		if C['ct'].icons then
			--local f = CreateFrame('frame')
			--f:SetLayout()
			--ct.blank = f:CreateTexture('ARTWORK')
			--ct.blank:SetTexture(A.solid)
			--ct.blank:SetTexCoord(unpack(E.TexCoords))
			--ct.blank:SetParent(f)
			ct.blank = [[Interface\AddOns\SohighUI\styles\arts\solid]]
		end
		
		local heal = function(self, event, ...)
			local msg, icon
			local eventType, sourceGUID, _, sourceFlags = select(2, ...)
			if sourceGUID == ct.pguid or sourceFlags == gflags then
				if eventType == 'SPELL_HEAL' or (eventType == 'SPELL_PERIODIC_HEAL' and C['ct']._hotDps) then
					if C['ct'].healing then
						local spellId, _, _, amount, critical = select(9, ...)
						if E.healfilter[spellId] then
							return
						end
						if amount >= M.healthreshold then
							local color = {}
							local rawamount = amount
							if C['ct'].shortNum == true then
								amount = E.ShortValue(amount)
							end

							if critical then
								amount = '|cffFF0000'..M.critPrefix..'|r'..amount..'|cffFF0000'..M.critPostfix..'|r'
								color = {0.1, 1, 0.1}
							else
								color = {0.1, 0.65, 0.1}
							end
							if C['ct'].icons then
								_, _, icon = GetSpellInfo(spellId)
							else
								msg = ''
							end
							if icon then
								msg = ' \124T'..icon..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
							elseif C['ct'].icons then
								msg = ' \124T'..ct.blank..':'..C['ct'].iconSize.value..':'..C['ct'].iconSize.value..':0:0:64:64:5:59:5:59\124t'
							end
							if C['ct'].mergeAoE then
								spellId = E.merge[spellId] or spellId
								if E.aoespam[spellId] then
									SQ[spellId]['locked'] = true
									SQ[spellId]['queue'] = ct.SpamQueue(spellId, rawamount)
									SQ[spellId]['msg'] = msg
									SQ[spellId]['color'] = color
									SQ[spellId]['count'] = SQ[spellId]['count'] + 1
									if SQ[spellId]['count'] == 1 then
										SQ[spellId]['utime'] = time() + E.aoespam[spellId]
									end
									SQ[spellId]['locked'] = false
									return
								end
							end
							xCT4:AddMessage(amount..''..msg, unpack(color))
						end
					end
				end
			end
		end

		xCTh:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
		xCTh:SetScript('OnEvent', heal)
	end

	--* Check outdated spells
	if C['ct'].mergeAoE then
		for spell in pairs(E.aoespam) do
			local name = GetSpellInfo(spell)
			if not name then
				E.Suitag('|cffff0000WARNING: spell ID ['..tostring(spell)..'] no longer exists!|r')
			end
		end

		for spell in pairs(E.merge) do
			local name = GetSpellInfo(spell)
			if not name then
				E.Suitag('|cffff0000WARNING: spell ID ['..tostring(spell)..'] no longer exists!|r')
			end
		end
	end

	if C['ct'].healing then
		for spell in pairs(E.healfilter) do
			local name = GetSpellInfo(spell)
			if not name then
				E.Suitag('|cffff0000WARNING: spell ID ['..tostring(spell)..'] no longer exists!|r')
			end
		end
	end