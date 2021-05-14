
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local find, gsub = string.find, string.gsub

	local function LoadSkin()
		QuestFrameGreetingPanel:HookScript('OnShow', function()
		QuestFrameGreetingPanel:StripLayout()

		ET:HandleButton(QuestFrameGreetingGoodbyeButton, true)
		QuestFrameGreetingGoodbyeButton:SetAnchor('BOTTOMRIGHT', -37, 4)

		GreetingText:SetTextColor(1, 1, 1)
		CurrentQuestsText:SetTextColor(1, 0.80, 0.10)
		AvailableQuestsText:SetTextColor(1, 0.80, 0.10)

		QuestGreetingFrameHorizontalBreak:dummy()
		QuestGreetingScrollFrame:Height(402)

		QuestGreetingScrollFrameScrollBar:ShortBar()
		
		--local up = _G['QuestGreetingScrollFrameScrollBar'..'ScrollUpButton']
		--local dn = _G['QuestGreetingScrollFrameScrollBar'..'ScrollDownButton']
		
		--up:SetAlpha(0)
		--dn:SetAlpha(0)

		for i = 1, MAX_NUM_QUESTS do
			local button = _G['QuestTitleButton'..i]

			if not button.isSkinned then
				ET:HandleButtonHighlight(button)
				button.isSkinned = true
			end

			if button:GetFontString() then
				if button:GetFontString():GetText() and button:GetFontString():GetText():find('|cff000000') then
					button:GetFontString():SetText(gsub(button:GetFontString():GetText(), '|cff000000', '|cffFFFF00'))
				end
			end
		end
		end);
	end

	table.insert(ET['SohighUI'], LoadSkin)