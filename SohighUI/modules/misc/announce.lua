	
	--* Announces messages when different events occur for user-defined spells Author Ganders
	
	local E, C, L, _ = select(2, shCore()):unpack()
	if C.main.announce ~= true then return end
	
	local announce = CreateFrame('frame', 'NinjaYell', UIParent)
	announce.color = {r = 1, g = 1, b = 1}
	announce.ids = {}

	local _G = getfenv(0)
	local format = string.format

	local bit_bor = _G.bit.bor
	local COMBATLOG_FILTER_ME = _G.COMBATLOG_FILTER_ME

	local failSafe
	local channel
	local message
	local target

	--local function printf(...) E.Suitag(format(...)) end

	--//Documentation for Spell DB:
	--[[Spell DB, enter the spell you want announced in this table
		Enter custom messages you want as shown below
	Variables:
		%t = Target's name
		%m = Extra Info (for Missed, it's missType (i.e. Miss, Parry, Block, Dodge, etc.) for Interrupt it's the spell name that you interrupted)
	Custom values:
		Applied = Custom message(s) to use when this spell is APPLIED to your target
		Faded = Custom message(s) to use when this spell is REMOVED from your target
		Missed = Custom message(s) to use when this spell fails to hit for any reason
		Interrupt = Custom message(s) to use when this spell INTERRUPTS another spell
		Channel = Priority channel to use (this spell will ALWAYS use the specified channel)
		Target = Whisper target (can be a function or a string, ONLY NEEDED if you used WHISPER as the priority channel)
	]]
	
	announce.spells = {
		['Blind'] = {},
		['Taunt'] = {
			Applied = '',
			Faded = '',
			Missed = "Taunt failed on %t (%m). Now we're fucked.",
		},
		['Sap'] = {},
		['Kick'] = {},
		['Counterspell'] = {},
		['Pummel'] = {},
		['Polymorph'] = {
			Applied = '%t is sheeped. You break it, you tank it!',
			Faded = "%t's fleece is no longer as white as snow",
		},
		['Distract'] = {},
		['Cyclone'] = {},
		['Fear'] = {},
		['Psychic Scream'] = {},
		['Freezing Trap'] = {},
	}

	local function isMe(flags)
		return bit_bor(flags, COMBATLOG_FILTER_ME) == COMBATLOG_FILTER_ME
	end

	local function CLEU(self, event, time, eventType, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, missType, extraSpellName)
		if (not(announce.spells[spellName])) then return end
		
		if (eventType == 'SPELL_CAST_SUCCESS' or eventType == 'SPELL_CAST_START') then
			--* print(eventType)
			if (isMe(srcFlags)) then
				--* printf('%s isMe', eventType)
				self:Scoop(spellName)
			end
		--[[
		elseif ( eventType == 'SPELL_CAST_FAILED' ) then
			print(eventType)
			if ( failSafe == spellName ) then
				printf('%s failSafe passed, dumping', eventType)
				self:Dump()
			end
		--]]
		elseif (eventType == 'SPELL_AURA_APPLIED') then
			--* print(eventType)
			if (failSafe == spellName and announce.ids[destName] == destGUID) then
				--* printf('%s failSafe and GUID match found, dumping & announcing', eventType)	
				self:Announce(spellName, destName, 1)
				self:Dump()
				announce.spells[spellName].GUID = destGUID
				announce.spells[spellName].Active = true		
			else
				--* printf('%s %s', failSafe, tostring(announce.ids[destName] == destGUID))
			end
		elseif (eventType == 'SPELL_INTERRUPT') then
			--* print(eventType)
			if (isMe(srcFlags) and failSafe == spellName and announce.ids[destName] == destGUID) then
				--* printf('%s isMe, failSafe and GUID match, announcing & dumping', eventType)
				self:Announce(spellName, destName, 4, extraSpellName)
				self:Dump()
			else
				--* printf('%s %s %s', tostring(isMe(srcFlags)), failSafe, tostring(announce.ids[destName] == destGUID))
			end
		elseif (eventType == 'SPELL_MISSED') then
			--* print(eventType)
			if (isMe(srcFlags)) then
				--* printf('%s isMe', eventType)
				self:Announce(spellName, destName, 3, missType)
			else
				--* printf('%s', tostring(isMe(srcFlags)))
			end
		elseif (eventType == 'SPELL_AURA_REMOVED') then
			--* print(eventType)
			if (announce.spells[spellName].Active and announce.spells[spellName].GUID == destGUID) then
				--* printf('%s Active and GUID match', eventType)
				self:Announce(spellName, destName, 2)
				announce.spells[spellName].GUID = false
				announce.spells[spellName].Active = false
			else
				--* printf('%s %s', tostring(announce.spells[spellName].Active), tostring(announce.spells[spellName].GUID == destGUID))
			end
		elseif (eventType == 'UNIT_DIED') then
			--* print(eventType)
			if (announce.ids[destName]) then
				self:Dump()
			end
		end
	end

	function announce:Scoop(spellName)
		failSafe = spellName
		for i, v in ipairs({'target', 'focus', 'mouseover'}) do
			if (UnitExists(v)) then
				announce.ids[UnitName(v)] = UnitGUID(v)
			end
		end
	end

	function announce:Dump()
		failSafe = nil
		for k, v in pairs(announce.ids) do
			announce.ids[k] = nil
		end
	end

	function announce:Announce(spellName, destName, index, ...)
		message = nil
		if (index == 1) then
			if (announce.spells[spellName].Applied) then
				if (type(announce.spells[spellName].Applied) == 'string') then
					message = announce.spells[spellName].Applied:gsub('%%t', destName)
				else
					message = announce.spells[spellName].Applied[random(#announce.spells[spellName].Applied)]:gsub('%%t', destName)
				end
			else
				message = format('** %s on %s **', spellName, destName)
			end
		elseif (index == 2) then
			if (announce.spells[spellName].Faded) then
				if (type(announce.spells[spellName].Faded) == 'string') then
					message = announce.spells[spellName].Faded:gsub('%%t', destName)
				else
					message = announce.spells[spellName].Faded[random(#announce.spells[spellName].Faded)]:gsub('%%t', destName)
				end
			else
				message = format('** %s faded from %s **', spellName, destName)
			end
		elseif (index == 3) then
			if (announce.spells[spellName].Missed) then
				if (type(announce.spells[spellName].Missed) == 'string') then
					message = announce.spells[spellName].Missed:gsub('%%t', destName):gsub('%%m', ...)
				else
					message = announce.spells[spellName].Missed[random(#announce.spells[spellName].Missed)]:gsub('%%t', destName):gsub('%%m', ...)
				end
			else
				message = format('** %s failed on %s (%s) **', spellName, destName, ...)
			end
		elseif (index == 4) then
			if (announce.spells[spellName].Interrupt) then
				if ( type(announce.spells[spellName].Interrupt) == 'string' ) then
					message = announce.spells[spellName].Interrupt:gsub('%%t', destName):gsub('%%m', ...)
				else
					message = announce.spells[spellName].Interrupt[random(#announce.spells[spellName].Interrupt)]:gsub('%%t', destName):gsub('%%m', ...)
				end
			else
				message = format("** Interrupted %s's %s **", destName, ...)
			end
		end
		
		if (not message) then return end

		channel = nil
		if (announce.spells[spellName].Channel) then
			channel = announce.spells[spellName].Channel
		else
			if (IsPartyLeader()) then
				channel = 'RAID_WARNING'
			elseif (GetNumRaidMembers() > 0 and (select(2, IsInInstance()) ~= 'pvp')) then
				channel = 'RAID'
			elseif (GetNumPartyMembers() > 0) then
				channel = 'PARTY'
			end
		end
		
		if (not channel) then
			if (MikSBT and not(MikSBT.IsModDisabled())) then
				MikSBT.DisplayMessage(message, MikSBT.DISPLAYTYPE_NOTIFICATION, true, announce.color.r*255, announce.color.g*255, announce.color.b*255, nil, nil, nil, nil)
				return
			elseif (SCT) then
				SCT:DisplayMessage(message, announce.color)
				return
			elseif (COMBAT_TEXT_SCROLL_FUNCTION) then
				CombatText_AddMessage(message, COMBAT_TEXT_SCROLL_FUNCTION, announce.color.r, announce.color.g, announce.color.b, 'crit', nil)
				return
			end
		elseif (channel == 'WHISPER') then
			target = announce.spells[spellName].Target
			if (type(target) == 'function') then
				target = target()
			end
			if (target) then
				SendChatMessage(message, 'WHISPER', nil, target)
			end
			return
		end

		SendChatMessage(message, channel or 'SAY')
	end

	function announce:Enable()
		self:SetScript('OnEvent', CLEU)
		self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
		E.Suitag('Enabled')
	end

	function announce:Disable()
		self:SetScript('OnEvent', nil)
		self:UnregisterAllEvents()
		E.Suitag('Disabled')
	end

	local function Toggle()
		if ( announce:IsEventRegistered('COMBAT_LOG_EVENT_UNFILTERED') ) then
			announce:Disable()
		else
			announce:Enable()
		end
	end

	SLASH_NYELL1 = '/nyell'
	SlashCmdList['NYELL'] = Toggle

	announce:Enable()