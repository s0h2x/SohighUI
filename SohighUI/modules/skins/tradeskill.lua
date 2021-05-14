
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack, select = unpack, select
	local find = string.find

	local CreateFrame = CreateFrame
	local GetItemInfo = GetItemInfo
	local GetItemQualityColor = GetItemQualityColor
	local GetTradeSkillItemLink = GetTradeSkillItemLink
	local GetTradeSkillReagentInfo = GetTradeSkillReagentInfo
	local GetTradeSkillReagentItemLink = GetTradeSkillReagentItemLink
	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()
	
		TRADE_SKILLS_DISPLAYED = 25

		local TradeSkillFrame = _G['TradeSkillFrame']
		TradeSkillFrame:StripLayout(true)
		TradeSkillFrame:SetAttribute('UIPanelLayout-width', E:Scale(710))
		TradeSkillFrame:SetAttribute('UIPanelLayout-height', E:Scale(508))
		TradeSkillFrame:SetSize(680, 508)

		TradeSkillFrame:SetLayout()
		TradeSkillFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		TradeSkillFrame.bg:SetAnchor('BOTTOMRIGHT', -34, 0)
		
		TradeSkillFrame:SetShadow()
		TradeSkillFrame.shadow:SetAnchor('TOPLEFT', 8, -10)
		TradeSkillFrame.shadow:SetAnchor('BOTTOMRIGHT', -30, -2)

		TradeSkillFrame.bg1 = CreateFrame('frame', nil, TradeSkillFrame)
		TradeSkillFrame.bg1:SetLayout()
		TradeSkillFrame.bg1:SetAnchor('TOPLEFT', 14, -92)
		TradeSkillFrame.bg1:SetAnchor('BOTTOMRIGHT', -367, 4)
		TradeSkillFrame.bg1:SetFrameLevel(TradeSkillFrame.bg1:GetFrameLevel() -1)

		TradeSkillFrame.bg2 = CreateFrame('frame', nil, TradeSkillFrame)
		TradeSkillFrame.bg2:SetLayout()
		TradeSkillFrame.bg2:SetAnchor('TOPLEFT', TradeSkillFrame.bg1, 'TOPRIGHT', 3, 0)
		TradeSkillFrame.bg2:SetAnchor('BOTTOMRIGHT', TradeSkillFrame, 'BOTTOMRIGHT', -38, 4)
		TradeSkillFrame.bg2:SetFrameLevel(TradeSkillFrame.bg2:GetFrameLevel() -1)

		TradeSkillRankFrameBorder:StripLayout()

		TradeSkillRankFrame:StripLayout()
		TradeSkillRankFrame:SetSize(447, 12)
		TradeSkillRankFrame:ClearAllPoints()
		TradeSkillRankFrame:SetAnchor('TOP', -20, -45)
		TradeSkillRankFrame:SetLayout()
		TradeSkillRankFrame:SetStatusBarTexture(A.FetchMedia)
		TradeSkillRankFrame:SetStatusBarColor(E.Color.r, E.Color.r, E.Color.b)
		TradeSkillRankFrame.SetStatusBarColor = E.hoop

		TradeSkillRankFrameSkillRank:ClearAllPoints()
		TradeSkillRankFrameSkillRank:SetAnchor('CENTER', TradeSkillRankFrame, 'CENTER', 0, 0)

		ET:HandleCheckBox(TradeSkillFrameAvailableFilterCheckButton)
		TradeSkillFrameAvailableFilterCheckButton:SetAnchor('TOPLEFT', 70, -65)

		TradeSkillFrameEditBox:ClearAllPoints()
		TradeSkillFrameEditBox:SetAnchor('LEFT', TradeSkillFrameAvailableFilterCheckButton, 'RIGHT', 100, 0)
		ET:HandleEditBox(TradeSkillFrameEditBox)

		--S:HandleDropDownBox(TradeSkillInvSlotDropDown, 160)
		TradeSkillInvSlotDropDown:ClearAllPoints()
		TradeSkillInvSlotDropDown:SetAnchor('LEFT', TradeSkillFrameEditBox, 'RIGHT', -16, -3)

		--S:HandleDropDownBox(TradeSkillSubClassDropDown, 160)
		TradeSkillSubClassDropDown:ClearAllPoints()
		TradeSkillSubClassDropDown:SetAnchor('LEFT', TradeSkillInvSlotDropDown, 'RIGHT', -25, 0)

		TradeSkillFrameTitleText:ClearAllPoints()
		TradeSkillFrameTitleText:SetAnchor('TOP', TradeSkillRankFrameSkillRank, 'TOP', 0, 25)

		for i = 9, 25 do
			CreateFrame('Button', 'TradeSkillSkill'..i, TradeSkillFrame, 'TradeSkillSkillButtonTemplate'):SetAnchor('TOPLEFT', _G['TradeSkillSkill'..i - 1], 'BOTTOMLEFT')
		end

		TradeSkillExpandButtonFrame:StripLayout()
		TradeSkillExpandButtonFrame:SetAnchor('TOPLEFT', 10, -71)

		TradeSkillCollapseAllButton:SetNormalTexture(A.collapse)
		TradeSkillCollapseAllButton.SetNormalTexture = E.hoop
		
		TradeSkillCollapseAllButton:SetAnchor('LEFT', 0, 2)
		TradeSkillCollapseAllButton:SetSize(15)

		TradeSkillCollapseAllButton:SetHighlightTexture''
		TradeSkillCollapseAllButton.SetHighlightTexture = E.hoop

		TradeSkillCollapseAllButton:SetDisabledTexture(A.collapse)
		TradeSkillCollapseAllButton.SetDisabledTexture = E.hoop
		
		TradeSkillCollapseAllButton:GetDisabledTexture():SetAnchor('LEFT', 0, 2)
		TradeSkillCollapseAllButton:GetDisabledTexture():SetSize(15)
		TradeSkillCollapseAllButton:GetDisabledTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
		TradeSkillCollapseAllButton:GetDisabledTexture():SetDesaturated(true)--]]

		hooksecurefunc(TradeSkillCollapseAllButton, 'SetNormalTexture', function(self, texture)
			if find(texture, 'MinusButton') then
				self:GetNormalTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
			else
				self:GetNormalTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
			end
		end)

		for i = 1, TRADE_SKILLS_DISPLAYED do
			local button = _G['TradeSkillSkill'..i]
			local highlight = _G['TradeSkillSkill'..i..'Highlight']

			button:SetNormalTexture(A.collapse)
			button.SetNormalTexture = E.hoop
			--button:GetNormalTexture():SetSize(14)
			--button:GetNormalTexture():SetAnchor('LEFT', 0, 1)
			button:SetSize(14)
			button:SetAnchor('LEFT', 0, 1)

			highlight:SetTexture''
			highlight.SetTexture = E.hoop

			hooksecurefunc(button, 'SetNormalTexture', function(self, texture)
				if find(texture, 'MinusButton') then
					self:GetNormalTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
				elseif find(texture, 'PlusButton') then
					self:GetNormalTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
				else
					self:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
				end
			end)
		end

		TradeSkillListScrollFrame:StripLayout()
		TradeSkillListScrollFrame:SetSize(300, 400)
		TradeSkillListScrollFrame:ClearAllPoints()
		TradeSkillListScrollFrame:SetAnchor('TOPLEFT', 1, -80)

		TradeSkillListScrollFrameScrollBar:ShortBar()
		
		local up = _G['TradeSkillListScrollFrameScrollBar'..'ScrollUpButton']
		local dn = _G['TradeSkillListScrollFrameScrollBar'..'ScrollDownButton']
		
		up:SetAlpha(0)
		dn:SetAlpha(0)

		TradeSkillDetailScrollFrame:StripLayout()
		TradeSkillDetailScrollFrame:SetSize(300, 381)
		TradeSkillDetailScrollFrame:ClearAllPoints()
		TradeSkillDetailScrollFrame:SetAnchor('TOPRIGHT', TradeSkillFrame, -64, -95)
		TradeSkillDetailScrollFrame.scrollBarHideable = nil

		--TradeSkillDetailScrollFrameScrollBar:ShortBar()
		TradeSkillDetailScrollFrameScrollBar:SetAlpha(0)

		TradeSkillDetailScrollChildFrame:StripLayout()
		TradeSkillDetailScrollChildFrame:SetSize(300, 150)

		TradeSkillSkillName:SetAnchor('TOPLEFT', 58, -3)
		
		local TradeSkillSkillIconBg = CreateFrame('frame', nil, TradeSkillFrame)
		TradeSkillSkillIconBg:SetLayout()
		TradeSkillSkillIconBg:SetAllPoints(TradeSkillSkillIcon)
		TradeSkillSkillIconBg:SetFrameLevel(TradeSkillSkillIcon:GetFrameLevel() +2)

		TradeSkillSkillIcon:SetSize(47)
		TradeSkillSkillIcon:SetAnchor('TOPLEFT', 6, -3)
		
		--TradeSkillSkillIcon:StripLayout()
		--TradeSkillSkillIcon:SetLayout()
		TradeSkillSkillIcon:StyleButton(nil, true)
		TradeSkillSkillIcon:SetParent(TradeSkillSkillIconBg)

		TradeSkillRequirementLabel:SetTextColor(1, 0.80, 0.10)

		for i = 1, MAX_TRADE_SKILL_REAGENTS do
			local reagent = _G['TradeSkillReagent'..i]
			local icon = _G['TradeSkillReagent'..i..'IconTexture']
			local count = _G['TradeSkillReagent'..i..'Count']
			local name = _G['TradeSkillReagent'..i..'Name']
			local nameFrame = _G['TradeSkillReagent'..i..'NameFrame']

			reagent:SetLayout()
			reagent:StyleButton()
			reagent:SetSize(143, 40)
			
			icon:SetParent(reagent.bg)
			icon:SetSize(34)
			icon:SetDrawLayer('OVERLAY')
			icon:SetAnchor('TOPLEFT', 4, -4)
			icon:SetTexCoord(unpack(E.TexCoords))

			count:SetAnchor('BOTTOMRIGHT', icon, 'BOTTOMRIGHT', -3, 2)
			count:SetParent(reagent.bg)
			count:SetDrawLayer('OVERLAY')

			name:SetAnchor('LEFT', nameFrame, 'LEFT', 20, 0)
			name:SetParent(reagent.bg)

			nameFrame:dummy()
		end

		TradeSkillReagentLabel:SetAnchor('TOPLEFT', TradeSkillSkillIcon, 'BOTTOMLEFT', 0, -10)

		TradeSkillReagent1:SetAnchor('TOPLEFT', TradeSkillReagentLabel, 'BOTTOMLEFT', 1, -3)
		TradeSkillReagent2:SetAnchor('LEFT', TradeSkillReagent1, 'RIGHT', 3, 0)
		TradeSkillReagent3:SetAnchor('TOPLEFT', TradeSkillReagent1, 'BOTTOMLEFT', 0, -3)
		TradeSkillReagent4:SetAnchor('LEFT', TradeSkillReagent3, 'RIGHT', 3, 0)
		TradeSkillReagent5:SetAnchor('TOPLEFT', TradeSkillReagent3, 'BOTTOMLEFT', 0, -3)
		TradeSkillReagent6:SetAnchor('LEFT', TradeSkillReagent5, 'RIGHT', 3, 0)
		TradeSkillReagent7:SetAnchor('TOPLEFT', TradeSkillReagent5, 'BOTTOMLEFT', 0, -3)
		TradeSkillReagent8:SetAnchor('LEFT', TradeSkillReagent7, 'RIGHT', 3, 0)

		TradeSkillCancelButton:ClearAllPoints()
		TradeSkillCancelButton:SetAnchor('TOPRIGHT', TradeSkillDetailScrollFrame, 'BOTTOMRIGHT', 23, -3)
		ET:HandleButton(TradeSkillCancelButton)

		TradeSkillCreateButton:ClearAllPoints()
		TradeSkillCreateButton:SetAnchor('TOPRIGHT', TradeSkillCancelButton, 'TOPLEFT', -3, 0)
		ET:HandleButton(TradeSkillCreateButton)

		TradeSkillCreateAllButton:ClearAllPoints()
		TradeSkillCreateAllButton:SetAnchor('TOPLEFT', TradeSkillDetailScrollFrame, 'BOTTOMLEFT', 4, -3)
		ET:HandleButton(TradeSkillCreateAllButton)

		TradeSkillDecrementButton:ButtonPrevLeft()
		TradeSkillDecrementButton:SetSize(24)
		TradeSkillInputBox:SetSize(24, 16)
		ET:HandleEditBox(TradeSkillInputBox)
		TradeSkillIncrementButton:ButtonNextRight()
		TradeSkillIncrementButton:SetSize(24)

		TradeSkillFrameCloseButton:CloseTemplate()

		TradeSkillHighlight:StripLayout()

		TradeSkillHighlightFrame.Left = TradeSkillHighlightFrame:CreateTexture(nil, 'ARTWORK')
		TradeSkillHighlightFrame.Left:SetSize(145, 15)
		TradeSkillHighlightFrame.Left:SetAnchor('LEFT', TradeSkillHighlightFrame, 'CENTER')
		TradeSkillHighlightFrame.Left:SetTexture(A.solid)

		TradeSkillHighlightFrame.Right = TradeSkillHighlightFrame:CreateTexture(nil, 'ARTWORK')
		TradeSkillHighlightFrame.Right:SetSize(145, 15)
		TradeSkillHighlightFrame.Right:SetAnchor('RIGHT', TradeSkillHighlightFrame, 'CENTER')
		TradeSkillHighlightFrame.Right:SetTexture(A.solid)

		hooksecurefunc(TradeSkillHighlight, 'SetVertexColor', function(_, r, g, b)
			TradeSkillHighlightFrame.Left:SetGradientAlpha('Horizontal', r, g, b, 0.35, r, g, b, 0)
			TradeSkillHighlightFrame.Right:SetGradientAlpha('Horizontal', r, g, b, 0, r, g, b, 0.35)
		end)

		hooksecurefunc('TradeSkillFrame_SetSelection', function(id)
			if TradeSkillSkillIcon:GetNormalTexture() then
				TradeSkillReagentLabel:SetAlpha(1)
				TradeSkillSkillIcon:SetAlpha(1)
				TradeSkillSkillIcon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
				TradeSkillSkillIcon:GetNormalTexture():SetDrawLayer('OVERLAY')
				TradeSkillSkillIcon:GetNormalTexture():SetInside()
			else
				TradeSkillReagentLabel:SetAlpha(0)
				TradeSkillSkillIcon:SetAlpha(0)
			end

			local skillLink = GetTradeSkillItemLink(id)
			if skillLink then
				local quality = select(3, GetItemInfo(skillLink))
				if quality then
					
					TradeSkillSkillIconBg.bg:SetBackdropBorderColor(GetItemQualityColor(quality))
					TradeSkillSkillName:SetTextColor(GetItemQualityColor(quality))
				else
					TradeSkillSkillIconBg.bg:SetBackdropBorderColor(unpack(A.borderColor))
					TradeSkillSkillName:SetTextColor(1, 1, 1)
				end
			end

			local numReagents = GetTradeSkillNumReagents(id)
			for i = 1, numReagents, 1 do
				local _, _, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i)
				local reagentLink = GetTradeSkillReagentItemLink(id, i)
				local reagent = _G['TradeSkillReagent'..i]
				local icon = _G['TradeSkillReagent'..i..'IconTexture']
				local name = _G['TradeSkillReagent'..i..'Name']

				if reagentLink then
					local quality = select(3, GetItemInfo(reagentLink))
					if quality then
						
						reagent.bg:SetBackdropBorderColor(GetItemQualityColor(quality))
						if playerReagentCount < reagentCount then
							name:SetTextColor(0.5, 0.5, 0.5)
						else
							name:SetTextColor(GetItemQualityColor(quality))
						end
					else
						reagent.bg:SetBackdropBorderColor(unpack(A.borderColor))
					end
				end
			end
		end);
	end

	ET['Blizzard_TradeSkillUI'] = LoadSkin