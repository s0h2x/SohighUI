
	local E, C, _ = select(2, shCore()):unpack()
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	local unpack = unpack
	
	local gridscale = 1
	
	local countOffsets = {
		TOPLEFT = {6 * gridscale, 1},
		TOPRIGHT = {-6 * gridscale, 1},
		BOTTOMLEFT = {6 * gridscale, 1},
		BOTTOMRIGHT = {-6 * gridscale, 1},
		LEFT = {6 * gridscale, 1},
		RIGHT = {-6 * gridscale, 1},
		TOP = {0, 0},
		BOTTOM = {0, 0},
	}
	
	local function CreateAuraWatchIcon(self, icon)
		icon.icon:SetTexCoord(unpack(E.TexCoords))
		if (icon.cd) then
			ChatFrame1:AddMessage('functions.lua, CreateAuraWatchIcon:')
			--icon.cd:SetReverse()
		end 	
	end

	local function createAuraWatch(self, unit)
		local auras = CreateFrame('frame', nil, self)
		auras:SetAnchor('TOPLEFT', self.Health, 2, -2)
		auras:SetAnchor('BOTTOMRIGHT', self.Health, -2, 2)
		auras.presentAlpha = 1
		auras.missingAlpha = 0
		auras.icons = {}
		auras.PostCreateIcon = CreateAuraWatchIcon

		if (not C['units'].auraTimer) then
			auras.hideCooldown = true
		end

		local buffs = {}
		local debuffs = E.debuffIDs

		if (E.buffIDs['ALL']) then
			for key, value in pairs(E.buffIDs['ALL']) do
				tinsert(buffs, value)
			end
		end

		if (E.buffIDs[E.Class]) then
			for key, value in pairs(E.buffIDs[E.Class]) do
				tinsert(buffs, value)
			end
		end

		-- 'Cornerbuffs'
		if (buffs) then
			for key, spell in pairs(buffs) do
				local icon = CreateFrame('frame', nil, auras)
				icon.spellID = spell[1]
				icon.anyUnit = spell[4]
				icon:SetSize(7 * gridscale)
				icon:SetAnchor(spell[2], 0, 0)

				local tex = icon:CreateTexture(nil, 'OVERLAY')
				tex:SetAllPoints(icon)
				tex:SetTexture(A.solid)
				if (spell[3]) then
					tex:SetVertexColor(unpack(spell[3]))
				else
					tex:SetVertexColor(0.8, 0.8, 0.8)
				end

				local count = icon:CreateFontString(nil, 'OVERLAY')
				count:SetFont(A.font, 8 * gridscale, A.fontStyleT)
				count:SetAnchor('CENTER', unpack(countOffsets[spell[2]]))
				icon.count = count

				auras.icons[spell[1]] = icon
			end
		end

		-- Raid debuffs (Big icon in the middle)
		if (debuffs) then
			for key, spellID in pairs(debuffs) do
				local icon = CreateFrame('frame', nil, auras)
				icon.spellID = spellID
				icon.anyUnit = true
				icon:SetSize(22 * gridscale)
				icon:SetAnchor('CENTER', 0, 0)

				local count = icon:CreateFontString(nil, 'OVERLAY')
				count:SetFont(A.font, 9 * gridscale, A.fontStyleT)
				count:SetAnchor('BOTTOMRIGHT', 2, 2)
				icon.count = count

				auras.icons[spellID] = icon
			end
		end

		self.AuraWatch = auras
	end