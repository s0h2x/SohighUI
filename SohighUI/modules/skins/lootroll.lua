	
	--* loot roll
	
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end
	
	local _G = _G
	local unpack, select = unpack, select
	
	local GetLootRollItemInfo = GetLootRollItemInfo
	local GetItemQualityColor = GetItemQualityColor
	local NUM_GROUP_LOOT_FRAMES = NUM_GROUP_LOOT_FRAMES

	local function LoadSkin()

		local function OnShow(self)
			self:StripLayout(true)
			self:SetLayout()
			
			self:SetShadow()
			self:SetGradient()

			local cornerTexture = _G[self:GetName()..'Corner']
			cornerTexture:SetTexture()

			local iconFrame = _G[self:GetName()..'IconFrame']
			local _, _, _, quality = GetLootRollItemInfo(self.rollID)
			iconFrame:SetBackdropBorderColor(GetItemQualityColor(quality))
		end

		for i = 1, NUM_GROUP_LOOT_FRAMES do
			local frame = _G['GroupLootFrame'..i]
			local f = frame:GetName()
			local iconFrame = _G[f..'IconFrame']
			local icon = _G[f..'IconFrameIcon']
			local statusBar = _G[f..'Timer']
			local decoration = _G[f..'Decoration']
			local pass = _G[f..'PassButton']

			frame:SetParent(UIParent)
			frame:StripLayout()

			iconFrame:SetLayout()

			icon:SetInside()
			icon:SetTexCoord(unpack(E.TexCoords))

			statusBar:StripLayout()
			statusBar:SetLayout()
			statusBar:SetStatusBarTexture(A.FetchMedia)

			decoration:SetTexture('Interface\\DialogFrame\\UI-DialogBox-Gold-Dragon')
			decoration:SetSize(130)
			decoration:SetAnchor('TOPLEFT', -37, 20)

			pass:CloseTemplate()

			_G['GroupLootFrame'..i]:HookScript('OnShow', OnShow)
		end
	end

	table.insert(ET['SohighUI'], LoadSkin)