	
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end
	
	local _G = _G
	local unpack = unpack

	local hooksecurefunc = hooksecurefunc
	local GetWhoInfo = GetWhoInfo
	local GetGuildRosterInfo = GetGuildRosterInfo
	local GUILDMEMBERS_TO_DISPLAY = GUILDMEMBERS_TO_DISPLAY
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS

	local function LoadSkin()
	
		--* friends
		FriendsFrame:StripLayout(true)
		FriendsFrame:SetLayout()
		FriendsFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		FriendsFrame.bg:SetAnchor('BOTTOMRIGHT', -33, 76)
		
		FriendsFrame:SetShadow()
		FriendsFrame.shadow:SetAnchor('TOPLEFT', 6, -10)
		FriendsFrame.shadow:SetAnchor('BOTTOMRIGHT', -29, 72)

		FriendsFrameCloseButton:CloseTemplate()

		for i = 1, 5 do
			local tab = _G['FriendsFrameTab'..i]
			tab:StripLayout()
			tab:SetLayout()
			
			tab.bg:SetAnchor('TOPLEFT', 10, -4)
			tab.bg:SetAnchor('BOTTOMRIGHT', -7, -1)
			
			tab:SetGradient()
			tab.gr:SetAllPoints(tab.bg)
			
			--tab.shadow:SetAnchor('TOPLEFT', 7, -2)
			--tab.shadow:SetAnchor('BOTTOMRIGHT', -3, -3)
			
			_G['FriendsFrameTab'..i..'Text']:SetAnchor('TOPLEFT', 21, -12)
		end

		--* friends list frame
		for i = 1, 3 do
			local Tab = _G['FriendsFrameToggleTab'..i]
			Tab:StripLayout()
			Tab:SetLayout()
			
			Tab.bg:SetAnchor('TOPLEFT', 3, -7)
			Tab.bg:SetAnchor('BOTTOMRIGHT', -2, -1)
			
		end

		for i = 1, 10 do
			ET:HandleButtonHighlight(_G['FriendsFrameFriendButton'..i])
		end

		FriendsFrameFriendsScrollFrame:StripLayout()
		FriendsFrameFriendsScrollFrameScrollBar:ShortBar()

		ET:HandleButton(FriendsFrameAddFriendButton)
		--FriendsFrameAddFriendButton:SetLayout()
		FriendsFrameAddFriendButton:SetAnchor('BOTTOMLEFT', 17, 102)

		ET:HandleButton(FriendsFrameSendMessageButton)

		ET:HandleButton(FriendsFrameRemoveFriendButton)
		FriendsFrameRemoveFriendButton:SetAnchor('TOP', FriendsFrameAddFriendButton, 'BOTTOM', 0, -2)

		ET:HandleButton(FriendsFrameGroupInviteButton)
		FriendsFrameGroupInviteButton:SetAnchor('TOP', FriendsFrameSendMessageButton, 'BOTTOM', 0, -2)

		--* ignore
		FriendsFrameIgnoreScrollFrame:StripLayout()
		FriendsFrameIgnoreScrollFrameScrollBar:ShortBar()

		for i = 1, 2 do
			local Tab = _G['IgnoreFrameToggleTab'..i]
			Tab:StripLayout()
			Tab:SetLayout()
			Tab.bg:SetAnchor('TOPLEFT', 3, -7)
			Tab.bg:SetAnchor('BOTTOMRIGHT', -2, -1)

			--Tab:HookScript2('OnEnter', S.SetModifiedBackdrop)
			--Tab:HookScript2('OnLeave', S.SetOriginalBackdrop)
		end

		ET:HandleButton(FriendsFrameIgnorePlayerButton)
		ET:HandleButton(FriendsFrameStopIgnoreButton)

		for i = 1, 20 do
			ET:HandleButtonHighlight(_G['FriendsFrameIgnoreButton'..i])
		end

		--* Who Frame
		WhoFrameColumnHeader3:ClearAllPoints()
		WhoFrameColumnHeader3:SetAnchor('TOPLEFT', 20, -70)

		WhoFrameColumnHeader4:ClearAllPoints()
		WhoFrameColumnHeader4:SetAnchor('LEFT', WhoFrameColumnHeader3, 'RIGHT', -2, -0)
		WhoFrameColumnHeader4:Width(48)

		WhoFrameColumnHeader1:ClearAllPoints()
		WhoFrameColumnHeader1:SetAnchor('LEFT', WhoFrameColumnHeader4, 'RIGHT', -2, -0)
		WhoFrameColumnHeader1:Width(105)

		WhoFrameColumnHeader2:ClearAllPoints()
		WhoFrameColumnHeader2:SetAnchor('LEFT', WhoFrameColumnHeader1, 'RIGHT', -2, -0)

		for i = 1, 4 do
			_G['WhoFrameColumnHeader'..i]:StripLayout()
			--ET:HandleButton(_G['WhoFrameColumnHeader'..i])
		end

		--S:HandleDropDownBox(WhoFrameDropDown)

		for i = 1, 17 do
			local button = _G['WhoFrameButton'..i]
			local level = _G['WhoFrameButton'..i..'Level']
			local name = _G['WhoFrameButton'..i..'Name']

			button.icon = button:CreateTexture('$parentIcon', 'ARTWORK')
			button.icon:SetAnchor('LEFT', 45, 0)
			button.icon:SetSize(15)
			button.icon:SetTexture('Interface\\WorldStateFrame\\Icons-Classes')

			button:SetLayout()
			button.bg:SetAllPoints(button.icon)
			ET:HandleButtonHighlight(button)

			level:ClearAllPoints()
			level:SetAnchor('TOPLEFT', 12, -2)

			name:SetSize(100, 14)
			name:ClearAllPoints()
			name:SetAnchor('LEFT', 85, 0)

			_G['WhoFrameButton'..i..'Class']:Hide()
		end

		WhoListScrollFrame:StripLayout()
		WhoListScrollFrameScrollBar:ShortBar()

		ET:HandleEditBox(WhoFrameEditBox)
		WhoFrameEditBox:SetAnchor('BOTTOMLEFT', 17, 108)
		WhoFrameEditBox:SetSize(326, 18)

		ET:HandleButton(WhoFrameWhoButton)
		WhoFrameWhoButton:ClearAllPoints()
		WhoFrameWhoButton:SetAnchor('BOTTOMLEFT', 16, 82)

		ET:HandleButton(WhoFrameAddFriendButton)
		WhoFrameAddFriendButton:SetAnchor('LEFT', WhoFrameWhoButton, 'RIGHT', 3, 0)
		WhoFrameAddFriendButton:SetAnchor('RIGHT', WhoFrameGroupInviteButton, 'LEFT', -3, 0)

		ET:HandleButton(WhoFrameGroupInviteButton)

		hooksecurefunc('WhoList_Update', function()
			local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
			local button, nameText, levelText, classText, variableText
			local _, guild, level, race, zone, classFileName
			local classTextColor, levelTextColor
			local index, columnTable

			local playerZone = GetRealZoneText()
			local playerGuild = GetGuildInfo('player')

			for i = 1, WHOS_TO_DISPLAY, 1 do
				index = whoOffset + i
				button = _G['WhoFrameButton'..i]
				nameText = _G['WhoFrameButton'..i..'Name']
				levelText = _G['WhoFrameButton'..i..'Level']
				classText = _G['WhoFrameButton'..i..'Class']
				variableText = _G['WhoFrameButton'..i..'Variable']

				_, guild, level, race, _, zone, classFileName = GetWhoInfo(index)

				classTextColor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[classFileName] or RAID_CLASS_COLORS[classFileName]
				levelTextColor = E.GetQuestDifficultyColor(level)

				if classFileName then
					button.icon:Show()
					button.icon:SetTexCoord(unpack(M.index.cit[classFileName]))

					nameText:SetTextColor(classTextColor.r, classTextColor.g, classTextColor.b)
					levelText:SetTextColor(levelTextColor.r, levelTextColor.g, levelTextColor.b)

					if zone == playerZone then zone = '|cfffaebd7'..zone end
					if guild == playerGuild then guild = '|cff92f200'..guild end
					if race == E.Race then race = '|cff00ff00'..race end

					columnTable = {zone, guild, race}

					variableText:SetText(columnTable[UIDropDownMenu_GetSelectedID(WhoFrameDropDown)])
				else
					button.icon:Hide()
				end
			end
		end)

		--* Guild Frame
		GuildFrameColumnHeader3:ClearAllPoints()
		GuildFrameColumnHeader3:SetAnchor('TOPLEFT', 20, -70)

		GuildFrameColumnHeader4:ClearAllPoints()
		GuildFrameColumnHeader4:SetAnchor('LEFT', GuildFrameColumnHeader3, 'RIGHT', -2, -0)
		GuildFrameColumnHeader4:Width(48)

		GuildFrameColumnHeader1:ClearAllPoints()
		GuildFrameColumnHeader1:SetAnchor('LEFT', GuildFrameColumnHeader4, 'RIGHT', -2, -0)
		GuildFrameColumnHeader1:Width(105)

		GuildFrameColumnHeader2:ClearAllPoints()
		GuildFrameColumnHeader2:SetAnchor('LEFT', GuildFrameColumnHeader1, 'RIGHT', -2, -0)
		GuildFrameColumnHeader2:Width(127)

		for i = 1, GUILDMEMBERS_TO_DISPLAY do
			local button = _G['GuildFrameButton'..i]
			local name = _G['GuildFrameButton'..i..'Name']
			local level = _G['GuildFrameButton'..i..'Level']

			button.icon = button:CreateTexture('$parentIcon', 'ARTWORK')
			button.icon:SetAnchor('LEFT', 48, 0)
			button.icon:SetSize(15)
			button.icon:SetTexture('Interface\\WorldStateFrame\\Icons-Classes')

			button:SetLayout()
			button.bg:SetAllPoints(button.icon)
			ET:HandleButtonHighlight(button)

			level:ClearAllPoints()
			level:SetAnchor('TOPLEFT', 10, -1)

			name:SetSize(100, 14)
			name:ClearAllPoints()
			name:SetAnchor('LEFT', 85, 0)

			_G['GuildFrameButton'..i..'Class']:Hide()

			ET:HandleButtonHighlight(_G['GuildFrameGuildStatusButton'..i])

			_G['GuildFrameGuildStatusButton'..i..'Name']:SetAnchor('TOPLEFT', 14, 0)
		end

		hooksecurefunc('GuildStatus_Update', function()
			local _, level, zone, online, classFileName
			local button, buttonText, classTextColor, levelTextColor
			local playerZone = GetRealZoneText()

			if FriendsFrame.playerStatusFrame then
				for i = 1, GUILDMEMBERS_TO_DISPLAY, 1 do
					button = _G['GuildFrameButton'..i]
					_, _, _, level, _, zone, _, _, online, _, classFileName = GetGuildRosterInfo(button.guildIndex)

					if classFileName then
						if online then
							classTextColor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[classFileName] or RAID_CLASS_COLORS[classFileName]
							levelTextColor = E.GetQuestDifficultyColor(level)

							buttonText = _G['GuildFrameButton'..i..'Name']
							buttonText:SetTextColor(classTextColor.r, classTextColor.g, classTextColor.b)
							buttonText = _G['GuildFrameButton'..i..'Level']
							buttonText:SetTextColor(levelTextColor.r, levelTextColor.g, levelTextColor.b)
							buttonText = _G['GuildFrameButton'..i..'Zone']

							if (zone == playerZone) then
								buttonText:SetTextColor(0, 1, 0)
							end
						end

						button.icon:SetTexCoord(unpack(M.index.cit[classFileName]))
					end
				end
			else
				for i = 1, GUILDMEMBERS_TO_DISPLAY, 1 do
					button = _G['GuildFrameGuildStatusButton'..i]
					_, _, _, _, _, _, _, _, online, _, classFileName = GetGuildRosterInfo(button.guildIndex)

					if classFileName then
						if online then
							classTextColor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[classFileName] or RAID_CLASS_COLORS[classFileName]
							_G['GuildFrameGuildStatusButton'..i..'Name']:SetTextColor(classTextColor.r, classTextColor.g, classTextColor.b)
							_G['GuildFrameGuildStatusButton'..i..'Online']:SetTextColor(1.0, 1.0, 1.0)
						end
					end
				end
			end
		end)

		GuildFrameLFGFrame:StripLayout()
		GuildFrameLFGFrame:SetLayout()

		ET:HandleCheckBox(GuildFrameLFGButton)

		for i = 1, 4 do
			_G['GuildFrameColumnHeader'..i]:StripLayout()
			--ET:HandleButton(_G['GuildFrameColumnHeader'..i])
			_G['GuildFrameGuildStatusColumnHeader'..i]:StripLayout()
			--ET:HandleButton(_G['GuildFrameGuildStatusColumnHeader'..i])
		end

		GuildListScrollFrame:StripLayout()
		GuildListScrollFrameScrollBar:ShortBar()

		GuildFrameGuildListToggleButton:ButtonNextRight()

		ET:HandleButton(GuildFrameGuildInformationButton)
		ET:HandleButton(GuildFrameAddMemberButton)
		ET:HandleButton(GuildFrameControlButton)

		--* member detail frame
		GuildMemberDetailFrame:StripLayout()
		GuildMemberDetailFrame:SetLayout()
		GuildMemberDetailFrame:SetAnchor('TOPLEFT', GuildFrame, 'TOPRIGHT', -31, -13)

		GuildMemberDetailCloseButton:CloseTemplate()

		ET:HandleButton(GuildMemberRemoveButton)
		GuildMemberRemoveButton:SetAnchor('BOTTOMLEFT', 3, 3)

		ET:HandleButton(GuildMemberGroupInviteButton)
		GuildMemberGroupInviteButton:SetAnchor('LEFT', GuildMemberRemoveButton, 'RIGHT', 13, 0)

		GuildFramePromoteButton:StripLayout()
		GuildFrameDemoteButton:StripLayout()
		
		--GuildFramePromoteButton:ButtonNextRight()
		--GuildFrameDemoteButton:ButtonNextRight()

		GuildFramePromoteButton:SetHitRectInsets(0, 0, 0, 0)
		GuildFrameDemoteButton:SetHitRectInsets(0, 0, 0, 0)
		GuildFrameDemoteButton:SetAnchor('LEFT', GuildFramePromoteButton, 'RIGHT', 2, 0)

		GuildMemberNoteBackground:StripLayout()
		GuildMemberNoteBackground:SetLayout()
		GuildMemberNoteBackground.bg:SetAnchor('TOPLEFT', 0, -2)
		GuildMemberNoteBackground.bg:SetAnchor('BOTTOMRIGHT', 0, -1)

		GuildMemberOfficerNoteBackground:StripLayout()
		GuildMemberOfficerNoteBackground:SetLayout()
		GuildMemberOfficerNoteBackground.bg:SetAnchor('TOPLEFT', 0, -2)
		GuildMemberOfficerNoteBackground.bg:SetAnchor('BOTTOMRIGHT', 0, -1)
		
		GuildFrameNotesLabel:SetAnchor('TOPLEFT', GuildFrame, 'TOPLEFT', 23, -340)
		GuildFrameNotesText:SetAnchor('TOPLEFT', GuildFrameNotesLabel, 'BOTTOMLEFT', 0, -6)
		
		--[[GuildMOTDEditButton:SetLayout()
		GuildMOTDEditButton.bg:SetAnchor('TOPLEFT', -7, 3)
		GuildMOTDEditButton.bg:SetAnchor('BOTTOMRIGHT', 7, -2)
		GuildMOTDEditButton:SetHitRectInsets(-7, -7, -3, -2)-]]
		
		GuildMOTDEditButton:StripLayout(true)

		--* info frame
		GuildInfoFrame:StripLayout()
		GuildInfoFrame:SetLayout()
		GuildInfoFrame.bg:SetAnchor('TOPLEFT', 3, -6)
		GuildInfoFrame.bg:SetAnchor('BOTTOMRIGHT', -2, 3)
		GuildInfoFrame:SetAnchor('TOPLEFT', GuildControlPopupFrame, 'TOPLEFT', 2, 0)

		GuildInfoTextBackground:SetLayout()
		GuildInfoFrameScrollFrameScrollBar:ShortBar()

		GuildInfoCloseButton:CloseTemplate()

		ET:HandleButton(GuildInfoSaveButton)
		GuildInfoSaveButton:SetAnchor('BOTTOMLEFT', 104, 11)

		ET:HandleButton(GuildInfoCancelButton)
		GuildInfoCancelButton:SetAnchor('LEFT', GuildInfoSaveButton, 'RIGHT', 3, 0)

		ET:HandleButton(GuildInfoGuildEventButton)
		GuildInfoGuildEventButton:SetAnchor('RIGHT', GuildInfoSaveButton, 'LEFT', -28, 0)

		--* guildEventLog frame
		GuildEventLogFrame:StripLayout()
		GuildEventLogFrame:SetLayout()
		GuildEventLogFrame.bg:SetAnchor('TOPLEFT', 3, -6)
		GuildEventLogFrame.bg:SetAnchor('BOTTOMRIGHT', -2, 5)
		GuildEventLogFrame:SetAnchor('TOPLEFT', GuildControlPopupFrame, 'TOPLEFT', 2, 0)

		GuildEventFrame:SetLayout()

		GuildEventLogScrollFrameScrollBar:ShortBar()
		GuildEventLogCloseButton:CloseTemplate()

		GuildEventLogCancelButton:SetAnchor('BOTTOMRIGHT', -9, 9)
		ET:HandleButton(GuildEventLogCancelButton)

		--* control frame
		GuildControlPopupFrame:StripLayout()
		GuildControlPopupFrame:SetLayout()
		GuildControlPopupFrame.bg:SetAnchor('TOPLEFT', 3, -6)
		GuildControlPopupFrame.bg:SetAnchor('BOTTOMRIGHT', -27, 27)
		GuildControlPopupFrame:SetAnchor('TOPLEFT', GuildFrame, 'TOPRIGHT', -35, -6)

		--S:HandleDropDownBox(GuildControlPopupFrameDropDown, 185)
		GuildControlPopupFrameDropDownButton:Width(18)

		--[[local function SkinPlusMinus(button, minus)
			button:SetNormalTexture('Interface\\AddOns\\ElvUI\\media\\textures\\PlusMinusButton')
			button.SetNormalTexture = E.noop

			button:SetPushedTexture('Interface\\AddOns\\ElvUI\\media\\textures\\PlusMinusButton')
			button.SetPushedTexture = E.noop

			button:SetHighlightTexture('')
			button.SetHighlightTexture = E.noop

			button:SetDisabledTexture('Interface\\AddOns\\ElvUI\\media\\textures\\PlusMinusButton')
			button.SetDisabledTexture = E.noop
			button:GetDisabledTexture():SetDesaturated(true)

			if minus then
				button:GetNormalTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
				button:GetPushedTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
				button:GetDisabledTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
			else
				button:GetNormalTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
				button:GetPushedTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
				button:GetDisabledTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
			end
		end--]]

		--SkinPlusMinus(GuildControlPopupFrameAddRankButton)
		GuildControlPopupFrameAddRankButton:SetAnchor('LEFT', GuildControlPopupFrameDropDown, 'RIGHT', -5, 3)

		--SkinPlusMinus(GuildControlPopupFrameRemoveRankButton, true)
		GuildControlPopupFrameRemoveRankButton:SetAnchor('LEFT', GuildControlPopupFrameAddRankButton, 'RIGHT', 4, 0)

		ET:HandleEditBox(GuildControlPopupFrameEditBox)
		GuildControlPopupFrameEditBox:SetLayout()
		GuildControlPopupFrameEditBox.bg:SetAnchor('TOPLEFT', 0, -5)
		GuildControlPopupFrameEditBox.bg:SetAnchor('BOTTOMRIGHT', 0, 5)

		for i = 1, 17 do
			local checkbox = _G['GuildControlPopupFrameCheckbox'..i]
			if checkbox then
				ET:HandleCheckBox(checkbox)
			end
		end

		ET:HandleEditBox(GuildControlWithdrawGoldEditBox)
		GuildControlWithdrawGoldEditBox:SetLayout()
		GuildControlWithdrawGoldEditBox.bg:SetAnchor('TOPLEFT', 0, -5)
		GuildControlWithdrawGoldEditBox.bg:SetAnchor('BOTTOMRIGHT', 0, 5)

		for i = 1, MAX_GUILDBANK_TABS do
			local tab = _G['GuildBankTabPermissionsTab'..i]

			tab:StripLayout()
			tab:SetLayout()
			tab.bg:SetAnchor('TOPLEFT', 3, -10)
			tab.bg:SetAnchor('BOTTOMRIGHT', -2, 4)
		end

		GuildControlPopupFrameTabPermissions:SetLayout()

		ET:HandleCheckBox(GuildControlTabPermissionsViewTab)
		ET:HandleCheckBox(GuildControlTabPermissionsDepositItems)
		ET:HandleCheckBox(GuildControlTabPermissionsUpdateText)

		ET:HandleEditBox(GuildControlWithdrawItemsEditBox)
		GuildControlWithdrawItemsEditBox:SetLayout()
		GuildControlWithdrawItemsEditBox.bg:SetAnchor('TOPLEFT', 0, -5)
		GuildControlWithdrawItemsEditBox.bg:SetAnchor('BOTTOMRIGHT', 0, 5)

		ET:HandleButton(GuildControlPopupAcceptButton)
		ET:HandleButton(GuildControlPopupFrameCancelButton)

		--* Channel Frame
		ChannelFrameVerticalBar:dummy()

		ET:HandleCheckBox(ChannelFrameAutoJoinParty)
		ET:HandleCheckBox(ChannelFrameAutoJoinBattleground)

		ET:HandleButton(ChannelFrameNewButton)

		ChannelListScrollFrame:StripLayout()
		ChannelListScrollFrameScrollBar:ShortBar()

		for i = 1, MAX_DISPLAY_CHANNEL_BUTTONS do
			local button = _G['ChannelButton'..i]
			local collapsed = _G['ChannelButton'..i..'Collapsed']

			button:StripLayout()
			ET:HandleButtonHighlight(button)

			collapsed:SetTextColor(1, 1, 1)
			collapsed:SetFont(A.font, 22, A.fontStyle)
		end

		for i = 1, 22 do
			ET:HandleButtonHighlight(_G['ChannelMemberButton'..i])
		end

		ChannelRosterScrollFrame:StripLayout()
		ChannelRosterScrollFrameScrollBar:ShortBar()

		ChannelFrameDaughterFrame:StripLayout()
		ChannelFrameDaughterFrame:SetLayout()

		ET:HandleEditBox(ChannelFrameDaughterFrameChannelName)
		ET:HandleEditBox(ChannelFrameDaughterFrameChannelPassword)

		ChannelFrameDaughterFrameDetailCloseButton:CloseTemplate()

		ET:HandleButton(ChannelFrameDaughterFrameCancelButton)
		ET:HandleButton(ChannelFrameDaughterFrameOkayButton)

		--* Raid Frame
		ET:HandleButton(RaidFrameConvertToRaidButton)
		ET:HandleButton(RaidFrameRaidInfoButton)

		--* Raid Info Frame
		RaidInfoFrame:StripLayout()
		RaidInfoFrame:SetLayout()

		RaidInfoFrame:SetScript('OnShow', function()
			if GetNumRaidMembers() > 0 then
				RaidInfoFrame:SetAnchor('TOPLEFT', RaidFrame, 'TOPRIGHT', -14, -12)
			else
				RaidInfoFrame:SetAnchor('TOPLEFT', RaidFrame, 'TOPRIGHT', -34, -12)
			end
		end)

		RaidInfoCloseButton:CloseTemplate()

		RaidInfoScrollFrame:StripLayout()
		RaidInfoScrollFrameScrollBar:ShortBar()
	end

	table.insert(ET['SohighUI'], LoadSkin)