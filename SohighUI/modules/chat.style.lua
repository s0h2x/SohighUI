
	--* chat frame
	
	local E, C, _ = select(2, shCore()):unpack()
	if C['main']._chat ~= true then return end
	
	local _G = _G
	
	local hooksecurefunc = hooksecurefunc
	
    local blacklist = {[ChatFrame2] = true,}
    local button = {'UpButton', 'DownButton', 'BottomButton'}
	
	local orig = {}
	
    orig.FCF_SetTabPosition = FCF_SetTabPosition
    orig.FCF_FlashTab = FCF_FlashTab
	
	--* styled tab
	local function tab(f)
		if not f.styled then
		
			local tab = _G[f:GetName()..'Tab']
			local a, b, c = tab:GetRegions()

			for _, v in pairs({ a, b, c }) do v:Hide() end

			local flash = _G[f:GetName()..'TabFlash']
			local a = flash:GetRegions()
			a:SetTexture''

			local text = _G[f:GetName()..'TabText']
			text:SetJustifyH'CENTER'
			text:Width(40)
			text:SetDrawLayer('OVERLAY', 7)
			text:SetTextColor(E.Color.r, E.Color.g, E.Color.b)

			local hover = E.SetFontString(tab, fontName, 13, fontStyle)
			hover:SetAnchor('RIGHT', text, 'LEFT')
			hover:SetTextColor(1, 1, 1)
			hover:SetText''

			tab:GetHighlightTexture():SetTexture''

			local t = text:GetText()
			tab:SetScript('OnEnter', function()
				hover:SetText'> '
				GameTooltip_AddNewbieTip(CHAT_OPTIONS_LABEL, 1.0, 1.0, 1.0, NEWBIE_TOOLTIP_CHATOPTIONS, 1)
			end);
			tab:SetScript('OnLeave', function()
				hover:SetText''
				GameTooltip:Hide()
			end);

			if C['main']._chatTab ~= false then
				hooksecurefunc(tab, 'SetAlpha', function(t, alpha)
					if alpha ~= 1 and (not t.isDocked or SELECTED_CHAT_FRAME:GetID() == t:GetID()) then
						UIFrameFadeRemoveFrame(t)
						t:SetAlpha(1)
					elseif alpha < 0.6 then
						UIFrameFadeRemoveFrame(t)
						t:SetAlpha(0.6)
					end
				end);
			end

			f.styled = true
		
		end
	end

	local function addEditBox()
		local x = ({ChatFrameEditBox:GetRegions()})
		
		x[6]:SetAlpha(0)
		x[7]:SetAlpha(0)
		x[8]:SetAlpha(0)
		
		ChatFrameEditBox:SetAltArrowKeyMode(nil)
		ChatFrameEditBox:ClearAllPoints()
		
		if C['main']._chatOrient ~= false then
			ChatFrameEditBox:SetAnchor('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', -2, 18)
			ChatFrameEditBox:SetAnchor('BOTTOMRIGHT', ChatFrame1, 'TOPRIGHT',  2, 18)
		else
			ChatFrameEditBox:SetAnchor('TOPLEFT', ChatFrame1, 'BOTTOMLEFT', -2, -18)
			ChatFrameEditBox:SetAnchor('TOPRIGHT', ChatFrame1, 'BOTTOMRIGHT',  2, -18)
		end
	end

    local function scroll(self, d)
    	if d > 0 then
    		if IsShiftKeyDown() then
    			self:ScrollToTop()
    		else
    			self:ScrollUp()
    		end
    	elseif d < 0 then
    		if IsShiftKeyDown() then
    			self:ScrollToBottom()
    		else
    			self:ScrollDown()
    		end
    	end
    end

    for i = 1, NUM_CHAT_WINDOWS do
    	local f = _G['ChatFrame'..i]
    	f:EnableMouseWheel(true)
    	f:SetFading(false)
    	f:SetScript('OnMouseWheel', scroll)

        for _, v in pairs(button) do
    		v = _G['ChatFrame'..i..v]
    		v:Hide()
			v:dummy()
    	end

        if not blacklist[f] then
    		f.AddMessage = AddMessage
    	end
    end

	if C['main']._chatEmote ~= false then
		ChatFrameMenuButton:GetNormalTexture():SetVertexColor(E.Color.r, E.Color.g, E.Color.b)
		ChatFrameMenuButton:ClearAllPoints()
		ChatFrameMenuButton:SetAnchor('BOTTOMRIGHT', ChatFrameEditBox, 'BOTTOMLEFT', -3, -10)
		ChatFrameMenuButton:SetParent(ChatFrameEditBox)
	else
		ChatFrameMenuButton:Hide()
		ChatFrameMenuButton:dummy()
	end
	
	function FCF_SetTabPosition(f, x)
		orig.FCF_SetTabPosition(f, x)
		tab(f)
	end

	--* sticky
	local channel =	{
		'SAY', 'YELL', 'PARTY', 'GUILD', 'OFFICER', 
		'RAID', 'RAID_WARNING', 'BATTLEGROUND', 
		'WHISPER', 'CHANNEL', 'EMOTE',
	}
	
    for _, v in pairs(channel) do
        ChatTypeInfo[v].sticky = 1
    end

	local _w = CreateFrame('frame')
	_w:RegisterEvent('PLAYER_LOGIN')
	_w:SetScript('OnEvent', addEditBox)
