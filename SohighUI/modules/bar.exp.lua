
	--* Exp statusBar
	local E, C, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local next = next
	local format = string.format
	local floor = math.floor
	local min, max = math.min, math.max
	
	local UnitXP, UnitXPMax = UnitXP, UnitXPMax
	
	local showTrueValue = false

	MainMenuExpBar:ClearAllPoints();
	MainMenuExpBar:SetAnchor('TOP', MainMenuBar, 0, -4)
	MainMenuExpBar:Height(5)
	MainMenuExpBar:SetLayout()

    MainMenuExpBar.spark = MainMenuExpBar:CreateTexture(nil, 'OVERLAY', nil, 7)
    MainMenuExpBar.spark:SetTexture('Interface\\CastingBar\\UI-CastingBar-Spark')
	MainMenuExpBar.spark:SetSize(35)
	MainMenuExpBar.spark:SetBlendMode'ADD'

	MainMenuExpBar.rep = MainMenuExpBar:CreateFontString(nil, 'OVERLAY')
	MainMenuExpBar.rep:SetFont(A.font, 12, A.fontStyle)
	MainMenuExpBar.rep:SetAnchor('RIGHT', MainMenuBarExpText, 'LEFT')

	ReputationWatchStatusBar:SetLayout()
	ReputationWatchStatusBar.spark = ReputationWatchStatusBar:CreateTexture(nil, 'OVERLAY', nil, 7)
	ReputationWatchStatusBar.spark:SetTexture('Interface\\CastingBar\\UI-CastingBar-Spark')
	ReputationWatchStatusBar.spark:SetSize(35)
	ReputationWatchStatusBar.spark:SetBlendMode'ADD'
    --ReputationWatchStatusBar.spark:SetVertexColor(colour.r * 1.3, colour.g * 1.3, colour.b * 1.3, .6)

	for i = 0, 3 do
		_G['MainMenuXPBarTexture'..i]:SetTexture''
		_G['ReputationWatchBarTexture'..i]:SetTexture''
		_G['ReputationXPBarTexture'..i]:SetTexture''
	end
	
	--* max level
	--if tonumber(GetCVar'__i') ~= 1 then
		for m = 0, 3 do
			_G['MainMenuMaxLevelBar'..m]:Width(189)
			_G['MainMenuMaxLevelBar'..m]:SetVertexColor(0, 0, 0, .8)
			_G['MainMenuBarMaxLevelBar']:SetAnchor('TOP', MainMenuBar, 100, -11)
		end
	--end

	function MainMenuExpBar_Update()
		local xp, next = UnitXP('player'), UnitXPMax('player')
		MainMenuExpBar:SetMinMaxValues(min(0, xp), next)
		MainMenuExpBar:SetValue(floor(xp))
	end

	hooksecurefunc('ReputationWatchBar_Update', function(newLevel)
		if not newLevel then newLevel = E.Level end
		local n, stand, min, max, abexp = GetWatchedFactionInfo();
		local perc = floor((abexp - min)/(max - min) * 100)

		local rwb = ReputationWatchBar
		local rws = ReputationWatchStatusBar
		local rwsbt = ReputationWatchStatusBarText

		local __x = ((abexp - min)/(max - min)) * rws:GetWidth()

		rwb:SetFrameStrata('LOW')
		rwb:Height(newLevel < MAX_PLAYER_LEVEL and 4 or 5)

		if (newLevel == MAX_PLAYER_LEVEL) then
			rwb:ClearAllPoints();
			rwb:SetAnchor('TOP', MainMenuBar, 0, -4)	--* height
			rwsbt:SetAnchor('CENTER', ReputationWatchBarOverlayFrame, 0, 3)	--* height
			rwsbt:SetDrawLayer('OVERLAY', 7)
			
			if n then rwsbt:SetFont(A.font, 14, A.fontStyle)
				if showTrueValue ~= false then
					rwsbt:SetText(n ..': '.. format(abexp - min) ..' / '.. format(max - min))
				else
					rwsbt:SetText(n ..': '.. perc ..' %into ' .._G['FACTION_STANDING_LABEL'.. stand])
				end
			end
			MainMenuExpBar.spark:Hide()
		else
			TextStatusBar_UpdateTextString(MainMenuExpBar)
			MainMenuExpBar.spark:Show()
			rwsbt:SetText''
		end

		rws:Height(newLevel < MAX_PLAYER_LEVEL and 4 or 5)
    --*	rws:SetStatusBarColor(E.Color.r, E.Color.g, E.Color.b, 1)
		rws.spark:SetAnchor('CENTER', rws, 'LEFT', __x, -1)
	end);

	local w = CreateFrame('frame')
	w:RegisterEvent('CVAR_UPDATE')
	w:RegisterEvent('PLAYER_ENTERING_WORLD')
	w:RegisterEvent('PLAYER_XP_UPDATE')
	w:RegisterEvent('UPDATE_EXHAUSTION')
	w:RegisterEvent('PLAYER_LEVEL_UP')
	w:SetScript('OnEvent', function()
		local xp, max = UnitXP('player'), UnitXPMax('player')
		local __x = (xp/max) * MainMenuExpBar:GetWidth()
		
		MainMenuExpBar.spark:SetAnchor('CENTER', MainMenuExpBar, 'LEFT', __x, -1)
		
		if (w == 'PLAYER_ENTERING_WORLD' or w == 'UPDATE_EXHAUSTION') then
			local rest = GetRestState()
			if (rest == '1') then
				MainMenuExpBar.spark:SetVertexColor(0 * 1.5, .39 * 1.5, .88 * 1.5, 1)
			elseif (rest == '2') then
				MainMenuExpBar.spark:SetVertexColor(.58 * 1.5, 0 * 1.5, .55 * 1.5, 1)
			end
		end
	end);