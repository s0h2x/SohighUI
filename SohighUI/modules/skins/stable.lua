	
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G

	local GetPetHappiness = GetPetHappiness
	local HasPetUI = HasPetUI
	local UnitExists = UnitExists

	local function LoadSkin()
		local PetStableFrame = _G['PetStableFrame']
		PetStableFrame:StripLayout()
		PetStableFrame:SetLayout()
		PetStableFrame.bg:SetAnchor('TOPLEFT', 10, -11)
		PetStableFrame.bg:SetAnchor('BOTTOMRIGHT', -32, 71)
		
		PetStableFrame:SetShadow()
		PetStableFrame.shadow:SetAnchor('TOPLEFT', 8, -9)
		PetStableFrame.shadow:SetAnchor('BOTTOMRIGHT', -28, 67)

		PetStableFramePortrait:dummy()

		ET:HandleButton(PetStablePurchaseButton)

		PetStableFrameCloseButton:CloseTemplate()

		ET:HandleRotateButton(PetStableModelRotateRightButton)
		ET:HandleRotateButton(PetStableModelRotateLeftButton)

		ET:HandleItemButton(_G['PetStableCurrentPet'], true)
		_G['PetStableCurrentPetIconTexture']:SetDrawLayer('OVERLAY')

		for i = 1, NUM_PET_STABLE_SLOTS do
			ET:HandleItemButton(_G['PetStableStabledPet'..i], true)
			_G['PetStableStabledPet'..i..'IconTexture']:SetDrawLayer('OVERLAY')
		end

		PetStablePetInfo:GetRegions():SetTexCoord(0.04, 0.15, 0.06, 0.30)
		PetStablePetInfo:SetFrameLevel(PetModelFrame:GetFrameLevel() +2)
		PetStablePetInfo:SetLayout()
		PetStablePetInfo:SetSize(24)

		hooksecurefunc('PetStable_Update', function()
			local happiness = GetPetHappiness()
			local hasPetUI, isHunterPet = HasPetUI()
			if UnitExists('pet') and hasPetUI and not isHunterPet then return end

			local texture = PetStablePetInfo:GetRegions()
			if happiness == 1 then
				texture:SetTexCoord(0.41, 0.53, 0.06, 0.30)
			elseif happiness == 2 then
				texture:SetTexCoord(0.22, 0.345, 0.06, 0.30)
			elseif happiness == 3 then
				texture:SetTexCoord(0.04, 0.15, 0.06, 0.30)
			end
		end)
	end

	table.insert(ET['SohighUI'], LoadSkin)