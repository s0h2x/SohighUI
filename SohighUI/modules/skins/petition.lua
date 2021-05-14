
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end
	
	local _G = _G

	local function LoadSkin()
		local PetitionFrame = _G['PetitionFrame']
		PetitionFrame:StripLayout(true)
		PetitionFrame:SetLayout()
		PetitionFrame.bg:SetAnchor('TOPLEFT', 12, -17)
		PetitionFrame.bg:SetAnchor('BOTTOMRIGHT', -28, 65)
		
		PetitionFrame:SetShadow()
		PetitionFrame.shadow:SetAnchor('TOPLEFT', 10, -15)
		PetitionFrame.shadow:SetAnchor('BOTTOMRIGHT', -24, 61)

		ET:HandleButton(PetitionFrameSignButton)
		ET:HandleButton(PetitionFrameRequestButton)
		ET:HandleButton(PetitionFrameRenameButton)
		ET:HandleButton(PetitionFrameCancelButton)
		PetitionFrameCloseButton:CloseTemplate()

		PetitionFrameCharterTitle:SetTextColor(1, 0.80, 0.10)
		PetitionFrameCharterName:SetTextColor(1, 1, 1)
		PetitionFrameMasterTitle:SetTextColor(1, 0.80, 0.10)
		PetitionFrameMasterName:SetTextColor(1, 1, 1)
		PetitionFrameMemberTitle:SetTextColor(1, 0.80, 0.10)

		for i = 1, 9 do
			_G['PetitionFrameMemberName'..i]:SetTextColor(1, 1, 1)
		end

		PetitionFrameInstructions:SetTextColor(1, 1, 1)

		PetitionFrameRenameButton:SetAnchor('LEFT', PetitionFrameRequestButton, 'RIGHT', 3, 0)
		PetitionFrameRenameButton:SetAnchor('RIGHT', PetitionFrameCancelButton, 'LEFT', -3, 0)
	end

	table.insert(ET['SohighUI'], LoadSkin)