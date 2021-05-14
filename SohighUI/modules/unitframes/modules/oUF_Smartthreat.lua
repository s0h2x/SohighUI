
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	local Update = function(self, event, unit)
		if (unit ~= self.unit) then 
			return 
		end

		local threat = self.ThreatGlow
		local unit = unit or self.unit

		local status
		if (UnitAffectingCombat(unit)) then
			status = UnitAffectingCombat('target') or UnitAffectingCombat('focus')
		else
			status = UnitAffectingCombat(unit)
		end

		if (status and status > 0) then
			--local r, g, b = UnitAffectingCombat(status)
			local r, g, b = 0.8, 0.8, 0.8

			if (threat:IsObjectType('Texture')) then
				threat:SetVertexColor(r, g, b, 1)
			elseif (threat:IsObjectType('FontString')) then
				threat:SetTextColor(r, g, b, 1)
			elseif (threat:IsObjectType('frame') and threat:GetBackdropBorderColor()) then
				threat:SetBackdropBorderColor(r, g, b, 1)
			else
				return
			end
		else
			if (threat:IsObjectType('frame') and threat:GetBackdropBorderColor()) then
				threat:SetBackdropBorderColor(0, 0, 0, 0)
			else
				threat:SetAlpha(0)
			end
		end
	end

	local Path = function(self, ...)
		return (self.ThreatGlow.Override or Update)(self, ...)
	end

	local ForceUpdate = function(element)
		return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
	end

	local Enable = function(self)
		local threat = self.ThreatGlow

		if (threat and not self.ThreatGlow.ignore) then
			threat.__owner = self
			threat.ForceUpdate = ForceUpdate

			self:RegisterEvent('UNIT_COMBAT', Path)
			self:RegisterEvent('UNIT_TARGET', Path)
			--Path(self, _, Path)

			self:RegisterEvent('PLAYER_DEAD', Path)
			self:RegisterEvent('PLAYER_UNGHOST', Path)
			self:RegisterEvent('PLAYER_ALIVE', Path)
			self:RegisterEvent('PLAYER_UPDATE_RESTING', Path)
			self:RegisterEvent('PLAYER_REGEN_ENABLED', Path)
			self:RegisterEvent('PLAYER_REGEN_DISABLED', Path)

			return true
		end
	end

	local Disable = function(self)
		local threat = self.ThreatGlow

		if (threat and not self.ThreatGlow.ignore) then
			self:UnregisterEvent('UNIT_COMBAT', Path)
			self:UnregisterEvent('UNIT_TARGET', Path)
			self:UnregisterEvent('PLAYER_DEAD', Path)
			self:UnregisterEvent('PLAYER_UNGHOST', Path)
			self:UnregisterEvent('PLAYER_ALIVE', Path)
			self:UnregisterEvent('PLAYER_UPDATE_RESTING', Path)
			self:UnregisterEvent('PLAYER_REGEN_ENABLED', Path)
			self:UnregisterEvent('PLAYER_REGEN_DISABLED', Path)
		end
	end

	oUF:AddElement('SmartThreatGlow', Path, Enable, Disable)