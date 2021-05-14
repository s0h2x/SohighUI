	
	--* shadow
	
	local E, C, _ = select(2, shCore()):unpack()
	
	local f = CreateFrame('frame', 'ShadowBackground')
	f:SetAnchor('TOPLEFT')
	f:SetAnchor('BOTTOMRIGHT')
	f:SetFrameLevel(0)
	f:SetFrameStrata('BACKGROUND')
	
	f.tex = f:CreateTexture()
	f.tex:SetTexture(A.shadowBorder)
	f.tex:SetAllPoints(f)
	
	E.SetShadowLevel = function() f:SetAlpha(C.main.shadow.value/100) end
	
	f:SetScript('OnEvent', E.SetShadowLevel);
	f:RegisterEvent('PLAYER_ENTERING_WORLD')