
	--* chat queue func by Devrak

	local E, C, L, _ = select(2, shCore()):unpack()
	
	local sui__chat, db_snap
	
	local _G = _G
	local format, find, gsub = string.format, string.find, string.gsub
	
	local hooksecurefunc = hooksecurefunc
	local CreateFrame = CreateFrame

	namecolor = 1
	
	local war = {
		['AFK'] = AFK,
		['DND'] = DND,
		['RAID_WARNING'] = RAID_WARNING,
	}
	
	_G.CHAT_SAY_GET = '%s: '
	_G.CHAT_YELL_GET = '%s: '

	local function sui__chat_onWindowName(frame)
		local tab = _G[frame:GetName()..'Tab']
		tab.fullText = tab:GetText()
		
		if frame.isDocked or frame.isDocked then
			tab:SetText(string.upper(string.sub(tab.fullText, 1, 1)))
		end
	end

	--* who que
	local function sui__chat_que()
		for k in pairs(sui__chat.queue) do
			local curTime = GetTime()
			sui__chat.queryTimeOut = curTime +10
			sui__chat.query = k
			
			--* time since last que > 5 sec = Fast Que
			if curTime -5 > sui__chat.queryTime then
				SendWho(k)
			else
				sui__chat.queryTime = curTime +5
				sui__chat:SetScript('OnUpdate', function()
					if GetTime() > sui__chat.queryTime then
						if not sui__chat.whoOpen then
							SendWho(k)
							sui__chat:SetScript('OnUpdate', nil)
						end
					end
				end)
			end
			return
		end
	end

	local function sui__chat_onWho()

		--* stops queries when whoframe is visible
		if WhoFrame:IsVisible() and not sui__chat.whoOpen then
			sui__chat.query = nil
			sui__chat.whoOpen = true
		elseif not WhoFrame:IsVisible() and sui__chat.whoOpen then
			sui__chat.whoOpen = false
			
			--* quee
			sui__chat_que()
		end
	end

	local function sui__chat_SendWho(args)
		if args ~= sui__chat.query then sui__chat.query = nil end
		
		--* LibWho ?
		if args == sui__chat.query and sui__chat.L then
			sui__chat.L:Who(args)
		else
			sui__chat.sendWho(args)
			sui__chat.queryTime = GetTime()
		end
	end

	local function sui__chat_FriendsFrame_OnEvent()
		if sui__chat.query and event == 'WHO_LIST_UPDATE' then return
		else sui__chat.ofriends() end
	end

	local function sui__chat_onItemRef(link, text, button)
		local type = string.sub(text, 13, 15)
		--[[if (type == 'ref') then
			sui__chat.box:Show()
			sui__chat.box:SetText(string.sub(text, 20, -6))
			sui__chat.box:SetAutoFocus(true)
		return--]]
		
		--* party inv
		if (type == 'inv') then
			InviteUnit(string.sub(text, 17, -12))
		return
			
		--* apply for party
		elseif (type == 'app') then
			ChatFrame_OpenChat('/w '.. string.sub(text, 17, -14)..' ')
			return
		end

		SetItemRef(link, text, button)
	end

	local function sui__chat_filter(name, level, mtype)
		if sui__chat.whisp[name] or sui__chat.guild[name] or sui__chat.friends[name] then return false
		elseif (mtype == 'CHAT_MSG_WHISPER') and level < sui__chat.temp.MsgLevel then return true
		elseif (mtype == 'CHAT_MSG_CHANNEL' or mtype == 'CHAT_MSG_SAY' or mtype == 'CHAT_MSG_YELL') and sui__chat.temp.MsgChans == 1 and level < sui__chat.temp.MsgLevel then return true
		else return false end
	end

	local function sui__chat_queryAddMessages()
		if db_snap[sui__chat.query] then
			for i = 1 , #sui__chat.queue[sui__chat.query] do
			
				--* filter
				if sui__chat.temp.MsgLevel == 0 or not sui__chat_filter(sui__chat.query, db_snap[sui__chat.query]['level'], sui__chat.queue[sui__chat.query][i]['Type']) then
					if namecolor == 1 then
						sui__chat.queue[sui__chat.query][i]['text'] = string.gsub(sui__chat.queue[sui__chat.query][i]['text'], '%['.. sui__chat.query ..'%]', '[|cff' .. sui__chat.ccolor[db_snap[sui__chat.query]['class']] .. '' .. sui__chat.query ..'|r]', 1)
					end
					sui__chat.oaddm(sui__chat.queue[sui__chat.query][i]['frame'], sui__chat.queue[sui__chat.query][i]['text'], sui__chat.queue[sui__chat.query][i]['r'], sui__chat.queue[sui__chat.query][i]['g'], sui__chat.queue[sui__chat.query][i]['b'])
				end
			end
		else
			for i = 1 , #sui__chat.queue[sui__chat.query] do
				sui__chat.oaddm(sui__chat.queue[sui__chat.query][i]['frame'], sui__chat.queue[sui__chat.query][i]['text'], sui__chat.queue[sui__chat.query][i]['r'], sui__chat.queue[sui__chat.query][i]['g'], sui__chat.queue[sui__chat.query][i]['b'])
			end
		end

		--* reset
		sui__chat.queue[sui__chat.query] = nil
		sui__chat.query = nil
		
		--* queee
		sui__chat_que()
	end

	local function sui__chat_onAddMessage(frame, text, r,g,b)
		if (event == 'CHAT_MSG_CHANNEL') or
			(event == 'CHAT_MSG_GUILD') or
			(event == 'CHAT_MSG_OFFICER') or
			(event == 'CHAT_MSG_PARTY') or
			(event == 'CHAT_MSG_PARTY_LEADER') or
			(event == 'CHAT_MSG_RAID') or
			(event == 'CHAT_MSG_BATTLEGROUND') or
			(event == 'CHAT_MSG_BATTLEGROUND_LEADER') or
			(event == 'CHAT_MSG_WHISPER_INFORM') or
			(event == 'CHAT_MSG_WHISPER') or
			(event == 'CHAT_MSG_YELL') or
			(event == 'CHAT_MSG_SAY') then
			
			local cleartext = string.gsub(arg1, '|c?.+|r?', '')
			local Arg2 = arg2
			local chch

			--* channel names
			if (event ~= 'CHAT_MSG_WHISPER' and event ~= 'CHAT_MSG_SAY' and event ~= 'CHAT_MSG_YELL' and event ~= 'CHAT_MSG_WHISPER_INFORM') then
				text = string.gsub(text, '[%.%s0-9a-zA-Z]*%]', string.sub(text, 2, 2)..']', 1)
				
				--* guild member colors
				if (event == 'CHAT_MSG_CHANNEL') and sui__chat.guild[Arg2] and Arg2 ~= E.Name then
					text = string.gsub(text, '^[%[0-9A-Z]*%]', '|cff40fb40[' .. string.sub(text, 2, 2)..']|r', 1)
				end
			end

			--* whisp
			if (event == 'CHAT_MSG_WHISPER' or event == 'CHAT_MSG_WHISPER_INFORM') then
				if (event == 'CHAT_MSG_WHISPER') then
					text = string.gsub(text, ' whispers', '', 1)
					text = string.gsub(text, '%['..Arg2..'%]', '< ['..Arg2..']', 1)
				else
					text = string.gsub(text, 'To ', '', 1)
					text = string.gsub(text, '%['..Arg2..'%]', '> ['..Arg2..']', 1)

					sui__chat.whisp[Arg2] = true
				end
				
				--* extra tag for guildies/friends
				if sui__chat.guild[Arg2] then
					text = string.gsub(text, '%['..Arg2..'%]', '|cff40fb40[G] |r['..Arg2..']', 1)
				elseif sui__chat.friends[Arg2] then
					text = string.gsub(text, '%['..Arg2..'%]', '|cfface5ee[F] |r['..Arg2..']', 1)
				end
			end
			
			--* group invite/apply for group
			if (Arg2 ~= E.Name and event ~= 'CHAT_MSG_RAID' and event ~= 'CHAT_MSG_RAID_LEADER' and event ~= 'CHAT_MSG_RAID_WARNING') then
				
				--* LFM/LF1M ~
				if string.find(arg1, 'LF%d?M%s') then
					text = text .. ' |cff'.. sui__chat.sys.gicolor ..'|Happ:' .. Arg2 .. '|h[apply]|h|r'
				
				--* inv 123 ...
				else
					text = string.gsub(text, '%s+invite.?', ' |cff'.. sui__chat.sys.gicolor ..'|Hinv:' .. Arg2 .. '|h[inv]|h|r', 1)
					text = string.gsub(text, '%s+inv.?', 	' |cff'.. sui__chat.sys.gicolor ..'|Hinv:' .. Arg2 .. '|h[inv]|h|r', 1)
					text = string.gsub(text, '%s+123.?', 	' |cff'.. sui__chat.sys.gicolor ..'|Hinv:' .. Arg2 .. '|h[123]|h|r', 1)
				end
			end
			
			--* self highlight
			text = string.gsub(text, '%s+'.. E.Name, ' |cff'.. sui__chat.sys.selfcolor ..''.. E.Name ..'|r', 1)
			
			--* hyperlinks
			if string.find(cleartext, '[0-9a-z]%.[a-z][a-z]') then
				chch = string.match(cleartext,'[htps]-%:?/?/?[0-9a-z%-]+[%.[0-9a-z%-]+]-%.[a-z]+[/[0-9a-zA-Z%-%.%?=&]+]-:?%d?%d?%d?%d?%d?')
				if chch ~= nil then
					text = string.gsub(text, '?', '$1')
					text = string.gsub(text, '-', '$2')
					chch = string.gsub(chch, '?', '$1')
					chch = string.gsub(chch, '-', '$2')
					text = string.gsub(text, chch, '|cff'.. sui__chat.sys.hlcolor ..'|Href:|h['..chch..']|h|r')
					text = string.gsub(text, '$1', '?')
					text = string.gsub(text, '$2', '-')
				end
			end
			
			--* class color
			if namecolor == 1 or sui__chat.temp.MsgLevel > 1 then
				if sui__chat.query and GetTime() > sui__chat.queryTimeOut then sui__chat_queryAddMessages() end
				if db_snap[Arg2] then
					if sui__chat.temp.MsgLevel > 1 and sui__chat_filter(Arg2, db_snap[Arg2]['level'], event) then return end

					if namecolor == 1 then
						text = string.gsub(text, '%['.. Arg2 ..'%]', '[|cff' .. sui__chat.ccolor[db_snap[Arg2]['class']] .. '' .. Arg2 ..'|r]', 1)
					end
				elseif not sui__chat.queue[Arg2] then
					sui__chat.queue[Arg2] = {[1] = {['text'] = text, ['r'] = r, ['g'] = g, ['b'] = b, ['frame'] = frame, ['Type'] = event}}
					if sui__chat.query == nil and not sui__chat.whoOpen then
						sui__chat_que()
					end
				return
				
				--* Message while waiting ? -> Stack Up
				elseif sui__chat.queue[Arg2] then
					sui__chat.queue[Arg2][#sui__chat.queue[Arg2]+1] = {['text'] = text, ['r'] = r, ['g'] = g, ['b'] = b, ['frame'] = frame, ['Type'] = event}
					return
				end
			end
			
		--* sys msg
		elseif (event == 'CHAT_MSG_SYSTEM') then
			if string.sub(text, 0, 9) == '|Hplayer:' then
				if(string.sub(text, -6) == 'group.') then
					local who = string.match(text, '[A-Z][a-z]+', 3)
					if sui__chat.guild[who] then
						text = string.gsub(text, '%['..who..'%]', '|cff40fb40[G]|r['..who..']', 1)
					elseif sui__chat.friends[who] then
						text = string.gsub(text, '%['..who..'%]', '|cfface5ee[F]|r['..who..']', 1)
					end
				elseif sui__chat.query then return end
			end

			if(string.sub(text, -5) == 'total') and sui__chat.query then
				local numres = GetNumWhoResults()
				for i = 1, numres do
					local name, _, level, _, _, _, class = GetWhoInfo(i)
					if not db_snap[name] then
						db_snap[name] = {['class'] = class, ['level'] = level, ['faction'] = E.Faction, ['stamp'] = sui__chat.stamp}
					elseif level < 70 then
						db_snap[name] = {['class'] = class, ['level'] = level, ['faction'] = E.Faction, ['stamp'] = sui__chat.stamp}
					end
				end
				sui__chat_queryAddMessages()
			return
			elseif(string.sub(text, -5) == 'total')	then
				sui__chat_que()
			end
		end
		
		if C['main']._chatTime ~= false then 
			local time = date('%I:%M%p')
			text = string.format('|cff00b5ff[%s]|r %s', gsub(time, '0*(%time+)', '%1', 1), text)
		end
		
		text = gsub(text, '<'..war.AFK..'>', '[|cffffc700'..L_ChatAFK..'|r] ')
		text = gsub(text, '<'..war.DND..'>', '[|cffff0039'..L_ChatDND..'|r] ')
		--text = gsub(text, '^%['..war.RAID_WARNING..'%]', '['..L_ChatRW..']')

		--* to chat
		sui__chat.oaddm(frame, text, r,g,b)
	end

	local function sui__chat_onEvent(self, event, arg, ...)
		if (event == 'FRIENDLIST_UPDATE') then
			local name
			self.friends = {}
			
			--* frendies list
			for i = 1, GetNumFriends() do
				name = GetFriendInfo(i)
				if name ~= nil then self.friends[name] = true end
			end
			return
			
		--* guild
		elseif (event == 'GUILD_ROSTER_UPDATE') then
			local count, name = GetNumGuildMembers(true) , nil
			if count == 0 then return
			
			elseif count ~= self.cguild then
				self.guild = {}
				for i = 1, count do
					self.guild[GetGuildRosterInfo(i)] = true
				end
			end
		return

		--* query from from who update
		elseif (event == 'WHO_LIST_UPDATE') and sui__chat.query then
			if db_snap[sui__chat.query] then
				sui__chat_queryAddMessages()
			end
		return
			
		--* LibWho
		elseif (event == 'MINIMAP_UPDATE_ZOOM') then
			if LibStub then
				if LibStub.libs['LibWho-2.0'] then
					sui__chat.L = LibStub.libs['LibWho-2.0']
				elseif LibStub.libs['WhoLib-1.0'] then
					sui__chat.L = LibStub.libs['WhoLib-1.0']
				end
			end
			sui__chat:UnregisterEvent('MINIMAP_UPDATE_ZOOM')
			return
		end
	end
	
	local function sui__chat_onSendText(this)
		local attr = this:GetAttribute('chatType')
		if (attr == 'CHANNEL' or attr == 'YELL' or attr == 'EMOTE' or attr == 'OFFICER' or attr == 'WHISPER') then
			ChatFrameEditBox:SetAttribute('stickyType', attr)
		end
	end

	function sui__chat_init()
		
		--* snap
		db_snap = suiDB
		
		--* setup
		sui__chat = CreateFrame('frame')
		sui__chat.queue = {}
		sui__chat.query = nil
		sui__chat.queryTime = 0
		sui__chat.stamp = date('%y%m%d')
		sui__chat.whisp = {}
		sui__chat.guild = {}
		sui__chat.guildies = 0
		sui__chat.friends = {}
		sui__chat.numWindows = NUM_CHAT_WINDOWS
		sui__chat.ccolor = M.index.classcolor
		sui__chat.temp = M.index.template
		sui__chat.sys = M.index.syscolor
		
		--* store OrgFx
		sui__chat.oaddm = ChatFrame1.AddMessage
		sui__chat.sendWho = SendWho
		sui__chat.ofriends = FriendsFrame_OnEvent
		
		--* hook new
		ChatFrame_OnHyperlinkShow = sui__chat_onItemRef
		FriendsFrame_OnEvent = sui__chat_FriendsFrame_OnEvent
		SendWho = sui__chat_SendWho
		
		--* message handler
		for i = 1, sui__chat.numWindows do
			if not IsCombatLog(_G['ChatFrame'..i]) then
				_G['ChatFrame'..i].AddMessage = sui__chat_onAddMessage
			end
			_G['ChatFrame'..i]:SetMaxLines(900)
		end

		sui__chat:RegisterEvent('MINIMAP_UPDATE_ZOOM')
		sui__chat:RegisterEvent('GUILD_ROSTER_UPDATE')
		sui__chat:RegisterEvent('FRIENDLIST_UPDATE')
		sui__chat:RegisterEvent('WHO_LIST_UPDATE')
		sui__chat:RegisterEvent('PLAYER_LOGOUT')
		sui__chat:SetScript('OnEvent', sui__chat_onEvent)
		
		--* hooks
		hooksecurefunc('FCF_SetWindowName', sui__chat_onWindowName)
		hooksecurefunc('ChatEdit_OnEscapePressed', function(ceb) ceb:Hide() end)
		hooksecurefunc('ChatEdit_SendText', sui__chat_onSendText)
		hooksecurefunc(WhoFrame, 'Hide', sui__chat_onWho)
		hooksecurefunc(WhoFrame, 'Show', sui__chat_onWho)
	end

	--* register
	table.insert(sui.modules, 'sui__chat_init')