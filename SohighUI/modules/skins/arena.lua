	
	--* arena
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G

	local function LoadSkin()
		ArenaFrame:SetLayout()
		ArenaFrame.bg:SetAnchor('TOPLEFT', 11, -12)
		ArenaFrame.bg:SetAnchor('BOTTOMRIGHT', -34, 74)
		
		ArenaFrame:SetShadow()
		ArenaFrame.shadow:SetAnchor('TOPLEFT', 9, -10)
		ArenaFrame.shadow:SetAnchor('BOTTOMRIGHT', -30, 70)

		ArenaFrame:StripLayout(true)

		ArenaFrameZoneDescription:SetTextColor(1, 1, 1)

		ET:HandleButton(ArenaFrameCancelButton)
		ET:HandleButton(ArenaFrameJoinButton)

		ET:HandleButton(ArenaFrameGroupJoinButton)
		ArenaFrameGroupJoinButton:SetAnchor('RIGHT', ArenaFrameJoinButton, 'LEFT', -2, 0)

		for i = 1, 6 do
			local button = _G['ArenaZone'..i]

			ET:HandleButtonHighlight(button)
		end

		ArenaFrameCloseButton:CloseTemplate()
	end

	table.insert(ET['SohighUI'], LoadSkin)