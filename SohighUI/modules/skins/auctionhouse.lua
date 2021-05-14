
	--* Auction
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local pairs, unpack = pairs, unpack

	local hooksecurefunc = hooksecurefunc
	local CreateFrame = CreateFrame

	local function LoadSkin()

		local AuctionFrame = _G['AuctionFrame']
		AuctionFrame:StripLayout(true)
		AuctionFrame:SetLayout()
		AuctionFrame.bg:SetAnchor('TOPLEFT', 10, -10)
		AuctionFrame.bg:SetAnchor('BOTTOMRIGHT', 0, 10)
		
		AuctionFrame:SetShadow()
		AuctionFrame.shadow:SetAnchor('TOPLEFT', 8, -8)
		AuctionFrame.shadow:SetAnchor('BOTTOMRIGHT', 4, 8)
		
		AuctionFrame:Height(455)

		local Buttons = {
			BrowseSearchButton,
			BrowseResetButton,
			BrowseBidButton,
			BrowseBuyoutButton,
			BrowseCloseButton,
			BidBidButton,
			BidBuyoutButton,
			BidCloseButton,
			AuctionsCreateAuctionButton,
			AuctionsCancelAuctionButton,
			AuctionsCloseButton
		}

		local CheckBoxes = {
			IsUsableCheckButton,
			ShowOnPlayerCheckButton
		}

		local EditBoxes = {
			BrowseName,
			BrowseMinLevel,
			BrowseMaxLevel,
			BrowseBidPriceGold,
			BrowseBidPriceSilver,
			BrowseBidPriceCopper,
			BidBidPriceGold,
			BidBidPriceSilver,
			BidBidPriceCopper,
			AuctionsStackSizeEntry,
			AuctionsNumStacksEntry,
			StartPriceGold,
			StartPriceSilver,
			StartPriceCopper,
			BuyoutPriceGold,
			BuyoutPriceSilver,
			BuyoutPriceCopper
		}

		local SortTabs = {
			BrowseQualitySort,
			BrowseLevelSort,
			BrowseDurationSort,
			BrowseHighBidderSort,
			BrowseCurrentBidSort,
			BidQualitySort,
			BidLevelSort,
			BidDurationSort,
			BidBuyoutSort,
			BidStatusSort,
			BidBidSort,
			AuctionsQualitySort,
			AuctionsDurationSort,
			AuctionsHighBidderSort,
			AuctionsBidSort
		}

		for _, Button in pairs(Buttons) do
			ET:HandleButton(Button, true)
		end

		for _, CheckBox in pairs(CheckBoxes) do
			ET:HandleCheckBox(CheckBox)
		end

		for _, EditBox in pairs(EditBoxes) do
			ET:HandleEditBox(EditBox)
			EditBox:SetTextInsets(1, 1, -1, 1)
		end

		for i = 1, AuctionFrame.numTabs do
			local tab = _G['AuctionFrameTab'..i]

			tab:StripLayout()
			tab:SetLayout()
			
			tab.bg:SetAnchor('TOPLEFT', -1, -5)
			tab.bg:SetAnchor('BOTTOMRIGHT', -20, -1)
			
			tab:SetGradient()
			tab.gr:SetAllPoints(tab.bg)
			
			_G['AuctionFrameTab'..i..'Text']:SetAnchor('TOPLEFT', 10, -12)

			if i == 1 then
				tab:ClearAllPoints()
				tab:SetAnchor('BOTTOMLEFT', AuctionFrame, 'BOTTOMLEFT', 25, -20)
				tab.SetAnchor = E.hoop
			end
		end

		for _, Tab in pairs(SortTabs) do
			Tab:StripLayout()
			Tab:SetNormalTexture([[Interface\Buttons\UI-SortArrow]])
			Tab:StyleButton()
		end

		for i = 1, NUM_FILTERS_TO_DISPLAY do
			local tab = _G['AuctionFilterButton'..i]

			tab:StripLayout()
			ET:HandleButtonHighlight(tab)
		end

		AuctionFrameCloseButton:CloseTemplate()

		-- DressUpFrame
		AuctionDressUpFrame:StripLayout()
		AuctionDressUpFrame:SetLayout()
		AuctionDressUpFrame.bg:SetAnchor('TOPLEFT', 0, 10)
		AuctionDressUpFrame.bg:SetAnchor('BOTTOMRIGHT', -5, 3)
		AuctionDressUpFrame:SetAnchor('TOPLEFT', AuctionFrame, 'TOPRIGHT', 1, -28)

		AuctionDressUpModel:SetLayout()
		AuctionDressUpModel.bg:SetOutside(AuctionDressUpBackgroundTop, nil, nil, AuctionDressUpBackgroundBot)

		SetAuctionDressUpBackground()
		AuctionDressUpBackgroundTop:SetDesaturated(true)
		AuctionDressUpBackgroundBot:SetDesaturated(true)

		ET:HandleRotateButton(AuctionDressUpModelRotateLeftButton)
		AuctionDressUpModelRotateLeftButton:SetAnchor('TOPLEFT', AuctionDressUpFrame, 8, -17)

		ET:HandleRotateButton(AuctionDressUpModelRotateRightButton)
		AuctionDressUpModelRotateRightButton:SetAnchor('TOPLEFT', AuctionDressUpModelRotateLeftButton, 'TOPRIGHT', 3, 0)

		ET:HandleButton(AuctionDressUpFrameResetButton)

		AuctionDressUpFrameCloseButton:CloseTemplate()

		-- Browse Frame
		BrowseTitle:SetAnchor('TOP', 25, -18)

		BrowseFilterScrollFrame:StripLayout()
		BrowseScrollFrame:StripLayout()

		--ET:HandleDropDownBox(BrowseDropDown)

		BrowseFilterScrollFrameScrollBar:ShortBar()
		BrowseFilterScrollFrameScrollBar:ClearAllPoints()
		BrowseFilterScrollFrameScrollBar:SetAnchor('TOPRIGHT', BrowseFilterScrollFrame, 'TOPRIGHT', 22, -17)
		BrowseFilterScrollFrameScrollBar:SetAnchor('BOTTOMRIGHT', BrowseFilterScrollFrame, 'BOTTOMRIGHT', 0, 16)

		BrowseScrollFrameScrollBar:ShortBar()
		BrowseScrollFrameScrollBar:ClearAllPoints()
		BrowseScrollFrameScrollBar:SetAnchor('TOPRIGHT', BrowseScrollFrame, 'TOPRIGHT', 23, -17)
		BrowseScrollFrameScrollBar:SetAnchor('BOTTOMRIGHT', BrowseScrollFrame, 'BOTTOMRIGHT', 0, 17)

		BrowseCloseButton:SetAnchor('BOTTOMRIGHT', 66, 8)
		BrowseBuyoutButton:SetAnchor('RIGHT', BrowseCloseButton, 'LEFT', -4, 0)
		BrowseBidButton:SetAnchor('RIGHT', BrowseBuyoutButton, 'LEFT', -4, 0)

		BrowseBidPrice:SetAnchor('BOTTOM', -15, 14)
		BrowseBidText:SetAnchor('BOTTOMRIGHT', AuctionFrameBrowse, 'BOTTOM', -116, 12)

		BrowseBidPriceGold:SetAnchor('TOPLEFT', 0, -3)
		BrowseBidPriceSilver:Width(35)
		BrowseBidPriceCopper:Width(35)

		BrowseMaxLevel:SetAnchor('LEFT', BrowseMinLevel, 'RIGHT', 8, 0)
		BrowseLevelText:SetAnchor('BOTTOMLEFT', AuctionFrameBrowse, 'TOPLEFT', 195, -48)

		BrowseName:Width(164)
		BrowseName:SetAnchor('TOPLEFT', AuctionFrameBrowse, 'TOPLEFT', 20, -54)
		BrowseNameText:SetAnchor('TOPLEFT', BrowseName, 'TOPLEFT', 0, 16)

		BrowseResetButton:Width(82)
		BrowseResetButton:SetAnchor('TOPLEFT', AuctionFrameBrowse, 'TOPLEFT', 20, -74)

		BrowseSearchButton:ClearAllPoints()
		BrowseSearchButton:SetAnchor('TOPRIGHT', AuctionFrameBrowse, 'TOPRIGHT', 25, -30)

		BrowseNextPageButton:ButtonNextRight()
		BrowseNextPageButton:ClearAllPoints()
		BrowseNextPageButton:SetAnchor('BOTTOMLEFT', BrowseSearchButton, 'BOTTOMRIGHT', 10, -27)

		BrowsePrevPageButton:ButtonPrevLeft()
		BrowsePrevPageButton:ClearAllPoints()
		BrowsePrevPageButton:SetAnchor('BOTTOMRIGHT', BrowseSearchButton, 'BOTTOMLEFT', -10, -27)

		IsUsableCheckButton:ClearAllPoints()
		IsUsableCheckButton:SetAnchor('RIGHT', BrowseIsUsableText, 'LEFT', 2, 0)
		BrowseIsUsableText:SetAnchor('TOPLEFT', 440, -40)

		ShowOnPlayerCheckButton:ClearAllPoints()
		ShowOnPlayerCheckButton:SetAnchor('RIGHT', BrowseShowOnCharacterText, 'LEFT', 2, 0)

		BrowseShowOnCharacterText:SetAnchor('TOPLEFT', 440, -60)

		-- Bid Frame
		BidTitle:SetAnchor('TOP', 25, -18)

		BidScrollFrame:StripLayout()
		BidScrollFrame:Height(332)

		BidScrollFrameScrollBar:ShortBar()
		BidScrollFrameScrollBar:ClearAllPoints()
		BidScrollFrameScrollBar:SetAnchor('TOPRIGHT', BidScrollFrame, 'TOPRIGHT', 23, -17)
		BidScrollFrameScrollBar:SetAnchor('BOTTOMRIGHT', BidScrollFrame, 'BOTTOMRIGHT', 0, 12)

		BidCloseButton:SetAnchor('BOTTOMRIGHT', 66, 8)
		BidBuyoutButton:SetAnchor('RIGHT', BidCloseButton, 'LEFT', -4, 0)
		BidBidButton:SetAnchor('RIGHT', BidBuyoutButton, 'LEFT', -4, 0)

		BidBidPrice:SetAnchor('BOTTOM', -15, 14)
		BidBidText:SetAnchor('BOTTOMRIGHT', AuctionFrameBid, 'BOTTOM', -115, 12)

		BidBidPriceGold:SetAnchor('TOPLEFT', 0, -3)
		BidBidPriceSilver:Width(35)
		BidBidPriceCopper:Width(35)

		-- Auctions Frame
		AuctionsTitle:SetAnchor('TOP', 25, -18)

		AuctionsScrollFrame:StripLayout()

		AuctionsScrollFrameScrollBar:ShortBar()
		AuctionsScrollFrameScrollBar:ClearAllPoints()
		AuctionsScrollFrameScrollBar:SetAnchor('TOPRIGHT', AuctionsScrollFrame, 'TOPRIGHT', 23, -19)
		AuctionsScrollFrameScrollBar:SetAnchor('BOTTOMRIGHT', AuctionsScrollFrame, 'BOTTOMRIGHT', 0, 17)

		AuctionsCloseButton:SetAnchor('BOTTOMRIGHT', 66, 8)
		AuctionsCancelAuctionButton:SetAnchor('RIGHT', AuctionsCloseButton, 'LEFT', -4, 0)
		AuctionsCreateAuctionButton:SetAnchor('BOTTOMLEFT', 18, 38)

		AuctionsItemButton:StripLayout()
		--AuctionsItemButton:SetTemplate('Default', true)
		AuctionsItemButton:StyleButton(nil, true)

		StartPriceSilver:Width(35)
		StartPriceCopper:Width(35)

		BuyoutPriceSilver:Width(35)
		BuyoutPriceCopper:Width(35)

		AuctionsItemButton:Hook('OnEvent', function(self, event)
			if (event == 'NEW_AUCTION_UPDATE') and self:GetNormalTexture() then
				self:GetNormalTexture():SetTexCoord(unpack(unpack(E.TexCoords)))
				self:GetNormalTexture():SetInside()

				local _, _, _, quality = GetAuctionSellItemInfo()
				if quality then
					self:SetBackdropBorderColor(GetItemQualityColor(quality))
					AuctionsItemButtonName:SetTextColor(GetItemQualityColor(quality))
				else
					self:SetBackdropBorderColor(unpack(A.bordercolor))
					AuctionsItemButtonName:SetTextColor(1, 1, 1)
				end
			else
				self:SetBackdropBorderColor(unpack(A.bordercolor))
				AuctionsItemButtonName:SetTextColor(1, 1, 1)
			end
		end);

		for Frame, NumButtons in pairs({['Browse'] = NUM_BROWSE_TO_DISPLAY, ['Auctions'] = NUM_AUCTIONS_TO_DISPLAY, ['Bid'] = NUM_BIDS_TO_DISPLAY}) do
			for i = 1, NumButtons do
				local Button = _G[Frame..'Button'..i]
				local ItemButton = _G[Frame..'Button'..i..'Item']
				local Texture = _G[Frame..'Button'..i..'ItemIconTexture']
				local Name = _G[Frame..'Button'..i..'Name']

				if Button then
					Button:StripLayout()
					ET:HandleButtonHighlight(Button)
				end

				if ItemButton then
					--ItemButton:SetTemplate()
					ItemButton:StyleButton()
					ItemButton:GetNormalTexture():SetTexture''
					ItemButton:SetAnchor('TOPLEFT', 0, -1)
					ItemButton:SetSize(34)

					Texture:SetTexCoord(unpack(E.TexCoords))
					Texture:SetInside()

					hooksecurefunc(Name, 'SetVertexColor', function(_, r, g, b) ItemButton:SetBackdropBorderColor(r, g, b) end);
					hooksecurefunc(Name, 'Hide', function() ItemButton:SetBackdropBorderColor(unpack(A.bordercolor)) end);
				end
			end
		end

		-- Custom Backdrops
		for _, Frame in pairs({AuctionFrameBrowse, AuctionFrameAuctions}) do
			Frame.LeftBackground = CreateFrame('frame', nil, Frame)
			--Frame.LeftBackground:SetTemplate('Transparent')
			Frame.LeftBackground:SetFrameLevel(Frame:GetFrameLevel() - 2)

			Frame.RightBackground = CreateFrame('frame', nil, Frame)
			--Frame.RightBackground:SetTemplate('Transparent')
			Frame.RightBackground:SetFrameLevel(Frame:GetFrameLevel() - 2)
		end

		AuctionFrameAuctions.LeftBackground:SetAnchor('TOPLEFT', 15, -72)
		AuctionFrameAuctions.LeftBackground:SetAnchor('BOTTOMRIGHT', -545, 34)

		AuctionFrameAuctions.RightBackground:SetAnchor('TOPLEFT', AuctionFrameAuctions.LeftBackground, 'TOPRIGHT', 3, 0)
		AuctionFrameAuctions.RightBackground:SetAnchor('BOTTOMRIGHT', AuctionFrame, -8, 42)

		AuctionFrameBrowse.LeftBackground:SetAnchor('TOPLEFT', 20, -103)
		AuctionFrameBrowse.LeftBackground:SetAnchor('BOTTOMRIGHT', -575, 34)

		AuctionFrameBrowse.RightBackground:SetAnchor('TOPLEFT', AuctionFrameBrowse.LeftBackground, 'TOPRIGHT', 4, 0)
		AuctionFrameBrowse.RightBackground:SetAnchor('BOTTOMRIGHT', AuctionFrame, 'BOTTOMRIGHT', -8, 42)

		AuctionFrameBid.Background = CreateFrame('frame', nil, AuctionFrameBid)
		AuctionFrameBid.Background:SetAnchor('TOPLEFT', 22, -72)
		AuctionFrameBid.Background:SetAnchor('BOTTOMRIGHT', 66, 34)
		AuctionFrameBid.Background:SetFrameLevel(AuctionFrameBid:GetFrameLevel() -2)
	end

	ET['Blizzard_AuctionUI'] = LoadSkin