
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local SetDressUpBackground = SetDressUpBackground

	local function LoadSkin()
	
		local DressUpFrame = _G['DressUpFrame']
		DressUpFrame:StripLayout()
		DressUpFrame:SetLayout()
		DressUpFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		DressUpFrame.bg:SetAnchor('BOTTOMRIGHT', -33, 73)
		
		DressUpFrame:SetShadow()
		DressUpFrame.shadow:SetAnchor('TOPLEFT', 7, -10)
		DressUpFrame.shadow:SetAnchor('BOTTOMRIGHT', -29, 69)

		DressUpFramePortrait:dummy()

		SetDressUpBackground()
		--DressUpBackgroundTopLeft:SetDesaturated(true)
		--DressUpBackgroundTopRight:SetDesaturated(true)
		--DressUpBackgroundBotLeft:SetDesaturated(true)
		--DressUpBackgroundBotRight:SetDesaturated(true)

		DressUpFrameDescriptionText:SetAnchor('CENTER', DressUpFrameTitleText, 'BOTTOM', -5, -22)

		DressUpFrameCloseButton:CloseTemplate()

		ET:HandleRotateButton(DressUpModelRotateLeftButton)
		DressUpModelRotateLeftButton:SetAnchor('TOPLEFT', DressUpFrame, 25, -79)

		ET:HandleRotateButton(DressUpModelRotateRightButton)
		DressUpModelRotateRightButton:SetAnchor('TOPLEFT', DressUpModelRotateLeftButton, 'TOPRIGHT', 3, 0)

		ET:HandleButton(DressUpFrameCancelButton)
		DressUpFrameCancelButton:SetAnchor('CENTER', DressUpFrame, 'TOPLEFT', 306, -423)

		ET:HandleButton(DressUpFrameResetButton)
		DressUpFrameResetButton:SetAnchor('RIGHT', DressUpFrameCancelButton, 'LEFT', -3, 0)

		DressUpModel:SetLayout()
		DressUpModel.bg:SetOutside(DressUpBackgroundTopLeft, nil, nil, DressUpModel)
	end

	table.insert(ET['SohighUI'], LoadSkin)