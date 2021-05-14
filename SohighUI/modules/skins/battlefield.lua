
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G

	local function LoadSkin()
	
		BattlefieldFrame:StripLayout(true)
		BattlefieldFrame:SetLayout()
		BattlefieldFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		BattlefieldFrame.bg:SetAnchor('BOTTOMRIGHT', -32, 73)
		
		BattlefieldFrame:SetShadow()
		BattlefieldFrame.shadow:SetAnchor('TOPLEFT', 8, -10)
		BattlefieldFrame.shadow:SetAnchor('BOTTOMRIGHT', -28, 69)

		BattlefieldListScrollFrame:StripLayout()

		BattlefieldListScrollFrameScrollBar:ShortBar()

		for i = 1, BATTLEFIELD_ZONES_DISPLAYED do
			local button = _G['BattlefieldZone'..i]

			ET:HandleButtonHighlight(button)
		end

		ET:HandleButton(BattlefieldFrameCancelButton)
		ET:HandleButton(BattlefieldFrameJoinButton)

		BattlefieldFrameGroupJoinButton:SetAnchor('RIGHT', BattlefieldFrameJoinButton, 'LEFT', -2, 0)
		ET:HandleButton(BattlefieldFrameGroupJoinButton)

		BattlefieldFrameCloseButton:CloseTemplate()
		BattlefieldFrameZoneDescription:SetTextColor(1, 1, 1)
	end

	table.insert(ET['SohighUI'], LoadSkin)