	
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

	--// Multi ItemRefTooltip
	local tips = {[1] = _G['ItemRefTooltip']}
	local types = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, currency = true}

	local CreateTip = function(link)
		for k, v in ipairs(tips) do
			for i, tip in ipairs(tips) do
				if tip:IsShown() and tip.link == link then
					tip.link = nil
					HideUIPanel(tip)
					return
				end
			end
			if not v:IsShown() then
				v.link = link
				return v
			end
		end

		local num = #tips + 1
		local tip = CreateFrame('GameTooltip', 'ItemRefTooltip'..num, UIParent, 'GameTooltipTemplate')
		tip:StripLayout(true)
		tip:SetLayout()
		tip:SetShadow()
		tip:SetAnchor('BOTTOM', 0, 80)
		tip:SetSize(128, 64)
		tip:EnableMouse(true)
		tip:SetMovable(true)
		tip:SetClampedToScreen(true)
		tip:RegisterForDrag('LeftButton')
		tip:SetScript('OnDragStart', function(self) self:StartMoving() end)
		tip:SetScript('OnDragStop', function(self) self:StopMovingOrSizing() end)
		tip:HookScript('OnShow', function(self)
			self:SetBackdropColor(1,1,1)
			self:SetBackdropBorderColor(1,1,1)
		end);

		local closeButton = CreateFrame('Button', 'ItemRefTooltip'..num..'CloseButton', tip)
		closeButton:SetAnchor('TOPRIGHT')
		closeButton:CloseTemplate()
		closeButton:SetScript('OnClick', function(self) HideUIPanel(tip) end);

		table.insert(UISpecialFrames, tip:GetName())

		tip.link = link
		tips[num] = tip

		return tip
	end

	local ShowTip = function(tip, link)
		ShowUIPanel(tip)
		if not tip:IsShown() then
			tip:SetOwner(UIParent, 'ANCHOR_PRESERVE')
		end
		tip:SetHyperlink(link)
	end

	local _SetItemRef = SetItemRef
	function SetItemRef(...)
		local link, text, button = ...
		local handled = strsplit(':', link)
		if not IsModifiedClick() and handled and types[handled] then
			local tip = CreateTip(link)
			if tip then
				ShowTip(tip, link)
			end
		else
			return _SetItemRef(...)
		end
	end
