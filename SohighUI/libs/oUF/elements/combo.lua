
	local parent, ns = debugstack():match[[\AddOns\(.-)\]], oUF
	local oUF = ns.oUF or _G.oUF

	local GetComboPoints = GetComboPoints
	local MAX_COMBO_POINTS = MAX_COMBO_POINTS

	local Update = function(self, event, unit)
		if(unit == 'pet') then return end

		local cpoints = self.CPoints
		if(cpoints.PreUpdate) then
			cpoints:PreUpdate()
		end

		local cp = GetComboPoints()

		for i=1, MAX_COMBO_POINTS do
			if(i <= cp) then
				cpoints[i]:Show()
			else
				cpoints[i]:Hide()
			end
		end

		if(cpoints.PostUpdate) then
			return cpoints:PostUpdate(cp)
		end
	end

	local Path = function(self, ...)
		return (self.CPoints.Override or Update) (self, ...)
	end

	local ForceUpdate = function(element)
		return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
	end

	local Enable = function(self)
		local cpoints = self.CPoints
		if(cpoints) then
			cpoints.__owner = self
			cpoints.ForceUpdate = ForceUpdate

			self:RegisterEvent('PLAYER_COMBO_POINTS', Path, true)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', Path, true)

			for index = 1, MAX_COMBO_POINTS do
				local cpoint = cpoints[index]
				if(cpoint:IsObjectType'Texture' and not cpoint:GetTexture()) then
					cpoint:SetTexture[[Interface\ComboFrame\ComboPoint]]
					cpoint:SetTexCoord(0, 0.375, 0, 1)
				end
			end

			return true
		end
	end

	local Disable = function(self)
		local cpoints = self.CPoints
		if(cpoints) then
			for index = 1, MAX_COMBO_POINTS do
				cpoints[index]:Hide()
			end
			self:UnregisterEvent('PLAYER_COMBO_POINTS', Path)
			self:UnregisterEvent('PLAYER_TARGET_CHANGED', Path)
		end
	end

	oUF:AddElement('CPoints', Path, Enable, Disable)