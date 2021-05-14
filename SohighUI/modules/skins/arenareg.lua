
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local select = select

	local function LoadSkin()
		ArenaRegistrarFrame:StripLayout(true)
		
		ArenaRegistrarFrame:SetLayout()
		ArenaRegistrarFrame.bg:SetAnchor('TOPLEFT', 14, -18)
		ArenaRegistrarFrame.bg:SetAnchor('BOTTOMRIGHT', -30, 67)
		
		ArenaRegistrarFrame:SetShadow()
		ArenaRegistrarFrame.shadow:SetAnchor('TOPLEFT', 12, -16)
		ArenaRegistrarFrame.shadow:SetAnchor('BOTTOMRIGHT', -26, 63)

		ArenaRegistrarFrameCloseButton:CloseTemplate()

		ArenaRegistrarGreetingFrame:StripLayout()

		select(1, ArenaRegistrarGreetingFrame:GetRegions()):SetTextColor(1, 0.80, 0.10)
		RegistrationText:SetTextColor(1, 0.80, 0.10)

		ET:HandleButton(ArenaRegistrarFrameGoodbyeButton)

		for i = 1, MAX_TEAM_BORDERS do
			local button = _G['ArenaRegistrarButton'..i]
			local obj = select(3, button:GetRegions())

			ET:HandleButtonHighlight(button)

			obj:SetTextColor(1, 1, 1)
		end

		ArenaRegistrarPurchaseText:SetTextColor(1, 1, 1)

		ET:HandleButton(ArenaRegistrarFrameCancelButton)
		ET:HandleButton(ArenaRegistrarFramePurchaseButton)

		select(6, ArenaRegistrarFrameEditBox:GetRegions()):dummy()
		select(7, ArenaRegistrarFrameEditBox:GetRegions()):dummy()
		ET:HandleEditBox(ArenaRegistrarFrameEditBox)
		ArenaRegistrarFrameEditBox:Height(18)

		PVPBannerFrame:SetLayout()
		PVPBannerFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		PVPBannerFrame.bg:SetAnchor('BOTTOMRIGHT', -33, 73)

		PVPBannerFrame:StripLayout()

		PVPBannerFramePortrait:dummy()

		PVPBannerFrameCustomizationFrame:StripLayout()

		local customization, customizationLeft, customizationRight
		for i = 1, 2 do
			customization = _G['PVPBannerFrameCustomization'..i]
			customizationLeft = _G['PVPBannerFrameCustomization'..i..'LeftButton']
			customizationRight = _G['PVPBannerFrameCustomization'..i..'RightButton']

			customization:StripLayout()
			customizationLeft:ButtonPrevLeft()
			customizationRight:ButtonNextRight()
		end

		local pickerButton
		for i = 1, 3 do
			pickerButton = _G['PVPColorPickerButton'..i]
			ET:HandleButton(pickerButton)
			if i == 2 then
				pickerButton:SetAnchor('TOP', PVPBannerFrameCustomization2, 'BOTTOM', 0, -33)
			elseif i == 3 then
				pickerButton:SetAnchor('TOP', PVPBannerFrameCustomization2, 'BOTTOM', 0, -59)
			end
		end

		ET:HandleButton(PVPBannerFrameAcceptButton)
		ET:HandleButton(PVPBannerFrameCancelButton)
		ET:HandleButton(select(4, PVPBannerFrame:GetChildren()))

		PVPBannerFrameCloseButton:CloseTemplate()
	end

	table.insert(ET['SohighUI'], LoadSkin)