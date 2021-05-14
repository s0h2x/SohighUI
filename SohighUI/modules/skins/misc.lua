
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack, select = unpack, select

	local GetLocale = GetLocale
	local UnitIsUnit = UnitIsUnit
	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()

		--* ESC/Menu Buttons
		GameMenuFrame:StripLayout()
		GameMenuFrame:SetLayout()
		GameMenuFrame:SetShadow()
		--GameMenuFrame:Height(285)

		GameMenuFrameHeader:ClearAllPoints()
		GameMenuFrameHeader:SetAnchor('TOP', GameMenuFrame, 0, 7)

		local BlizzardMenuButtons = {
			'Options',
			'UIOptions',
			'Keybindings',
			'Macros',
			'AddOns',
			'SoundOptions',
			'Logout',
			'Quit',
			'Continue',
			'MoveAnything',
		}
		
		for i = 1, #BlizzardMenuButtons do
			local MenuButtons = _G['GameMenuButton'..BlizzardMenuButtons[i]]
			if MenuButtons then
				--*ET:HandleButton(MenuButtons)
				--*MenuButtons:SetAnchor('TOP', GameMenuFrame, 0, -30+(off))
				MenuButtons:StripLayout()
				MenuButtons:SetLayout()
				ET:HandleButtonHighlight(MenuButtons)
				--*off = off -27
			end
		end
		
		--* fix for moveanything button point
		if IsAddOnLoaded('MoveAnything') then
			function GameMenu_AddButton(button)
				if(GameMenu_InsertAfter == nil) then
					GameMenu_InsertAfter = GameMenuButtonExit;
				end
				if(GameMenu_InsertBefore == nil) then
					GameMenu_InsertBefore = GameMenuButtonReturn;
				end
				
				local button = GameMenu_InsertAfter
				button:ClearAllPoints();
				button:SetAnchor('CENTER', GameMenuButtonExit, 'CENTER', 0, -110);
				GameMenuFrame:Height(GameMenuFrame:GetHeight());
			end
			if (GameMenuButtonAddOns) then
				GameMenu_AddButton(button);
			end
		end

		--[[if E.isMacClient then
			ET:HandleButton(GameMenuButtonMacOptions)
		end-]]

		--* Static Popups
		for i = 1, 4 do
			local staticPopup = _G['StaticPopup'..i]
			local itemFrame = _G['StaticPopup'..i..'ItemFrame']
			local itemFrameBox = _G['StaticPopup'..i..'EditBox']
			local itemFrameTexture = _G['StaticPopup'..i..'ItemFrameIconTexture']
			local itemFrameNormal = _G['StaticPopup'..i..'ItemFrameNormalTexture']
			local itemFrameName = _G['StaticPopup'..i..'ItemFrameNameFrame']
			local closeButton = _G['StaticPopup'..i..'CloseButton']
			local wideBox = _G['StaticPopup'..i..'WideEditBox']

			--*staticPopup:SetLayout()
			staticPopup:SetShadow()
			staticPopup.shadow:SetAnchor('TOPLEFT', 5, -5)
			staticPopup.shadow:SetAnchor('BOTTOMRIGHT', -5, 5)

			ET:HandleEditBox(itemFrameBox)
			itemFrameBox.bg:SetAnchor('TOPLEFT', -2, -4)
			itemFrameBox.bg:SetAnchor('BOTTOMRIGHT', 2, 4)

			ET:HandleEditBox(_G['StaticPopup'..i..'MoneyInputFrameGold'])
			ET:HandleEditBox(_G['StaticPopup'..i..'MoneyInputFrameSilver'])
			ET:HandleEditBox(_G['StaticPopup'..i..'MoneyInputFrameCopper'])

			for k = 1, itemFrameBox:GetNumRegions() do
				local region = select(k, itemFrameBox:GetRegions())
				if region and region:GetObjectType() == 'Texture' then
					if region:GetTexture() == 'Interface\\ChatFrame\\UI-ChatInputBorder-Left' or region:GetTexture() == 'Interface\\ChatFrame\\UI-ChatInputBorder-Right' then
						region:dummy()
					end
				end
			end

			closeButton:StripLayout()
			closeButton:CloseTemplate()

			itemFrame:GetNormalTexture():dummy()
			itemFrame:SetLayout()
			itemFrame:StyleButton()

			hooksecurefunc('StaticPopup_Show', function(which, _, _, data)
				local info = StaticPopupDialogs[which]
				if not info then return nil end

				if info.hasItemFrame then
					if data and type(data) == 'table' then
						itemFrame:SetBackdropBorderColor(unpack(data.color or {1, 1, 1, 1}))
					end
				end
			end);

			itemFrameTexture:SetTexCoord(unpack(E.TexCoords))
			itemFrameTexture:SetInside()

			itemFrameNormal:SetAlpha(0)
			itemFrameName:dummy()

			select(8, wideBox:GetRegions()):Hide()
			ET:HandleEditBox(wideBox)
			wideBox:Height(22)

			for j = 1, 3 do
				ET:HandleButton(_G['StaticPopup'..i..'Button'..j])
			end
		end

		--* Ready Check Frame
		ReadyCheckPortrait:dummy()

		ReadyCheckFrame:StripLayout()
		ReadyCheckFrame:SetLayout()
		ReadyCheckFrame:SetSize(290, 85)

		ET:HandleButton(ReadyCheckFrameYesButton)
		ReadyCheckFrameYesButton:ClearAllPoints()
		ReadyCheckFrameYesButton:SetAnchor('LEFT', ReadyCheckFrame, 15, -20)
		ReadyCheckFrameYesButton:SetParent(ReadyCheckFrame)

		ET:HandleButton(ReadyCheckFrameNoButton)
		ReadyCheckFrameNoButton:ClearAllPoints()
		ReadyCheckFrameNoButton:SetAnchor('RIGHT', ReadyCheckFrame, -15, -20)
		ReadyCheckFrameNoButton:SetParent(ReadyCheckFrame)

		ReadyCheckFrameText:ClearAllPoints()
		ReadyCheckFrameText:SetAnchor('TOP', 0, -15)
		ReadyCheckFrameText:SetParent(ReadyCheckFrame)
		ReadyCheckFrameText:SetTextColor(1, 1, 1)

		ReadyCheckFrame:HookScript('OnShow', function(self) --* bug fix, don't show it if initiator
			if UnitIsUnit('player', self.initiator) then
				self:Hide()
			end
		end)

		--* Coin PickUp Frame
		CoinPickupFrame:StripLayout()
		CoinPickupFrame:SetLayout()

		ET:HandleButton(CoinPickupOkayButton)
		ET:HandleButton(CoinPickupCancelButton)

		--* Zone Text Frame
		ZoneTextFrame:ClearAllPoints()
		ZoneTextFrame:SetAnchor('TOP', UIParent, 0, -128)

		--* Stack Split Frame
		StackSplitFrame:SetLayout()
		StackSplitFrame:GetRegions():Hide()
		StackSplitFrame:SetFrameStrata('DIALOG')

		StackSplitFrame.bg1 = CreateFrame('Frame', nil, StackSplitFrame)
		StackSplitFrame.bg1:SetLayout()
		StackSplitFrame.bg1:SetAnchor('TOPLEFT', 10, -15)
		StackSplitFrame.bg1:SetAnchor('BOTTOMRIGHT', -10, 55)
		StackSplitFrame.bg1:SetFrameLevel(StackSplitFrame.bg1:GetFrameLevel() - 1)

		ET:HandleButton(StackSplitOkayButton)
		ET:HandleButton(StackSplitCancelButton)

		--* Opacity Frame
		OpacityFrame:StripLayout()
		OpacityFrame:SetLayout()

		--* Declension Frame
		if GetLocale() == 'ruRU' then
			DeclensionFrame:SetLayout()

			DeclensionFrameSetPrev:ButtonPrevLeft()
			DeclensionFrameSetNext:ButtonNextRight()
			ET:HandleButton(DeclensionFrameOkayButton)
			ET:HandleButton(DeclensionFrameCancelButton)

			for i = 1, RUSSIAN_DECLENSION_PATTERNS do
				local editBox = _G['DeclensionFrameDeclension'..i..'Edit']
				if editBox then
					editBox:StripLayout()
					ET:HandleEditBox(editBox)
				end
			end
		end

		--* Rating Menu Frame
		if GetLocale() == 'koKR' then
			ET:HandleButton(GameMenuButtonRatings)

			RatingMenuFrame:SetLayout()
			RatingMenuFrameHeader:dummy()
			ET:HandleButton(RatingMenuButtonOkay)
		end

		--* Channel Pullout Frame
		ChannelPullout:SetLayout()

		ChannelPulloutBackground:dummy()

		ChannelPulloutTab:SetSize(107, 26)
		ChannelPulloutTabText:SetAnchor('LEFT', ChannelPulloutTabLeft, 'RIGHT', 0, 4)

		ChannelPulloutCloseButton:CloseTemplate()
		ChannelPulloutCloseButton:SetSize(32)

		--* Ticket Frame
		local ticketBG = select(2, TicketStatusFrame:GetChildren())
		ticketBG:SetLayout()

		TicketStatusFrameButton:StripLayout()
		TicketStatusFrameButton:SetLayout()
		TicketStatusFrameButton:SetAnchor('TOPRIGHT', -3, -5)

		TicketStatusFrameButton.tex = TicketStatusFrameButton:CreateTexture(nil, 'ARTWORK')
		TicketStatusFrameButton.tex:SetTexture('Interface\\Icons\\INV_Scroll_09')
		TicketStatusFrameButton.tex:SetTexCoord(unpack(E.TexCoords))
		TicketStatusFrameButton.tex:SetInside()

		--* Quest Timers
		QuestTimerFrame:StripLayout()

		QuestTimerHeader:SetAnchor('TOP', 0, 8)

		--* dropdown menu
		hooksecurefunc('UIDropDownMenu_Initialize', function()
			for i = 1, UIDROPDOWNMENU_MAXLEVELS do
				local dropBackdrop = _G['DropDownList'..i..'Backdrop']
				local dropMenuBackdrop = _G['DropDownList'..i..'MenuBackdrop']
				
				dropBackdrop:SetBackdrop(nil)
				dropMenuBackdrop:SetBackdrop(nil)
				dropBackdrop:SetLayout()
				dropMenuBackdrop:SetLayout()
				
				dropBackdrop:SetShadow()
				dropMenuBackdrop:SetShadow()

				for j = 1, UIDROPDOWNMENU_MAXBUTTONS do
					local button = _G['DropDownList'..i..'Button'..j]
					local highlight = _G['DropDownList'..i..'Button'..j..'Highlight']
					local normalText = _G['DropDownList'..i..'Button'..j..'NormalText']
					local colorSwatch = _G['DropDownList'..i..'Button'..j..'ColorSwatch']

					button:SetFrameLevel(dropBackdrop:GetFrameLevel() + 1)
					highlight:SetTexture(1, 1, 1, 0.3)
					normalText:SetFont(A.font, 14)
				end
			end
		end);

		--* Chat Menu
		local ChatMenus = {
			'ChatMenu',
			'EmoteMenu',
			'LanguageMenu',
			'VoiceMacroMenu',
		}

		for i = 1, #ChatMenus do
			if _G[ChatMenus[i]] == _G['ChatMenu'] then
				_G[ChatMenus[i]]:HookScript('OnShow', function(self)
					self:SetBackdrop(nil)
					self:SetLayout()
				end)
			else
				_G[ChatMenus[i]]:HookScript('OnShow', function(self)
					self:SetBackdrop(nil)
					self:SetLayout()
				end)
			end
		end

		for i = 1, 32 do
			ET:HandleButtonHighlight(_G['ChatMenuButton'..i])
			ET:HandleButtonHighlight(_G['EmoteMenuButton'..i])
			ET:HandleButtonHighlight(_G['LanguageMenuButton'..i])
			ET:HandleButtonHighlight(_G['VoiceMacroMenuButton'..i])
		end
	end

	table.insert(ET['SohighUI'], LoadSkin)