	
	--* copy URL
	
	local E, C, L, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local gsub = string.gsub

	local SetItemRef_orig = SetItemRef
	function ReURL_SetItemRef(link, text, button, chatFrame)
		if strsub(link, 1, 3) == 'url' then
			local editBoxText = ChatFrameEditBox:GetText()
			local url = strsub(link, 5)
			if not ChatFrameEditBox:IsShown() then
				ChatFrameEditBox:Show()
				ChatEdit_UpdateHeader(ChatFrameEditBox)
			end
			if editBoxText and editBoxText ~= '' then
				ChatFrameEditBox:SetText''
			end
			ChatFrameEditBox:Insert(url)
			ChatFrameEditBox:HighlightText()

		--else
			--SetItemRef_orig(link, text, button, chatFrame)
		end
	end
	SetItemRef = ReURL_SetItemRef

	function ReURL_AddLinkSyntax(chatstring)
		if type(chatstring) == 'string' then
			local extraspace
			if not strfind(chatstring, '^ ') then
				extraspace = true
				chatstring = ' '..chatstring
			end
			chatstring = gsub(chatstring, " www%.([_A-Za-z0-9-]+)%.(%S+)%s?", ReURL_Link("www.%1.%2"))
			chatstring = gsub(chatstring, " (%a+)://(%S+)%s?", ReURL_Link("%1://%2"))
			chatstring = gsub(chatstring, " ([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)%s?", ReURL_Link("%1@%2%3%4"))
			chatstring = gsub(chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?):(%d%d?%d?%d?%d?)%s?", ReURL_Link("%1.%2.%3.%4:%5"))
			chatstring = gsub(chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%s?", ReURL_Link("%1.%2.%3.%4"))
			if extraspace then
				chatstring = strsub(chatstring, 2)
			end
		end
		return chatstring
	end

	function ReURL_Link(url)
		url = ' |cff00FF00|Hurl:'..url..'|h['..url..']|h|r '
		return url
	end

	-- Hook all the AddMessage funcs
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G['ChatFrame'..i]
		local addmessage = frame.AddMessage
		frame.AddMessage = function(self, text, ...) addmessage(self, ReURL_AddLinkSyntax(text), ...) end
	end
