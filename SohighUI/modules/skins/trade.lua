
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end
	
	local _G = _G
	local unpack, select = unpack, select

	local CreateFrame = CreateFrame
	local hooksecurefunc = hooksecurefunc
	local GetItemInfo = GetItemInfo
	local GetItemQualityColor = GetItemQualityColor
	local GetTradePlayerItemLink = GetTradePlayerItemLink
	local GetTradeTargetItemLink = GetTradeTargetItemLink

	local function LoadSkin()
	
		local TradeFrame = _G['TradeFrame']
		TradeFrame:StripLayout(true)
		TradeFrame:Width(400)
		TradeFrame:SetLayout()
		TradeFrame.bg:SetAnchor('TOPLEFT', 10, -11)
		TradeFrame.bg:SetAnchor('BOTTOMRIGHT', -28, 48)
		
		TradeFrame:SetShadow()
		TradeFrame.shadow:SetAnchor('TOPLEFT', 6, -9)
		TradeFrame.shadow:SetAnchor('BOTTOMRIGHT', -24, 44)

		TradeFrameCloseButton:CloseTemplate()

		ET:HandleEditBox(TradePlayerInputMoneyFrameGold)
		ET:HandleEditBox(TradePlayerInputMoneyFrameSilver)
		ET:HandleEditBox(TradePlayerInputMoneyFrameCopper)

		ET:HandleButton(TradeFrameTradeButton)
		TradeFrameTradeButton:SetAnchor('BOTTOMRIGHT', -120, 55)

		ET:HandleButton(TradeFrameCancelButton)

		TradePlayerItem1:SetAnchor('TOPLEFT', 24, -104)

		for _, frame in pairs({'TradePlayerItem', 'TradeRecipientItem'}) do
			for i = 1, MAX_TRADE_ITEMS do
				local item = _G[frame..i]
				local button = _G[frame..i..'ItemButton']
				local icon = _G[frame..i..'ItemButtonIconTexture']
				local name = _G[frame..i..'NameFrame']

				item:StripLayout()

				button:StripLayout()
				button:SetLayout()
				--button:StyleButton()

				--[[button.bg = CreateFrame('frame', nil, button)
				button.bg:SetTemplate('Default')
				button.bg:SetAnchor('TOPLEFT', button, 'TOPRIGHT', 4, 0)
				button.bg:SetAnchor('BOTTOMRIGHT', name, 'BOTTOMRIGHT', -5, 14)
				button.bg:SetFrameLevel(button:GetFrameLevel() - 4)--]]

				icon:SetTexCoord(unpack(E.TexCoords))
				icon:SetInside()
			end
		end

		hooksecurefunc('TradeFrame_UpdatePlayerItem', function(id)
			local link = GetTradePlayerItemLink(id)
			local item = _G['TradePlayerItem'..id..'ItemButton']
			local name = _G['TradePlayerItem'..id..'Name']

			if link then
				local quality = select(3, GetItemInfo(link))
				if quality then
					item:SetBackdropBorderColor(GetItemQualityColor(quality))
					name:SetTextColor(GetItemQualityColor(quality))
				else
					item:SetBackdropBorderColor(unpack(A.borderColor))
					name:SetTextColor(1, 1, 1)
				end
			else
				item:SetBackdropBorderColor(unpack(A.borderColor))
			end
		end)

		hooksecurefunc('TradeFrame_UpdateTargetItem', function(id)
			local link = GetTradeTargetItemLink(id)
			local item = _G['TradeRecipientItem'..id..'ItemButton']
			local name = _G['TradeRecipientItem'..id..'Name']

			if link then
				local quality = select(3, GetItemInfo(link))
				if quality  then
					item:SetBackdropBorderColor(GetItemQualityColor(quality))
					name:SetTextColor(GetItemQualityColor(quality))
				else
					item:SetBackdropBorderColor(unpack(A.borderColor))
					name:SetTextColor(1, 1, 1)
				end
			else
				item:SetBackdropBorderColor(unpack(A.borderColor))
			end
		end)

		local highlights = {
			'TradeHighlightPlayerTop',
			'TradeHighlightPlayerBottom',
			'TradeHighlightPlayerMiddle',
			'TradeHighlightPlayerEnchantTop',
			'TradeHighlightPlayerEnchantBottom',
			'TradeHighlightPlayerEnchantMiddle',
			'TradeHighlightRecipientTop',
			'TradeHighlightRecipientBottom',
			'TradeHighlightRecipientMiddle',
			'TradeHighlightRecipientEnchantTop',
			'TradeHighlightRecipientEnchantBottom',
			'TradeHighlightRecipientEnchantMiddle',
		}
		for i = 1, #highlights do
			_G[highlights[i]]:SetTexture(0, 1, 0, 0.2)
		end
	end

	table.insert(ET['SohighUI'], LoadSkin)