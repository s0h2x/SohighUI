
	--*	Auto release the spirit in battlegrounds

	local E, C, L, _ = select(2, shCore()):unpack()
	if C.main.autoRelease ~= true then return end

	local frame = CreateFrame('frame')
	frame:RegisterEvent('PLAYER_DEAD')
	frame:SetScript('OnEvent', function(self, event)
		local inBattlefield = false
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status = GetBattlefieldStatus(i)
			if (status == 'active') then inBattlefield = true end
		end
		if not (HasSoulstone() and CanUseSoulstone()) then
			SetMapToCurrentZone()
			local areaID = GetCurrentMapAreaID() or 0
			if (areaID == 501 or inBattlefield == true) then
				RepopMe()
			end
		end
	end);