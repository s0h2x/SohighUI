
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local select = select

	local function LoadSkin()
		GuildRegistrarGreetingFrame:StripLayout()

		GuildRegistrarFrame:StripLayout(true)
		GuildRegistrarFrame:SetLayout()
		GuildRegistrarFrame.bg:SetAnchor('TOPLEFT', 12, -17)
		GuildRegistrarFrame.bg:SetAnchor('BOTTOMRIGHT', -28, 65)

		ET:HandleButton(GuildRegistrarFrameGoodbyeButton)
		ET:HandleButton(GuildRegistrarFrameCancelButton)
		ET:HandleButton(GuildRegistrarFramePurchaseButton)

		GuildRegistrarFrameCloseButton:CloseTemplate()

		ET:HandleEditBox(GuildRegistrarFrameEditBox)

		for i = 1, GuildRegistrarFrameEditBox:GetNumRegions() do
			local region = select(i, GuildRegistrarFrameEditBox:GetRegions())
			if region and region:IsObjectType('Texture') then
				if region:GetTexture() == 'Interface\\ChatFrame\\UI-ChatInputBorder-Left' or region:GetTexture() == 'Interface\\ChatFrame\\UI-ChatInputBorder-Right' then
					region:dummy()
				end
			end
		end

		GuildRegistrarFrameEditBox:Height(20)

		for i = 1, 2 do
			_G['GuildRegistrarButton'..i]:GetFontString():SetTextColor(1, 1, 1)
			ET:HandleButtonHighlight(_G['GuildRegistrarButton'..i])
		end

		GuildRegistrarPurchaseText:SetTextColor(1, 1, 1)
		AvailableServicesText:SetTextColor(1, 1, 0)
	end

	table.insert(ET['SohighUI'], LoadSkin)