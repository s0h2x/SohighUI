	
	--* Auto Merchant
	
	local E, C, L, _ = select(2, shCore()):unpack()
	if C.main.autoMerchant ~= true then return end
	
	local select = select
	local format = string.format
	
	local CanGuildBankRepair = CanGuildBankRepair
	local CanMerchantRepair = CanMerchantRepair
	local CreateFrame = CreateFrame
	local hooksecurefunc = hooksecurefunc
	local GetContainerItemLink, GetContainerNumSlots = GetContainerItemLink, GetContainerNumSlots
	local GetGuildBankWithdrawMoney = GetGuildBankWithdrawMoney
	local GetItemInfo, GetMerchantItemInfo = GetItemInfo, GetMerchantItemInfo
	local GetMoney = GetMoney
	local GetNumPartyMembers = GetNumPartyMembers
	local GetRepairAllCost = GetRepairAllCost
	local GetMerchantItemMaxStack = GetMerchantItemMaxStack
	local GetMerchantItemLink = GetMerchantItemLink
	local RepairAllItems = RepairAllItems
	local UseContainerItem = UseContainerItem
	local BuyMerchantItem = BuyMerchantItem

	local w = CreateFrame('frame')
	local OnEvent = function(self, event, ...) self[event](self, event, ...) end
	w:SetScript('OnEvent', OnEvent)
	
	--*	Alt+Click to buy a stack
	hooksecurefunc('MerchantItemButton_OnModifiedClick', function(self, ...)
		local self = this
		if IsAltKeyDown() then
			local itemLink = GetMerchantItemLink(self:GetID())
			if not itemLink then return end

			local maxStack = select(8, GetItemInfo(itemLink))
			if maxStack and maxStack > 1 then
				local numAvailable = select(5, GetMerchantItemInfo(self:GetID()))
				if numAvailable > -1 then
					BuyMerchantItem(self:GetID(), numAvailable)
				else
					BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
				end
			end
		end
	end);

	--*	auto sell junk
	local function MERCHANT_SHOW(...)
		for bagIndex = 0, 4 do
			if GetContainerNumSlots(bagIndex) > 0 then
				for slotIndex = 1, GetContainerNumSlots(bagIndex) do
					if select(2, GetContainerItemInfo(bagIndex, slotIndex)) then
						local quality = select(3, string.find(GetContainerItemLink(bagIndex, slotIndex), '(|c%x+)'))
						
						if (quality == ITEM_QUALITY_COLORS[0].hex) then
							UseContainerItem(bagIndex, slotIndex)
						end
					end
				end
			end
		end
	
		--*	auto repair
		if CanMerchantRepair() then
			local cost, needed = GetRepairAllCost()
			if needed then
				local GuildWealth = CanGuildBankRepair() and GetGuildBankWithdrawMoney() > cost
				if GuildWealth and GetNumPartyMembers() > 5 then
					RepairAllItems(1)
					E.Suitag(format(L_RepairBank, E.FormatMoney(cost)))
				elseif cost < GetMoney() then
					RepairAllItems()
					E.Suitag(format(L_Repaired_For, E.FormatMoney(cost)))
				else
					E.Suitag(L_Afford_Repair)
				end
			end
		end
	end

	w:RegisterEvent('MERCHANT_SHOW')
	w['MERCHANT_SHOW'] = MERCHANT_SHOW
