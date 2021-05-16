	
	--* style short 12x12
	
	local E, C, _ = select(2, shCore()):unpack()
	if C['bar'].styleAB ~= 2 then return end;
	
	local _G = _G
	local unpack = unpack
	local tostring = tostring

	MultiBarRightButton1:ClearAllPoints();
	MultiBarRightButton1:SetAnchor(unpack(C.Anchors.abRightB))

	MultiBarLeftButton1:ClearAllPoints();
	MultiBarLeftButton1:SetAnchor(unpack(C.Anchors.abLeftB))
	
	MultiBarBottomRight:ClearAllPoints()
	MultiBarBottomRight:SetAnchor(unpack(C.Anchors.abShortBR))
	
	MainMenuMaxLevelBar0:SetAnchor(unpack(C.Anchors.abShortMaxLvl))
	MainMenuXPBarTexture0:SetAnchor(unpack(C.Anchors.abShortXPTex1))
	MainMenuXPBarTexture1:SetAnchor(unpack(C.Anchors.abShortXPTex2))
	
	local suiM = _G['MenuButton']
	local bpack = _G['MenuButtonPack']

	suiM:SetAnchor(unpack(C.Anchors.abShortStyleMenu))
	bpack:SetAnchor(unpack(C.Anchors.abShortStyleBpack))
	
	local abExp = {
		'MainMenuBar',
		'MainMenuExpBar',
		'MainMenuBarMaxLevelBar',
		'ReputationWatchStatusBar'
	}
	
	for _, aExp in pairs(abExp) do
		_G[aExp]:Width(512)
	end

	--* endCap
	for f, eCap in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
		eCap:SetAnchor('BOTTOM', MainMenuBarArtFrame, (f == 1) and -287 or 284, 0)
		eCap.SetAnchor = E.hoop
		
		MainMenuBarLeftEndCap:SetTexture(A.eCapLeftB)
		MainMenuBarRightEndCap:SetTexture(A.eCapRightB)
	end
	
	--* maxLevelBar
	local abLvlMax = {'MainMenuMaxLevelBar'}
	
	for i = 0, 3 do
		for _, aLvl in pairs(abLvlMax) do
			local expBar = aLvl .. tostring(i)
			local expMax = 'MainMenuBarMaxLevelBar'
			
			_G[expBar]:SetVertexColor(0,0,0,.9)
			_G[expBar]:Width(128)
			
			_G[expMax]:ClearAllPoints();
			_G[expMax]:SetAnchor(unpack(C.Anchors.abShortExpBar))
		end
	end
	
	--* background(dark)
	for f, mBar in pairs({ MainMenuBarTexture0, MainMenuBarTexture1 }) do
		mBar:SetAnchor('BOTTOM', MainMenuBarArtFrame, (f == 1) and -0 or 0, 0)
		mBar.SetAnchor = E.hoop
		mBar:SetTexture(A.solid)
		mBar:SetVertexColor(unpack(A.abColor))
		mBar:Width(MainMenuBar:GetWidth())
	end
