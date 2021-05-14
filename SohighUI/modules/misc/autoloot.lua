
	local E, C, L, _ = select(2, shCore()):unpack()
	if C.main.autoLoot ~= true then return end

	----------------------------------------------------------------------------------------
	--	Loot roll confirmation (tekKrush by Tekkub)
	----------------------------------------------------------------------------------------
	local frame = CreateFrame('frame')
	frame:RegisterEvent('CONFIRM_LOOT_ROLL')
	frame:RegisterEvent('LOOT_BIND_CONFIRM')
	frame:SetScript('OnEvent', function(self, event, id)
		for i = 1, STATICPOPUP_NUMDIALOGS do
			local frame = _G['StaticPopup'..i]
			if (frame.which == 'CONFIRM_LOOT_ROLL' or frame.which == 'LOOT_BIND') and frame:IsVisible() then
				StaticPopup_OnClick(frame, 1)
			end
		end
	end);