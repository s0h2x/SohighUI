
	--* bags (beta)
	
	local E, C, _ = select(2, shCore()):unpack()
	if C['bags'].enable ~= true then return end
	
	local _G = _G
	local select = select

	local GetContainerNumSlots = GetContainerNumSlots

	local togglemain, togglebank = 0, 0
	local togglebag
	
	local keyringbuttons, orig = {}, {}
	orig.ToggleKeyRing	= ToggleKeyRing

	local bags = {
		bag = {
			CharacterBag0Slot,
			CharacterBag1Slot,
			CharacterBag2Slot,
			CharacterBag3Slot
		},
		bank = {
			BankFrameBag1,
			BankFrameBag2,
			BankFrameBag3,
			BankFrameBag4,
			BankFrameBag5,
			BankFrameBag6,
			BankFrameBag7
		}
	}

	--* main frame
	E.init__bags = function()
	
		if not style then
			style = 'bag'
		else
			style = 'bank'
		end
		
		local bf = CreateFrame('frame', 'sui_'..style, UIParent)

		if (style == 'bag') then 
			bf:Width(((C['bags'].bagSize.value+C['bags'].bagSpace.value)*C['bags'].bagColumns.value)+20-(C['bags'].bagSpace.value))
		else
			bf:Width(((C['bags'].bagSize.value+C['bags'].bagSpace.value)*C['bags'].bankColumns.value)+20-(C['bags'].bagSpace.value))
		end
		
		bf:SetScale(M.bagScale)
		bf:SetAnchor('BOTTOMRIGHT')
		bf:SetFrameStrata('HIGH')
		bf:SetFrameLevel(1)
		bf:RegisterForDrag('LeftButton')
		bf:SetScript('OnDragStart', function(self) self:StartMoving() end);
		bf:SetScript('OnDragStop', function(self) self:StopMovingOrSizing() end);
		bf:Hide()

		bf:SetLayout()
		bf:SetShadow()

		bf:SetClampedToScreen(true)
		bf:SetMovable(true)
		bf:SetUserPlaced(true)
		bf:EnableMouse(true)
		
		local suiBag = CreateFrame('frame', 'sui_'..style..'_bags')
		suiBag:SetParent('sui_'..style)
		suiBag:SetSize(bf:GetSize())
		suiBag:SetAnchor('BOTTOMRIGHT', 'sui_'..style, 'TOPRIGHT', 0, 12)
		suiBag:Hide()

		suiBag:SetLayout()
		
		--* shows 1-4
		local btggl = CreateFrame('frame')
		btggl:SetSize(37, 17)
		btggl:SetAnchor('TOPRIGHT', 'sui_'..style, 'TOPRIGHT', -32, -4)
		btggl:SetParent('sui_'..style)
		btggl:EnableMouse(true)
		
		btggl:StyleButton()

		local btg_t = btggl:CreateTexture(nil, 'OVERLAY')
		btg_t:SetAnchor('CENTER', btggl, 'CENTER', 1, 0)
		btg_t:SetTexture(A.bagsTex)
		btg_t:SetSize(20)
		
		btggl:SetScript('OnMouseUp', function()
			if (togglebag ~= 1) then
				togglebag = 1
			else
				togglebag = 0
			end
			if (togglebag ~= 0) then
				suiBag:Show()
				--btg_t:SetTextColor(.8, .2, .7, .8)
			else 
				suiBag:Hide()
				--btg_t:SetTextColor(.64, .64, .62)
			end
		end);
		
		--* key? [in future...]
		--[[local KR = CreateFrame('frame')
		KR:SetSize(17)
		KR:SetAnchor('LEFT', btggl, 'RIGHT', 4, 0)
		KR:SetParent('sui_'..style)
		KR:EnableMouse(true)
		KeyRingButton:SetAlpha(0)

		KR:SetLayout(0)
		KR:SetGradient()
		
		local keyring = KR:CreateFontString('button')
		keyring:SetAnchor('CENTER', KR, 'CENTER', 1, 0)
		keyring:SetFont(A.font, 14, 'THINOUTLINE')
		keyring:SetText('K')
		keyring:SetTextColor(.64, .64, .62)
		KR:SetScript('OnMouseUp', function() ToggleKeyRing() end);
		KR:SetScript('OnEnter', function() keyring:SetTextColor(.8, .2, .7, .8) end);
		KR:SetScript('OnLeave', function() keyring:SetTextColor(.64, .64, .62) end);
		--]]
		local __x = CreateFrame('Button', nil, suiBag, 'UIPanelCloseButton')
		__x:SetAnchor('LEFT', btggl, 'RIGHT', 8, 0)
		__x:SetSize(26)
		__x:SetParent('sui_'..style)
		__x:EnableMouse(true)
		__x:CloseTemplate()
		
		if (style == 'bag') then __x:SetScript('OnMouseUp', function() CloseBackpack() end);
			--* show bags menu
			for _, f in pairs(bags.bag) do
				local count = _G[f:GetName()..'Count']
				local icon 	= _G[f:GetName()..'IconTexture']
				f:SetParent(_G['sui_'..style..'_bags'])
				f:ClearAllPoints()
				f:SetSize(24)
				
				if lastbuttonbag then
					f:SetAnchor('LEFT', lastbuttonbag, 'RIGHT', C['bags'].bagSpace.value, 0)
				else
					f:SetAnchor('TOPLEFT', _G['sui_'..style..'_bags'], 'TOPLEFT', 8, -8)
				end
				
				count.Show = function() end
				count:Hide()
				
				icon:SetTexCoord(0, 1, 0, 1)
				
				f:SetNormalTexture''
				f:SetPushedTexture''
				f:SetCheckedTexture''
				
				lastbuttonbag = f
				
				_G['sui_'..style..'_bags']:Width((24+C['bags'].bagSpace.value)*(getn(bags.bag))+14)
				_G['sui_'..style..'_bags']:Height(40)
			end
		else
			__x:SetScript('OnMouseUp', function() CloseBankFrame() end);
			--* show bags in bank menu
			for _, f in pairs(bags.bank) do
				local count = _G[f:GetName()..'Count']
				local icon 	= _G[f:GetName()..'IconTexture']
				f:SetParent(_G['sui_'..style..'_bags'])
				f:ClearAllPoints()
				f:SetSize(24)
				
				--[[if lastbuttonbank then
					f:SetAnchor('LEFT', lastbuttonbank, 'RIGHT', C['bags'].bagSpace.value, 0)
				else
					f:SetAnchor('TOPLEFT', _G['sui_'..style..'_bags'], 'TOPLEFT', 8, -8)
				end--]]

				count.Show = function() end
				count:Hide()
				
				icon:SetTexCoord(0, 1, 0, 1)
				
				f:SetNormalTexture''
				f:SetPushedTexture''
				f:SetHighlightTexture''
				
				lastbuttonbank = f
				
				_G['sui_'..style..'_bags']:Width((24+C['bags'].bagSpace.value)*(getn(bags.bank))+14)
				_G['sui_'..style..'_bags']:Height(40)
			end
		end
	end

	--* template func
	local function template(index, frame)
		  for i = 1, index do
			local bag 	= _G[frame..i]
			local count = _G[bag:GetName()..'Count']
			local icon 	= _G[bag:GetName()..'IconTexture']

			bag:SetNormalTexture''
			bag:SetPushedTexture''

			bag:SetLayout()
			
			count:SetFont(A.font, 12, A.fontStyle)
			count:SetAnchor('BOTTOMRIGHT', bag, 2, 0)
			
			icon:SetAnchor('TOPLEFT', bag, 0, 0)
			icon:SetAnchor('BOTTOMRIGHT', bag, 0, 0)
			icon:SetTexCoord(unpack(E.TexCoords))
			
			bag.border = bag
		end
	end

	for i = 1, 12 do
		_G['ContainerFrame'..i..'CloseButton']:Hide()
		_G['ContainerFrame'..i..'PortraitButton']:Hide()
		_G['ContainerFrame'..i]:EnableMouse(false)
		
		template(36, 'ContainerFrame'..i..'Item')

		for __cf = 1, 7 do
			select(__cf, _G['ContainerFrame'..i]:GetRegions()):SetAlpha(0)
		end
	end

	ContainerFrame1Item1:SetScript('OnHide', function()
		sui_bag:Hide() 
			togglemain = 0
		end);

	BankFrameItem1:SetScript('OnHide', function()
		_G.sui_bank:Hide()
			togglebank = 0
			BankFrame:Hide()
		if (sui_bag:IsShown()) then
				CloseBackpack()
			end
		end);

	BankFrameItem1:SetScript('OnShow', function()
		_G.sui_bank:Show()
			BankFrame:Show()
			ToggleAllBags()
		end);

	BankPortraitTexture:Hide()
	for a = 1, 5 do
		select(a, BankFrame:GetRegions()):Hide()
	end

	BankCloseButton:Hide()
	BankFrame:EnableMouse(0)
	BankFrame:SetSize(0)
	BankFrame:DisableDrawLayer('BACKGROUND')
	BankFrame:DisableDrawLayer('BORDER')
	BankFrame:DisableDrawLayer('OVERLAY')

	E.init__bags('bag', 'BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -97, 150)
	E.init__bags('bank', 'TOPLEFT', UIParent, 'TOPLEFT', 7, -100)
	
	template(NUM_BANKGENERIC_SLOTS, 'BankFrameItem')
	template(7, 'BankFrameBag')

	--* centralize and rewrite bag rendering function
	function ContainerFrame_GenerateFrame(frame, size, id)
		frame.size = size;
		for i = 1, size, 1 do
			local index = size - i + 1;
			local itemButton = _G[frame:GetName()..'Item'..i];
			itemButton:SetID(index);
			itemButton:Show();
		end
		frame:SetID(id);
		frame:Show()
		updateContainerFrameAnchors();
		
		local numrows, lastrowbutton, numbuttons, lastbutton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
		for bag = 1, 5 do
			local slots = GetContainerNumSlots(bag -1)
				for item = slots, 1, -1 do
					local itemframes = _G['ContainerFrame'..bag..'Item'..item]
					itemframes:ClearAllPoints()
					itemframes:SetSize(C['bags'].bagSize.value)
					itemframes:SetFrameStrata'HIGH'
					itemframes:SetFrameLevel(2)
					ContainerFrame1MoneyFrame:ClearAllPoints()
					ContainerFrame1MoneyFrame:Show()
					ContainerFrame1MoneyFrame:SetAnchor('TOPLEFT', sui_bag, 'TOPLEFT', 10, -10)
					ContainerFrame1MoneyFrame:SetFrameStrata'HIGH'
					ContainerFrame1MoneyFrame:SetFrameLevel(2)
					
					if (bag == 1 and item == 16) then
						itemframes:SetAnchor('TOPLEFT', sui_bag, 'TOPLEFT', 10, -30)
						lastrowbutton = itemframes
						lastbutton = itemframes
					elseif (numbuttons == C['bags'].bagColumns.value) then
						itemframes:SetAnchor('TOPRIGHT', lastrowbutton, 'TOPRIGHT', 0, -(C['bags'].bagSpace.value+C['bags'].bagSize.value))
						itemframes:SetAnchor('BOTTOMLEFT', lastrowbutton, 'BOTTOMLEFT', 0, -(C['bags'].bagSpace.value+C['bags'].bagSize.value))
						lastrowbutton = itemframes
						numrows = numrows + 1
						numbuttons = 1
					else
						itemframes:SetAnchor('TOPRIGHT', lastbutton, 'TOPRIGHT', (C['bags'].bagSpace.value+C['bags'].bagSize.value), 0)
						itemframes:SetAnchor('BOTTOMLEFT', lastbutton, 'BOTTOMLEFT', (C['bags'].bagSpace.value+C['bags'].bagSize.value), 0)
						numbuttons = numbuttons + 1
					end
					lastbutton = itemframes
				end
			end
			
			sui_bag:Height(((C['bags'].bagSize.value+C['bags'].bagSpace.value)*(numrows+1)+40)-C['bags'].bagSpace.value)
			
			local numrows, lastrowbutton, numbuttons, lastbutton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
			for bank = 1, NUM_BANKGENERIC_SLOTS do --* 1-28 ??
				local bankitems = _G['BankFrameItem'..bank]
				bankitems:ClearAllPoints()
				bankitems:SetSize(C['bags'].bagSize.value)
				bankitems:SetFrameStrata'HIGH'
				bankitems:SetFrameLevel(2)
				ContainerFrame2MoneyFrame:Hide()	--* hide bank money
				ContainerFrame2MoneyFrame:ClearAllPoints()
				ContainerFrame2MoneyFrame:SetAnchor('TOPLEFT', _G.sui_bank, 'TOPLEFT', 10, -10)
				ContainerFrame2MoneyFrame:SetFrameStrata'HIGH'
				ContainerFrame2MoneyFrame:SetFrameLevel(2)
				ContainerFrame2MoneyFrame:SetParent(_G.sui_bank)
				BankFrameMoneyFrame:Hide()
				
				if (bank == 1) then	--* my bad.. now fixed xD
					bankitems:SetAnchor('TOPLEFT', _G.sui_bank, 'TOPLEFT', 10, -30)
					lastrowbutton = bankitems
					lastbutton = bankitems
				elseif (numbuttons == C['bags'].bankColumns.value) then
					bankitems:SetAnchor('TOPRIGHT', lastrowbutton, 'TOPRIGHT', 0, -(C['bags'].bagSpace.value+C['bags'].bagSize.value))
					bankitems:SetAnchor('BOTTOMLEFT', lastrowbutton, 'BOTTOMLEFT', 0, -(C['bags'].bagSpace.value+C['bags'].bagSize.value))
					lastrowbutton = bankitems
					numrows = numrows + 1
					numbuttons = 1
				else
					bankitems:SetAnchor('TOPRIGHT', lastbutton, 'TOPRIGHT', (C['bags'].bagSpace.value+C['bags'].bagSize.value), 0)
					bankitems:SetAnchor('BOTTOMLEFT', lastbutton, 'BOTTOMLEFT', (C['bags'].bagSpace.value+C['bags'].bagSize.value), 0)
					numbuttons = numbuttons + 1
				end
				lastbutton = bankitems
			end
			for bag = 6, 12 do
				local slots = GetContainerNumSlots(bag-1)
				for item = slots, 1, -1 do
					local itemframes = _G['ContainerFrame'..bag..'Item'..item]
					itemframes:ClearAllPoints()
					itemframes:SetSize(C['bags'].bagSize.value)
					itemframes:SetFrameStrata'HIGH'
					itemframes:SetFrameLevel(2)
					
					if (numbuttons == C['bags'].bankColumns.value) then
						itemframes:SetAnchor('TOPRIGHT', lastrowbutton, 'TOPRIGHT', 0, -(C['bags'].bagSpace.value+C['bags'].bagSize.value))
						itemframes:SetAnchor('BOTTOMLEFT', lastrowbutton, 'BOTTOMLEFT', 0, -(C['bags'].bagSpace.value+C['bags'].bagSize.value))
						lastrowbutton = itemframes
						numrows = numrows + 1
						numbuttons = 1
					else
						itemframes:SetAnchor('TOPRIGHT', lastbutton, 'TOPRIGHT', (C['bags'].bagSpace.value+C['bags'].bagSize.value), 0)
						itemframes:SetAnchor('BOTTOMLEFT', lastbutton, 'BOTTOMLEFT', (C['bags'].bagSpace.value+C['bags'].bagSize.value), 0)
						numbuttons = numbuttons + 1
					end
					lastbutton = itemframes
				end
			end
			_G.sui_bank:Height(((C['bags'].bagSize.value+C['bags'].bagSpace.value)*(numrows+1)+40)-C['bags'].bagSpace.value)
		end
		
	local function reanchorKeyring()
		local id = IsBagOpen(KEYRING_CONTAINER)
		if id then
			local bu = _G['ContainerFrame'..id]
			bu:ClearAllPoints()
			if togglemain == 1 then
				bu:SetAnchor('TOPRIGHT', sui_bag, 'TOPLEFT')
			else
				bu:SetAnchor('BOTTOMRIGHT', UIParent, -110, 150)
			end
		end
	end

	--* ContainerFrame.lua
	function OpenBag(id, f)
		if (not CanOpenPanels()) then
			if (UnitIsDead('player')) then
				NotWhileDeadError();
			end
			return;
		end
		
		if (f) then
			local size = GetContainerNumSlots(id);
			if ( size > 0 ) then
				local containerShowing;
				for i = 1, NUM_CONTAINER_FRAMES, 1 do
					local frame = _G['ContainerFrame'..i];
					if ( frame:IsShown() and frame:GetID() == id ) then
						containerShowing = i;
					end
				end
				if (not containerShowing) then
					ContainerFrame_GenerateFrame(ContainerFrame_GetOpenFrame(), size, id);
				end
			end
		else
			ToggleAllBags();
		end
	end

	function updateContainerFrameAnchors() end

	--* idk, but this shows excellent work...
	function OpenBackpack()
		if (togglemain ~= 1) then
			togglemain = 1
			sui_bag:Show()
			OpenBag(0,1)
			for i = 1, NUM_BAG_FRAMES, 1 do OpenBag(i,1) end
		else
			CloseBackpack()
		end
	end
	
	function ToggleKeyRing()
		if (togglemain ~= 0) then
			togglemain = 0
			CloseBag(0,1)
			sui_bag:Hide()
			for i = 1, NUM_BAG_FRAMES, 1 do CloseBag(i,1) end
			orig.ToggleKeyRing()
			return
		end
	end

	function CloseBackpack()
		if (togglemain ~= 0) then
			togglemain = 0
			CloseBag(0,1)
			sui_bag:Hide()
			for i = 1, NUM_BAG_FRAMES, 1 do CloseBag(i,1) end
		end
	end

	function OpenAllBags()
		if (togglemain ~= 1) then
			togglemain = 1
			sui_bag:Show()
			OpenBag(0,1)
			for i = 1, NUM_BAG_FRAMES, 1 do OpenBag(i,1) end
		end
		if(BankFrame:IsShown()) then
			if (togglebank ~= 1) then
				togglebank = 1
				_G.sui_bank:Show()
				BankFrame:Show()
				for i = 1, NUM_CONTAINER_FRAMES, 1 do
					if (not IsBagOpen(i)) then OpenBag(i,1) end
				end
			end
		end
	end

	function ToggleAllBags()
		if (togglemain == 1) then
			if(not BankFrame:IsShown()) then 
				togglemain = 0
				CloseBag(0,1)
				sui_bag:Hide()
				for i = 1, NUM_BAG_FRAMES, 1 do CloseBag(i) end
			end
		else
			togglemain = 1
			sui_bag:Show()
			OpenBag(0,1)
			for i = 1, NUM_BAG_FRAMES, 1 do OpenBag(i,1) end
		end

		if(BankFrame:IsShown()) then
			if (togglebank ~= 0) then
				togglebank = 0
				sui_bank:Hide()
				BankFrame:Hide()
				CloseBankFrame()
				for i = NUM_BAG_FRAMES+1, NUM_CONTAINER_FRAMES, 1 do
					if (IsBagOpen(i)) then CloseBag(i) end
				end
			else
				togglebank = 1
				sui_bank:Show()
				BankFrame:Show()
				for i = 1, NUM_CONTAINER_FRAMES, 1 do
					if (not IsBagOpen(i)) then OpenBag(i,1) end
				end
			end
		end
	end

	--* better way?
	function ToggleBag() ToggleAllBags() end
	function ToggleBackpack() OpenBackpack() end

	local numSlots, full = GetNumBankSlots();
	local button;
	for i = 1, NUM_BANKBAGSLOTS, 1 do
		button = _G['BankFrameBag'..i];
		if (button) then
			if (i > numSlots) then
				button:HookScript('OnMouseUp', function()
					StaticPopup_Show('BUY_BANK_SLOT')
				end);
			end
		end
	end

	StaticPopupDialogs['BUY_BANK_SLOT'] = {
		text = CONFIRM_BUY_BANK_SLOT,
		button1 = YES,
		button2 = NO,
		OnAccept = function(self)
			PurchaseSlot()
		end,
		OnShow = function(self)
			MoneyFrame_Update(self.moneyFrame, GetBankSlotCost())
		end,
		hasMoneyFrame = 1,
		timeout = 0,
		hideOnEscape = 1,
		preferredIndex = 3
	}

	--* $$$ Dolla dolla bill y'all
	local moneytext = {'ContainerFrame1MoneyFrameGoldButtonText', 'ContainerFrame1MoneyFrameSilverButtonText', 'ContainerFrame1MoneyFrameCopperButtonText', 'ContainerFrame2MoneyFrameGoldButtonText', 'ContainerFrame2MoneyFrameSilverButtonText', 'ContainerFrame2MoneyFrameCopperButtonText'}
	for i = 1, 6 do
		_G[moneytext[i]]:SetFont(A.font, 14, A.fontStyle)
	end

	MainMenuBarBackpackButton:Hide()
	
	local w = CreateFrame('frame')
	w:RegisterEvent('PLAYER_ENTERING_WORLD')
	w:SetScript('OnEvent', E.init__bags);