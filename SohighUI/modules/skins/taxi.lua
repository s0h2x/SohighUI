
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G

	local function LoadSkin()
		local TaxiFrame = _G['TaxiFrame']
		TaxiFrame:SetLayout()
		TaxiFrame.bg:SetAnchor('TOPLEFT', 11, -12)
		TaxiFrame.bg:SetAnchor('BOTTOMRIGHT', -34, 75)

		TaxiFrame:StripLayout()

		TaxiPortrait:dummy()

		TaxiCloseButton:CloseTemplate()

		TaxiRouteMap:SetLayout()
	end

	table.insert(ET['SohighUI'], LoadSkin)