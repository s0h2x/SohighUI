	
	--* chat command things
	local E, C, L, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local format = format

	local GetNumPartyMembers, GetNumRaidMembers = GetNumPartyMembers, GetNumRaidMembers
	local GetNumQuestLogEntries = GetNumQuestLogEntries
	local IsAddOnLoaded = IsAddOnLoaded
	local IsInInstance = IsInInstance
	
	--* Fix combatlog manually when it broke (need for DamageMeter)
	local function CLFIX()
		CombatLogClearEntries()
		E.Suitag('Combat Log Cleaned.')
	end
	SLASH_CLFIX1 = '/clfix'
	SlashCmdList['CLFIX'] = CLFIX
	
	--* Fast Disband Party/Raid
	local function GROUPDISBAND()
		SendChatMessage('Disband', 'RAID' or 'PARTY')
		if UnitInRaid('player') then
			for i = 1, GetNumRaidMembers() do
				local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
				if online and name ~= E.Name then
					UninviteUnit(name)
				end
			end
		else
			for i = MAX_PARTY_MEMBERS, 1, -1 do
				if GetPartyMember(i) then
					UninviteUnit(UnitName('party'..i))
				end
			end
		end
		LeaveParty()
	end
	
	SLASH_GROUPDISBAND1 = '/rd'
	SlashCmdList['GROUPDISBAND'] = GROUPDISBAND
	
	--* SohighUI Help Commands
	SlashCmdList.UIHELP = function()
		for i, p in ipairs(L_SlashCmdHelp) do
			E.Suitag('|cffffe02e'..('%s'):format(tostring(p))..'|r')
		end
	end
	SLASH_UIHELP1 = '/uihelp'
	SLASH_UIHELP2 = '/helpui'
	SLASH_UIHELP3 = '/sohighui'
	
	--* Ready Check
	SlashCmdList.RCSLASH = function() DoReadyCheck() end
	SLASH_RCSLASH1 = '/rc'
	
	--* Convert party to raid
	SlashCmdList.PARTYTORAID = function()
		if GetNumPartyMembers() > 0 then
			if UnitInParty('player') and UnitIsPartyLeader('player') then
				ConvertToRaid()
			end
		else
			E.Suitag('|cffffe02e'..L_NotInGroup..'|r')
		end
	end
	SLASH_PARTYTORAID1 = '/toraid'
	SLASH_PARTYTORAID2 = '/convert'
	SLASH_PARTYTORAID3 = '/cpr'
	
	--* Clear Chat
	SlashCmdList.CLEARCHAT = function(cmd)
		cmd = cmd and strtrim(strlower(cmd))
		for i = 1, NUM_CHAT_WINDOWS do
			local f = _G['ChatFrame'..i]
			if f:IsVisible() or cmd == 'all' then
				f:Clear()
			end
		end
	end
	SLASH_CLEARCHAT1 = '/cc'
	SLASH_CLEARCHAT2 = '/clearchat'