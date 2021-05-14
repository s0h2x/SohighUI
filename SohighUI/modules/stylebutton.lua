	
	local E, C, _ = select(2, shCore()):unpack()
	--if C['bar'].enable ~= true then return end

	-- By Tukz
	local _G = _G
	local ipairs = ipairs
	local tostring = tostring
	local match = string.match
	local gsub = string.gsub
	
	local hooksecurefunc = hooksecurefunc

	local function StyleNormalButton(self)
		self = this
		local name = self:GetName()
		if name:match('MultiCast') then return end
		
		local button = self
		local icon	 = _G[name..'Icon']
		local count	 = _G[name..'Count']
		local flash	 = _G[name..'Flash']
		local hotkey = _G[name..'HotKey']
		local border = _G[name..'Border']
		local macro  = _G[name..'Name']
		local normal = _G[name..'NormalTexture']
		local float  = _G[name..'FloatingBG']

		flash:SetTexture''
		button:SetNormalTexture''

		if float then
			float:Show()
			float = E.hoop
		end

		count:ClearAllPoints()
		count:SetAnchor('BOTTOMRIGHT', 0, 2)
		count:SetFont(A.font, 12, A.fontStyle)
		count:SetShadowOffset(E.Mult, -E.Mult)
		count:SetShadowColor(0, 0, 0, 1)
		
		hotkey:SetFontObject(NumberFontNormal)
		hotkey:SetTextColor(1, .8, 0)

		if macro then
			if C['bar'].macroName ~= false then
				macro:Show()
				macro:SetFont(A.font, 12, A.fontStyle)
				macro:ClearAllPoints()
				macro:SetAnchor('BOTTOM', 2, 2)
				macro:SetJustifyH('CENTER')
				macro:SetShadowOffset(E.Mult, -E.Mult)
				macro:SetShadowColor(0, 0, 0, 1)
				macro:SetVertexColor(1, 0.82, 0, 1)
			else
				macro:Hide()
			end
		end

		if not button.isSkinned then
			if self:GetHeight() ~= M.buttonSize and not InCombatLockdown() and not name:match('ExtraAction') then
				self:SetSize(M.buttonSize)
			end

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetDrawLayer('BORDER')
			icon:SetInside()
			
			button:SetCheckedTexture(A.abTexHighlight)
			button:GetCheckedTexture():SetAllPoints(normal)

			button:SetPushedTexture(A.abTexPushed)
			button:GetPushedTexture():SetAllPoints(normal)

			--button:SetHighlightTexture()
			--button:GetHighlightTexture():SetAllPoints(normal)
			
			if border then
				local btex = button:CreateTexture(nil, self)
				btex:SetParent(button)
				btex:SetAnchor('TOPRIGHT', button, 1, 1)
				btex:SetAnchor('BOTTOMLEFT', button, -1, -1)
				btex:SetTexture(A.abTexNormal)
				btex:SetSize(button:GetSize())
				btex:SetVertexColor(.62, .62, .57, 1)
				border:SetTexture(btex)
			end
			
		--[[if (not button.Shadow) then
			local Shadow = button:CreateTexture(nil, 'BACKGROUND')
			Shadow:SetParent(button)
			Shadow:SetAnchor('TOPRIGHT', normal, 2.6, 2.6)
			Shadow:SetAnchor('BOTTOMLEFT', normal, -2.6, -2.6)
			Shadow:SetTexture(A.auraShadow)
			Shadow:SetVertexColor(0, 0, 0, 1)
		end--]]

			button.isSkinned = true
		end
		
		if (not button.Background) then
			if C['bar'].background ~= false then
				local Background = button:CreateTexture(nil, 'BACKGROUND')
				Background:SetParent(button)
				Background:SetTexture(A.abBackground)
				Background:SetAnchor('TOPRIGHT', button, 14, 12)
				Background:SetAnchor('BOTTOMLEFT', button, -14, -16)
			end
		end

		if normal then
			normal:ClearAllPoints()
			normal:SetAnchor('TOPRIGHT', button, 2, 2)
			normal:SetAnchor('BOTTOMLEFT', button, -2, -2)
		end
	end

	local function StyleSmallButton(normal, button, icon, name, pet)
		local flash = _G[name..'Flash']
		button:SetNormalTexture''
		button.SetNormalTexture = E.hoop

		flash:SetTexture(0.8, 0.8, 0.8, 0.5)
		flash:SetAnchor('TOPLEFT', button, 2, -2)
		flash:SetAnchor('BOTTOMRIGHT', button, -2, 2)

		if not button.isSkinned then
			button:SetSize(M.buttonSize -6)

			button:SetCheckedTexture(A.abTexHighlight)
			button:GetCheckedTexture():SetAllPoints(normal)

			button:SetPushedTexture(A.abTexPushed)
			button:GetPushedTexture():SetAllPoints(normal)

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetDrawLayer('BORDER')
			icon:ClearAllPoints()
			icon:SetAnchor('TOPLEFT', button, 2, -2)
			icon:SetAnchor('BOTTOMRIGHT', button, -2, 2)
			
			local border = _G[name..'Border']
			if border then
				local btex = button:CreateTexture(nil, self)
				btex:SetParent(button)
				btex:SetAnchor('TOPRIGHT', button, 1, 1)
				btex:SetAnchor('BOTTOMLEFT', button, -1, -1)
				btex:SetTexture(A.abTexNormal)
				btex:SetSize(button:GetSize())
				btex:SetVertexColor(.62, .62, .57, 1)
				border:SetTexture(btex)
			end

			if pet then
				local autocast = _G[name..'AutoCastable']
				autocast:SetSize((M.buttonSize * 2) - 10)
				autocast:ClearAllPoints()
				autocast:SetAnchor('CENTER', button, 0, 0)

				local cooldown = _G[name..'Cooldown']
				cooldown:SetSize(M.buttonSize - 2)
			end

			button.isSkinned = true
		end
		
		--[[if not button.shadow then
			local Shadow = button:CreateTexture(nil, 'BACKGROUND')
			Shadow:SetParent(button)
			Shadow:SetAnchor('TOPRIGHT', normal, 1, 1)
			Shadow:SetAnchor('BOTTOMLEFT', normal, -1, -1)
			Shadow:SetTexture(A.auraShadow)
			Shadow:SetVertexColor(0, 0, 0, .6)
		end--]]

		if normal then
			normal:ClearAllPoints()
			normal:SetAnchor('TOPRIGHT', button, 2, 2)
			normal:SetAnchor('BOTTOMLEFT', button, -2, -2)
		end
	end

	local function StyleShift()
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			local name = 'ShapeshiftButton'..i
			local button = _G[name]
			local icon	 = _G[name..'Icon']
			local normal = _G[name..'NormalTexture']
			StyleSmallButton(normal, button, icon, name)
		end
	end

	local function StylePet()
		for i = 1, NUM_PET_ACTION_SLOTS do
			local name = 'PetActionButton'..i
			local button = _G[name]
			local icon	 = _G[name..'Icon']
			local normal = _G[name..'NormalTexture2']
			StyleSmallButton(normal, button, icon, name, true)
		end
	end

	--// Rescale cooldown spiral to fix texture
	local buttonNames = {
		'ActionButton',
		'MultiBarBottomLeftButton',
		'MultiBarBottomRightButton',
		'MultiBarLeftButton',
		'MultiBarRightButton',
		'ShapeshiftButton',
		'PetActionButton',
		'MultiCastActionButton'
	}

	for _, name in ipairs(buttonNames) do
		for index = 1, NUM_ACTIONBAR_BUTTONS do
			local buttonName = name..tostring(index)
			local button = _G[buttonName]
			local cooldown = _G[buttonName..'Cooldown']

			if (button == nil or cooldown == nil) then
				break
			end

			cooldown:ClearAllPoints()
			cooldown:SetInside()
		end
	end

	do
		for i = 1, 10 do
			StyleShift(_G['ShapeshiftButton'..i])
			StylePet(_G['PetActionButton'..i])
		end
	end

	hooksecurefunc('ActionButton_Update', StyleNormalButton)