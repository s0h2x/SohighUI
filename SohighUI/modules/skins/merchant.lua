
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack, select = unpack, select

	local CreateFrame = CreateFrame
	local GetBuybackItemInfo = GetBuybackItemInfo
	local GetItemInfo = GetItemInfo
	local GetItemQualityColor = GetItemQualityColor
	local GetNumBuybackItems = GetNumBuybackItems
	local GetMerchantItemLink = GetMerchantItemLink
	local GetMerchantNumItems = GetMerchantNumItems
	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()
	
		local MerchantFrame = _G.MerchantFrame
		MerchantFrame:StripLayout(true)
		MerchantFrame:SetLayout()
		MerchantFrame.bg:SetAnchor('TOPLEFT', 10, -11)
		MerchantFrame.bg:SetAnchor('BOTTOMRIGHT', -28, 60)
		
		MerchantFrame:SetShadow()
		MerchantFrame.shadow:SetAnchor('TOPLEFT', 6, -9)
		MerchantFrame.shadow:SetAnchor('BOTTOMRIGHT', -24, 56)

		MerchantFrame:EnableMouseWheel(true)
		MerchantFrame:SetScript('OnMouseWheel', function(_, value)
			if value > 0 then
				if MerchantPrevPageButton:IsShown() and MerchantPrevPageButton:IsEnabled() == 1 then
					MerchantPrevPageButton_OnClick()
				end
			else
				if MerchantNextPageButton:IsShown() and MerchantNextPageButton:IsEnabled() == 1 then
					MerchantNextPageButton_OnClick()
				end
			end
		end)

		MerchantFrameCloseButton:CloseTemplate()

		for i = 1, BUYBACK_ITEMS_PER_PAGE do
			local item = _G['MerchantItem'..i]
			local button = _G['MerchantItem'..i..'ItemButton']
			local icon = _G['MerchantItem'..i..'ItemButtonIconTexture']
			local money = _G['MerchantItem'..i..'MoneyFrame']
			local nameFrame = _G['MerchantItem'..i..'NameFrame']
			local name = _G['MerchantItem'..i..'Name']
			local slot = _G['MerchantItem'..i..'SlotTexture']

			item:StripLayout(true)
			item:SetLayout()
			item.bg:SetAnchor('TOPLEFT', 0, 0)
			item.bg:SetAnchor('BOTTOMRIGHT', 0, -4)

			button:StripLayout()
			ET:HandleButton(button)
			button:SetLayout(true)
			button:SetSize(40)
			button:SetAnchor('TOPLEFT', item, 'TOPLEFT', 4, -4)

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetInside()

			nameFrame:SetAnchor('LEFT', slot, 'RIGHT', -6, -17)

			name:SetAnchor('LEFT', slot, 'RIGHT', -4, 5)

			money:ClearAllPoints()
			money:SetAnchor('BOTTOMLEFT', button, 'BOTTOMRIGHT', 3, 0)

			for j = 1, 2 do
				local currencyItem = _G['MerchantItem'..i..'AltCurrencyFrameItem'..j]
				local currencyIcon = _G['MerchantItem'..i..'AltCurrencyFrameItem'..j..'Texture']

				currencyIcon.bg = CreateFrame('frame', nil, currencyItem)
				currencyIcon.bg:SetLayout()
				currencyIcon.bg:SetFrameLevel(currencyItem:GetFrameLevel())
				currencyIcon.bg:SetOutside(currencyIcon)

				currencyIcon:SetTexCoord(unpack(E.TexCoords))
				currencyIcon:SetParent(currencyIcon.bg)
			end
		end

		MerchantNextPageButton:StripLayout()
		MerchantPrevPageButton:StripLayout()
		
		MerchantNextPageButton:ButtonNextRight()
		MerchantPrevPageButton:ButtonPrevLeft()

		--MerchantRepairItemButton:StyleButton()
		ET:HandleButton(MerchantRepairItemButton)
		MerchantRepairItemButton:SetLayout(true)

		for i = 1, MerchantRepairItemButton:GetNumRegions() do
			local region = select(i, MerchantRepairItemButton:GetRegions())
			if region:IsObjectType('Texture') then
				region:SetTexCoord(0.04, 0.24, 0.07, 0.5)
				region:SetInside()
			end
		end

		ET:HandleButton(MerchantRepairAllButton)
		MerchantRepairAllButton:SetLayout(true)

		MerchantRepairAllIcon:SetTexCoord(0.34, 0.1, 0.34, 0.535, 0.535, 0.1, 0.535, 0.535)
		MerchantRepairAllIcon:SetInside()

		ET:HandleButton(MerchantGuildBankRepairButton)
		MerchantGuildBankRepairButton:SetLayout(true)

		MerchantGuildBankRepairButtonIcon:SetTexCoord(0.61, 0.82, 0.1, 0.52)
		MerchantGuildBankRepairButtonIcon:SetInside()

		MerchantBuyBackItem:StripLayout(true)
		MerchantBuyBackItem:SetLayout()
		MerchantBuyBackItem.bg:SetAnchor('TOPLEFT', -6, 6)
		MerchantBuyBackItem.bg:SetAnchor('BOTTOMRIGHT', 6, -6)
		MerchantBuyBackItem:SetAnchor('TOPLEFT', MerchantItem10, 'BOTTOMLEFT', 0, -48)

		MerchantBuyBackItemItemButton:StripLayout()
		MerchantBuyBackItemItemButton:SetLayout()
		--ET:HandleButton(MerchantBuyBackItemItemButton)
		ET:HandleItemButton(MerchantBuyBackItemItemButton)

		MerchantBuyBackItemItemButtonIconTexture:SetTexCoord(unpack(E.TexCoords))
		--MerchantBuyBackItemItemButtonIconTexture:SetInside()

		for i = 1, 2 do
			local tab = _G['MerchantFrameTab'..i]
			tab:StripLayout()
			tab:SetLayout()
			
			tab.bg:SetAnchor('TOPLEFT', -1, -5)
			tab.bg:SetAnchor('BOTTOMRIGHT', -20, -1)
			
			tab:SetGradient()
			tab.gr:SetAllPoints(tab.bg)
			
			_G['MerchantFrameTab'..i..'Text']:SetAnchor('TOPLEFT', 10, -12)
		end

		hooksecurefunc('MerchantFrame_UpdateMerchantInfo', function()
			local numMerchantItems = GetMerchantNumItems()
			local index, itemButton, itemName, itemLink
			local quality, r, g, b

			for i = 1, BUYBACK_ITEMS_PER_PAGE do
				index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
				itemButton = _G['MerchantItem'..i..'ItemButton']
				itemName = _G['MerchantItem'..i..'Name']

				if index <= numMerchantItems then
					itemLink = GetMerchantItemLink(index)
					if itemLink then
						quality = select(3, GetItemInfo(itemLink))
						r, g, b = GetItemQualityColor(quality)

						itemName:SetTextColor(r, g, b)
						if quality then
							itemButton:SetBackdropBorderColor(r, g, b)
						else
							itemButton:SetBackdropBorderColor(unpack(A.borderColor))
						end
					else
						itemButton:SetBackdropBorderColor(unpack(A.borderColor))
					end
				end

				if GetBuybackItemInfo(GetNumBuybackItems()) then
					quality = select(3, GetItemInfo(GetBuybackItemInfo(GetNumBuybackItems())))
					r, g, b = GetItemQualityColor(quality)

					MerchantBuyBackItemName:SetTextColor(r, g, b)
					if quality then
						MerchantBuyBackItemItemButton:SetBackdropBorderColor(r, g, b)
					else
						MerchantBuyBackItemItemButton:SetBackdropBorderColor(unpack(A.borderColor))
					end
				else
					MerchantBuyBackItemItemButton:SetBackdropBorderColor(unpack(A.borderColor))
				end
			end
		end)

		hooksecurefunc('MerchantFrame_UpdateBuybackInfo', function()
			local numBuybackItems = GetNumBuybackItems()
			local itemButton, itemName
			local quality, r, g, b

			for i = 1, BUYBACK_ITEMS_PER_PAGE do
				itemButton = _G['MerchantItem'..i..'ItemButton']
				itemName = _G['MerchantItem'..i..'Name']

				if i <= numBuybackItems then
					if GetBuybackItemInfo(i) then
						quality = select(3, GetItemInfo(GetBuybackItemInfo(i)))
						r, g, b = GetItemQualityColor(quality)

						itemName:SetTextColor(r, g, b)
						if quality then
							itemButton:SetBackdropBorderColor(r, g, b)
						else
							itemButton:SetBackdropBorderColor(unpack(A.borderColor))
						end
					else
						itemButton:SetBackdropBorderColor(unpack(A.borderColor))
					end
				end
			end
		end)
	end

	table.insert(ET['SohighUI'], LoadSkin)