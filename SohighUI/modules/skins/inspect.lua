
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	local _G = _G
	local unpack = unpack

	local CreateFrame = CreateFrame
	local GetItemInfo = GetItemInfo
	local GetInventoryItemLink = GetInventoryItemLink
	local GetItemQualityColor = GetItemQualityColor
	local MAX_NUM_TALENTS = MAX_NUM_TALENTS

	local function LoadSkin()

		--* Inspect Frame
		local InspectFrame = _G['InspectFrame']
		InspectFrame:StripLayout(true)
		InspectFrame:SetLayout()
		InspectFrame.bg:SetAnchor('TOPLEFT', 10, -12)
		InspectFrame.bg:SetAnchor('BOTTOMRIGHT', -31, 75)
		
		InspectFrame:SetShadow()
		InspectFrame.shadow:SetAnchor('TOPLEFT', 8, -10)
		InspectFrame.shadow:SetAnchor('BOTTOMRIGHT', -27, 71)

		InspectPaperDollFrame:StripLayout()

		ET:HandleRotateButton(InspectModelRotateLeftButton)
		InspectModelRotateLeftButton:SetAnchor('TOPLEFT', 3, -3)

		ET:HandleRotateButton(InspectModelRotateRightButton)
		InspectModelRotateRightButton:SetAnchor('TOPLEFT', InspectModelRotateLeftButton, 'TOPRIGHT', 3, 0)

		InspectFrameCloseButton:CloseTemplate()

		local slots = {
			'HeadSlot',
			'NeckSlot',
			'ShoulderSlot',
			'BackSlot',
			'ChestSlot',
			'ShirtSlot',
			'TabardSlot',
			'WristSlot',
			'HandsSlot',
			'WaistSlot',
			'LegsSlot',
			'FeetSlot',
			'Finger0Slot',
			'Finger1Slot',
			'Trinket0Slot',
			'Trinket1Slot',
			'MainHandSlot',
			'SecondaryHandSlot',
			'RangedSlot'
		}

		for _, i in pairs(slots) do
			local item = _G['Inspect'..i]
			local icon = _G['Inspect'..i..'IconTexture']

			item:StripLayout()
			item:SetLayout()
			--item:StyleButton(false)

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetInside()
		end

		hooksecurefunc('InspectPaperDollItemSlotButton_Update', function(button)
			if button.hasItem then
				local itemID = GetInventoryItemLink(InspectFrame.unit, button:GetID())
				if itemID then
					local _, _, quality = GetItemInfo(itemID)
					if not quality then
						ET:Delay(0.1, function()
							if InspectFrame.unit then
								InspectPaperDollItemSlotButton_Update(button)
							end
						end)
						return
					elseif quality then
						button:SetBackdropBorderColor(GetItemQualityColor(quality))
						return
					end
				end
			end
			button:SetBackdropBorderColor(unpack(A.borderColor))
		end)

		--* Inspect Frame Tabs
		for i = 1, 3 do
			local tab = _G['InspectFrameTab'..i]
			tab:StripLayout()
			tab:SetLayout()
			
			tab.bg:SetAnchor('TOPLEFT', -1, -5)
			tab.bg:SetAnchor('BOTTOMRIGHT', -20, -1)
			
			tab:SetGradient()
			tab.gr:SetAllPoints(tab.bg)
			
			_G['InspectFrameTab'..i..'Text']:SetAnchor('TOPLEFT', 10, -14)
		end

		-- Inspect PvP Frame
		InspectPVPFrame:StripLayout()

		for i = 1, MAX_ARENA_TEAMS do
			_G['InspectPVPTeam'..i]:StripLayout()
			_G['InspectPVPTeam'..i]:SetLayout()
			_G['InspectPVPTeam'..i].bg:SetAnchor('TOPLEFT', 9, -6)
			_G['InspectPVPTeam'..i].bg:SetAnchor('BOTTOMRIGHT', -24, -5)
		end

		-- Inspect Talent Frame
		InspectTalentFrame:StripLayout()

		InspectTalentFrame.backdrop = CreateFrame('frame', nil, InspectTalentFrame)
		InspectTalentFrame.backdrop:SetLayout()	
		InspectTalentFrame.backdrop:SetAnchor('TOPLEFT', InspectTalentFrameBackgroundTopLeft, 'TOPLEFT', -1, 1)
		InspectTalentFrame.backdrop:SetAnchor('BOTTOMRIGHT', InspectTalentFrameBackgroundBottomRight, 'BOTTOMRIGHT', -19, 51)

		InspectTalentFrameBackgroundTopLeft:SetParent(InspectTalentFrame.backdrop)
		InspectTalentFrameBackgroundTopRight:SetParent(InspectTalentFrame.backdrop)
		InspectTalentFrameBackgroundBottomLeft:SetParent(InspectTalentFrame.backdrop)
		InspectTalentFrameBackgroundBottomRight:SetParent(InspectTalentFrame.backdrop)

		InspectTalentFrameScrollFrame:StripLayout()
		InspectTalentFrameScrollFrame:SetHitRectInsets(0, 0, 1, 1)

		InspectTalentFrameScrollFrameScrollBar:ShortBar()
		InspectTalentFrameScrollFrameScrollBar:SetAnchor('TOPLEFT', InspectTalentFrameScrollFrame, 'TOPRIGHT', 8, -19)

		InspectTalentFrameCloseButton:CloseTemplate()

		InspectTalentFrameCancelButton:Hide()

		InspectTalentFrameSpentPoints:SetAnchor('BOTTOMLEFT', 65, 84)

		for i = 1, 3 do
			local tab = _G['InspectTalentFrameTab'..i]

			tab:StripLayout()
			tab:SetLayout()
			tab.bg:SetAnchor('TOPLEFT', 3, -7)
			tab.bg:SetAnchor('BOTTOMRIGHT', 2, -1)
			tab:SetHitRectInsets(1, 0, 7, -1)

			tab:Width(101)
			tab.Width = E.hoop

			if i == 1 then
				tab:SetAnchor('TOPLEFT', 19, -40)
			end
		end

		for i = 1, MAX_NUM_TALENTS do
			local talent = _G['InspectTalentFrameTalent'..i]
			local icon = _G['InspectTalentFrameTalent'..i..'IconTexture']
			local border = _G['InspectTalentFrameTalent'..i..'RankBorder']
			local rank = _G['InspectTalentFrameTalent'..i..'Rank']

			if talent then
				talent:StripLayout()
				talent:SetShadow()

				talent.shadow:SetAnchor('TOPLEFT', -1, 2)
				talent.shadow:SetAnchor('BOTTOMRIGHT', 1, -.7)

				icon:SetInside()
				icon:SetTexCoord(unpack(E.TexCoords))
				icon:SetDrawLayer('ARTWORK')

				border:SetAnchor('CENTER', talent, 'BOTTOMRIGHT', 3, -5)

				rank:SetFont(A.font, 12, A.fontStyle)
			end
		end
	end

	ET['Blizzard_InspectUI'] = LoadSkin