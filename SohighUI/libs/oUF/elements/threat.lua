	
	--* threat (combat white glow)

	local parent, ns = debugstack():match[[\AddOns\(.-)\]], oUF
	local oUF = ns.oUF or _G.oUF

	local Update = function(self, event, unit)
		if(unit ~= self.unit) then return end

		local threat = self.Threat
		if(threat.PreUpdate) then threat:PreUpdate(unit) end

		unit = unit or self.unit
		local status = UnitAffectingCombat(unit)

		local r, g, b
		if(status and status > 0) then
			r, g, b = 0.8, 0.8, 0.8
			threat:SetVertexColor(r, g, b)
			threat:Show()
		else
			threat:Hide()
		end

		if(threat.PostUpdate) then
			return threat:PostUpdate(unit, status, r, g, b)
		end
	end

	local Path = function(self, ...)
		return (self.Threat.Override or Update) (self, ...)
	end

	local ForceUpdate = function(element)
		return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
	end

	local Enable = function(self)
		local threat = self.Threat
		if(threat) then
			threat.__owner = self
			threat.ForceUpdate = ForceUpdate

			self:RegisterEvent('UNIT_COMBAT', Path)
			self:RegisterEvent('PLAYER_DEAD', Path)
			self:RegisterEvent('PLAYER_UNGHOST', Path)
			self:RegisterEvent('PLAYER_ALIVE', Path)
			self:RegisterEvent('PLAYER_UPDATE_RESTING', Path)
			self:RegisterEvent('PLAYER_REGEN_ENABLED', Path)
			self:RegisterEvent('PLAYER_REGEN_DISABLED', Path)

			if(threat:IsObjectType'Texture' and not threat:GetTexture()) then
				threat:SetTexture[[Interface\Minimap\ObjectIcons]]
				threat:SetTexCoord(6/8, 7/8, 1/8, 2/8)
			end

			return true
		end
	end

	local Disable = function(self)
		local threat = self.Threat
		if(threat) then
			threat:Hide()
			self:UnregisterEvent('UNIT_COMBAT', Path)
			self:UnregisterEvent('PLAYER_DEAD', Path)
			self:UnregisterEvent('PLAYER_UNGHOST', Path)
			self:UnregisterEvent('PLAYER_ALIVE', Path)
			self:UnregisterEvent('PLAYER_UPDATE_RESTING', Path)
			self:UnregisterEvent('PLAYER_REGEN_ENABLED', Path)
			self:UnregisterEvent('PLAYER_REGEN_DISABLED', Path)
		end
	end

	oUF:AddElement('Threat', Path, Enable, Disable)
