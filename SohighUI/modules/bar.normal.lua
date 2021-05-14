	
	--* actionbar [Normal]
	
	local E, C, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local unpack = unpack
	local pairs = pairs
	
	local SHOW_MULTI_ACTIONBAR_1 = SHOW_MULTI_ACTIONBAR_1
	local SHOW_MULTI_ACTIONBAR_2 = SHOW_MULTI_ACTIONBAR_2
	
	local hooksecurefunc = hooksecurefunc
	local CreateFrame = CreateFrame
	
	local abStyle = CreateFrame('frame')
	abStyle:RegisterEvent('PLAYER_ENTERING_WORLD')
	
	--// Normal Style
	E.BarNormal = function()
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
		return end
	end
	
	abStyle:SetScript('OnEvent', E.BarNormal);