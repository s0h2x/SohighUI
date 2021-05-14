--[[
	oUF_Resolve by Sticklord
		

	Resolve = CreateFrame("StatusBar", nil, self)
		- Required
		- A statusbar to display current resolve in percent.
  
	Resolve.Percent = CreateFontString()
		- Optional
		- A fontstring to display bonus healing, i.e. 130%

	Resolve.DamageIntake = CreateFontString()
		- Optional
		- A fontstring to displat damage intake last 10 seconds, i.e. 12.4k

	Resolve:PreUpdate()
		- Called before the element has been updated
		- Arguments: self (element)

	Resolve:PostUpdate(perc, damageintake)
		- Called after the element has been updated
		- Arguments: 
			self (element)
			perc (healing modifier in percent)
			self (damage taken last 10 seconds)

Example

	local Resolve = CreateFrame('StatusBar', nil, self)
	Resolve:SetSize(120, 20)
	Resolve:SetAnchor('TOPLEFT', self, 'BOTTOMLEFT', 0, 0)
	
	Resolve.Percent = Resolve:CreateFontString(nil, "OVERLAY")
	Resolve.Percent:SetAnchor("LEFT", 10, 0)
	Resolve.Percent:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")

	self.Resolve = Resolve

Hooks
	OverrideVisibility(self)-	Used to completely override the internal visibility function.
								Removing the table key entry will make the element fall-back
								to its internal function again.
	Override(self)			-	Used to completely override the internal update function.
								Removing the table key entry will make the element fall-back
								to its internal function again.
]]
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	local SPELLID = 158300

	-- lim(x->inf) 100 * 3.4 * (1 - e^(-0.045*x)) = 340%
	-- 340 / 100 - 1 = 2.4 - it starts at 0% not 100%
	-- I assume perc is 0 - 240 or 0 - 2.4
	local MAXMOD = 2.4

	local function FormatValue(value)
		if value >= 1e7 then -- good to be safe
			return tonumber(format('%.1f', value/1e6))..'m'
		elseif value >= 1e6 then
			return tonumber(format('%.2f', value/1e6))..'m'
		elseif value >= 1e5 then
			return tonumber(format('%.0f', value/1e3))..'k'
		elseif value >= 1e3 then
			return tonumber(format('%.1f', value/1e3))..'k'
		else
			return value
		end
	end
		
	local function Update(self, event, unit)
		if unit ~= self.unit then return; end
		local element = self.Resolve

		if (element.PreUpdate) then
			element:PreUpdate()
		end
		
		local _, _, _, _, _, _, _, _, _, _, _, _, _, _, perc, dmgIntake = oUF.UnitAura(unit, element.spellname, element.rank)

		if (not perc) or (perc and (perc/MAXMOD + .5) < 1) then
			if (element:IsShown()) then
				element:Hide()
			end
			return
		elseif (not element:IsShown()) then
			element:Show()
		end	

		local realPerc = math.floor(perc/MAXMOD + .5)
		element:SetValue(realPerc)
		
		if element.Percent then
			element.Percent:SetText(realPerc .. "%")
		end
		if element.DamageIntake then
			element.DamageIntake:SetText(FormatValue(dmgIntake))
		end
		
		if (element.PostUpdate) then
			element:PostUpdate(perc, dmgIntake)
		end
	end

	local function Path(self, ...)
		return (self.Resolve.Override or Update) (self, ...)
	end

	local UpdateVisibility = function(self, event, unit)
		--local masteryIndex = GetSpecialization()
		--local class = E.Class
		local element = self.Resolve
		local shouldshow = false;

		--[[if masteryIndex then
			if E.Class == "DRUID" and masteryIndex == 3 then
				shouldshow = true
			elseif E.Class == "DEATHKNIGHT" and masteryIndex == 1 then
				shouldshow = true
			elseif E.Class == "PALADIN" and masteryIndex == 2 then
				shouldshow = true
			elseif E.Class == "WARRIOR" and masteryIndex == 3 then
				shouldshow = true
			elseif E.Class == "MONK" and masteryIndex == 1 then
				shouldshow = true
			end
		end--]]

		if (shouldshow) then
			if (not element.active) then
				element.active = true
				self:RegisterEvent("UNIT_AURA", Path)
				return Path(self, event, unit)
			end
		elseif (element.active) then
			element.active = false
			element:Hide()
			self:UnregisterEvent("UNIT_AURA", Path)
		end
	end

	local function VisibilityPath(self, ...)
		return (self.Resolve.OverrideVisibility or UpdateVisibility) (self, ...)
	end

	local function ForceUpdate(element)
		return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
	end

	local function Enable(self, unit)
		local element = self.Resolve
		if (element and unit == "player") then

			element.spellname, element.rank = GetSpellInfo(SPELLID)
			element.__owner = self
			element.ForceUpdate = ForceUpdate

			element:SetMinMaxValues(0, 100)
			
			if (element:IsObjectType('StatusBar') and (not element:GetStatusBarTexture())) then
				element:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			if element.Orientation then
				element:SetOrientation(element.Orientation)
			end
			if element.InverseOrientation then
				element:SetReverseFill(true)
			end
			
			if (element.Percent) then
				assert(element.Percent:GetObjectType() == "FontString", "Resolve.Percent is not a fontstring")
				element.Percent:SetText("0%")
			end
			if (element.DamageIntake) then
				assert(element.DamageIntake:GetObjectType() == "FontString", "Resolve.DamageIntake is not a fontstring")
				element.DamageIntake:SetText("0")
			end

			VisibilityPath(self, 'ForceUpdate', unit)
			self:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED', VisibilityPath)
			self:RegisterEvent('UPDATE_OVERRIDE_ACTIONBAR', VisibilityPath)
			self:RegisterEvent("UNIT_ENTERED_VEHICLE", VisibilityPath)
			self:RegisterEvent("UNIT_EXITED_VEHICLE", VisibilityPath)

			-- Smoothing
			oUF:RegisterInitCallback(function(obj)
				if obj.SmoothBar and obj.Resolve and (not obj.Resolve.SetValue_) then
					obj:SmoothBar(obj.Resolve)
				end
			end)
			return true
		end
	end

	local function Disable(self)
		if(self.Resolve) then
			self:UnregisterEvent("UNIT_AURA", Path)
			self:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED', VisibilityPath)
			self:UnregisterEvent('UPDATE_OVERRIDE_ACTIONBAR', VisibilityPath)
			self:UnregisterEvent("UNIT_ENTERED_VEHICLE", VisibilityPath)
			self:UnregisterEvent("UNIT_EXITED_VEHICLE", VisibilityPath)
		end
	end
	oUF:AddElement('Resolve', Path, Enable, Disable)
