
	--* character (C)
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end
	
	local _G = _G
	local select, unpack, pairs = select, unpack, pairs
	local find = string.find

	local GetInventoryItemQuality = GetInventoryItemQuality
	local GetInventoryItemTexture = GetInventoryItemTexture
	local GetInventorySlotInfo = GetInventorySlotInfo
	local GetItemQualityColor = GetItemQualityColor
	local GetPetHappiness = GetPetHappiness
	local HasPetUI = HasPetUI
	local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset
	local MAX_ARENA_TEAMS = MAX_ARENA_TEAMS
	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()
		CharacterFrame:StripLayout()
		CharacterFrame:SetLayout()
		CharacterFrame:SetShadow()
		
		CharacterFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		CharacterFrame.bg:SetAnchor('BOTTOMRIGHT', -32, 76)
		
		CharacterFrame.shadow:SetAnchor('TOPLEFT', 6, -8)
		CharacterFrame.shadow:SetAnchor('BOTTOMRIGHT', -28, 72)

		CharacterFramePortrait:Hide()
		
		CharacterFrameCloseButton:CloseTemplate()
		CharacterFrameCloseButton:ClearAllPoints()
		CharacterFrameCloseButton:SetAnchor('CENTER', CharacterFrame, 'TOPRIGHT', -45, -25)

		for i = 1, 5 do
			local tab = _G['CharacterFrameTab'..i]
			
			tab:StripLayout()
			tab:SetLayout()
			
			tab.bg:SetAnchor('TOPLEFT', -1, -5)
			tab.bg:SetAnchor('BOTTOMRIGHT', -20, -1)
			
			tab:SetGradient()
			tab.gr:SetAllPoints(tab.bg)
			
			_G['CharacterFrameTab'..i..'Text']:SetAnchor('TOPLEFT', 10, -14)
		end

		-- Character Frame
		PaperDollFrame:StripLayout()

		CharacterModelFrame:SetAnchor('TOPLEFT', 65, -76)
		CharacterModelFrame:Height(195)

		PlayerTitleDropDown:SetAnchor('TOP', CharacterLevelText, 'BOTTOM', 0, -2)
		--S:HandleDropDownBox(PlayerTitleDropDown, 210)

		ET:HandleRotateButton(CharacterModelFrameRotateLeftButton)
		CharacterModelFrameRotateLeftButton:ClearAllPoints()
		CharacterModelFrameRotateLeftButton:SetAnchor('TOPLEFT', 3, -3)

		ET:HandleRotateButton(CharacterModelFrameRotateRightButton)
		CharacterModelFrameRotateRightButton:ClearAllPoints()
		CharacterModelFrameRotateRightButton:SetAnchor('TOPLEFT', CharacterModelFrameRotateLeftButton, 'TOPRIGHT', 3, 0)

		CharacterAttributesFrame:StripLayout()

		local function FixWidth(self)
			UIDropDownMenu_SetWidth(90, self)
		end

		---S:HandleDropDownBox(PlayerStatFrameLeftDropDown)
		PlayerStatFrameLeftDropDown:HookScript('OnShow', FixWidth)
		--S:SquareButton_SetIcon(PlayerStatFrameLeftDropDownButton, 'DOWN')

		--S:HandleDropDownBox(PlayerStatFrameRightDropDown)
		PlayerStatFrameRightDropDown:HookScript('OnShow', FixWidth)

		CharacterResistanceFrame:SetAnchor('TOPRIGHT', PaperDollFrame, 'TOPLEFT', 297, -80)

		local function HandleResistanceFrame(frameName)
			for i = 1, 5 do
				local frame = _G[frameName..i]

				frame:SetSize(26)
				frame:SetLayout()

				if i ~= 1 then
					frame:ClearAllPoints()
					frame:SetAnchor('TOP', _G[frameName..i - 1], 'BOTTOM', 0, -(1 + 2) - 1)
				end

				select(1, _G[frameName..i]:GetRegions()):SetInside()
				select(1, _G[frameName..i]:GetRegions()):SetDrawLayer('ARTWORK')
				select(2, _G[frameName..i]:GetRegions()):SetDrawLayer('OVERLAY')
			end
		end

		HandleResistanceFrame('MagicResFrame')

		select(1, MagicResFrame1:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.25, 0.3203125)
		select(1, MagicResFrame2:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.0234375, 0.09375)
		select(1, MagicResFrame3:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.13671875, 0.20703125)
		select(1, MagicResFrame4:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.36328125, 0.43359375)
		select(1, MagicResFrame5:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.4765625, 0.546875)

		local slots = {
			'HeadSlot',
			'NeckSlot',
			'ShoulderSlot',
			'BackSlot',
			'ChestSlot',
			'ShirtSlot',
			'TabardSlot',
			'WristSlot',
			'HandsSlot',
			'WaistSlot',
			'LegsSlot',
			'FeetSlot',
			'Finger0Slot',
			'Finger1Slot',
			'Trinket0Slot',
			'Trinket1Slot',
			'MainHandSlot',
			'SecondaryHandSlot',
			'RangedSlot',
			'AmmoSlot'
		}

		for _, i in pairs(slots) do
			local slot = _G['Character'..i]
			local icon = _G['Character'..i..'IconTexture']
			local cooldown = _G['Character'..i..'Cooldown']

			slot:StripLayout()
			slot:SetLayout()
			slot:SetFrameLevel(PaperDollFrame:GetFrameLevel() +2)

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetInside()

			--[[if(cooldown) then
				T.CreateAuraWatch(cooldown)
			end--]]
		end

		--* pet frame
		PetPaperDollFrame:StripLayout()

		ET:HandleButton(PetPaperDollCloseButton)

		ET:HandleRotateButton(PetModelFrameRotateLeftButton)
		PetModelFrameRotateLeftButton:ClearAllPoints()
		PetModelFrameRotateLeftButton:SetAnchor('TOPLEFT', 3, -3)

		ET:HandleRotateButton(PetModelFrameRotateRightButton)
		PetModelFrameRotateRightButton:ClearAllPoints()
		PetModelFrameRotateRightButton:SetAnchor('TOPLEFT', PetModelFrameRotateLeftButton, 'TOPRIGHT', 3, 0)

		PetAttributesFrame:StripLayout()

		HandleResistanceFrame('PetMagicResFrame')

		select(1, PetMagicResFrame1:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.25, 0.3203125)
		select(1, PetMagicResFrame2:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.0234375, 0.09375)
		select(1, PetMagicResFrame3:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.13671875, 0.20703125)
		select(1, PetMagicResFrame4:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.36328125, 0.43359375)
		select(1, PetMagicResFrame5:GetRegions()):SetTexCoord(0.21875, 0.78125, 0.4765625, 0.546875)

		PetPaperDollFrameExpBar:StripLayout()
		PetPaperDollFrameExpBar:SetLayout()
		PetPaperDollFrameExpBar:SetStatusBarTexture(A.status)

		local function updHappiness(self)
			local happiness = GetPetHappiness()
			local _, isHunterPet = HasPetUI()
			if not happiness or not isHunterPet then return end

			local texture = self:GetRegions()
			if (happiness == 1) then
				texture:SetTexCoord(0.41, 0.53, 0.06, 0.30)
			elseif (happiness == 2) then
				texture:SetTexCoord(0.22, 0.345, 0.06, 0.30)
			elseif (happiness == 3) then
				texture:SetTexCoord(0.04, 0.15, 0.06, 0.30)
			end
		end

		PetPaperDollPetInfo:SetLayout()
		PetPaperDollPetInfo:SetAnchor('TOPLEFT', PetModelFrameRotateLeftButton, 'BOTTOMLEFT', 9, -3)
		PetPaperDollPetInfo:GetRegions():SetTexCoord(0.04, 0.15, 0.06, 0.30)
		PetPaperDollPetInfo:SetFrameLevel(PetModelFrame:GetFrameLevel() + 2)
		PetPaperDollPetInfo:SetSize(24)

		updHappiness(PetPaperDollPetInfo)
		PetPaperDollPetInfo:RegisterEvent('UNIT_HAPPINESS')
		PetPaperDollPetInfo:SetScript('OnEvent', updHappiness)
		PetPaperDollPetInfo:SetScript('OnShow', updHappiness)

		--* reputation frame
		ReputationFrame:StripLayout()

		for i = 1, NUM_FACTIONS_DISPLAYED do
			local bar = _G['ReputationBar'..i]
			local header = _G['ReputationHeader'..i]
			local name = _G['ReputationBar'..i..'FactionName']
			local war = _G['ReputationBar'..i..'AtWarCheck']

			bar:StripLayout()
			bar:SetLayout()
			bar:SetStatusBarTexture(A.status)
			bar:SetSize(108, 13)

			if (i == 1) then
				bar:SetAnchor('TOPLEFT', 190, -86)
			end

			name:SetAnchor('LEFT', bar, 'LEFT', -150, 0)
			name:Width(140)

			header:StripLayout()
			header:SetNormalTexture(nil)
			header:SetAnchor('TOPLEFT', bar, 'TOPLEFT', -170, 0)
			
			header.Text = header:CreateFontString(nil, 'OVERLAY')
			header.Text:SetFont(A.font, 13, A.fontStyle)
			header.Text:SetAnchor('LEFT', header, 'LEFT', 10, 1)
			header.Text:SetText('-')

			war:StripLayout()
			war:SetAnchor('LEFT', bar, 'RIGHT', 0, 0)

			war.icon = war:CreateTexture(nil, 'OVERLAY')
			war.icon:SetAnchor('LEFT', 3, -6)
			war.icon:SetTexture('Interface\\Buttons\\UI-CheckBox-SwordCheck')
		end

		local function UpdateFaction()
			local numFactions = GetNumFactions()
			local offset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
			local index, header

			for i = 1, NUM_FACTIONS_DISPLAYED, 1 do
				header = _G['ReputationHeader'..i]
				index = offset + i

				if index <= numFactions then
					if header.isCollapsed then
						header:StripLayout(true)
						header:SetNormalTexture(nil)
						header.Text:SetText('+')
					else
						header:StripLayout(true)
						header:SetNormalTexture(nil)
						header.Text:SetText('-')
					end
				end
			end
		end
		hooksecurefunc('ReputationFrame_Update', UpdateFaction)

		ReputationFrameStandingLabel:SetAnchor('TOPLEFT', 223, -59)
		ReputationFrameFactionLabel:SetAnchor('TOPLEFT', 55, -59)

		ReputationListScrollFrame:StripLayout()
		ReputationListScrollFrameScrollBar:ShortBar()

		ReputationDetailFrame:StripLayout()
		ReputationDetailFrame:SetLayout()
		ReputationDetailFrame:SetAnchor('TOPLEFT', ReputationFrame, 'TOPRIGHT', -31, -12)

		ReputationDetailCloseButton:CloseTemplate()
		ReputationDetailCloseButton:SetAnchor('TOPRIGHT', 2, 2)

		ET:HandleCheckBox(ReputationDetailAtWarCheckBox)
		ET:HandleCheckBox(ReputationDetailInactiveCheckBox)
		ET:HandleCheckBox(ReputationDetailMainScreenCheckBox)

		-- Skill Frame
		SkillFrame:StripLayout()

		SkillFrameExpandButtonFrame:DisableDrawLayer('BACKGROUND')

		SkillFrameCollapseAllButton:SetAnchor('LEFT', SkillFrameExpandTabLeft, 'RIGHT', -70, -3)
		SkillFrameCollapseAllButton.Text = SkillFrameCollapseAllButton:CreateFontString(nil, 'OVERLAY')
		SkillFrameCollapseAllButton.Text:SetFont(A.font, 13, A.fontStyle)
		SkillFrameCollapseAllButton.Text:SetAnchor('LEFT', SkillFrameCollapseAllButton, 'LEFT', 15, 1)
		SkillFrameCollapseAllButton.Text:SetText('-')

		--SkillFrameCollapseAllButton:SetHighlightTexture(nil)

		hooksecurefunc(SkillFrameCollapseAllButton, 'SetNormalTexture', function(self, texture)
			if string.find(texture, 'MinusButton') then
				self:StripLayout()
				SkillFrameCollapseAllButton.Text:SetText('-')
			else
				self:StripLayout()
				SkillFrameCollapseAllButton.Text:SetText('+')
			end
		end);

		SkillFrameCancelButton:StripLayout()

		for i = 1, SKILLS_TO_DISPLAY do
			local bar = _G['SkillRankFrame'..i]
			local label = _G['SkillTypeLabel'..i]
			local border = _G['SkillRankFrame'..i..'Border']
			local background = _G['SkillRankFrame'..i..'Background']

			bar:SetLayout()
			bar:SetStatusBarTexture(A.status)

			border:StripLayout()
			background:SetTexture(nil)

			label:StripLayout()
			label:SetAnchor('TOPLEFT', bar, 'TOPLEFT', -30, 0)

			label.Text = label:CreateFontString(nil, 'OVERLAY')
			label.Text:SetFont(A.font, 13, A.fontStyle)
			label.Text:SetAnchor('LEFT', label, 'LEFT', 15, 1)
			label.Text:SetText('-')

			hooksecurefunc(label, 'SetNormalTexture', function(self, texture)
				if string.find(texture, 'MinusButton') then
					self:StripLayout()
					--self:GetNormalTexture():SetTexCoord(0.545, 0.975, 0.085, 0.925)
				else
					self:StripLayout()
					--self:GetNormalTexture():SetTexCoord(0.045, 0.475, 0.085, 0.925)
				end
			end)
		end

		SkillListScrollFrame:StripLayout()
		SkillListScrollFrameScrollBar:ShortBar()

		SkillDetailScrollFrame:StripLayout()
		SkillDetailScrollFrameScrollBar:ShortBar()

		SkillDetailStatusBar:StripLayout()
		SkillDetailStatusBar:SetLayout()
		SkillDetailStatusBar:SetParent(SkillDetailScrollFrame)
		SkillDetailStatusBar:SetStatusBarTexture(A.status)
		--ET:RegisterStatusBar(SkillDetailStatusBar)

		--S:HandleNextPrevButton(SkillDetailStatusBarUnlearnButton)
		SkillDetailStatusBarUnlearnButton:ButtonNextRight()
		--S:SquareButton_SetIcon(SkillDetailStatusBarUnlearnButton, 'DELETE')
		SkillDetailStatusBarUnlearnButton:SetSize(24)
		SkillDetailStatusBarUnlearnButton:SetAnchor('LEFT', SkillDetailStatusBarBorder, 'RIGHT', 5, 0)
		SkillDetailStatusBarUnlearnButton:SetHitRectInsets(0, 0, 0, 0)

		--* PvP frame
		PVPFrame:StripLayout()

		for i = 1, MAX_ARENA_TEAMS do
			local pvpTeam = _G['PVPTeam'..i]

			pvpTeam:StripLayout()
			pvpTeam:SetLayout()
			pvpTeam.bg:SetAnchor('TOPLEFT', 9, -4)
			pvpTeam.bg:SetAnchor('BOTTOMRIGHT', -24, 3)
			
			pvpTeam:SetShadow()
			pvpTeam.shadow:SetAnchor('TOPLEFT', 7, -2)
			pvpTeam.shadow:SetAnchor('BOTTOMRIGHT', -20, -1)

			--pvpTeam:HookScript('OnEnter', S.SetModifiedBackdrop)
			--pvpTeam:HookScript('OnLeave', S.SetOriginalBackdrop)

			--_G['PVPTeam'..i..'Highlight'] = function() end
		end

		PVPTeamDetails:StripLayout()
		PVPTeamDetails:SetLayout()
		PVPTeamDetails:SetShadow()
		PVPTeamDetails.shadow:SetAnchor('TOPLEFT', -5, 5)
		PVPTeamDetails.shadow:SetAnchor('BOTTOMRIGHT', 5, -5)
		
		PVPTeamDetails:SetAnchor('TOPLEFT', PVPFrame, 'TOPRIGHT', -20, -12)

		PVPFrameToggleButton:ButtonNextRight()
		PVPFrameToggleButton:SetAnchor('BOTTOMRIGHT', PVPFrame, 'BOTTOMRIGHT', -48, 81)
		PVPFrameToggleButton:SetSize(14)

		for i = 1, 5 do
			local header = _G['PVPTeamDetailsFrameColumnHeader'..i]
			header:StripLayout()
		end

		for i = 1, 10 do
			local button = _G['PVPTeamDetailsButton'..i]
			button:Width(335)
		end

		ET:HandleButton(PVPTeamDetailsAddTeamMember)

		PVPTeamDetailsToggleButton:ButtonNextRight()
		--PVPTeamDetailsToggleButton:SetAnchor('BOTTOMRIGHT', 12, 0)

		PVPTeamDetailsCloseButton:CloseTemplate()
	end

	table.insert(ET['SohighUI'], LoadSkin)