	
	--* Functions
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local unpack = unpack
	local select = select
	local type = type

	local function HideBuffFrame()
		if C.units.playerauras ~= true then return end
		BuffFrame:UnregisterEvent('UNIT_AURA')
		BuffFrame:Hide()
		TemporaryEnchantFrame:Hide()
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
	end
	HideBuffFrame()
	
	E.SetFontString = function(f, fontName, fontHeight, fontStyle)
		local fs = f:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
		fs:SetFont(A.font, 14, A.fontStyle)
		fs:SetJustifyH('LEFT')
		fs:SetShadowColor(0, 0, 0)
		fs:SetShadowOffset(unpack(A.fontShadow))
		
		return fs
	end
	
	--[[*______________Compatibility______________*]]--
	wipe = function(t)
		for k, v in pairs(t) do
			t[k] = nil
		end
	end
	
	function ET:HandleEditBox(f)
		f:SetLayout()
		f.bg:SetFrameLevel(f:GetFrameLevel())

		if f:GetName() then
			if _G[f:GetName()..'Left'] then _G[f:GetName()..'Left']:dummy() end
			if _G[f:GetName()..'Middle'] then _G[f:GetName()..'Middle']:dummy() end
			if _G[f:GetName()..'Right'] then _G[f:GetName()..'Right']:dummy() end
			if _G[f:GetName()..'Mid'] then _G[f:GetName()..'Mid']:dummy() end

			if f:GetName():find('Silver') or f:GetName():find('Copper') then
				f.bg:SetAnchor('BOTTOMRIGHT', -12, -2)
			end
		end
	end
	
	function ET:HandleCheckBox(f, default)
		f:SetNormalTexture(A.media.chbx)
		f:SetPushedTexture''
		f:SetFrameLevel(f:GetFrameLevel() +2)
		f:SetSize(32)

		if f.SetCheckedTexture then
			if default then return end
			local checked = f:CreateTexture(nil, nil, self)
			checked:SetTexture(A.media.chbxCheck)
			checked:SetAnchor('TOPLEFT', f, 6, -6)
			checked:SetAnchor('BOTTOMRIGHT', f, -6, 6)
			f:SetCheckedTexture(checked)
		end

		if f.SetDisabledCheckedTexture then
			local disabled = f:CreateTexture(nil, nil, self)
			disabled:SetTexture(.6, .6, .6, .75)
			disabled:SetAnchor('TOPLEFT', f, 6, -6)
			disabled:SetAnchor('BOTTOMRIGHT', f, -6, 6)
			f:SetDisabledCheckedTexture(disabled)
		end
	end
	
	function ET:HandleItemButton(b, shrinkIcon)
		if b.isSkinned then return end

		local icon = b.icon or b.IconTexture or b.iconTexture
		local texture
		if b:GetName() and _G[b:GetName()..'IconTexture'] then
			icon = _G[b:GetName()..'IconTexture']
		elseif b:GetName() and _G[b:GetName()..'Icon'] then
			icon = _G[b:GetName()..'Icon']
		end

		if icon and icon:GetTexture() then
			texture = icon:GetTexture()
		end

		b:StripLayout()
		b:SetLayout()

		if icon then
			icon:SetTexCoord(unpack(E.TexCoords))

			if shrinkIcon then
				b.bg:SetAllPoints()
				icon:SetInside(b)
			else
				b.bg:SetOutside(icon)
			end
			icon:SetParent(b.bg)

			if texture then
				icon:SetTexture(texture)
			end
		end
		b.isSkinned = true
	end
	
	function ET:HandleRotateButton(btn)
		btn:SetLayout()
		btn:SetSize(btn:GetWidth() -14, btn:GetHeight() -14)

		btn:GetNormalTexture():SetTexCoord(.3, .29, .3, .65, .69, .29, .69, .65)
		btn:GetPushedTexture():SetTexCoord(.3, .29, .3, .65, .69, .29, .69, .65)

		btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

		btn:GetNormalTexture():SetInside()
		btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
		btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
	end
	
	function ET:HandleButton(f, strip, isDeclineButton)
		local name = f:GetName()
		if name then
			local left   = _G[name..'Left']
			local middle = _G[name..'Middle']
			local right	 = _G[name..'Right']

			if left then left:dummy() end
			if middle then middle:dummy() end
			if right then right:dummy() end
		end

		if f.SetNormalTexture then f:SetNormalTexture'' end
		if f.SetHighlightTexture then f:SetHighlightTexture'' end
		if f.SetPushedTexture then f:SetPushedTexture'' end
		if f.SetDisabledTexture then f:SetDisabledTexture'' end

		if strip then f:StripLayout() end

		if isDeclineButton then
			if f.Icon then f.Icon:Hide() end
			if not f.text then
				f.text = f:CreateFontString(nil, 'OVERLAY')
				f.text:SetFont(A.font, 16, A.fontStyle)
				f.text:SetText('x')
				f.text:SetJustifyH('CENTER')
				f.text:SetAnchor('CENTER', f, 'CENTER')
			end
		end

		f:SetLayout()
		f:SetGradient()
	end
	
	function ET:HandleButtonHighlight(f)
		if f.SetHighlightTexture then
			f:SetHighlightTexture''
		end

		local lgr = f:CreateTexture(nil, 'HIGHLIGHT')
		lgr:SetSize(f:GetWidth() * 0.5, f:GetHeight() * 0.95)
		lgr:SetAnchor('LEFT', f, 'CENTER')
		lgr:SetTexture(A.solid)
		lgr:SetGradientAlpha('Horizontal', 0.9, 0.9, 0.9, 0.35, 0.9, 0.9, 0.9, 0)

		local rgr = f:CreateTexture(nil, 'HIGHLIGHT')
		rgr:SetSize(f:GetWidth() * 0.5, f:GetHeight() * 0.95)
		rgr:SetAnchor('RIGHT', f, 'CENTER')
		rgr:SetTexture(A.solid)
		rgr:SetGradientAlpha('Horizontal', 0.9, 0.9, 0.9, 0, 0.9, 0.9, 0.9, 0.35)
	end
	
	--[[*______________Load Blizzard AddOns______________*]]--
	local LBA = CreateFrame('frame')
	LBA:RegisterEvent('ADDON_LOADED')
	LBA:SetScript('OnEvent', function(self, event, addon)
		if IsAddOnLoaded('Skinner') then
			self:UnregisterEvent('ADDON_LOADED')
			return
		end
		for _addon, skinfunc in pairs(ET) do
			if type(skinfunc) == 'function' then
				if (_addon == addon) then
					if skinfunc then skinfunc() end
				end
			elseif type(skinfunc) == 'table' then
				if (_addon == addon) then
					for _, skinfunc in pairs(ET[_addon]) do
						if skinfunc then skinfunc() end
					end
				end
			end
		end
	end);