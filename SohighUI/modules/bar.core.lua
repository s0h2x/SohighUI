	
	--* actionbar [core]
	
	local E, C, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local unpack = unpack
	local pairs = pairs
	
	local hooksecurefunc = hooksecurefunc
	
	MainMenuBarPerformanceBarFrame:dummy()
	
	--// Stance
	BonusActionBarTexture0:Hide()
	BonusActionBarTexture1:Hide()

	--// Sliding Color
	SlidingActionBarTexture0:SetVertexColor(unpack(A.sAbColor))
	SlidingActionBarTexture1:SetVertexColor(unpack(A.sAbColor))
	
	local abBlock = {'MultiBarRight','MultiBarBottomRight','ShapeshiftBarFrame','PossessBarFrame'}
	local shapeshift = {'PossessButton1', 'PetActionButton1', 'ShapeshiftButton1'}
	
	local hideObj = {
		'MainMenuBarPageNumber',
		'ShapeshiftBarLeft',
		'ShapeshiftBarMiddle',
		'ShapeshiftBarRight',
		'MainMenuBarTexture2',
		'MainMenuBarTexture3',
		'ActionBarUpButton',
		'ActionBarDownButton',
		'KeyRingButton'
	}
	
	--// ShapeShift Anchor
	for _, sh in pairs(shapeshift) do
		_G[sh]:ClearAllPoints();
		_G[sh]:SetAnchor(unpack(C.Anchors.abBigSmallBar))

		if (C['bar'].styleAB == 2 or C['bar'].styleAB == 3) then
			_G[sh]:SetAnchor(unpack(C.Anchors.abSixShapeShift))
		end
	end
	
	--// Hide Textures
	for _, obj in pairs(hideObj) do
		_G[obj]:dummy()
	end

	function ShapeshiftBar_Update() ShapeshiftBar_UpdateState() end

	--// Blocked Move
	for _, x in pairs(abBlock) do
		UIPARENT_MANAGED_FRAME_POSITIONS[x] = nil
	end
	
	local stripList = {
		'MainMenuBarTexture0',
		'MainMenuBarTexture1',
		'MainMenuBarLeftEndCap',
		'MainMenuBarRightEndCap'
	}
	
	if C['bar'].stripArts ~= false then
		for _, obj in pairs(stripList) do
			_G[obj]:StripLayout(true)
		end
	end
	
	if C['bar'].caps ~= true then
		MainMenuBarLeftEndCap:Hide()
		MainMenuBarRightEndCap:Hide()
	end
	
	if C['bar'].scale then
		E.SetBarScale = function()
			MainMenuBar:SetScale(C['bar'].scale.value)
			MultiBarBottomRight:SetScale(C['bar'].scale.value)
			MultiBarBottomLeft:SetScale(C['bar'].scale.value)
			MultiBarLeft:SetScale(C['bar'].scale.value)
			MultiBarRight:SetScale(C['bar'].scale.value)
		end
	end
	
	--// Normal Style
	if (C['bar'].styleAB == 1) then
	
		MainMenuBar:Width(776)
		
		MainMenuExpBar:SetSize(768, 5)
		MainMenuExpBar:ClearAllPoints()
		MainMenuExpBar:SetAnchor(unpack(C.Anchors.abBigExpBar))

		ReputationWatchStatusBar:Width(768)
		ReputationWatchBar:Width(760)

		local suiM = _G['MenuButton']
		local bpack = _G['MenuButtonPack']

		suiM:SetAnchor(unpack(C.Anchors.abBigStyleMenu))
		bpack:SetAnchor(unpack(C.Anchors.abBigStyleBpack))

		MultiBarRightButton1:ClearAllPoints()
		MultiBarRightButton1:SetAnchor(unpack(C.Anchors.abRightB))

		MultiBarLeftButton1:ClearAllPoints()
		MultiBarLeftButton1:SetAnchor(unpack(C.Anchors.abLeftB))

		MultiBarBottomRight:ClearAllPoints()
		MultiBarBottomRight:SetAnchor(unpack(C.Anchors.abBigBR))

		MultiBarBottomRightButton7:ClearAllPoints()
		MultiBarBottomRightButton7:SetAnchor(unpack(C.Anchors.abBigBRA))
		MultiBarBottomRightButton7.SetAnchor = E.hoop

		ShapeshiftBarFrame:ClearAllPoints()
		ShapeshiftBarFrame:SetAnchor(unpack(C.Anchors.abBigShift))

		--// Background Color (dark)
		for f, mBar in pairs({ MainMenuBarTexture0, MainMenuBarTexture1 }) do
			mBar:SetAnchor('BOTTOM', MainMenuBarArtFrame, (f == 1) and -0 or 0, 0)
			mBar.SetAnchor = E.hoop
			mBar:SetTexture(A.solid)
			mBar:SetVertexColor(unpack(A.abColor))
			mBar:Width(756)
		end

		for f, eCap in pairs({ MainMenuBarLeftEndCap, MainMenuBarRightEndCap }) do
			eCap:SetAnchor('BOTTOM', MainMenuBarArtFrame, (f == 1) and -414 or 406, 0)
			eCap.SetAnchor = E.hoop
			
			MainMenuBarLeftEndCap:SetTexture(A.eCapLeftB)
			MainMenuBarRightEndCap:SetTexture(A.eCapRightB)
		end

		--// Shapeshift
		hooksecurefunc('MultiActionBar_Update', function()
			for _, ss in pairs(shapeshift) do
				local offset = (SHOW_MULTI_ACTIONBAR_2 and 60 or SHOW_MULTI_ACTIONBAR_1 and 52 or 0)
				_G[ss]:SetAnchor('BOTTOMLEFT', MainMenuBar, 'TOPLEFT', 30, offset)
			end
		end);
	end
	
	local w = CreateFrame('frame')
	w:RegisterEvent('PLAYER_ENTERING_WORLD')
	w:SetScript('OnEvent', E.SetBarScale);