
	--* talent skin
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local function LoadSkin()
		PlayerTalentFrame:StripLayout()
		PlayerTalentFrame:SetLayout()
		PlayerTalentFrame:SetShadow()

		PlayerTalentFrame.bg:SetAnchor('TOPLEFT', 13, -12)
		PlayerTalentFrame.bg:SetAnchor('BOTTOMRIGHT', -31, 76)
		
		PlayerTalentFrame.shadow:SetAnchor('TOPLEFT', 9, -8)
		PlayerTalentFrame.shadow:SetAnchor('BOTTOMRIGHT', -27, 72)

		PlayerTalentFramePortrait:Hide()
		PlayerTalentFrameCloseButton:CloseTemplate()
		PlayerTalentFrameCloseButton:SetAnchor('TOPRIGHT', -34, -16)

		PlayerTalentFrameCancelButton:dummy()

		for i = 1, 3 do
			local tab = _G['PlayerTalentFrameTab'..i]
			tab:StripLayout()
			tab:SetLayout()
			
			tab.bg:SetAnchor('TOPLEFT', -1, -5)
			tab.bg:SetAnchor('BOTTOMRIGHT', -20, -1)
			
			tab:SetGradient()
			tab.gr:SetAllPoints(tab.bg)
			
			_G['PlayerTalentFrameTab'..i..'Text']:SetAnchor('TOPLEFT', 12, -12)
		end
		
		PlayerTalentFrameScrollFrame:ScrollTemplate()
		PlayerTalentFrameScrollFrameScrollBar:SetAnchor('TOPLEFT', PlayerTalentFrameScrollFrame, 'TOPRIGHT', 10, -16)
		PlayerTalentFrameScrollButtonOverlay:Hide()

		PlayerTalentFrameSpentPoints:SetAnchor('TOP', 0, -42)
		PlayerTalentFrameTalentPointsText:SetAnchor('BOTTOMRIGHT', PlayerTalentFrame, 'BOTTOMLEFT', 220, 84)

		for i = 1, MAX_NUM_TALENTS do
			local talent = _G['PlayerTalentFrameTalent'..i]
			local icon	 = _G['PlayerTalentFrameTalent'..i..'IconTexture']
			local rank	 = _G['PlayerTalentFrameTalent'..i..'Rank']

			if talent then
				talent:StripLayout()
				talent:SetShadow()

				talent.shadow:SetAnchor('TOPLEFT', -1, 2)
				talent.shadow:SetAnchor('BOTTOMRIGHT', 1, -.7)

				icon:SetInside()
				icon:SetTexCoord(unpack(E.TexCoords))
				icon:SetDrawLayer('ARTWORK')

				rank:SetFont(A.font, 15, A.fontStyle)
			end
		end
	end

	ET['Blizzard_TalentUI'] = LoadSkin