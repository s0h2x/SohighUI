
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack = unpack
	local find = string.find
	
	local hooksecurefunc = hooksecurefunc
	local CreateFrame = CreateFrame

	local function LoadSkin()
	
		ClassTrainerFrame:SetAttribute('UIPanelLayout-Width', E:Scale(710))
		ClassTrainerFrame:SetAttribute('UIPanelLayout-Height', E:Scale(470))
		ClassTrainerFrame:SetSize(710, 470)
		ClassTrainerFrame:StripLayout(true)
		ClassTrainerFrame:SetLayout()
		ClassTrainerFrame.bg:SetAnchor('TOPLEFT', 15, -11)
		ClassTrainerFrame.bg:SetAnchor('BOTTOMRIGHT', -35, 74)
		
		ClassTrainerFrame:SetShadow()
		ClassTrainerFrame.shadow:SetAnchor('TOPLEFT', 11, -9)
		ClassTrainerFrame.shadow:SetAnchor('BOTTOMRIGHT', -31, 70)

		ClassTrainerListScrollFrame:StripLayout()
		ClassTrainerListScrollFrame:SetSize(300)
		ClassTrainerListScrollFrame.SetHeight = E.hoop
		ClassTrainerListScrollFrame:ClearAllPoints()
		ClassTrainerListScrollFrame:SetAnchor('TOPLEFT', 17, -85)

		ClassTrainerDetailScrollFrame:StripLayout()
		ClassTrainerDetailScrollFrame:SetSize(295, 280)
		ClassTrainerDetailScrollFrame.SetHeight = E.hoop
		ClassTrainerDetailScrollFrame:ClearAllPoints()
		ClassTrainerDetailScrollFrame:SetAnchor('TOPRIGHT', ClassTrainerFrame, -64, -85)
		ClassTrainerDetailScrollFrame.scrollBarHideable = nil

		ClassTrainerFrame.bg1 = CreateFrame('frame', nil, ClassTrainerFrame)
		ClassTrainerFrame.bg1:SetLayout()
		ClassTrainerFrame.bg1:SetAnchor('TOPLEFT', 18, -77)
		ClassTrainerFrame.bg1:SetAnchor('BOTTOMRIGHT', -367, 77)
		ClassTrainerFrame.bg1:SetFrameLevel(ClassTrainerFrame.bg1:GetFrameLevel() - 1)

		ClassTrainerFrame.bg2 = CreateFrame('frame', nil, ClassTrainerFrame)
		ClassTrainerFrame.bg2:SetLayout()
		ClassTrainerFrame.bg2:SetAnchor('TOPLEFT', ClassTrainerFrame.bg1, 'TOPRIGHT', 1, 0)
		ClassTrainerFrame.bg2:SetAnchor('BOTTOMRIGHT', ClassTrainerFrame, 'BOTTOMRIGHT', -38, 77)
		ClassTrainerFrame.bg2:SetFrameLevel(ClassTrainerFrame.bg2:GetFrameLevel() - 1)

		ClassTrainerDetailScrollChildFrame:StripLayout()
		ClassTrainerDetailScrollChildFrame:SetSize(300, 150)

		ClassTrainerExpandButtonFrame:StripLayout()

		--S:HandleDropDownBox(ClassTrainerFrameFilterDropDown)
		ClassTrainerFrameFilterDropDown:SetAnchor('TOPRIGHT', -55, -40)

		ClassTrainerListScrollFrameScrollBar:ShortBar()
		ClassTrainerDetailScrollFrameScrollBar:ShortBar()

		ClassTrainerCancelButton:ClearAllPoints()
		ClassTrainerCancelButton:SetAnchor('TOPRIGHT', ClassTrainerDetailScrollFrame, 'BOTTOMRIGHT', 23, -3)
		ET:HandleButton(ClassTrainerCancelButton)

		ClassTrainerTrainButton:ClearAllPoints()
		ClassTrainerTrainButton:SetAnchor('TOPRIGHT', ClassTrainerCancelButton, 'TOPLEFT', -3, 0)
		ET:HandleButton(ClassTrainerTrainButton)

		ClassTrainerMoneyFrame:ClearAllPoints()
		ClassTrainerMoneyFrame:SetAnchor('BOTTOMLEFT', ClassTrainerFrame, 'BOTTOMRIGHT', -180, 107)

		ClassTrainerFrameCloseButton:CloseTemplate()

		ClassTrainerSkillName:SetAnchor('TOPLEFT', 55, -3)

		ClassTrainerSkillIcon:StripLayout()
		ClassTrainerSkillIcon:SetLayout()
		--ET:HandleButton(ClassTrainerSkillIcon)
		--ClassTrainerSkillIcon:SetParent(ClassTrainerFrame.bg)
		ClassTrainerSkillIcon:StyleButton(nil, true)
		ClassTrainerSkillIcon:SetSize(47)
		ClassTrainerSkillIcon:SetAnchor('TOPLEFT', 2, 0)

		ClassTrainerSkillHighlight:StripLayout()

		ClassTrainerSkillHighlightFrame.Left = ClassTrainerSkillHighlightFrame:CreateTexture(nil, 'ARTWORK')
		ClassTrainerSkillHighlightFrame.Left:SetSize(152, 15)
		ClassTrainerSkillHighlightFrame.Left:SetAnchor('LEFT', ClassTrainerSkillHighlightFrame, 'CENTER')
		ClassTrainerSkillHighlightFrame.Left:SetTexture(A.solid)

		ClassTrainerSkillHighlightFrame.Right = ClassTrainerSkillHighlightFrame:CreateTexture(nil, 'ARTWORK')
		ClassTrainerSkillHighlightFrame.Right:SetSize(152, 15)
		ClassTrainerSkillHighlightFrame.Right:SetAnchor('RIGHT', ClassTrainerSkillHighlightFrame, 'CENTER')
		ClassTrainerSkillHighlightFrame.Right:SetTexture(A.solid)

		hooksecurefunc(ClassTrainerSkillHighlight, 'SetVertexColor', function(_, r, g, b)
			ClassTrainerSkillHighlightFrame.Left:SetGradientAlpha('Horizontal', r, g, b, 0.35, r, g, b, 0)
			ClassTrainerSkillHighlightFrame.Right:SetGradientAlpha('Horizontal', r, g, b, 0, r, g, b, 0.35)
		end)

		hooksecurefunc('ClassTrainer_SetSelection', function()
			local skillIcon = ClassTrainerSkillIcon:GetNormalTexture()

			if skillIcon and not skillIcon.isSkinned then
				skillIcon:SetInside()
				skillIcon:SetParent(ClassTrainerSkillIcon.bg)
				skillIcon:SetTexCoord(unpack(E.TexCoords))

				skillIcon.isSkinned = true
			end
		end);

		CLASS_TRAINER_SKILLS_DISPLAYED = 19

		hooksecurefunc('ClassTrainer_SetToTradeSkillTrainer', function()
			CLASS_TRAINER_SKILLS_DISPLAYED = 19
		end)

		hooksecurefunc('ClassTrainer_SetToClassTrainer', function()
			CLASS_TRAINER_SKILLS_DISPLAYED = 19
		end)

		for i = 12, 19 do
			CreateFrame('Button', 'ClassTrainerSkill'..i, ClassTrainerFrame, 'ClassTrainerSkillButtonTemplate'):SetAnchor('TOPLEFT', _G['ClassTrainerSkill'..i - 1], 'BOTTOMLEFT')
		end

		ClassTrainerSkill1:SetAnchor('TOPLEFT', 22, -80)

		for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED do
			local skillButton = _G['ClassTrainerSkill'..i]
			local highlight = _G['ClassTrainerSkill'..i..'Highlight']

			skillButton:SetNormalTexture(A.collapse)
			skillButton.SetNormalTexture = E.hoop
			skillButton:GetNormalTexture():SetSize(13)

			highlight:SetTexture''
			highlight.SetTexture = E.hoop

			hooksecurefunc(skillButton, 'SetNormalTexture', function(self, texture)
				if find(texture, 'MinusButton') then
					self:GetNormalTexture():SetTexCoord(0.545, 0.975, 0.085, 0.925)
				elseif find(texture, 'PlusButton') then
					self:GetNormalTexture():SetTexCoord(0.045, 0.475, 0.085, 0.925)
				else
					self:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
				end
			end)
		end

		ClassTrainerCollapseAllButton:SetAnchor('LEFT', ClassTrainerExpandTabLeft, 'RIGHT', -8, 18)

		ClassTrainerCollapseAllButton:SetNormalTexture(A.collapse)
		ClassTrainerCollapseAllButton.SetNormalTexture = E.hoop
		ClassTrainerCollapseAllButton:GetNormalTexture():SetAnchor('LEFT', 3, 2)
		ClassTrainerCollapseAllButton:GetNormalTexture():SetSize(15)

		ClassTrainerCollapseAllButton:SetHighlightTexture''
		ClassTrainerCollapseAllButton.SetHighlightTexture = E.hoop

		ClassTrainerCollapseAllButton:SetDisabledTexture(A.collapse)
		ClassTrainerCollapseAllButton.SetDisabledTexture = E.hoop
		ClassTrainerCollapseAllButton:GetDisabledTexture():SetAnchor('LEFT', 3, 2)
		ClassTrainerCollapseAllButton:GetDisabledTexture():SetSize(15)
		ClassTrainerCollapseAllButton:GetDisabledTexture():SetTexCoord(0.045, 0.475, 0.085, 0.925)
		ClassTrainerCollapseAllButton:GetDisabledTexture():SetDesaturated(true)

		hooksecurefunc(ClassTrainerCollapseAllButton, 'SetNormalTexture', function(self, texture)
			if find(texture, 'MinusButton') then
				self:GetNormalTexture():SetTexCoord(0.545, 0.975, 0.085, 0.925)
			else
				self:GetNormalTexture():SetTexCoord(0.045, 0.475, 0.085, 0.925)
			end
		end)
	end

	ET['Blizzard_TrainerUI'] = LoadSkin