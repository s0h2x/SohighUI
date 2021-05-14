
	local parent, ns = debugstack():match[[\AddOns\(.-)\]], oUF
	local oUF = ns.oUF or _G.oUF

	local Update = function(self, event)
		local lfdrole = self.LFDRole
		local role = 'NONE'
		if UnitGroupRolesAssigned then
			role = UnitGroupRolesAssigned(self.unit)
		end
		
		--local isTank, isHealer, isDamage = UnitGroupRolesAssigned("player")

		if (role) then
            if (role == 'TANK') then
                role = '>'
            elseif (role == 'HEALER') then
                role = '+'
            elseif (role == 'DAMAGER') then
                role = '-'
            elseif (role == 'NONE') then
                role = ''
            end

            return role
        else
            return ''
        end
	end

	local Enable = function(self)
		local lfdrole = self.LFDRole
		if(lfdrole) then
			local Update = lfdrole.Update or Update
			if(self.unit == 'player') then
				self:RegisterEvent('PLAYER_ROLES_ASSIGNED', Update)
			else
				self:RegisterEvent('PARTY_MEMBERS_CHANGED', Update)
			end

			if(lfdrole:IsObjectType'Texture' and not lfdrole:GetTexture()) then
				lfdrole:SetTexture[[Interface\LFGFrame\UI-LFG-ICON-PORTRAITROLES]]
			end

			return true
		end
	end

	local Disable = function(self)
		local lfdrole = self.LFDRole
		if(lfdrole) then
			local Update = lfdrole.Update or Update
			self:UnregisterEvent('PLAYER_ROLES_ASSIGNED', Update)
			self:UnregisterEvent('PARTY_MEMBERS_CHANGED', Update)
		end
	end

	oUF:AddElement('LFDRole', Update, Enable, Disable)
