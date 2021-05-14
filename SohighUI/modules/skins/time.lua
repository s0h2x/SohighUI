	
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local select, unpack = select, unpack

	local hooksecurefunc = hooksecurefunc
	local TIMEMANAGER_TITLE = TIMEMANAGER_TITLE

	local function LoadSkin()

		local TimeManagerFrame = _G['TimeManagerFrame']
		TimeManagerFrame:SetSize(190, 240)
		TimeManagerFrame:StripLayout()
		TimeManagerFrame:SetLayout()
		TimeManagerFrame:SetShadow()
		
		TimeManagerFrame:ClearAllPoints()
		TimeManagerFrame:SetAnchor('TOPRIGHT', Minimap, 'BOTTOMLEFT', -10, -5)

		select(7, TimeManagerFrame:GetRegions()):SetAnchor('TOP', 0, -5)

		TimeManagerCloseButton:SetAnchor('TOPRIGHT', 4, 5)
		TimeManagerCloseButton:CloseTemplate()

		TimeManagerStopwatchFrame:SetAnchor('TOPRIGHT', 10, -20)

		TimeManagerStopwatchFrameBackground:SetTexture(nil)

		TimeManagerStopwatchCheck:SetLayout()
		TimeManagerStopwatchCheck:StyleButton(nil, true)

		TimeManagerStopwatchCheck:GetNormalTexture():SetInside()
		TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))

		TimeManagerAlarmTimeFrame:SetAnchor('TOPLEFT', 12, -65)

		--[[S:HandleDropDownBox(TimeManagerAlarmHourDropDown, 80)
		S:HandleDropDownBox(TimeManagerAlarmMinuteDropDown, 80)
		S:HandleDropDownBox(TimeManagerAlarmAMPMDropDown, 80)-]]

		ET:HandleEditBox(TimeManagerAlarmMessageEditBox)

		TimeManagerAlarmEnabledButton:SetAnchor('LEFT', 16, -50)
		TimeManagerAlarmEnabledButton:SetNormalTexture(nil)
		TimeManagerAlarmEnabledButton.SetNormalTexture = E.hoop
		TimeManagerAlarmEnabledButton:SetPushedTexture(nil)
		TimeManagerAlarmEnabledButton.SetPushedTexture = E.hoop
		ET:HandleButton(TimeManagerAlarmEnabledButton)

		TimeManagerMilitaryTimeCheck:SetAnchor('TOPLEFT', 155, -190)
		ET:HandleCheckBox(TimeManagerMilitaryTimeCheck)
		ET:HandleCheckBox(TimeManagerLocalTimeCheck)

		-- StopWatch
		StopwatchFrame:StripLayout()
		StopwatchFrame:SetLayout()
		StopwatchFrame.bg:SetAnchor('TOPLEFT', 6, -9)
		StopwatchFrame.bg:SetAnchor('BOTTOMRIGHT', 4, 15)
		
		StopwatchFrame:SetShadow()
		StopwatchFrame.shadow:SetAnchor('TOPLEFT', 4, -7)
		StopwatchFrame.shadow:SetAnchor('BOTTOMRIGHT', 6, 11)

		StopwatchTabFrame:StripLayout()
		StopwatchTabFrame:SetLayout()
		StopwatchTabFrame.bg:SetAnchor('TOPLEFT', 5, 7)
		StopwatchTabFrame.bg:SetAnchor('BOTTOMRIGHT', 3, 11)
		StopwatchTabFrame:SetAnchor('TOP', 1, 5)

		StopwatchCloseButton:CloseTemplate()
		StopwatchCloseButton:SetSize(32)
		StopwatchCloseButton:SetAnchor('TOPRIGHT', StopwatchTabFrame.bg, 6, 6)

		StopwatchPlayPauseButton:SetLayout()
		StopwatchPlayPauseButton:SetSize(12)
		StopwatchPlayPauseButton:SetNormalTexture([[Interface\AddOns\SohighUI\styles\arts\tmp\play]])
		StopwatchPlayPauseButton:SetHighlightTexture('')
		StopwatchPlayPauseButton.bg:SetOutside(StopwatchPlayPauseButton, 2, 2)
		--StopwatchPlayPauseButton:HookScript('OnEnter', S.SetModifiedBackdrop)
		--StopwatchPlayPauseButton:HookScript('OnLeave', S.SetOriginalBackdrop)
		StopwatchPlayPauseButton:SetAnchor('RIGHT', StopwatchResetButton, 'LEFT', -4, 0)

		ET:HandleButton(StopwatchResetButton)
		StopwatchResetButton:SetSize(16)
		StopwatchResetButton:SetNormalTexture([[Interface\AddOns\SohighUI\styles\arts\tmp\reset]])
		StopwatchResetButton:SetAnchor('RIGHT', StopwatchFrame, 'RIGHT', 0, 3)

		local function SetPlayTexture()
			StopwatchPlayPauseButton:SetNormalTexture([[Interface\AddOns\SohighUI\styles\arts\tmp\play]])
		end
		local function SetPauseTexture()
			StopwatchPlayPauseButton:SetNormalTexture([[Interface\AddOns\SohighUI\styles\arts\tmp\pause]])
		end
		hooksecurefunc('Stopwatch_Play', SetPauseTexture)
		hooksecurefunc('Stopwatch_Pause', SetPlayTexture)
		hooksecurefunc('Stopwatch_Clear', SetPlayTexture)
	end

	table.insert(ET['SohighUI'], LoadSkin)