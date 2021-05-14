
	--* backpack
	local E, C, _ = select(2, shCore()):unpack()
	
	local _G = _G
	
	local CreateFrame = CreateFrame
	local BACKPACK_CONTAINER, NUM_BAG_SLOTS = BACKPACK_CONTAINER, NUM_BAG_SLOTS
	local GetContainerNumFreeSlots = GetContainerNumFreeSlots

	local count = _G['MainMenuBarBackpackButtonCount']

	--orig.bpack:Hide()
	
	local bpack = CreateFrame('Button', 'MenuButtonPack', MainMenuBarArtFrame)
	bpack:SetAnchor('BOTTOM', MainMenuBarArtFrame, 370, 14)
	bpack:SetSize(36)
	bpack:RegisterForClicks('AnyUp')
	bpack:SetScript('OnClick', function() ToggleBackpack() end);
	
	--* media
	bpack.__tex = bpack:CreateTexture(nil, 'BACKGROUND')
	bpack.__tex:SetTexture(A.bpackTex)
	bpack.__tex:SetAnchor('TOPLEFT', 2, 0)
	bpack.__tex:SetAnchor('BOTTOMRIGHT', 0, 0)
	
	--* arrow
	bpack.__arrow = bpack:CreateTexture(nil, 'OVERLAY')
	bpack.__arrow:SetTexture('Interface\\MoneyFrame\\Arrow-Right-Up')
	bpack.__arrow:SetAnchor('BOTTOM', bpack, 'TOP', 2, 2)
	bpack.__arrow:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
	bpack.__arrow:SetSize(16)
	
	--* mouseover
	local bpack__mo = CreateFrame('Button', nil, bpack)
	bpack__mo:SetAnchor('BOTTOM', bpack, 'TOP')
	bpack__mo:SetFrameLevel(10)
	bpack__mo:SetSize(55, 70)
	
	--* circle border
	bpack.__icon = bpack:CreateTexture(nil, 'BORDER')
	bpack.__icon:SetTexture(A.abBorder)
	bpack.__icon:SetAnchor('TOPLEFT', -16, 16)
	bpack.__icon:SetAnchor('BOTTOMRIGHT', 16, -16)
	bpack.__icon:SetVertexColor(E.Color.r, E.Color.g, E.Color.b)

	count:ClearAllPoints();
	count:SetAnchor('BOTTOM', bpack, 1, 0)
	
	if C['bar']._bpackIcon ~= true then bpack:Hide() end

	--* backpack show
	--[[local bpshow = function()
		bpack.__arrow:SetAnchor('BOTTOM', bpack, 'TOP', 2, 4)
		for i = 0, 3 do
			local slot = _G['CharacterBag'..i..'Slot']
			slot:SetAlpha(1)
			slot:EnableMouse(true)
		end
	end

	--* hide
	local bphide = function()
		bpack.__arrow:SetAnchor('BOTTOM', bpack, 'TOP', 2, 1)
		for i = 0, 3 do
			local slot = _G['CharacterBag'..i..'Slot']
			slot:SetAlpha(0)
			slot:EnableMouse(false)
		end
	end

	--* toggle
	local bptogle = function(min, max, toggle)
		for i = min, max do
			if (toggle == 'open') then OpenBag(i) else CloseBag(i) end
		end
	end

	ToggleBackpack = function()
		if IsBagOpen(0) then
			CloseBankFrame()
			bptogle(0, 11)
		else 
			bptogle(0, 4, 'open')
		end
	end

	--bpack:HookScript('OnEnter', bpshow)
	--bpack:HookScript('OnLeave', bphide)
	--bpack__mo:SetScript('OnEnter', bpshow)
	--bpack__mo:SetScript('OnLeave', bphide)

	--* backpackslots
	for slots = 0, 3 do
		local slot = _G['CharacterBag'.. slots ..'Slot']
		local slot_icon = _G['CharacterBag'.. slots ..'SlotIconTexture']
		local slot_count = _G['CharacterBag'.. slots ..'SlotCount']
		slot:SetNormalTexture''
		slot:SetAlpha(0)
		slot:EnableMouse(false)
		slot:SetFrameLevel(11)
		slot:SetSize(14)

		slot_count:ClearAllPoints();
		slot_count:SetAnchor('LEFT', slot, 'RIGHT', 6, -3)
		slot_count:SetFont(A.font, 10, A.fontStyle)

		slot_icon:SetTexCoord(unpack(E.TexCoords))

		if (slots == 0) then
			slot:ClearAllPoints();
			slot:SetAnchor('BOTTOM', bpack, 'TOP', 0, 14)
		else
			slot:ClearAllPoints();
			slot:SetAnchor('BOTTOM', _G['CharacterBag'.. (slots - 1) ..'Slot'], 'TOP', 0, 6)
		end
		
		slot:HookScript('OnEnter', bpshow)
		slot:HookScript('OnLeave', bphide)
	end
	-]]
	--* backpack is full?
	function MainMenuBarBackpackButton_UpdateFreeSlots()
		local total, slot, f = 0
		for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
			slot, f = GetContainerNumFreeSlots(i)
			if (f == 0) then
				total = total + slot
			end
		end
		MainMenuBarBackpackButton.freeSlots = total
		count:SetText(total > 0 and string.format('%s', total) or '|cffff0000Full|r')
	end
	
	bpack:SetScript('OnEnter', function() bpack.__icon:SetVertexColor(.91, .33, .50) end);
	bpack:SetScript('OnLeave', function()
		bpack.__icon:SetVertexColor(E.Color.r, E.Color.g, E.Color.b, .8)
	end);