
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G

	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()
	
		TabardFramePortrait:dummy()

		local TabardFrame = _G['TabardFrame']
		TabardFrame:StripLayout()
		TabardFrame:SetLayout()
		TabardFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		TabardFrame.bg:SetAnchor('BOTTOMRIGHT', -32, 74)
		
		TabardFrame:SetShadow()
		TabardFrame.shadow:SetAnchor('TOPLEFT', 8, -10)
		TabardFrame.shadow:SetAnchor('BOTTOMRIGHT', -28, 70)

		TabardModel:SetLayout()

		ET:HandleButton(TabardFrameCancelButton)
		ET:HandleButton(TabardFrameAcceptButton)

		TabardFrameCloseButton:CloseTemplate()

		ET:HandleRotateButton(TabardCharacterModelRotateLeftButton)
		ET:HandleRotateButton(TabardCharacterModelRotateRightButton)

		TabardFrameCostFrame:StripLayout()
		TabardFrameCustomizationFrame:StripLayout()

		for i = 1, 5 do
			local custom = 'TabardFrameCustomization'..i

			_G[custom]:StripLayout()
			_G[custom..'LeftButton']:ButtonPrevLeft()
			_G[custom..'RightButton']:ButtonNextRight()

			if i > 1 then
				_G[custom]:ClearAllPoints()
				_G[custom]:SetAnchor('TOP', _G['TabardFrameCustomization'..i - 1], 'BOTTOM', 0, -6)
			else
				local point, anchor, point2, x, y = _G[custom]:GetPoint()
				_G[custom]:SetAnchor(point, anchor, point2, x, y + 4)
			end
		end

		TabardCharacterModelRotateLeftButton:SetAnchor('BOTTOMLEFT', 4, 4)
		TabardCharacterModelRotateRightButton:SetAnchor('TOPLEFT', TabardCharacterModelRotateLeftButton, 'TOPRIGHT', 4, 0)
		hooksecurefunc(TabardCharacterModelRotateLeftButton, 'SetAnchor', function(self, point, _, _, xOffset, yOffset)
			if point ~= 'BOTTOMLEFT' or xOffset ~= 4 or yOffset ~= 4 then
				self:SetAnchor('BOTTOMLEFT', 4, 4)
			end
		end)

		hooksecurefunc(TabardCharacterModelRotateRightButton, 'SetAnchor', function(self, point, _, _, xOffset, yOffset)
			if point ~= 'TOPLEFT' or xOffset ~= 4 or yOffset ~= 0 then
				self:SetAnchor('TOPLEFT', TabardCharacterModelRotateLeftButton, 'TOPRIGHT', 4, 0)
			end
		end)
	end

	table.insert(ET['SohighUI'], LoadSkin)