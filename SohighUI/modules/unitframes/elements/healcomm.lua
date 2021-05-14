	
	local E, C, _ = select(2, shCore()):unpack()
	if C['units'].healComm ~= true then return end

	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	local CreateFrame = CreateFrame
	local hooksecurefunc = hooksecurefunc
	
	local function OnOrientationChanged(self, orientation)
		self.texturePointer.verticalOrientation = orientation == 'VERTICAL'

		if self.texturePointer.verticalOrientation then
			self.texturePointer:SetAnchor('BOTTOMLEFT', self)
		else
			self.texturePointer:SetAnchor('LEFT', self)
		end
	end

	local function OnSizeChanged(self, width, height)
		self.texturePointer.width = width
		self.texturePointer.height = height
		self.texturePointer:SetSize(width, height)
	end

	local function OnValueChanged(self, value)
		local _, max = self:GetMinMaxValues()

		if self.texturePointer.verticalOrientation then
			self.texturePointer:Height(self.texturePointer.height * (value / max))
		else
			self.texturePointer:Width(self.texturePointer.width * (value / max))
		end
	end
	
	local function CreateStatusBarTexturePointer(statusbar)
		assert(type(statusbar) == 'table', format('Bad argument #1 to \'CreateStatusBarTexturePointer\' (table expected, got %s)', statusbar and type(statusbar) or 'no value'))
		assert(statusbar.GetObjectType and statusbar:GetObjectType() == 'StatusBar', 'Bad argument #1 to \'CreateStatusBarTexturePointer\' (statusbar object expected)')

		local f = statusbar:CreateTexture()
		f.width = statusbar:GetWidth()
		f.height = statusbar:GetHeight()
		f.vertical = statusbar:GetOrientation() == 'VERTICAL'
		f:SetSize(f.width, f.height)

		if f.verticalOrientation then
			f:SetAnchor('BOTTOMLEFT', statusbar)
		else
			f:SetAnchor('LEFT', statusbar)
		end

		statusbar.texturePointer = f

		statusbar:SetScript('OnSizeChanged', OnSizeChanged)
		statusbar:SetScript('OnValueChanged', OnValueChanged)

		hooksecurefunc(statusbar, 'SetOrientation', OnOrientationChanged)

		return f
	end

	ns.Construct_HealComm = function(frame)
		local mhpb = CreateFrame('StatusBar', nil, frame.Health)
		mhpb:SetStatusBarTexture(frame.Health:GetStatusBarTexture():GetTexture())
		mhpb:SetStatusBarColor(0, 1, 0, .65)
		mhpb:Hide()

		local ohpb = CreateFrame('StatusBar', nil, frame.Health)
		ohpb:SetStatusBarTexture(frame.Health:GetStatusBarTexture():GetTexture())
		ohpb:SetStatusBarColor(0, 1, 0, .65)
		ohpb:Hide()

		CreateStatusBarTexturePointer(mhpb)

		local HealthPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			maxOverflow = 1,
			PostUpdate = ns.UpdateHealComm,
		}
		HealthPrediction.parent = frame

		return HealthPrediction
	end

	ns.Configure_HealComm = function(self)
		local healCommBar = self.HealCommBar
		local c = 0, 1, 0, .65

		if self.healPrediction then
			if not self:EnableElement('HealComm3') then
				self:EnableElement('HealComm3')
			end

			if not self.USE_PORTRAIT_OVERLAY then
				healCommBar.myBar:SetParent(self.Health)
				healCommBar.otherBar:SetParent(self.Health)
			else
				healCommBar.myBar:SetParent(self.Portrait.overlay)
				healCommBar.otherBar:SetParent(self.Portrait.overlay)
			end

			local orientation = self.health and self.health.orientation
			if orientation then
				healCommBar.myBar:SetOrientation(orientation)
				healCommBar.otherBar:SetOrientation(orientation)
			end

			healCommBar.myBar:SetStatusBarColor(0, 1, 0, .75)
			healCommBar.otherBar:SetStatusBarColor(0, 1, 0, .75)

			healCommBar.maxOverflow = (1 + (c.maxOverflow or 0))
		else
			if self:EnableElement('HealComm3') then
				self:DisableElement('HealComm3')
			end
		end
	end

	local function UpdateFillBar(frame, previousTexture, bar, amount)
		if amount == 0 then
			bar:Hide()
			return previousTexture
		end

		local orientation = frame.Health:GetOrientation()
		bar:ClearAllPoints()
		if (orientation == 'HORIZONTAL') then
			bar:SetAnchor('TOPLEFT', previousTexture, 'TOPRIGHT')
			bar:SetAnchor('BOTTOMLEFT', previousTexture, 'BOTTOMRIGHT')
		else
			bar:SetAnchor('BOTTOMRIGHT', previousTexture, 'TOPRIGHT')
			bar:SetAnchor('BOTTOMLEFT', previousTexture, 'TOPLEFT')
		end

		local totalWidth, totalHeight = frame.Health:GetSize()
		if orientation == 'HORIZONTAL' then
			bar:Width(totalWidth)
		else
			bar:Height(totalHeight)
		end

		return bar.texturePointer
	end

	ns.UpdateHealComm = function(self, myIncomingHeal, allIncomingHeal)
	--function UF:UpdateHealComm(_, myIncomingHeal, allIncomingHeal)
		local frame = self.parent
		local previousTexture = frame.Health.texturePointer

		previousTexture = UpdateFillBar(frame, previousTexture, self.myBar, myIncomingHeal)
		previousTexture = UpdateFillBar(frame, previousTexture, self.otherBar, allIncomingHeal)
	end