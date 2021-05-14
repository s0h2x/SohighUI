
	--* combat state
	local E, C, _ = select(2, shCore()):unpack()

	local parent, ns = debugstack():match[[\AddOns\(.-)\]], oUF
	local oUF = ns.oUF or _G.oUF
	
	local UnitAffectingCombat = UnitAffectingCombat

	local Update = function(self, event, unit)
		if (unit ~= self.unit) then 
			return 
		end

		local unit = unit or self.unit

		local status
		if (UnitAffectingCombat(unit)) then
			status = UnitAffectingCombat('target') or UnitAffectingCombat('focus')
		else
			status = UnitAffectingCombat(unit)
		end
		
		if (status and status > 0) then
			self.Combat:Show()
			self.Level:Hide()
		else
			self.Combat:Hide()
			self.Level:Show()
			E.hoop(self.Combat)
		end
	end

	local Enable = function(self, unit)
		local combat = self.Combat
		if(combat) then
			local Update = combat.Update or Update
			self:RegisterEvent('UNIT_COMBAT', Update)
			self:RegisterEvent('UNIT_TARGET', Update)
			self:RegisterEvent('PLAYER_DEAD', Update)
			self:RegisterEvent('PLAYER_UNGHOST', Update)
			self:RegisterEvent('PLAYER_ALIVE', Update)
			self:RegisterEvent('PLAYER_REGEN_ENABLED', Update)
			self:RegisterEvent('PLAYER_REGEN_DISABLED', Update)

			if(self.Combat:IsObjectType'Texture' and not self.Combat:GetTexture()) then
				self.Combat:SetTexture(A.combat)
				self.Combat:SetTexCoord(.5, 1, 0, .49)
			end

			return true
		end
	end

	local Disable = function(self)
		local combat = self.Combat
		if(combat) then
			local Update = combat.Update or Update
			self:UnregisterEvent('UNIT_COMBAT', Update)
			self:UnregisterEvent('UNIT_TARGET', Update)
			self:UnregisterEvent('PLAYER_DEAD', Update)
			self:UnregisterEvent('PLAYER_UNGHOST', Update)
			self:UnregisterEvent('PLAYER_ALIVE', Update)
			self:UnregisterEvent('PLAYER_REGEN_ENABLED', Update)
			self:UnregisterEvent('PLAYER_REGEN_DISABLED', Update)
		end
	end

	oUF:AddElement('Combat', Update, Enable, Disable)
