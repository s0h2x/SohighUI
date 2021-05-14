
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack = unpack

	local function LoadSkin()
		local MacroFrame = _G['MacroFrame']
		MacroFrame:StripLayout()
		MacroFrame:SetLayout()
		MacroFrame.bg:SetAnchor('TOPLEFT', 10, -11)
		MacroFrame.bg:SetAnchor('BOTTOMRIGHT', -32, 71)
		
		MacroFrame:SetShadow()
		MacroFrame.shadow:SetAnchor('TOPLEFT', 8, -9)
		MacroFrame.shadow:SetAnchor('BOTTOMRIGHT', -28, 67)

		--[[MacroFrame.bg = CreateFrame('Frame', nil, MacroFrame)
		MacroFrame.bg:SetTemplate('Transparent', true)
		MacroFrame.bg:SetAnchor('TOPLEFT', MacroButton1, -10, 10)
		MacroFrame.bg:SetAnchor('BOTTOMRIGHT', MacroButton18, 10, -10)--]]

		MacroFrameTextBackground:StripLayout()
		MacroFrameTextBackground:SetLayout()
		MacroFrameTextBackground.bg:SetAnchor('TOPLEFT', 6, -3)
		MacroFrameTextBackground.bg:SetAnchor('BOTTOMRIGHT', -3, 3)

		local Buttons = {
			'MacroFrameTab1',
			'MacroFrameTab2',
			'MacroDeleteButton',
			'MacroNewButton',
			'MacroExitButton',
			'MacroEditButton',
		}

		for i = 1, #Buttons do
			_G[Buttons[i]]:StripLayout()
			ET:HandleButton(_G[Buttons[i]])
		end

		for i = 1, 2 do
			local tab = _G['MacroFrameTab'..i]

			tab:Height(22)

			if i == 1 then
				tab:SetAnchor('TOPLEFT', MacroFrame, 'TOPLEFT', 60, -39)
			else
				tab:SetAnchor('LEFT', MacroFrameTab1, 'RIGHT', 4, 0)
			end
		end

		MacroFrameCloseButton:CloseTemplate()

		MacroFrameScrollFrameScrollBar:ShortBar()

		MacroEditButton:ClearAllPoints()
		MacroEditButton:SetAnchor('BOTTOMLEFT', MacroFrameSelectedMacroButton, 'BOTTOMRIGHT', 10, 0)

		MacroFrameSelectedMacroName:SetAnchor('TOPLEFT', MacroFrameSelectedMacroBackground, 'TOPRIGHT', -4, -10)

		MacroFrameSelectedMacroButton:StripLayout()
		MacroFrameSelectedMacroButton:SetLayout()
		--MacroFrameSelectedMacroButton:StyleButton(nil, true)

		MacroFrameSelectedMacroButtonIcon:SetTexCoord(unpack(E.TexCoords))
		MacroFrameSelectedMacroButtonIcon:SetInside()

		MacroFrameCharLimitText:ClearAllPoints()
		MacroFrameCharLimitText:SetAnchor('BOTTOM', MacroFrameTextBackground, 0, -9)

		for i = 1, MAX_MACROS do
			local button = _G['MacroButton'..i]
			local icon = _G['MacroButton'..i..'Icon']

			if button then
				button:StripLayout()
				button:SetLayout()
				--button:StyleButton(nil, true)
			end

			if icon then
				icon:SetTexCoord(unpack(E.TexCoords))
				icon:SetInside()
			end
		end

		-- PopUp Frame
		--S:HandleIconSelectionFrame(MacroPopupFrame, NUM_MACRO_ICONS_SHOWN, 'MacroPopupButton', 'MacroPopup')

		MacroPopupFrame:SetAnchor('TOPLEFT', MacroFrame, 'TOPRIGHT', -41, 1)

		MacroPopupEditBox:SetAnchor('TOPLEFT', 20, -35)

		MacroPopupScrollFrame:SetLayout()
		MacroPopupScrollFrame.bg:SetAnchor('TOPLEFT', 57, 2)
		MacroPopupScrollFrame.bg:SetAnchor('BOTTOMRIGHT', -9, 4)

		MacroPopupScrollFrameScrollBar:ShortBar()
		MacroPopupScrollFrameScrollBar:ClearAllPoints()
		MacroPopupScrollFrameScrollBar:SetAnchor('TOPRIGHT', MacroPopupScrollFrame, 12, -14)
		MacroPopupScrollFrameScrollBar:SetAnchor('BOTTOMRIGHT', MacroPopupScrollFrame, 0, 20)

		MacroPopupCancelButton:SetAnchor('BOTTOMRIGHT', MacroPopupFrame, -26, 13)
	end

	ET['Blizzard_MacroUI'] = LoadSkin