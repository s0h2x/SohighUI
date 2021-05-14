
	--* hotkeys
	
	local _G = _G
	local replace = string.gsub
	
	local hooksecurefunc = hooksecurefunc

	hooksecurefunc('ActionButton_UpdateHotkeys', function()
		local hotkey = _G[this:GetName() .. 'HotKey']
		local text = hotkey:GetText()

		text = replace(text, '(Mouse Button)', 'M')
		text = replace(text, '(M 4)', 'M-2')
		text = replace(text, '(M 5)', 'M-1')
		text = replace(text, '(Mouse Wheel Up)', 'UP')
		text = replace(text, '(Mouse Wheel Down)', 'DWN')
		text = replace(text, '(Middle Mouse)', 'M3')
		text = replace(text, '(Num Pad)', 'N-')
		text = replace(text, '(Page Up)', 'p-U')
		text = replace(text, '(Page Down)', 'PD')
		text = replace(text, '(Spacebar)', 'SPC')
		text = replace(text, '(Insert)', 'INS')
		text = replace(text, '(Home)', 'HM')
		text = replace(text, '(Delete)', 'Del')
			
		if (hotkey:GetText() == _G['RANGE_INDICATOR']) then
			hotkey:Hide();
		else
			hotkey:SetVertexColor(1, 1, 1);
		end

		hotkey:ClearAllPoints();
		hotkey:SetAnchor('TOPRIGHT', 0, -3)
		hotkey:SetVertexColor(1, 1, 1)
		hotkey:SetText(text)
	end);
