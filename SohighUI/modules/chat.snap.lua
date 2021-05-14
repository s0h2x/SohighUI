
	--* snap method by Devrak
	
	local E, C, L, _ = select(2, shCore()):unpack()
	
	local select = select
	local CreateFrame = CreateFrame
	local UnitName = UnitName
	local UnitLevel = UnitLevel
	local UnitClass = UnitClass
	local UnitIsPlayer = UnitIsPlayer
	local UnitExists = UnitExists
	local UnitGUID = UnitGUID
	local GetNumGuildMembers = GetNumGuildMembers
	
	local snap

	local function db_event(self, event, arg, ...)
		if (event == 'UPDATE_MOUSEOVER_UNIT') then
			if not UnitExists('mouseover') or not UnitIsPlayer('mouseover') then return end
			
			local name = UnitName('mouseover')
			local level = UnitLevel('mouseover')
			if not snap[name] then
				snap[name] = {['guid'] = UnitGUID('mouseover'), ['class'] = select(2, UnitClass('mouseover')), ['level'] = level, ['faction'] = UnitFactionGroup('mouseover'), ['stamp'] = self.dstamp}
			elseif snap[name]['guid'] == nil then
				snap[name] = {['guid'] = UnitGUID('mouseover'), ['class'] = select(2, UnitClass('mouseover')), ['level'] = level, ['faction'] = UnitFactionGroup('mouseover'), ['stamp'] = self.dstamp}
			elseif level < 70 then
				snap[name]['level'] = level
			end
		return
		
		elseif (event == 'UNIT_TARGET') then
			local unit = arg..'target'
			if not UnitExists(unit) or not UnitIsPlayer(unit) then return end
			
			local name = UnitName(unit)
			local level = UnitLevel(unit)

			if not snap[name] then
				snap[name] = {['guid'] = UnitGUID(unit), ['class'] = select(2, UnitClass(unit)), ['level'] = level, ['faction'] = UnitFactionGroup(unit), ['stamp'] = self.dstamp}
			elseif snap[name]['guid'] == nil then
				snap[name] = {['guid'] = UnitGUID(unit), ['class'] = select(2, UnitClass(unit)), ['level'] = level, ['faction'] = UnitFactionGroup(unit), ['stamp'] = self.dstamp}
			elseif level < 70 then
				snap[name]['level'] = level
			end
		return
		
		elseif (event == 'PARTY_MEMBERS_CHANGED') then
			local party = GetNumPartyMembers()
			if party ~= 0 then
				for i = 1, party do
					local unit = 'party'..i
					local name = UnitName(unit)
					local level = UnitLevel(unit)
					
					if not snap[name] then
						snap[name] = {['guid'] = UnitGUID(unit), ['class'] = select(2, UnitClass(unit)), ['level'] = level, ['faction'] = UnitFactionGroup(unit), ['stamp'] = self.dstamp}
					elseif snap[name]['guid'] == nil then
						snap[name] = {['guid'] = UnitGUID(unit), ['class'] = select(2, UnitClass(unit)), ['level'] = level, ['faction'] = UnitFactionGroup(unit), ['stamp'] = self.dstamp}
					elseif level < 70 then
						snap[name]['level'] = level
					end
				end
			end
		return

		elseif (event == 'RAID_ROSTER_UPDATE') then
			local raid = GetNumRaidMembers()
			if raid ~= 0 then
				for i = 1, raid do
					local unit = 'raid'..i
					local name = UnitName(unit)
					local level = UnitLevel(unit)

					if not snap[name] then
						snap[name] = {['guid'] = UnitGUID(unit), ['class'] = select(2, UnitClass(unit)), ['level'] = level, ['faction'] = UnitFactionGroup(unit), ['stamp'] = self.dstamp}
					elseif snap[name]['guid'] == nil then
						snap[name] = {['guid'] = UnitGUID(unit), ['class'] = select(2, UnitClass(unit)), ['level'] = level, ['faction'] = UnitFactionGroup(unit), ['stamp'] = self.dstamp}
					elseif level < 70 then
						snap[name]['level'] = level
					end
				end
			end
		return
		
		elseif (event == 'GUILD_ROSTER_UPDATE') then
			local count = GetNumGuildMembers(true)
			if count == 0 then GuildRoster() return
			
			elseif count ~= self.cguild then
				self.cguild = count
				for i = 1, count do
					local name, _, _, level, class = GetGuildRosterInfo(i)
					if not snap[name] then
						snap[name] = {['class'] = class:upper(), ['level'] = level, ['faction'] = self.faction, ['stamp'] = self.dstamp}
					elseif level < 70 then
						snap[name] = {['class'] = class:upper(), ['level'] = level, ['faction'] = self.faction, ['stamp'] = self.dstamp}
					end
				end
			end
		return
			
		elseif (event == 'FRIENDLIST_UPDATE') then
			for i=1, GetNumFriends() do
				local name, level, class = GetFriendInfo(i)

				if name and not snap[name] then
					snap[name] = {['class'] = class:upper(), ['level'] = level, ['faction'] = self.faction, ['stamp'] = self.dstamp}
				elseif level < 70 then
					snap[name] = {['class'] = class:upper(), ['level'] = level, ['faction'] = self.faction, ['stamp'] = self.dstamp}
				end
			end
		return

		elseif (event == 'WHO_LIST_UPDATE') then
			for i=1, GetNumWhoResults() do
				local name, _, level, _, _, _, class = GetWhoInfo(i)
				if not snap[name] then
					snap[name] = {['class'] = class, ['level'] = level, ['faction'] = self.faction, ['stamp'] = self.dstamp}
				elseif level < 70 then
					snap[name] = {['class'] = class, ['level'] = level, ['faction'] = self.faction, ['stamp'] = self.dstamp}
				end
			end
		return

		elseif (event == 'PLAYER_ENTERING_BATTLEGROUND') then
			RequestBattlefieldScoreData()
		return
			
		elseif (event == 'CHAT_MSG_BG_SYSTEM_NEUTRAL' or event == 'CHAT_MSG_BG_SYSTEM_HORDE' or event == 'CHAT_MSG_BG_SYSTEM_ALLIANCE') then
			if GetTime() > self.update then RequestBattlefieldScoreData() end
		return
	
		elseif (event == 'UPDATE_BATTLEFIELD_SCORE') then
			local scores = GetNumBattlefieldScores()
			if scores > 0 then 
				local ctime = GetTime()
				if ctime > self.update then
					self.update = ctime +14
					for i = 1, scores do
						local name, _, _, _, _, faction, _, _, _, class = GetBattlefieldScore(i)
						if not snap[name] then
							if faction == 0 then faction = 'Horde' else faction = 'Alliance' end
							snap[name] = {['class'] = class, ['faction'] = faction, ['stamp'] = self.dstamp}
						end
					end
				end
			end
			return
		end
	end

	function sui_database()
		local db_events = CreateFrame('frame', nil, nil)
		
		-- DB
		if suiDB == nil then
			suiDB = {}
		end
		
		-- Snap DB
		snap = suiDB
		
		-- C2
		db_events.cguild = 0
		db_events.update = GetTime()
		db_events.dstamp = date('%y%m%d')
		db_events.faction = E.Faction
		
		-- Reg Events
		db_events:RegisterEvent('UPDATE_MOUSEOVER_UNIT')
		db_events:RegisterEvent('UNIT_TARGET')
		db_events:RegisterEvent('PARTY_MEMBERS_CHANGED')
		db_events:RegisterEvent('RAID_ROSTER_UPDATE')
		db_events:RegisterEvent('WHO_LIST_UPDATE')
		db_events:RegisterEvent('GUILD_ROSTER_UPDATE')
		db_events:RegisterEvent('FRIENDLIST_UPDATE')
		db_events:RegisterEvent('PLAYER_ENTERING_BATTLEGROUND')
		db_events:RegisterEvent('CHAT_MSG_BG_SYSTEM_NEUTRAL')
		db_events:RegisterEvent('CHAT_MSG_BG_SYSTEM_HORDE')
		db_events:RegisterEvent('CHAT_MSG_BG_SYSTEM_ALLIANCE')
		db_events:RegisterEvent('UPDATE_BATTLEFIELD_SCORE')
		db_events:RegisterEvent('PLAYER_LOGOUT') -- For cleaning DB on logout

		-- Listen
		db_events:SetScript('OnEvent', db_event)
	end