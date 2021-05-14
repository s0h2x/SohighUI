
	--*	spellBook skin
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local select = select

	local CreateFrame = CreateFrame
	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()

		local SpellBookFrame = _G['SpellBookFrame']
		SpellBookFrame:StripLayout(true)
		SpellBookFrame:SetLayout()
		SpellBookFrame:SetShadow()
		
		SpellBookFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		SpellBookFrame.bg:SetAnchor('BOTTOMRIGHT', -31, 75)
		
		SpellBookFrame.shadow:SetAnchor('TOPLEFT', 6, -10)
		SpellBookFrame.shadow:SetAnchor('BOTTOMRIGHT', -27, 71)

		for i = 1, 3 do
			local tab = _G['SpellBookFrameTabButton'..i]

			tab:GetNormalTexture():SetTexture(nil)
			tab:GetDisabledTexture():SetTexture(nil)
			
			tab:SetLayout()

			tab.bg:SetAnchor('TOPLEFT', 14, -19)
			tab.bg:SetAnchor('BOTTOMRIGHT', -14, 19)
		end
		
		SpellBookPrevPageButton:ButtonPrevLeft()
		SpellBookNextPageButton:ButtonNextRight()

		SpellBookCloseButton:CloseTemplate()

		for i = 1, SPELLS_PER_PAGE do
			local button = _G['SpellButton'..i]
			local iconTexture = _G['SpellButton'..i..'IconTexture']
			local cooldown = _G['SpellButton'..i..'Cooldown']

			for i = 1, button:GetNumRegions() do
				local region = select(i, button:GetRegions())
				if region:GetObjectType() == 'Texture' then
					if region:GetTexture() ~= 'Interface\\Buttons\\ActionBarFlyoutButton' then
						region:SetTexture(nil)
					end
				end
			end

			if iconTexture then
				iconTexture:SetTexCoord(unpack(E.TexCoords))

				if not button.bg then
					button:SetLayout()
				end
			end

			button.bg = CreateFrame('frame', nil, button)
			button.bg:SetLayout()
			button.bg:SetAnchor('TOPLEFT', -6, 6)
			button.bg:SetAnchor('BOTTOMRIGHT', 115, -6)
			button.bg:SetFrameLevel(button.bg:GetFrameLevel() - 2)

			--[[if cooldown then
				ET:RegisterCooldown(cooldown)
			end--]]
		end

		hooksecurefunc('SpellButton_UpdateButton', function()
			local name = this:GetName()
			local spellName = _G[name..'SpellName']
			local subSpellName = _G[name..'SubSpellName']
			local iconTexture = _G[name..'IconTexture']
			local highlight = _G[name..'Highlight']

			spellName:SetTextColor(1, 0.80, 0.10)
			subSpellName:SetTextColor(1, 1, 1)

			if iconTexture then
				if highlight then
					highlight:SetTexture(1, 1, 1, 0.3)
				end
			end
		end)

		for i = 1, MAX_SKILLLINE_TABS do
			local tab = _G['SpellBookSkillLineTab'..i]

			tab:StripLayout()
			tab:SetLayout()

			tab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			tab:GetNormalTexture():SetInside()
		end

		SpellButton1:SetAnchor('TOPLEFT', SpellBookFrame, 'TOPLEFT', 25, -75)
		SpellButton2:SetAnchor('TOPLEFT', SpellButton1, 'TOPLEFT', 167, 0)
		SpellButton3:SetAnchor('TOPLEFT', SpellButton1, 'BOTTOMLEFT', 0, -17)
		SpellButton4:SetAnchor('TOPLEFT', SpellButton3, 'TOPLEFT', 167, 0)
		SpellButton5:SetAnchor('TOPLEFT', SpellButton3, 'BOTTOMLEFT', 0, -17)
		SpellButton6:SetAnchor('TOPLEFT', SpellButton5, 'TOPLEFT', 167, 0)
		SpellButton7:SetAnchor('TOPLEFT', SpellButton5, 'BOTTOMLEFT', 0, -17)
		SpellButton8:SetAnchor('TOPLEFT', SpellButton7, 'TOPLEFT', 167, 0)
		SpellButton9:SetAnchor('TOPLEFT', SpellButton7, 'BOTTOMLEFT', 0, -17)
		SpellButton10:SetAnchor('TOPLEFT', SpellButton9, 'TOPLEFT', 167, 0)
		SpellButton11:SetAnchor('TOPLEFT', SpellButton9, 'BOTTOMLEFT', 0, -17)
		SpellButton12:SetAnchor('TOPLEFT', SpellButton11, 'TOPLEFT', 167, 0)

		SpellBookPrevPageButton:SetAnchor('CENTER', SpellBookFrame, 'BOTTOMLEFT', 30, 100)
		SpellBookNextPageButton:SetAnchor('CENTER', SpellBookFrame, 'BOTTOMLEFT', 330, 100)

		SpellBookPageText:SetTextColor(1, 1, 1)
		SpellBookPageText:SetAnchor('CENTER', SpellBookFrame, 'BOTTOMLEFT', 185, 0)
	end

	table.insert(ET['SohighUI'], LoadSkin)