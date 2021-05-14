
	--* infobox
	
	local unpack = unpack

	function info__box()
		local E, C, L, _ = SohighUI:unpack()
		
		local maxLine = 11
		local __num, info = maxLine,
		{
			{ ['text'] = L_GUI_INFO_IBX_A },	--[1]
			{ ['text'] = L_GUI_INFO_IBX_B },	--[2]
			{ ['text'] = L_GUI_INFO_IBX_C },	--[3]
			{ ['text'] = L_GUI_INFO_IBX_D }, 	--[4]
			{ ['text'] = L_GUI_INFO_IBX_E },	--[5]
			{ ['text'] = L_GUI_INFO_IBX_F },	--[6]
			{ ['text'] = L_GUI_INFO_IBX_G },	--[7]
			{ ['text'] = L_GUI_INFO_IBX_H }, 	--[8]
			{ ['text'] = L_GUI_INFO_IBX_I }, 	--[9]
			{ ['text'] = L_GUI_INFO_IBX_J }, 	--[10]
			{ ['text'] = L_GUI_INFO_IBX_K }, 	--[11]
		}
		
		info.__line = {}

		for ibx = 1, __num do
			info.__line[ibx] = infobox:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			info.__line[ibx]:SetText(info[ibx]['text'])
			info.__line[ibx]:SetFont(A.font, 14, A.fontStyle)
		
			if (ibx == 1) then
				info.__line[ibx]:SetAnchor('CENTER', infobox, 'CENTER', 0, -65)
			elseif (ibx == 5) then
				info.__line[ibx]:SetAnchor('CENTER', info.__line[ibx - 1], 'CENTER', 0, -50)
			else
				info.__line[ibx]:SetAnchor('CENTER', info.__line[ibx - 1], 'CENTER', 0, -20)
			end
		end

		logo = infobox:CreateTexture(nil, 'ARTWORK')
		logo:SetAnchor('TOP', infobox, 0, -29)
		logo:SetTexture(A.media.logo)
		logo:SetAlpha(.7)

		info_line = infobox:CreateTexture(nil, 'ARTWORK')
		info_line:SetAnchor('CENTER', logo, 0, -100)
		info_line:SetTexture(A.media.line)
		info_line:SetVertexColor(unpack(A.media.guiInfoBoxColor))

		welcome = infobox:CreateFontString(nil, 'ARTWORK')
		welcome:SetFont(A.font, 16, A.fontStyle)
		welcome:SetAnchor('CENTER', info_line, 0, 20)
		welcome:SetText(L_GUI_INFO_IBX_START)

		addoninfo = infobox:CreateFontString(nil, 'ARTWORK')
		addoninfo:SetAnchor('CENTER', info_line, 0, -3)
		addoninfo:SetFont(A.font, 15, A.fontStyleT)
		addoninfo:SetText(L_GUI_INFO_IBX_ADDON)
		addoninfo:SetTextColor(E.Color.r, E.Color.g, E.Color.b)

		contact = infobox:CreateFontString(nil, 'ARTWORK')
		contact:SetAnchor('CENTER', addoninfo, 0, -110)
		contact:SetFont(A.font, 15, A.fontStyleT)
		contact:SetText(L_GUI_INFO_IBX_CONTACT)
		contact:SetTextColor(E.Color.r, E.Color.g, E.Color.b)

		contact_line = infobox:CreateTexture(nil, 'ARTWORK')
		contact_line:SetAnchor('CENTER', contact, 0, 2)
		contact_line:SetTexture(A.media.line)
		contact_line:SetVertexColor(unpack(A.media.guiInfoBoxColor))
	end