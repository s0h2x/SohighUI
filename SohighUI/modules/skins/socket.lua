
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack = unpack
	local format = string.format

	local GetNumSockets = GetNumSockets
	local GetSocketTypes = GetSocketTypes
	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()

		local ItemSocketingFrame = _G['ItemSocketingFrame']
		ItemSocketingFrame:StripLayout()
		ItemSocketingFrame:SetLayout()
		ItemSocketingFrame.bg:SetAnchor('TOPLEFT', 11, -12)
		ItemSocketingFrame.bg:SetAnchor('BOTTOMRIGHT', -4, 27)
		
		ItemSocketingFrame:SetShadow()
		ItemSocketingFrame.shadow:SetAnchor('TOPLEFT', 9, -10)
		ItemSocketingFrame.shadow:SetAnchor('BOTTOMRIGHT', 0, 23)

		ItemSocketingFramePortrait:dummy()

		ItemSocketingCloseButton:CloseTemplate()

		ItemSocketingScrollFrame:StripLayout()
		ItemSocketingScrollFrame:SetLayout()

		ItemSocketingScrollFrameScrollBar:ShortBar()

		for i = 1, MAX_NUM_SOCKETS do
			local button = _G[format('ItemSocketingSocket%d', i)]
			local icon = _G[format('ItemSocketingSocket%dIconTexture', i)]
			local bracket = _G[format('ItemSocketingSocket%dBracketFrame', i)]
			local bg = _G[format('ItemSocketingSocket%dBackground', i)]

			button:StripLayout()
			button:SetLayout()
			--button:StyleButton(false)

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetInside()

			bracket:dummy()
			bg:dummy()
		end

		hooksecurefunc('ItemSocketingFrame_Update', function()
			local numSockets = GetNumSockets()
			for i = 1, numSockets do
				local button = _G[format('ItemSocketingSocket%d', i)]
				local gemColor = GetSocketTypes(i)
				local color = GEM_TYPE_INFO[gemColor]

				button:SetBackdropColor(color.r, color.g, color.b, 0.35)
				button:SetBackdropBorderColor(color.r, color.g, color.b)
			end
		end)

		ET:HandleButton(ItemSocketingSocketButton)
	end

	E['Blizzard_ItemSocketingUI'] = LoadSkin