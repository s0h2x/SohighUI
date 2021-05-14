	
	--* loot skin
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end
	
	local _G = _G
	local unpack = unpack
	
	local LOOTFRAME_NUMBUTTONS = LOOTFRAME_NUMBUTTONS

	local function LoadSkin()
		--* loot frame
		if (IsAddOnLoaded('AdiBags') or IsAddOnLoaded('ArkInventory') or IsAddOnLoaded('cargBags_Nivaya') or IsAddOnLoaded('cargBags') or IsAddOnLoaded('Bagnon') or IsAddOnLoaded('Combuctor') or IsAddOnLoaded('TBag') or IsAddOnLoaded('BaudBag')) then return end

		LootFrame:StripLayout(true)
		LootFrame:SetLayout()
		LootFrame:SetShadow()
		
		LootFrame.bg:SetAnchor('TOPLEFT', 7, -2)
		LootFrame.bg:SetAnchor('BOTTOMRIGHT', -60, 35)
		
		LootFrame.shadow:SetAnchor('TOPLEFT', 3, 0)
		LootFrame.shadow:SetAnchor('BOTTOMRIGHT', -56, 31)
		
		LootFrameUpButton:ButtonPrevLeft()
		LootFrameUpButton:SetAnchor('BOTTOMLEFT', -5, 20)

		LootFrameDownButton:ButtonNextRight()
		LootFrameDownButton:SetAnchor('BOTTOMLEFT', 145, 20)
		
		LootCloseButton:CloseTemplate()

		for i = 1, LOOTFRAME_NUMBUTTONS do
			local slot = _G['LootButton'..i]
			local icon = _G['LootButton'..i..'IconTexture']
			local name = _G['LootButton'..i..'NameFrame']

			slot:SetNormalTexture''
			slot:SetLayout()
			
			slot.bg:SetAnchor('TOPLEFT', -1, 1)
			slot.bg:SetAnchor('BOTTOMRIGHT', 1, -.7)

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:ClearAllPoints()
			icon:SetAnchor('TOPLEFT', 2, -2)
			icon:SetAnchor('BOTTOMRIGHT', -2, 2)

			name:Hide()
		end
	end

	table.insert(ET['SohighUI'], LoadSkin)