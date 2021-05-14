	
	--* style 6x6
	
	local E, C, _ = select(2, shCore()):unpack()
	if C['bar'].styleAB ~= 3 then return end;
	
	local _G = _G
	local unpack = unpack
	local ipairs = ipairs
	
	local CreateFrame = CreateFrame
	
	MainMenuBar:Width(256)

	MultiBarBottomRight:ClearAllPoints();
	MultiBarBottomRight:SetAnchor(unpack(C.Anchors.abSixStyle))
	MultiBarBottomRight.SetAnchor = E.hoop
	MultiBarBottomRight:SetAlpha(0)
	
	local suiM = _G['MenuButton']
	local bpack = _G['MenuButtonPack']
	
	suiM:SetAnchor(unpack(C.Anchors.abSixStyleMenu))
	bpack:SetAnchor(unpack(C.Anchors.abSixStyleBpack))
	
	local artStyle = CreateFrame('frame', 'abArt', MainMenuBarArtFrame)
	local artBar = artStyle:CreateTexture(nil, 'ARTWORK')
	artBar:SetTexture(A.abSix)
	artBar:SetAnchor(unpack(C.Anchors.abSixStyleBar))
	artStyle:SetFrameStrata('DIALOG')
	
	local eCapL = artStyle:CreateTexture(nil, 'OVERLAY')
	eCapL:SetTexture(A.eCapLeftS)
	eCapL:SetSize(128)
	eCapL:SetParent(artStyle)
	eCapL:SetAnchor('BOTTOM', MainMenuBarArtFrame, -170, 0)
	eCapL.SetAnchor = E.hoop
	
	local eCapR = artStyle:CreateTexture(nil, 'OVERLAY')
	eCapR:SetTexture(A.eCapRightS)
	eCapR:SetSize(128)
	eCapR:SetParent(artStyle)
	eCapR:SetAnchor('BOTTOM', MainMenuBarArtFrame, 174, 0)
	eCapR.SetAnchor = E.hoop
	
	local abArts = {
		'ActionButton',
		'BonusActionButton',
		'MultiBarBottomLeftButton'
	}
	
	local abLevel = {
		'MainMenuBarTexture0',
		'MainMenuBarTexture1',
		'MainMenuBarMaxLevelBar',
		'MainMenuBarLeftEndCap',
		'MainMenuBarRightEndCap'
	}

	--* hide buttons
	for i = 7, 12 do
		for _, abSix in ipairs(abArts) do
			local barName = abSix .. tostring(i)
			_G[barName]:dummy()
		end
	end
		
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		for _, ss in pairs({_G['ShapeshiftButton'..i..'NormalTexture']}) do
			ss:SetAlpha(0)
		end
	end

	for i = 1, 6 do
		for _, abSix in ipairs(abArts) do
			local barName = abSix .. tostring(i)
			local frame  = _G[barName]
			local normal = _G[barName..'NormalTexture']
			
			normal:SetAlpha(0)
			
			frame:GetCheckedTexture():dummy()
			frame:GetNormalTexture():dummy()
			--frame:GetHighlightTexture():dummy()
			frame:GetPushedTexture():dummy()
		end
		
		if not BonusActionBarFrame:IsShown() then
			BonusActionBarFrame:Hide()
		end
	end

	--****--
	
	if C['bar'].stripArts ~= false then
		artStyle:StripLayout(true)
	end
	
	if C['bar'].caps ~= true then
		eCapL:Hide()
		eCapR:Hide()
	end

	for _, maxBar in pairs(abLevel) do
		_G[maxBar]:dummy()
	end
	
	MainMenuExpBar:Width(302)
	MainMenuExpBar:ClearAllPoints()
	MainMenuExpBar:SetAnchor(unpack(C.Anchors.abSixExpBar))
	
	ReputationWatchStatusBar:Width(308)
	ReputationWatchStatusBar:ClearAllPoints()
	ReputationWatchStatusBar:SetAnchor(unpack(C.Anchors.abSixRepBar))
	