
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack, select = unpack, select

	local hooksecurefunc = hooksecurefunc
	local GetInboxItem = GetInboxItem
	local GetInboxItemLink = GetInboxItemLink
	local GetItemQualityColor = GetItemQualityColor
	local GetSendMailItem = GetSendMailItem
	local ATTACHMENTS_MAX_RECEIVE = ATTACHMENTS_MAX_RECEIVE
	local ATTACHMENTS_MAX_SEND = ATTACHMENTS_MAX_SEND
	local INBOXITEMS_TO_DISPLAY = INBOXITEMS_TO_DISPLAY

	local function LoadSkin()
	
		--* Inbox Frame
		local MailFrame = _G['MailFrame']
		MailFrame:StripLayout(true)
		MailFrame:SetLayout()
		MailFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		MailFrame.bg:SetAnchor('BOTTOMRIGHT', -30, 74)
		
		MailFrame:SetShadow()
		MailFrame.shadow:SetAnchor('TOPLEFT', 8, -10)
		MailFrame.shadow:SetAnchor('BOTTOMRIGHT', -26, 70)

		MailFrame:EnableMouseWheel(true)
		MailFrame:SetScript('OnMouseWheel', function(_, value)
			if value > 0 then
				if InboxPrevPageButton:IsEnabled() == 1 then
					InboxPrevPage()
				end
			else
				if InboxNextPageButton:IsEnabled() == 1 then
					InboxNextPage()
				end
			end
		end)

		for i = 1, INBOXITEMS_TO_DISPLAY do
			local mail = _G['MailItem'..i]
			local button = _G['MailItem'..i..'Button']
			local icon = _G['MailItem'..i..'ButtonIcon']

			mail:StripLayout()
			mail:SetLayout()
			mail.bg:SetAnchor('TOPLEFT', 2, 1)
			mail.bg:SetAnchor('BOTTOMRIGHT', -2, 2)

			button:StripLayout()
			--button:SetTemplate('Default', true)
			--button:StyleButton()

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetInside()
		end

		hooksecurefunc('InboxFrame_Update', function()
			local numItems = GetInboxNumItems()
			local index = ((InboxFrame.pageNum - 1) * INBOXITEMS_TO_DISPLAY) + 1

			for i = 1, INBOXITEMS_TO_DISPLAY do
				if index <= numItems then
					local packageIcon, _, _, _, _, _, _, _, _, _, _, _, isGM = GetInboxHeaderInfo(index)
					local button = _G['MailItem'..i..'Button']

					button:SetBackdropBorderColor(unpack(A.borderColor))
					if packageIcon and not isGM then
						local ItemLink = GetInboxItemLink(index, 1)

						if ItemLink then
							local quality = select(3, GetItemInfo(ItemLink))

							if quality then
								button:SetBackdropBorderColor(GetItemQualityColor(quality))
							else
								button:SetBackdropBorderColor(unpack(A.borderColor))
							end
						end
					elseif isGM then
						button:SetBackdropBorderColor(0, 0.56, 0.94)
					end
				end

				index = index + 1
			end
		end)

		InboxPrevPageButton:ButtonPrevLeft()
		InboxPrevPageButton:SetAnchor('CENTER', InboxFrame, 'BOTTOMLEFT', 42, 104)

		InboxNextPageButton:ButtonNextRight()
		InboxNextPageButton:SetAnchor('CENTER', InboxFrame, 'BOTTOMLEFT', 318, 104)

		InboxCloseButton:CloseTemplate()

		for i = 1, 2 do
			local tab = _G['MailFrameTab'..i]

			tab:StripLayout()
			tab:SetLayout()
			
			tab.bg:SetAnchor('TOPLEFT', -1, -5)
			tab.bg:SetAnchor('BOTTOMRIGHT', -20, -1)
			
			tab:SetGradient()
			tab.gr:SetAllPoints(tab.bg)
			
			_G['MailFrameTab'..i..'Text']:SetAnchor('TOPLEFT', 10, -14)
		end

		-- Send Mail Frame
		SendMailFrame:StripLayout()

		SendMailScrollFrame:StripLayout(true)
		SendMailScrollFrame:SetLayout()

		hooksecurefunc('SendMailFrame_Update', function()
			for i = 1, ATTACHMENTS_MAX_SEND do
				local button = _G['SendMailAttachment'..i]
				local texture = button:GetNormalTexture()
				local itemName = GetSendMailItem(i)

				if not button.skinned then
					button:StripLayout()
					button:SetLayout()
					--button:StyleButton(nil, true)

					button.skinned = true
				end

				if itemName then
					local quality = select(3, GetItemInfo(itemName))

					if quality then
						button:SetBackdropBorderColor(GetItemQualityColor(quality))
					else
						button:SetBackdropBorderColor(unpack(A.borderColor))
					end

					texture:SetTexCoord(unpack(E.TexCoords))
					texture:SetInside()
				else
					button:SetBackdropBorderColor(unpack(A.borderColor))
				end
			end
		end)

		SendMailBodyEditBox:SetTextColor(1, 1, 1)

		SendMailScrollFrameScrollBar:ShortBar()

		ET:HandleEditBox(SendMailNameEditBox)
		--SendMailNameEditBox.backdrop:SetAnchor('BOTTOMRIGHT', 2, 0)
		SendMailNameEditBox:SetAnchor('TOPLEFT', 79, -46)

		ET:HandleEditBox(SendMailSubjectEditBox)
		--SendMailSubjectEditBox.backdrop:SetAnchor('BOTTOMRIGHT', 2, 0)

		ET:HandleEditBox(SendMailMoneyGold)
		ET:HandleEditBox(SendMailMoneySilver)
		ET:HandleEditBox(SendMailMoneyCopper)

		ET:HandleButton(SendMailMailButton)
		SendMailMailButton:SetAnchor('RIGHT', SendMailCancelButton, 'LEFT', -2, 0)

		ET:HandleButton(SendMailCancelButton)
		SendMailCancelButton:SetAnchor('BOTTOMRIGHT', -45, 80)

		SendMailMoneyFrame:SetAnchor('BOTTOMLEFT', 170, 84)

		-- Open Mail Frame
		OpenMailFrame:StripLayout(true)
		OpenMailFrame:SetLayout()
		OpenMailFrame.bg:SetAnchor('TOPLEFT', 12, -12)
		OpenMailFrame.bg:SetAnchor('BOTTOMRIGHT', -34, 74)

		for i = 1, ATTACHMENTS_MAX_SEND do
			local button = _G['OpenMailAttachmentButton'..i]
			local icon = _G['OpenMailAttachmentButton'..i..'IconTexture']
			local count = _G['OpenMailAttachmentButton'..i..'Count']

			button:StripLayout()
			button:SetLayout()
			--button:StyleButton()

			if icon then
				icon:SetTexCoord(unpack(E.TexCoords))
				icon:SetDrawLayer('ARTWORK')
				icon:SetInside()

				count:SetDrawLayer('OVERLAY')
			end
		end

		hooksecurefunc('OpenMailFrame_UpdateButtonPositions', function()
			for i = 1, ATTACHMENTS_MAX_RECEIVE do
				local ItemLink = GetInboxItemLink(InboxFrame.openMailID, i)
				local button = _G['OpenMailAttachmentButton'..i]

				button:SetBackdropBorderColor(unpack(A.borderColor))
				if ItemLink then
					local quality = select(3, GetItemInfo(ItemLink))

					if quality then
						button:SetBackdropBorderColor(GetItemQualityColor(quality))
					else
						button:SetBackdropBorderColor(unpack(A.borderColor))
					end
				end
			end
		end)

		OpenMailCloseButton:CloseTemplate()

		ET:HandleButton(OpenMailReportSpamButton)

		ET:HandleButton(OpenMailReplyButton)
		OpenMailReplyButton:SetAnchor('RIGHT', OpenMailDeleteButton, 'LEFT', -2, 0)

		ET:HandleButton(OpenMailDeleteButton)
		OpenMailDeleteButton:SetAnchor('RIGHT', OpenMailCancelButton, 'LEFT', -2, 0)

		ET:HandleButton(OpenMailCancelButton)

		OpenMailScrollFrame:StripLayout(true)
		OpenMailScrollFrame:SetLayout()

		OpenMailScrollFrameScrollBar:ShortBar()

		OpenMailBodyText:SetTextColor(1, 1, 1)
		InvoiceTextFontNormal:SetTextColor(1, 1, 1)
		OpenMailInvoiceBuyMode:SetTextColor(1, 0.80, 0.10)

		OpenMailArithmeticLine:dummy()

		OpenMailLetterButton:StripLayout()
		OpenMailLetterButton:SetLayout()
		--OpenMailLetterButton:StyleButton()

		OpenMailLetterButtonIconTexture:SetTexCoord(unpack(E.TexCoords))
		OpenMailLetterButtonIconTexture:SetDrawLayer('ARTWORK')
		OpenMailLetterButtonIconTexture:SetInside()

		OpenMailLetterButtonCount:SetDrawLayer('OVERLAY')

		OpenMailMoneyButton:StripLayout()
		OpenMailMoneyButton:SetLayout()
		--OpenMailMoneyButton:StyleButton()

		OpenMailMoneyButtonIconTexture:SetTexCoord(unpack(E.TexCoords))
		OpenMailMoneyButtonIconTexture:SetDrawLayer('ARTWORK')
		OpenMailMoneyButtonIconTexture:SetInside()

		OpenMailMoneyButtonCount:SetDrawLayer('OVERLAY')
	end

	table.insert(ET['SohighUI'], LoadSkin)