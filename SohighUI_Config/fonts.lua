
	--* fonts
	
	local _G = _G
	local unpack = unpack
	
	function init__fonts()
		
		local E, C, L, _ = SohighUI:unpack()
		local path = [[Interface\Addons\SohighUI\styles\fonts\]]
		A.Fetch = path .. M.assert.font[C['main'].font] .. [[.ttf]]

		STANDARD_TEXT_FONT	= 	A.Fetch
		UNIT_NAME_FONT	= 	A.Fetch
		DAMAGE_TEXT_FONT	= 	A.Fetch
		NAMEPLATE_FONT	= 	A.Fetch
		NAMEPLATE_SPELLCAST_FONT	= 	A.Fetch
		
		_G['UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT'] = 13
		_G['CHAT_FONT_HEIGHTS'] = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
	 
		local BlizFontObjects = {
			
		-- Fonts.xml
			
			SystemFont,
			GameFontNormal,
			GameFontNormalSmall,
			GameFontNormalLarge,
			GameFontNormalHuge,
			GameFontHighlightSmall,
			GameTooltipTextSmall,
			GameTooltipHeaderText,
			GameTooltipText,
			BossEmoteNormalHuge,
			GameFontBlack,
			NumberFontNormal,
			NumberFontNormalSmall,
			NumberFontNormalLarge,
			NumberFontNormalHuge,
			ChatFontNormal,
			ChatFontSmall,
			ChatFrame,
			CombatLogFont,
			--QuestTitleFont,
			QuestFont,
			QuestFontHighlight,
			ItemTextFontNormal,
			MailTextFontNormal,
			SubSpellFont,
			DialogButtonNormalText,
			TextStatusBarText,
			TextStatusBarTextSmall,
			CombatTextFont,
			WorldMapTextFont,
			shUF:SetAllFonts(),
			
		}
	 
		for _, FontObject in pairs(BlizFontObjects) do
			local _, oldSize, oldStyle  = FontObject:GetFont()
			FontObject:SetFont(A.Fetch, C['main'].fontSize.value, oldStyle)
		end
		
		for _, ZoneObject in pairs({ZoneTextFont, SubZoneTextFont, PVPInfoTextFont}) do
			local _, oldSize, oldStyle  = ZoneObject:GetFont()
			ZoneObject:SetFont(A.Fetch, C['main'].fontSize.value+10, A.fontStyle)
		end
		
		for _, QuestTitle in pairs({QuestTitleFont}) do
			local _, oldSize, oldStyle  = QuestTitle:GetFont()
			QuestTitle:SetFont(A.Fetch, oldSize, A.fontStyle)
		end
		
		--* channel list
		for i = 1, MAX_CHANNEL_BUTTONS do
			local f = _G['ChannelButton'..i..'Text']
			f:SetFontObject(GameFontNormalSmall)
		end

		--* chat fonts
		for i = 1, 12 do
			local f = _G['ChatFrame'..i]
			local tab = _G['ChatFrame'..i..'Tab']
			if f then
				_G['ChatFrame'..i]:SetFont(A.Fetch, C['main'].fontSize.value, oldStyle)
				tab:SetFont(A.Fetch, C['main'].fontSize.value-1, A.fontStyle)
			end
		end
	
		BlizFontObjects = nil
	end

	
	local w = CreateFrame('frame')
	w:RegisterEvent('PLAYER_ENTERING_WORLD')
	w:SetScript('OnEvent', init__fonts)
