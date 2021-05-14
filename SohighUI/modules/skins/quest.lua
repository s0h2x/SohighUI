
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack, select, pairs = unpack, select, pairs
	local find, format = string.find, string.format
	
	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()

		local QuestStrip = {
			'QuestFrame',
			'QuestLogFrame',
			'QuestLogCount',
			'EmptyQuestLogFrame',
			'QuestFrameDetailPanel',
			'QuestDetailScrollFrame',
			'QuestDetailScrollChildFrame',
			'QuestRewardScrollFrame',
			'QuestRewardScrollChildFrame',
			'QuestRewardItemHighlight',
			'QuestFrameProgressPanel',
			'QuestFrameRewardPanel',
		}

		for _, object in pairs(QuestStrip) do
			_G[object]:StripLayout(true)
		end

		local QuestButtons = {
			'QuestLogFrameAbandonButton',
			'QuestFrameExitButton',
			'QuestFramePushQuestButton',
			'QuestFrameCompleteButton',
			'QuestFrameGoodbyeButton',
			'QuestFrameCompleteQuestButton',
			'QuestFrameCancelButton',
			'QuestFrameAcceptButton',
			'QuestFrameDeclineButton'
		}

		for _, button in pairs(QuestButtons) do
			_G[button]:StripLayout()
			_G[button]:SetGradient()
			--_G[button].gr:SetAllPoints(ET:HandleButton)
			ET:HandleButton(_G[button])
		end

		local questItems = {
			['QuestLogItem'] = MAX_NUM_ITEMS,
			['QuestDetailItem'] = MAX_NUM_ITEMS,
			['QuestRewardItem'] = MAX_NUM_ITEMS,
			['QuestProgressItem'] = MAX_REQUIRED_ITEMS
		}

		for frame, numItems in pairs(questItems) do
			for i = 1, numItems do
				local item  = _G[frame..i]
				local icon  = _G[frame..i..'IconTexture']
				local count = _G[frame..i..'Count']
				local text  = _G[frame..i..'Name']

				item:StripLayout()
				item:SetLayout()
				item.bg:SetAnchor('TOPLEFT', 0, 0)
				item.bg:SetAnchor('BOTTOMRIGHT', -4, -1)
				item:SetSize(143, 40)
				item:SetFrameLevel(item:GetFrameLevel() +2)

				icon:SetParent(item.bg)
				icon:SetSize(34)
				icon:SetDrawLayer('OVERLAY')
				icon:SetAnchor('TOPLEFT', 4, -4)
				icon:SetTexCoord(unpack(E.TexCoords))

				count:SetParent(item.bg)
				count:SetDrawLayer('OVERLAY')
				
				text:SetParent(item.bg)
			end
		end
		
		local questHonorFrames = {
			'QuestLogHonorFrame',
			'QuestDetailHonorFrame',
			'QuestRewardHonorFrame'
		}

		for _, frame in pairs(questHonorFrames) do
			local honor 	= _G[frame]
			local icon 		= _G[frame..'Icon']
			local points	= _G[frame..'Points']
			local text		= _G[frame..'HonorReceiveText']

			honor:SetSize(143, 40)

			--[[if cfg.units.pvpicon ~= false then
				icon:SetTexture('Interface\\PVPFrame\\PVP-FFA')
			else--]]

			icon:SetTexture('Interface\\PVPFrame\\PVP-Currency-'..E.Faction)
			icon.SetTexture = E.hoop
			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetDrawLayer('OVERLAY')
			icon:SetSize(28)
			
			text:SetAnchor('TOPRIGHT', 14, 14)
			text:Hide()
		end

		local function QuestQualityColors(frame, text, link, quality)
			if link and not quality then
				quality = select(3, GetItemInfo(link))
			end

			if quality then
				--frame:SetBackdropBorderColor(GetItemQualityColor(quality))
				frame.bg:SetBackdropBorderColor(GetItemQualityColor(quality))

				text:SetTextColor(GetItemQualityColor(quality))
			else
				--frame:SetBackdropBorderColor(unpack(A.borderColor))
				frame.bg:SetBackdropBorderColor(unpack(A.borderColor))

				text:SetTextColor(1, 1, 1)
			end
		end

		hooksecurefunc('QuestRewardItem_OnClick', function()
			if (this.type == 'choice') then
				--_G[this:GetName()]:SetBackdropBorderColor(1, 0.80, 0.10)
				_G[this:GetName()].bg:SetBackdropBorderColor(1, 0.80, 0.10)
				_G[this:GetName()..'Name']:SetTextColor(1, 0.80, 0.10)

				for i = 1, MAX_NUM_ITEMS do
					local item = _G['QuestRewardItem'..i]
					local name = _G['QuestRewardItem'..i..'Name']
					local link = item.type and GetQuestItemLink(item.type, item:GetID())

					if item ~= this then
						QuestQualityColors(item, name, link)
					end
				end
			end
		end);

		local function QuestObjectiveTextColor()
			local numObjectives = GetNumQuestLeaderBoards()
			local objective
			local _, type, finished
			local numVisibleObjectives = 0
			for i = 1, numObjectives do
				_, type, finished = GetQuestLogLeaderBoard(i)
				if type ~= 'spell' then
					numVisibleObjectives = numVisibleObjectives + 1
					objective = _G['QuestLogObjective'..numVisibleObjectives]
					if finished then
						objective:SetTextColor(1, 0.80, 0.10)
					else
						objective:SetTextColor(0.6, 0.6, 0.6)
					end
				end
			end
		end

		hooksecurefunc('QuestLog_UpdateQuestDetails', function()
			local requiredMoney = GetQuestLogRequiredMoney()
			if requiredMoney > 0 then
				if requiredMoney > GetMoney() then
					QuestLogRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
				else
					QuestLogRequiredMoneyText:SetTextColor(1, 0.80, 0.10)
				end
			end
		end)

		hooksecurefunc('QuestFrameItems_Update', function(questState)
			local titleTextColor = {1, 0.80, 0.10}
			local textColor = {1, 1, 1}

			QuestTitleText:SetTextColor(unpack(titleTextColor))
			QuestTitleFont:SetTextColor(unpack(titleTextColor))
			QuestFont:SetTextColor(unpack(textColor))
			QuestFontNormalSmall:SetTextColor(unpack(textColor))
			QuestDescription:SetTextColor(unpack(textColor))
			QuestObjectiveText:SetTextColor(unpack(textColor))

			QuestDetailObjectiveTitleText:SetTextColor(unpack(titleTextColor))
			QuestDetailRewardTitleText:SetTextColor(unpack(titleTextColor))
			QuestDetailItemReceiveText:SetTextColor(unpack(textColor))
			QuestDetailSpellLearnText:SetTextColor(unpack(textColor))
			QuestDetailItemChooseText:SetTextColor(unpack(textColor))

			QuestLogDescriptionTitle:SetTextColor(unpack(titleTextColor))
			QuestLogQuestTitle:SetTextColor(unpack(titleTextColor))
			QuestLogPlayerTitleText:SetTextColor(unpack(titleTextColor))
			QuestLogRewardTitleText:SetTextColor(unpack(titleTextColor))
			QuestLogObjectivesText:SetTextColor(unpack(textColor))
			QuestLogQuestDescription:SetTextColor(unpack(textColor))
			QuestLogItemChooseText:SetTextColor(unpack(textColor))
			QuestLogItemReceiveText:SetTextColor(unpack(textColor))
			QuestLogSpellLearnText:SetTextColor(unpack(textColor))

			QuestRewardRewardTitleText:SetTextColor(unpack(titleTextColor))
			QuestRewardTitleText:SetTextColor(unpack(titleTextColor))
			QuestRewardItemChooseText:SetTextColor(unpack(textColor))
			QuestRewardItemReceiveText:SetTextColor(unpack(textColor))
			QuestRewardSpellLearnText:SetTextColor(unpack(textColor))
			QuestRewardText:SetTextColor(unpack(textColor))

			if GetQuestLogRequiredMoney() > 0 then
				if GetQuestLogRequiredMoney() > GetMoney() then
					QuestLogRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
				else
					QuestLogRequiredMoneyText:SetTextColor(unpack(textColor))
				end
			end

			QuestObjectiveTextColor()

			local numQuestRewards = questState == 'QuestLog' and GetNumQuestLogRewards() or GetNumQuestRewards()
			local numQuestChoices = questState == 'QuestLog' and GetNumQuestLogChoices() or GetNumQuestChoices()
			local numQuestSpellRewards = questState == 'QuestLog' and GetQuestLogRewardSpell() or GetRewardSpell()
			local rewardsCount = numQuestChoices + numQuestRewards + (numQuestSpellRewards and 1 or 0)

			if rewardsCount > 0 then
				for i = 1, rewardsCount do
					local item = _G[questState..'Item'..i]
					local name = _G[questState..'Item'..i..'Name']
					local link = item.type and (questState == 'QuestLog' and GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

					QuestQualityColors(item, name, link)
				end
			end
		end)

		QuestLogTimerText:SetTextColor(1, 1, 1)

		QuestFrame:SetLayout()
		QuestFrame.bg:SetAnchor('TOPLEFT', 15, -11)
		QuestFrame.bg:SetAnchor('BOTTOMRIGHT', -30, 0)
		QuestFrame:Width(384)
		
		QuestFrame:SetShadow()
		QuestFrame.shadow:SetAnchor('TOPLEFT', 11, -9)
		QuestFrame.shadow:SetAnchor('BOTTOMRIGHT', -26, -4)

		QuestLogFrame:SetAttribute('UIPanelLayout-Width', E:Scale(685))
		QuestLogFrame:SetAttribute('UIPanelLayout-Height', E:Scale(490))
		QuestLogFrame:SetSize(685, 490)
		QuestLogFrame:SetLayout()
		QuestLogFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		QuestLogFrame.bg:SetAnchor('BOTTOMRIGHT', -1, 8)
		
		QuestLogFrame:SetShadow()
		QuestLogFrame.shadow:SetAnchor('TOPLEFT', 6, -10)
		QuestLogFrame.shadow:SetAnchor('BOTTOMRIGHT', 3, 4)

		QuestDetailScrollFrame:Height(402)
		QuestRewardScrollFrame:Height(402)
		QuestProgressScrollFrame:Height(402)

		QuestLogListScrollFrame:StripLayout()
		QuestLogListScrollFrame:SetLayout()
		QuestLogListScrollFrame.bg:SetAnchor('TOPLEFT', -1, 2)
		QuestLogListScrollFrame:SetSize(305, 375)

		QuestLogDetailScrollFrame:StripLayout()
		QuestLogDetailScrollFrame:SetLayout()
		QuestLogDetailScrollFrame.bg:SetAnchor('TOPLEFT', -4, 2)
		QuestLogDetailScrollFrame:SetSize(300, 375)
		QuestLogDetailScrollFrame:ClearAllPoints()
		QuestLogDetailScrollFrame:SetAnchor('TOPRIGHT', QuestLogFrame, -32, -75)

		QuestLogNoQuestsText:ClearAllPoints()
		QuestLogNoQuestsText:SetAnchor('CENTER', EmptyQuestLogFrame, 'CENTER', -45, 65)

		QuestLogHighlightFrame:Width(306)
		QuestLogHighlightFrame.Width = E.hoop

		QuestLogSkillHighlight:StripLayout()

		QuestLogHighlightFrame.Left = QuestLogHighlightFrame:CreateTexture(nil, 'ARTWORK')
		QuestLogHighlightFrame.Left:SetSize(152, 15)
		QuestLogHighlightFrame.Left:SetAnchor('LEFT', QuestLogHighlightFrame, 'CENTER')
		QuestLogHighlightFrame.Left:SetTexture(A.solid)

		QuestLogHighlightFrame.Right = QuestLogHighlightFrame:CreateTexture(nil, 'ARTWORK')
		QuestLogHighlightFrame.Right:SetSize(152, 15)
		QuestLogHighlightFrame.Right:SetAnchor('RIGHT', QuestLogHighlightFrame, 'CENTER')
		QuestLogHighlightFrame.Right:SetTexture(A.solid)

		hooksecurefunc(QuestLogSkillHighlight, 'SetVertexColor', function(_, r, g, b)
			QuestLogHighlightFrame.Left:SetGradientAlpha('Horizontal', r, g, b, 0.35, r, g, b, 0)
			QuestLogHighlightFrame.Right:SetGradientAlpha('Horizontal', r, g, b, 0, r, g, b, 0.35)
		end)

		QuestLogFrameAbandonButton:SetAnchor('BOTTOMLEFT', 18, 15)
		QuestLogFrameAbandonButton:Width(101)
		QuestLogFrameAbandonButton:SetText(ABANDON_QUEST)

		QuestFramePushQuestButton:ClearAllPoints()
		QuestFramePushQuestButton:SetAnchor('LEFT', QuestLogFrameAbandonButton, 'RIGHT', 2, 0)
		QuestFramePushQuestButton:Width(101)
		QuestFramePushQuestButton:SetText(SHARE_QUEST)

		QuestFrameExitButton:SetAnchor('BOTTOMRIGHT', -31, 15)
		QuestFrameExitButton:Width(100)

		QuestFrameAcceptButton:SetAnchor('BOTTOMLEFT', 20, 4)
		QuestFrameDeclineButton:SetAnchor('BOTTOMRIGHT', -37, 4)
		QuestFrameCompleteButton:SetAnchor('BOTTOMLEFT', 20, 4)
		QuestFrameGoodbyeButton:SetAnchor('BOTTOMRIGHT', -37, 4)
		QuestFrameCompleteQuestButton:SetAnchor('BOTTOMLEFT', 20, 4)
		QuestFrameCancelButton:SetAnchor('BOTTOMRIGHT', -37, 4)

		QuestFrameNpcNameText:SetAnchor('CENTER', QuestNpcNameFrame, 'CENTER', -5, -1)

		QuestLogDetailScrollFrameScrollBar:ShortBar()
		QuestDetailScrollFrameScrollBar:ShortBar()
		QuestLogListScrollFrameScrollBar:Hide()
		--QuestLogListScrollFrameScrollBar:SetAnchor('TOPLEFT', QuestLogListScrollFrame, 'TOPRIGHT', 5, -16)
		QuestProgressScrollFrameScrollBar:ShortBar()
		QuestRewardScrollFrameScrollBar:ShortBar()
		
		--local QuestDetailScrollBarDown = _G['QuestDetailScrollFrameScrollBar'..'ScrollDownButton']
		--QuestDetailScrollBarDown:SetAnchor('TOP', 0, -340)

		QuestFrameCloseButton:CloseTemplate()
		QuestFrameCloseButton:SetAllPoints(GossipFrameCloseButton)

		QuestLogFrameCloseButton:CloseTemplate()
		QuestLogFrameCloseButton:ClearAllPoints()
		QuestLogFrameCloseButton:SetAnchor('TOPRIGHT', 2, -9)

		QuestLogTrack:Hide()

		local QuestTrack = CreateFrame('Button', 'QuestTrack', QuestLogFrame, 'UIPanelButtonTemplate')
		ET:HandleButton(QuestTrack)
		QuestTrack:SetAnchor('LEFT', QuestFramePushQuestButton, 'RIGHT', 2, 0)
		QuestTrack:SetSize(101, 21)
		QuestTrack:SetText(TRACK_QUEST)

		QuestTrack:Hook('OnClick', function()
			if IsQuestWatched(GetQuestLogSelection()) then
				RemoveQuestWatch(GetQuestLogSelection())

				QuestWatch_Update()
			else
				if GetNumQuestLeaderBoards(GetQuestLogSelection()) == 0 then
					UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0)
					return
				end

				if GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS then
					UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0)
					return
				end

				AddQuestWatch(GetQuestLogSelection())

				QuestLog_Update()
				QuestWatch_Update()
			end

			QuestLog_Update()
		end)

		hooksecurefunc('QuestLog_Update', function()
			local numEntries = GetNumQuestLogEntries()
			if numEntries == 0 then
				QuestTrack:Disable()
			else
				QuestTrack:Enable()
			end

			QuestLogListScrollFrame:Show()
		end)

		hooksecurefunc('QuestFrameProgressItems_Update', function()
			QuestProgressTitleText:SetTextColor(1, 0.80, 0.10)
			QuestProgressText:SetTextColor(1, 1, 1)
			QuestProgressRequiredItemsText:SetTextColor(1, 0.80, 0.10)

			if GetQuestMoneyToGet() > 0 then
				if GetQuestMoneyToGet() > GetMoney() then
					QuestProgressRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
				else
					QuestProgressRequiredMoneyText:SetTextColor(1, 0.80, 0.10)
				end
			end

			for i = 1, MAX_REQUIRED_ITEMS do
				local item = _G['QuestProgressItem'..i]
				local name = _G['QuestProgressItem'..i..'Name']
				local link = item.type and GetQuestItemLink(item.type, item:GetID())

				QuestQualityColors(item, name, link)
			end
		end)

		QUESTS_DISPLAYED = 25

		for i = 7, 25 do
			local questLogTitle = CreateFrame('Button', 'QuestLogTitle'..i, QuestLogFrame, 'QuestLogTitleButtonTemplate')

			questLogTitle:SetID(i)
			questLogTitle:Hide()
			questLogTitle:SetAnchor('TOPLEFT', _G['QuestLogTitle'..i - 1], 'BOTTOMLEFT', 0, 1)
		end

		for i = 1, QUESTS_DISPLAYED do
			local questLogTitle = _G['QuestLogTitle'..i]
			local highlight = _G['QuestLogTitle'..i..'Highlight']

			questLogTitle:SetNormalTexture(A.collapse)
			questLogTitle.SetNormalTexture = E.hoop
			questLogTitle:GetNormalTexture():SetSize(14)
			questLogTitle:GetNormalTexture():SetAnchor('LEFT', 3, 0)

			highlight:SetTexture''
			highlight.SetTexture = E.hoop

			hooksecurefunc(questLogTitle, 'SetNormalTexture', function(self, texture)
				if find(texture, 'MinusButton') then
					self:GetNormalTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
				elseif find(texture, 'PlusButton') then
					self:GetNormalTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
				else
					self:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
				end
			end)
		end

		QuestLogCollapseAllButton:StripLayout()
		QuestLogCollapseAllButton:SetAnchor('TOPLEFT', -58, -2)

		QuestLogCollapseAllButton:SetNormalTexture(A.collapse)
		QuestLogCollapseAllButton.SetNormalTexture = E.hoop
		QuestLogCollapseAllButton:GetNormalTexture():SetSize(15)

		QuestLogCollapseAllButton:SetHighlightTexture''
		QuestLogCollapseAllButton.SetHighlightTexture = E.hoop

		QuestLogCollapseAllButton:SetDisabledTexture(A.collapse)
		QuestLogCollapseAllButton.SetDisabledTexture = E.hoop
		QuestLogCollapseAllButton:GetDisabledTexture():SetSize(15)
		QuestLogCollapseAllButton:GetDisabledTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
		QuestLogCollapseAllButton:GetDisabledTexture():SetDesaturated(true)

		hooksecurefunc(QuestLogCollapseAllButton, 'SetNormalTexture', function(self, texture)
			if find(texture, 'MinusButton') then
				self:GetNormalTexture():SetTexCoord(0.540, 0.965, 0.085, 0.920)
			elseif find(texture, 'PlusButton') then
				self:GetNormalTexture():SetTexCoord(0.040, 0.465, 0.085, 0.920)
			else
				self:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
			end
		end);
	end

	table.insert(ET['SohighUI'], LoadSkin)