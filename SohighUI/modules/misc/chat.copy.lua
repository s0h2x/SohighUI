	
	--* copy chat
	
	local E, C, L, _ = select(2, shCore()):unpack()
	if C['main']._chatCopy ~= true then return end
	
	local _G = _G
	local select = select
	
	local format = string.format
	local gsub = string.gsub
	local tinsert = table.insert
	
	local lines = {}
	local frame = nil
	local editBox = nil
	local font = nil
	local isf = nil
	local sizes = {
		':14:14',
		':15:15',
		':16:16',
		':12:20',
		':14'
	}

	local function CreateCopyFrame()
		frame = CreateFrame('frame', 'CopyFrame', UIParent)
		frame:SetLayout()
		frame:SetShadow()
		frame:Width(540)
		frame:Height(300)
		frame:SetAnchor('CENTER', UIParent, 'CENTER', 0, 100)
		frame:SetFrameStrata('DIALOG')
		tinsert(UISpecialFrames, 'CopyFrame')
		frame:Hide()

		editBox = CreateFrame('EditBox', 'CopyBox', frame)
		editBox:SetMultiLine(true)
		editBox:SetMaxLetters(99999)
		editBox:EnableMouse(true)
		editBox:SetAutoFocus(false)
		editBox:SetFontObject(ChatFontNormal)
		editBox:Width(450)
		editBox:Height(250)
		editBox:SetScript('OnEscapePressed', function() frame:Hide() end)

		editBox:SetScript('OnTextSet', function(self)
			local text = self:GetText()
			for _, size in pairs(sizes) do
				if strfind(text, size) and not strfind(text, size..']') then
					self:SetText(gsub(text, size, ':12:12'))
				end
			end
		end);

		local scrollArea = CreateFrame('ScrollFrame', 'CopyScroll', frame, 'UIPanelScrollFrameTemplate')
		scrollArea:SetAnchor('TOPLEFT', frame, 'TOPLEFT', 8, -30)
		scrollArea:SetAnchor('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -27, 8)
		scrollArea:SetScrollChild(editBox)
		--T.SkinScrollBar(CopyScrollScrollBar)
		CopyScrollScrollBar:ShortBar()

		local closeFrame = CreateFrame('Button', 'CopyCloseButton', frame, 'UIPanelCloseButton')
		closeFrame:CloseTemplate()
		closeFrame:SetAnchor('TOPRIGHT')

		font = frame:CreateFontString(nil, nil, 'GameFontNormal')
		font:Hide()

		isf = true
	end

	local scrollDown = function()
		CopyScroll:SetVerticalScroll((CopyScroll:GetVerticalScrollRange()) or 0)
	end

	local function GetLines(...)
		-- Grab all those 
		local ct = 1
		for i = select('#', ...), 1, -1 do
			local region = select(i, ...)
			if region:GetObjectType() == 'FontString' then
				lines[ct] = tostring(region:GetText())
				ct = ct + 1
			end
		end
		return ct - 1
	end

	local function Copy(cf)
		local _, fontSize = cf:GetFont()
		
		if not isf then CreateCopyFrame() end
		local text = ''
		cf:SetFont(A.font, 0.01, A.fontStyle)
		local lineCt = GetLines(cf:GetRegions())
		local text = table.concat(lines, '\n', 1, lineCt)
		cf:SetFont(A.font, fontSize, A.fontStyle)
		text = text:gsub('|T[^\\]+\\[^\\]+\\[Uu][Ii]%-[Rr][Aa][Ii][Dd][Tt][Aa][Rr][Gg][Ee][Tt][Ii][Nn][Gg][Ii][Cc][Oo][Nn]_(%d)[^|]+|t', '{rt%1}')
		text = text:gsub('|T13700([1-8])[^|]+|t', '{rt%1}')
		text = text:gsub('|T[^|]+|t', '')
		if frame:IsShown() then frame:Hide() return end
		frame:Show()
		editBox:SetText(text)
	end

	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format('ChatFrame%d', i)]
		local button = CreateFrame('Button', format('ButtonCF%d', i), cf)
		button:SetAnchor('BOTTOMRIGHT', 0, 1)
		button:SetSize(20)
		button:SetAlpha(0)
		button:SetLayout()
		button:SetBackdropBorderColor(E.Color.r, E.Color.g, E.Color.b)

		local icon = button:CreateTexture(nil, 'BORDER')
		icon:SetAnchor('CENTER')
		icon:SetTexture('Interface\\BUTTONS\\UI-GuildButton-PublicNote-Up')
		icon:SetSize(16)

		button:SetScript('OnMouseUp', function(self, btn)
			if (btn == 'RightButton') then
				SlashCmdList.CLEARCHAT()
			elseif (btn == 'MiddleButton') then
				RandomRoll(1, 100)
			else
				Copy(cf)
			end
		end);
		
		button:SetScript('OnEnter', function() button:FadeIn() end);
		button:SetScript('OnLeave', function() button:FadeOut() end);

		SlashCmdList.COPY_CHAT = function()
			Copy(_G['ChatFrame1'])
		end
	end