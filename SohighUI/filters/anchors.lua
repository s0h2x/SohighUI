	
--* position frames
local E, C, _ = select(2, shCore()):unpack()
	
--//Usage: SetAnchor(unpack(C.Anchors.Name))
--//If you're saving frame positions, use 'UIParent', not UIParent
C['Anchors'] = {
	--*ActionBars
	--*Big Bar Style
	['abRightB'] = {'TOPRIGHT', 'UIParent', 'RIGHT', -6, (MultiBarRight:GetHeight()/2)},
	['abLeftB'] = {'TOPRIGHT', 'MultiBarRightButton1', 'TOPLEFT', -6, 0},
	['abBigBR'] = {'BOTTOMLEFT', 'MultiBarBottomLeft', 'BOTTOMRIGHT', 2, ReputationWatchBar:IsShown() and 7 or 0},
	['abBigBRA'] = {'TOPLEFT', 'ActionButton12', 'TOPLEFT', 40, 0},
	['abBigShift'] = {'TOP', 'MainMenuBar', -164, -91},
	['abBigStyleMenu'] = {'BOTTOM', 'MainMenuBarArtFrame', -495, 14},
	['abBigStyleBpack'] = {'BOTTOM', 'MainMenuBarArtFrame', 495, 14},
	['abBigStyleBar'] = {'BOTTOM', 'MainMenuBarArtFrame', 0, -11},
	['abBigExpBar'] = {'TOP', 'MainMenuBar', 0, -4},
	['abBigSmallBar'] = {'BOTTOMLEFT', 'MainMenuBar', 'TOPLEFT', 40, 5},

	--*Short Bar Style (12x12)
	['abShortStyle'] = {'BOTTOM', 'UIParent', 'BOTTOM', -400, -400},
	['abShortBR'] = {'BOTTOM', 'MultiBarBottomLeft', 'TOP', 0, ReputationWatchBar:IsShown() and 7 or 6},
	['abShortMaxLvl'] = {'BOTTOM', 'MainMenuBarMaxLevelBar', 'TOP', -128, 0},
	['abShortXPTex1'] = {'BOTTOM', 'MainMenuExpBar', 'BOTTOM', -128, 3},
	['abShortXPTex2'] = {'BOTTOM', 'MainMenuExpBar', 'BOTTOM', 128, 3},
	['abShortStyleMenu'] = {'BOTTOM', 'MainMenuBarArtFrame', -375, 14},
	['abShortStyleBpack'] = {'BOTTOM', 'MainMenuBarArtFrame', 375, 14},
	['abShortExpBar'] = {'TOP', 'MainMenuBar', -64, -11},

	--*Six Bar Style (6x6)
	['abSixStyle'] = {'BOTTOM', 'UIParent', -200, -200},
	['abSixStyleMenu'] = {'BOTTOM', 'MainMenuBarArtFrame', -290, 14},
	['abSixStyleBpack'] = {'BOTTOM', 'MainMenuBarArtFrame', 290, 14},
	['abSixStyleBar'] = {'BOTTOM', 'MainMenuBarArtFrame', 0, -11},
	['abSixShapeShift'] = {'BOTTOMLEFT', 'MainMenuBar', 'TOPLEFT', -50, 65},
	['abSixExpBar'] = {'TOP', 'MainMenuBar', 0, 2},
	['abSixRepBar'] = {'TOP', 'MainMenuExpBar', 0, 4},

	--*Bags Position
	['bag'] = {'RIGHT', 'UIParent', 'RIGHT', -140, -20},
	['bank'] = {'LEFT', 'UIParent', 'LEFT', 23, 150},

	--*Minimap Position
	['LFT'] = {'TOP', 'Minimap', 'BOTTOM', 0, -1},
	['mapBorder'] = {'TOPRIGHT', 'Minimap', 13, 4},
	['mapMail'] = {'BOTTOMRIGHT', 0, -10},
	['mapTrackIcnTL'] = {'TOPLEFT', 'MiniMapTracking', 'TOPLEFT', 2, -2},
	['mapTrackIcnBR'] = {'BOTTOMRIGHT', 'MiniMapTracking', 'BOTTOMRIGHT', -2, 2},
	['mapTrack'] = {'TOPLEFT', 'Minimap', -15, -34},
	['mapZone'] = {'BOTTOM', 'Minimap', 1, -45},
	['mapTime'] = {'BOTTOM', 'Minimap', 0, -6},
	['mapZoneText'] = {'CENTER', 'Minimap', 'CENTER', 0, 0},
	['mapSubZoneText'] = {'CENTER', 'ZoneTextString', 'CENTER', 0, -3},
	['mapToggle'] = {'TOPRIGHT', 'Minimap', 10, 10},

	--*Damage Meter Position
	['dmeter'] = {'BOTTOMRIGHT', 'UIParent', 'BOTTOMRIGHT', 12, -12},

	--*ZoneText Position
	['zoneText'] = {'CENTER', 'UIParent', 0, 280},
	['subZoneText'] = {'CENTER', 'UIParent', 0, 240},
	
	--*Enemy Cooldowns
	['enemyCD'] = {'BOTTOMLEFT', 'UIParent', 'TOPRIGHT', 33, 62},
}
