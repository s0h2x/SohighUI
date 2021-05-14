	
	--* statusbar
	
	local _G = _G
	local unpack = unpack

	function init__sb()
		
		local E, C, L, _ = SohighUI:unpack()
		local path = [[Interface\Addons\SohighUI\styles\arts\sb\]]
		A.FetchMedia = path	..	M.assert.statusbar[C['units'].statusbar]	..	[[.tga]]
	 
		local SbObjects = {
			TooltipStatusBar,
			TradeSkillRankFrame,
			DamageMeterBar,
			shUF:SetAllStatusBars(),
		}
		
		for _, bar in pairs(SbObjects) do
			local _, oldsb = bar:GetStatusBarTexture()
			bar:SetStatusBarTexture(A.FetchMedia, oldsb)
		end
		
		for i = 1, NUM_GROUP_LOOT_FRAMES do
			local bar = _G['GroupLootFrame'..i..'Timer']
			bar:SetStatusBarTexture(A.FetchMedia)
		end
		
		for i = 1, NUM_FACTIONS_DISPLAYED do
			local bar = _G['ReputationBar'..i]
			bar:SetStatusBarTexture(A.FetchMedia)
		end
		
		for i = 1, SKILLS_TO_DISPLAY do
			local bar = _G['SkillRankFrame'..i]
			bar:SetStatusBarTexture(A.FetchMedia)
		end
		
		SbObjects = nil
	end
	
	local w = CreateFrame('frame')
	w:RegisterEvent('PLAYER_ENTERING_WORLD')
	w:SetScript('OnEvent', init__sb)
