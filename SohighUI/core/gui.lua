
	--* GUI
	local E, C, L, _ = select(2, shCore()):unpack()

	if not IsAddOnLoaded('SohighUI_Config') or suiCFG == nil then return end

	for group, options in pairs(suiCFG) do
		if C[group] then local count = 0
			for option, value in pairs(options) do
				if C[group][option] ~= nil then
					if C[group][option] == value then
						suiCFG[group][option] = nil
					else
						count = count+1
						C[group][option] = value
					end
				end
			end
			if count == 0 then suiCFG[group] = nil end
		else
			suiCFG[group] = nil
		end
	end