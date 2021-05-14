
	--* gossip frames
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local select = select
	local find, gsub = string.find, string.gsub

	local hooksecurefunc = hooksecurefunc

	local function LoadSkin()

		--* itemtext frame
		ItemTextScrollFrame:StripLayout()
		ItemTextFrame:StripLayout(true)
		ItemTextFrame:SetLayout()
		ItemTextFrame.bg:SetAnchor('TOPLEFT', 13, -13)
		ItemTextFrame.bg:SetAnchor('BOTTOMRIGHT', -32, 74)
		
		ItemTextFrame:SetShadow()
		ItemTextFrame.shadow:SetAnchor('TOPLEFT', 11, -11)
		ItemTextFrame.shadow:SetAnchor('BOTTOMRIGHT', -28, 70)

		ItemTextPageText:SetTextColor(1, 1, 1)
		ItemTextPageText.SetTextColor = E.hoop

		ItemTextPageText:EnableMouseWheel(true)
		ItemTextPageText:SetScript('OnMouseWheel', function(_, value)
			if value > 0 then
				if ItemTextPrevPageButton:IsShown() and ItemTextPrevPageButton:IsEnabled() == 1 then
					ItemTextPrevPage()
				end
			else
				if ItemTextNextPageButton:IsShown() and ItemTextNextPageButton:IsEnabled() == 1 then
					ItemTextNextPage()
				end
			end
		end);

		ItemTextCurrentPage:SetAnchor('TOP', -15, -52)

		ItemTextTitleText:ClearAllPoints()
		ItemTextTitleText:SetAnchor('TOP', ItemTextCurrentPage, 'TOP', 0, 30)

		ItemTextPrevPageButton:ButtonPrevLeft()
		ItemTextPrevPageButton:SetAnchor('CENTER', ItemTextFrame, 'TOPLEFT', 45, -60)

		ItemTextNextPageButton:ButtonNextRight()
		ItemTextNextPageButton:SetAnchor('CENTER', ItemTextFrame, 'TOPRIGHT', -80, -60)

		ItemTextScrollFrameScrollBar:ShortBar()

		ItemTextCloseButton:CloseTemplate()

		--* gossip frame
		GossipFramePortrait:dummy()

		GossipGreetingText:SetTextColor(1, 1, 1)

		GossipFrame:SetLayout()
		GossipFrame.bg:SetAnchor('TOPLEFT', 15, -11)
		GossipFrame.bg:SetAnchor('BOTTOMRIGHT', -30, 0)
		
		GossipFrame:SetShadow()
		GossipFrame.shadow:SetAnchor('TOPLEFT', 11, -9)
		GossipFrame.shadow:SetAnchor('BOTTOMRIGHT', -26, -4)

		GossipFrameNpcNameText:ClearAllPoints()
		GossipFrameNpcNameText:SetAnchor('TOP', GossipFrame, 'TOP', -5, -24)

		GossipFrameGreetingPanel:StripLayout()

		GossipGreetingScrollFrame:Height(392)

		ET:HandleButton(GossipFrameGreetingGoodbyeButton)
		GossipFrameGreetingGoodbyeButton:SetAnchor('BOTTOMRIGHT', -37, 4)

		GossipGreetingScrollFrameScrollBar:ShortBar()
		
		local up = _G['GossipGreetingScrollFrameScrollBar'..'ScrollUpButton']
		local dn = _G['GossipGreetingScrollFrameScrollBar'..'ScrollDownButton']
		up:SetAlpha(0)
		dn:SetAlpha(0)

		GossipFrameCloseButton:CloseTemplate()
		GossipFrameCloseButton:SetAnchor('CENTER', GossipFrame, 'TOPRIGHT', -44, -25)

		for i = 1, NUMGOSSIPBUTTONS do
			local button = _G['GossipTitleButton'..i]
			local obj = select(3, button:GetRegions())

			ET:HandleButtonHighlight(button)

			obj:SetTextColor(1, 1, 1)
		end

		hooksecurefunc('GossipFrameUpdate', function()
			for i = 1, NUMGOSSIPBUTTONS do
				local button = _G['GossipTitleButton'..i]

				if button:GetFontString() then
					if button:GetFontString():GetText() and button:GetFontString():GetText():find('|cff000000') then
						button:GetFontString():SetText(gsub(button:GetFontString():GetText(), '|cff000000', '|cffFFFF00'))
					end
				end
			end
		end)
	end

	table.insert(ET['SohighUI'], LoadSkin)