	
	--* auto decline duel
	
	local E, C, L, _ = select(2, shCore()):unpack()
	if C.main.declineDuel ~= true then return end
	
	local format = string.format
	local disable = false
	
	local frame = CreateFrame('frame')
	frame:RegisterEvent('DUEL_REQUESTED')
	frame:RegisterEvent('PET_BATTLE_PVP_DUEL_REQUESTED')
	frame:SetScript('OnEvent', function(self, event, name)
		if (event == 'DUEL_REQUESTED') then
			CancelDuel()
			RaidNotice_AddMessage(RaidWarningFrame, L_Misc_Duel..name, {r = 0.41, g = 0.8, b = 0.94}, 3)
			E.Suitag(format('|cffffff00'.. L_Misc_Duel.. name .. '.'))
			StaticPopup_Hide('DUEL_REQUESTED')
		end
	end);

	SlashCmdList.DISABLEDECLINE = function()
		if not disable then
			disable = true
		else
			disable = false
		end
	end

	SLASH_DISABLEDECLINE1 = '/dd'
	SLASH_DISABLEDECLINE2 = '/вв'