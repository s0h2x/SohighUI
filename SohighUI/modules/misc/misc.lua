
	--* misc
	
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.misc ~= true then return end

	--* force readycheck warning
	local ShowReadyCheckHook = function(self, initiator)
		if (initiator ~= 'player') then
			PlaySound('ReadyCheck')
		end
	end
	hooksecurefunc('ShowReadyCheck', ShowReadyCheckHook)

	--*	force other warning
	local ForceWarning = CreateFrame('frame')
	ForceWarning:RegisterEvent('UPDATE_BATTLEFIELD_STATUS')
	ForceWarning:RegisterEvent('RESURRECT_REQUEST')
	ForceWarning:SetScript('OnEvent', function(self, event)
		if (event == 'UPDATE_BATTLEFIELD_STATUS') then
			for i = 1, MAX_BATTLEFIELD_QUEUES do
				local status = GetBattlefieldStatus(i)
				if (status == 'confirm') then
					PlaySound('PVPTHROUGHQUEUE')
					break
				end
				i = i + 1
			end
		elseif (event == 'RESURRECT_REQUEST') then
			PlaySoundFile('Sound\\Spells\\Resurrection.wav')
		end
	end);

	--*	Misclicks for some popups
	StaticPopupDialogs.RESURRECT.hideOnEscape = nil
	StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
	StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
	StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
	StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
	StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
	StaticPopupDialogs.CONFIRM_BATTLEFIELD_ENTRY.button2 = nil

	----------------------------------------------------------------------------------------
	--	Spin camera while afk (by Telroth and Eclipse)
	----------------------------------------------------------------------------------------
	--[[if C.main.AFKSpinCamera ~= false then
		local SpinCam = CreateFrame('Frame')
		local OnEvent = function(self, event, unit)
			if (event == 'PLAYER_FLAGS_CHANGED') then
				if (unit == 'player') then
					if UnitIsAFK(unit) then
						SpinStart()
					else
						SpinStop()
					end
				end
			elseif (event == 'PLAYER_LEAVING_WORLD') then
				SpinStop()
			end
		end
		SpinCam:RegisterEvent('PLAYER_ENTERING_WORLD')
		SpinCam:RegisterEvent('PLAYER_LEAVING_WORLD')
		SpinCam:RegisterEvent('PLAYER_FLAGS_CHANGED')
		SpinCam:SetScript('OnEvent', OnEvent)

		function SpinStart()
			spinning = true
			MoveViewRightStart(0.1)
			UIParent:Hide()
		end

		function SpinStop()
			if not spinning then return end
			spinning = nil
			MoveViewRightStop()
			UIParent:Show()
		end
	end--]]

	--*	remove Boss Emote spam during BG (ArathiBasin SpamFix by Partha)
	local Fixer = CreateFrame('frame')
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame

	local function DisableSpam()
		if GetZoneText() == L_Misc_ZoneAb then
			RaidBossEmoteFrame:UnregisterEvent('RAID_BOSS_EMOTE')
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent('RAID_BOSS_EMOTE')
			spamDisabled = false
		end
	end

	Fixer:RegisterEvent('PLAYER_ENTERING_WORLD')
	Fixer:RegisterEvent('ZONE_CHANGED_NEW_AREA')
	Fixer:SetScript('OnEvent', DisableSpam)

	--*	undress button in auction dress-up frame (by Nefarion)
	local strip = CreateFrame('Button', 'DressUpFrameUndressButton', DressUpFrame, 'UIPanelButtonTemplate')
	--[[strip:StripLayout()
	strip:SetLayout()
	
	strip.bg:SetAnchor('TOPLEFT', 10, -12)
	strip.bg:SetAnchor('BOTTOMRIGHT', -33, 73)
	-]]
	ET:HandleButton(strip)
	strip:SetText(L_Misc_Undress)
	strip:Height(22)
	strip:Width(strip:GetTextWidth() +35)
	strip:SetAnchor('RIGHT', DressUpFrameResetButton, 'LEFT', -4, 0)
	strip:RegisterForClicks('AnyUp')
	strip:SetScript('OnClick', function(self, b)
		if (b == 'RightButton') then
			self.model:UndressSlot(19)
		else
			self.model:Undress()
		end
		PlaySound('gsTitleOptionOK')
	end)
	strip.model = DressUpModel

	strip:RegisterEvent('AUCTION_HOUSE_SHOW')
	strip:RegisterEvent('AUCTION_HOUSE_CLOSED')
	strip:SetScript('OnEvent', function(self)
		if AuctionFrame:IsVisible() and self.model ~= SideDressUpModel then
			self:SetParent(SideDressUpModel)
			self:ClearAllPoints()
			self:SetAnchor('TOP', SideDressUpModelResetButton, 'BOTTOM', 0, -3)
			self.model = SideDressUpModel
		elseif self.model ~= DressUpModel then
			self:SetParent(DressUpModel)
			self:ClearAllPoints()
			self:SetAnchor('RIGHT', DressUpFrameResetButton, 'LEFT', -2, 0)
			self.model = DressUpModel
		end
	end)

	--*	force quit
	local CloseWoW = CreateFrame('Frame')
	CloseWoW:RegisterEvent('CHAT_MSG_SYSTEM')
	CloseWoW:SetScript('OnEvent', function(self, event, msg)
		if (event == 'CHAT_MSG_SYSTEM') then
			if msg and msg == IDLE_MESSAGE then
				ForceQuit()
			end
		end
	end)
	
	-----------------------------
	UIErrorsFrame:SetFrameLevel(0)