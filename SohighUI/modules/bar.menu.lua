
	--* menu
	local E, C, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local unpack = unpack
	
	local CreateFrame = CreateFrame

	local mb = {
		['CharacterMicroButton'] 	= {{-12, 10}, {-12, 10}},
		['SpellbookMicroButton'] 	= {{ 12, 10}, { 12, 10}},
		['TalentMicroButton'] 		= {{-12, 40}, {-12, 40}},
		['QuestLogMicroButton']		= {{-12, 40}, { 12, 40}},
		['SocialsMicroButton']		= {{ 12, 40}, {-12, 70}},
		['LFGMicroButton']			= {{-12, 70}, { 12, 70}},
		['MainMenuMicroButton']		= {{ 12, 70}, {-12, 100}},
		['HelpMicroButton']			= {{-12, 100}, {12, 100}}
	}
	
	local micbutton = {
		'CharacterMicroButton',
		'SpellbookMicroButton',
		'TalentMicroButton',
		'QuestLogMicroButton',
		'SocialsMicroButton',
		'LFGMicroButton',
		'MainMenuMicroButton',
		'HelpMicroButton'
	}
	
	for _, mic in pairs(micbutton) do
		_G[mic]:SetInside()
	end
  
	local menu = CreateFrame('Button', 'MenuButton', MainMenuBarArtFrame)
	menu:SetAnchor('BOTTOM', MainMenuBarArtFrame, -370, 14)
	menu:RegisterForClicks('AnyUp')
	menu:SetSize(36)
	
	--* texture
	menu.__tex = menu:CreateTexture(nil, 'BACKGROUND')
	menu.__tex:SetTexture('Interface\\Addons\\SohighUI\\styles\\units\\UI-CLASSESICON-CIRCLES')
	menu.__tex:SetTexCoord(unpack(M.index.cit[E.Class]))
	menu.__tex:SetAnchor('TOPLEFT')
	menu.__tex:SetAnchor('BOTTOMRIGHT', 0, 0)
	
	--* arrow
	menu.__arrow = menu:CreateTexture(nil, 'OVERLAY')
	menu.__arrow:SetTexture('Interface\\MoneyFrame\\Arrow-Right-Up')
	menu.__arrow:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
	menu.__arrow:SetAnchor('BOTTOM', menu, 'TOP', 2, 4)
	menu.__arrow:SetSize(16)

	--* mouseover
	local menu__mo = CreateFrame('Button', nil, menu)
	menu__mo:SetAnchor('BOTTOM', menu, 'TOP')
	menu__mo:SetFrameLevel(10)
	menu__mo:SetSize(60, 55)
	
	--* circle border
	menu.__icon = menu:CreateTexture(nil, 'BORDER')
	menu.__icon:SetTexture(A.abBorder)
	menu.__icon:SetAnchor('TOPLEFT', -16, 16)
	menu.__icon:SetAnchor('BOTTOMRIGHT', 16, -16)
	menu.__icon:SetVertexColor(E.Color.r, E.Color.g, E.Color.b, .8)

	MicroButtonPortrait:SetAnchor('TOP', 0, -22)
	MicroButtonPortrait:SetSize(14, 21)

	KeyRingButton:SetParent(ContainerFrame1)
	KeyRingButton:ClearAllPoints();
	KeyRingButton:SetAnchor('TOPLEFT', ContainerFrame1, -25, -2)

	E.hoop(UpdateTalentButton)
	
	if C['bar']._menuIcon ~= true then menu:Hide() end

	local mshow = function()
		menu.__arrow:SetAnchor('BOTTOM', menu, 'TOP', 2, 4)
		for show, v in pairs(mb) do
			local b = _G[show]
			b:SetAlpha(1)
			b:EnableMouse(true)
		end
	end

	local mhide = function()
		GameTooltip:Hide()
		menu.__arrow:SetAnchor('BOTTOM', menu, 'TOP', 2, 1)
		for hide, v in pairs(mb) do
			local b = _G[hide]
			b:SetAlpha(0)
			b:EnableMouse(false)
		end
	end

	local madd = function()
		for add, m in pairs(mb) do
			local b = _G[add]
			b:SetSize(23, 48)
			b:ClearAllPoints();
			b:SetAlpha(0)
			b:EnableMouse(false)
			b:SetFrameLevel(11)
			b:SetAnchor('BOTTOM', menu, 'TOP', E.Level<10 and m[1][1] or m[2][1], E.Level<10 and m[1][2] or m[2][2])
			b:HookScript('OnEnter', mshow)
			b:HookScript('OnLeave', mhide)
		end
	end

	menu:SetScript('OnEnter', function() mshow() menu.__icon:SetVertexColor(.91, .33, .50) end);
	menu:SetScript('OnClick', function()
		SlashCmdList.CONFIG()
	end);
	
	menu:SetScript('OnLeave', function() mhide() menu.__icon:SetVertexColor(E.Color.r, E.Color.g, E.Color.b, .8) end);
	menu__mo:SetScript('OnEnter', mshow)
	menu__mo:SetScript('OnLeave', mhide)
	
	local w = CreateFrame('frame')
	w:SetScript('OnEvent', madd)
	w:RegisterEvent('PLAYER_LOGIN')
	w:RegisterEvent('PLAYER_LEVEL_UP')
