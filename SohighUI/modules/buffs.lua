	
	--* buffs style

	local E, C, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local unpack = unpack
	local ceil = math.ceil
	
	local hooksecurefunc = hooksecurefunc
	
	BUFF_FLASH_TIME_ON = 0.8;
	BUFF_FLASH_TIME_OFF = 0.8;
	BUFF_MIN_ALPHA = 0.70;

	--[[
	_G.DAY_ONELETTER_ABBR = '|cffffffff%dd|r'
	_G.HOUR_ONELETTER_ABBR = '|cffffffff%dh|r'
	_G.MINUTE_ONELETTER_ABBR = '|cffffffff%dm|r'
	_G.SECOND_ONELETTER_ABBR = '|cffffffff%d|r'

	_G.DEBUFF_MAX_DISPLAY = 32 -- show more debuffs
	_G.BUFF_MIN_ALPHA = 1
	--]]
	
	--* Functions for TempEnchant...
	local function count_t(t)
		local count = 0
		for _, v in pairs(t) do
			count = count + 1
		end
		return count
	end

	local subscribtions = {}

	local function subscribe(frame, event, handler)
		if C.units.enchantoUF ~= false then return end
		if not frame or not frame.GetName or not frame.SetScript then return end
		
		if not subscribtions[frame:GetName()] then
			subscribtions[frame:GetName()] = {}
		end

		if not subscribtions[frame:GetName()][event] then
			subscribtions[frame:GetName()][event] = {}
			frame:SetScript(event, function(...)
				local self = ...
				for _, callback in pairs(subscribtions[self:GetName()][event]) do
					callback(...)
				end
			end)
		end

		local id = count_t(subscribtions[frame:GetName()][event])
		subscribtions[frame:GetName()][event][id] = handler;
		return id
	end
	
	local origSecondsToTimeAbbrev = _G.SecondsToTimeAbbrev
	local function SecondsToTimeAbbrevHook(seconds)
		origSecondsToTimeAbbrev(seconds)

		local tempTime
		if (seconds >= 86400) then
			tempTime = ceil(seconds / 86400)
			return '|cffffffff%dd|r', tempTime
		end
		if (seconds >= 3600) then
			tempTime = ceil(seconds / 3600)
			return '|cffffffff%dh|r', tempTime
		end
		if (seconds >= 60) then
			tempTime = ceil(seconds / 60)
			return '|cffffffff%dm|r', tempTime
		end
		return '|cffffffff%d|r', seconds
	end
	SecondsToTimeAbbrev = SecondsToTimeAbbrevHook

	local function GetActiveTempEnchantNum()
		local active = 0
		for i = 1, 2 do
			if (_G['TempEnchant'..i]:IsShown()) then
				active = active + 1
			end
		end
		return active
	end

	local function ApplySkin(self, button)
		if (button and not button.Shadow) then
			if (button) then
				if (self:match('Debuff')) then
					button:SetSize(M.debuffSize)
					button:SetScale(M.debuffScale)
				else
					button:SetSize(M.buffSize)
					button:SetScale(M.buffScale)
				end
			end

			local icon = _G[self..'Icon']
			if (icon) then
				icon:SetTexCoord(unpack(E.TexCoords))
			end
	  
			local duration = _G[self..'Duration']
			if (duration) then
				duration:ClearAllPoints()
				duration:SetAnchor('BOTTOM', button, 'BOTTOM', 0, M.durationY)
				if (self:match('Debuff')) then
					--duration:SetFont(A.font, M.debuffFontSize, A.fontStyleT)
					duration:SetFontObject(NumberFontNormal)
				else
					--duration:SetFont(A.font, M.buffFontSize, A.fontStyleT)
					duration:SetFontObject(NumberFontNormal)
				end
				duration:SetShadowOffset(0, 0)
				duration:SetDrawLayer('OVERLAY')
			end
	  
			local count = _G[self..'Count']
			if (count) then
				count:ClearAllPoints()
				count:SetAnchor('TOPRIGHT', button)
				if (self:match('Debuff')) then
					count:SetFont(A.font, M.debuffCountSize, A.fontStyleT)
				else
					count:SetFont(A.font, M.buffCountSize, A.fontStyleT)
				end
				count:SetShadowOffset(0, 0)
				count:SetDrawLayer('OVERLAY')
			end

			local border = _G[self..'Border']
			if (border) then
				border:SetTexture(A.abTexNormal)
				border:SetAnchor('TOPRIGHT', button, 1, 1)
				border:SetAnchor('BOTTOMLEFT', button, -1, -1)
				border:SetTexCoord(0, 1, 0, 1)
			end

			if (button and not border) then
				if (not button.texture) then
					button.texture = button:CreateTexture('$parentOverlay', 'ARTWORK')
					button.texture:SetParent(button)
					button.texture:SetTexture(A.abTexNormal)
					button.texture:SetAnchor('TOPRIGHT', button, 1, 1)
					button.texture:SetAnchor('BOTTOMLEFT', button, -1, -1)
					button.texture:SetVertexColor(unpack(M.buffColor))
				end
			end

			if (button) then
				if (not button.Shadow) then
					button.Shadow = button:CreateTexture('$parentShadow', 'BACKGROUND')
					button.Shadow:SetTexture(A.auraShadow)
					button.Shadow:SetAnchor('TOPRIGHT', button.texture or border, 3.35, 3.35)
					button.Shadow:SetAnchor('BOTTOMLEFT', button.texture or border, -3.35, -3.35)
					button.Shadow:SetVertexColor(0, 0, 0, 1)
				end
			end
		end
	end

	local function CheckSkinning()
		for index = 1, BUFF_ACTUAL_DISPLAY do
			local button = _G['BuffButton'..index]
			
			if button then
				ApplySkin(button:GetName(), button)
			end
		end
		
		for index = 1, DEBUFF_ACTUAL_DISPLAY do
			local button = _G['DebuffButton'..index]
			
			if button then
				ApplySkin(button:GetName(), button)
			end
		end
	end
	
	--* move and clickable
	--[[TemporaryEnchantFrame:SetMovable(true)
	TemporaryEnchantFrame:SetUserPlaced(true)
	TemporaryEnchantFrame:SetClampedToScreen(true)
	TemporaryEnchantFrame:SetScript('OnMouseDown', function()
		if (IsShiftKeyDown()) then
			TemporaryEnchantFrame:ClearAllPoints()
			TemporaryEnchantFrame.SetAnchor = ET.hoop
			TemporaryEnchantFrame:StartMoving()
		end
	end);

	TemporaryEnchantFrame:SetScript('OnMouseUp', function(self, button)
		self:StopMovingOrSizing()
	end);--]]

	BuffFrame:SetScript('OnUpdate', nil)
	hooksecurefunc(BuffFrame, 'Show', function(self)
		BuffFrame:SetScale(1.3)
		self:SetScript('OnUpdate', nil)
	end);

	-- TemporaryEnchantFrame
	TempEnchant1:ClearAllPoints()
	TempEnchant1:SetAnchor('TOPRIGHT', Minimap, 'TOPLEFT', -15, 0)
	-- TempEnchant1.SetAnchor = function() end

	TempEnchant2:ClearAllPoints()
	TempEnchant2:SetAnchor('TOPRIGHT', TempEnchant1, 'TOPLEFT', -M.paddingX, 0)

	local function UpdateFirstButton(self)
		if (self and self:IsShown()) then
			self:ClearAllPoints()
			if (GetActiveTempEnchantNum() > 0) then
				self:SetAnchor('TOPRIGHT', _G['TempEnchant'..GetActiveTempEnchantNum()], 'TOPLEFT', -M.paddingX, 0)
			return
			else
				self:SetAnchor('TOPRIGHT', TempEnchant1)
			return
			end
		end
	end

	local function CheckFirstButton()
		if (BuffButton1) then
			UpdateFirstButton(BuffButton1)
		end
	end

	hooksecurefunc('BuffFrame_Update', function()

		--[[*______________Buffs______________*]]--
		local previousBuff, aboveBuff
		local numBuffs = 0
		local numTotal = GetActiveTempEnchantNum()

		for i = 1, BUFF_ACTUAL_DISPLAY do
			local buff = _G['BuffButton'..i]
			numBuffs = numBuffs + 1
			numTotal = numTotal + 1

			buff:ClearAllPoints()
			
			if C.units.enchantoUF ~= true then
				if (numBuffs == 1) then
					UpdateFirstButton(buff)
				elseif (numBuffs > 1 and mod(numTotal, M.buffPerRow) == 1) then
					if (numTotal == M.buffPerRow + 1) then
						buff:SetAnchor('TOP', TempEnchant1, 'BOTTOM', 0, -M.paddingY)
					else
						buff:SetAnchor('TOP', aboveBuff, 'BOTTOM', 0, -M.paddingY)
					end

					aboveBuff = buff
				else
					buff:SetAnchor('TOPRIGHT', previousBuff, 'TOPLEFT', -M.paddingX, 0)
				end

				previousBuff = buff
			else
				--// Yep i know it's not a good solution, maybe TODO later ...
				if (numBuffs == 1) then
					buff:SetAnchor('TOPRIGHT', previousBuff, 'TOPLEFT', M.paddingX+31, -M.paddingY)
				elseif (numBuffs > 1 and mod(i, M.buffPerRow) == 1) then
					if (numTotal == M.buffPerRow + 1) then
						buff:SetAnchor('TOP', TempEnchant1, 'BOTTOM', 0, -M.paddingY)
					else
						buff:SetAnchor('TOP', aboveBuff, 'BOTTOM', 0, -M.paddingY)
					end

					aboveBuff = buff
				else
					buff:SetAnchor('TOPRIGHT', previousBuff, 'TOPLEFT', -M.paddingX, 0)
				end
				
				previousBuff = buff
			end
		end
  
		--[[*______________Debuffs______________*]]--
		local rowSpacing
		local debuffSpace = M.buffSize + M.paddingY
		local numRows = ceil(numTotal / M.buffPerRow)

		if (numRows and numRows > 1) then
			rowSpacing = -numRows * debuffSpace
		else
			rowSpacing = -debuffSpace
		end
		
		if DEBUFF_ACTUAL_DISPLAY then
			for index = 1, DEBUFF_ACTUAL_DISPLAY do
				local debuff = _G['DebuffButton'..index]
				if not debuff then break end
				
				debuff:ClearAllPoints()
		
				if (index == 1) then
					debuff:SetAnchor('TOP', TempEnchant1, 'BOTTOM', 0, rowSpacing)
				elseif (index >= 2 and mod(index, M.buffPerRow) == 1) then
					buff:SetAnchor('TOP', _G['DebuffButton'..(index - M.buffPerRow)], 'BOTTOM', 0, -M.paddingY)
				else
					debuff:SetAnchor('TOPRIGHT', _G['DebuffButton'..(index - 1)], 'TOPLEFT', -M.paddingX, 0)
				end
			end
		end
		CheckSkinning()
	end);

	for i = 1, 2 do
		--if C.units.enchantoUF ~= false then return end;

		local button = _G['TempEnchant'..i]
		button:SetScale(M.buffScale)
		button:SetSize(M.buffSize)
		
		subscribe(button, 'OnShow', function()
			CheckFirstButton()
		end);

		subscribe(button, 'OnHide', function()
			CheckFirstButton()
		end);--]]

		local icon = _G['TempEnchant'..i..'Icon']
		icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)

		local duration = _G['TempEnchant'..i..'Duration']
		duration:ClearAllPoints()
		duration:SetAnchor('BOTTOM', button, 'BOTTOM', 0, M.durationY)
		duration:SetFont(A.font, M.buffFontSize, A.fontStyleT)
		duration:SetShadowOffset(0, 0)
		duration:SetDrawLayer('OVERLAY')

		local border = _G['TempEnchant'..i..'Border']
		border:ClearAllPoints()
		border:SetAnchor('TOPRIGHT', button, 1, 1)
		border:SetAnchor('BOTTOMLEFT', button, -1, -1)	
		border:SetTexture(A.auraWhite)
		border:SetTexCoord(0, 1, 0, 1)
		border:SetVertexColor(0.9, 0.25, 0.9)

		button.Shadow = button:CreateTexture('$parentBackground', 'BACKGROUND')
		button.Shadow:SetAnchor('TOPRIGHT', border, 3.35, 3.35)
		button.Shadow:SetAnchor('BOTTOMLEFT', border, -3.35, -3.35)
		button.Shadow:SetTexture(A.auraShadow)
		button.Shadow:SetVertexColor(0, 0, 0, 1)
	end