	
	--* Auto accept invite, CREDIT : FatalEntity 

	local E, C, L, _ = select(2, shCore()):unpack()
	if C.main.autoInvite ~= true then return end
	
	local AddOn = CreateFrame('frame')
	local OnEvent = function(self, event, ...) self[event](self, event, ...) end
	AddOn:SetScript('OnEvent', OnEvent)

	local function PARTY_MEMBERS_CHANGED()
		StaticPopup_Hide('PARTY_INVITE')
		AddOn:UnregisterEvent('PARTY_MEMBERS_CHANGED')
	end

	local InGroup = false
	local function PARTY_INVITE_REQUEST()
		local leader = arg1
		InGroup = false
		
		--* Update Guild and Freindlist
		if GetNumFriends() > 0 then ShowFriends() end
		if IsInGuild() then GuildRoster() end
		
		for friendIndex = 1, GetNumFriends() do
			local friendName = GetFriendInfo(friendIndex)
			if friendName == leader then
				AcceptGroup()
				AddOn:RegisterEvent('PARTY_MEMBERS_CHANGED')
				AddOn['PARTY_MEMBERS_CHANGED'] = PARTY_MEMBERS_CHANGED
				InGroup = true
				break
			end
		end
		
		if not InGroup then
			for guildIndex = 1, GetNumGuildMembers(true) do
				local guildMemberName = GetGuildRosterInfo(guildIndex)
				if guildMemberName == leader then
					AcceptGroup()
					AddOn:RegisterEvent('PARTY_MEMBERS_CHANGED')
					AddOn['PARTY_MEMBERS_CHANGED'] = PARTY_MEMBERS_CHANGED
					InGroup = true
					break
				end
			end
		end
		
		if not InGroup then
			SendWho(leader)
		end
	end

	AddOn:RegisterEvent('PARTY_INVITE_REQUEST')
	AddOn['PARTY_INVITE_REQUEST'] = PARTY_INVITE_REQUEST
