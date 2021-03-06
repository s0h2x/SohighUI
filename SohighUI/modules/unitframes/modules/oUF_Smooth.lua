	
	--*	oUF Smooth
	
	local E, C, _ = select(2, shCore()):unpack()
	if C['units'].smoothing ~= true then return end
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	local smoothing = {}
	local function Smooth(self, value)
		local _, max = self:GetMinMaxValues()
		if (value == self:GetValue() or (self._max and self._max ~= max)) then
			smoothing[self] = nil
			self:SetValue_(value)
		else
			smoothing[self] = value
		end
		
		self._max = max
	end

	local function SmoothBar(self, bar)
		bar.SetValue_ = bar.SetValue
		bar.SetValue = Smooth
	end

	local function oUF_hook(frame)
		frame.SmoothBar = SmoothBar
		if (frame.Health and frame.Health.Smooth) then
			frame:SmoothBar(frame.Health)
		end
		
		if (frame.Power and frame.Power.Smooth) then
			frame:SmoothBar(frame.Power)
		end

		if (frame.HealPrediction) then
			if (frame.HealPrediction.myBar and frame.HealPrediction.myBar.Smooth) then
				frame:SmoothBar(frame.HealPrediction.myBar)
			end
			
			if (frame.HealPrediction.otherBar and frame.HealPrediction.myBar.otherBar) then
				frame:SmoothBar(frame.HealPrediction.otherBar)
			end
		end
	end

	for i, frame in ipairs(oUF.objects) do oUF_hook(frame) end
	oUF:RegisterInitCallback(oUF_hook)

	local f, min, max = CreateFrame('frame'), math.min, math.max 
	f:SetScript('OnUpdate', function()
		local limit = 40/GetFramerate()
		for bar, value in pairs(smoothing) do
			local cur = bar:GetValue()
			local new = cur + min((value-cur)/3, max(value-cur, limit))
			if (new ~= new) then
				new = value
			end
			
			bar:SetValue_(new)
			if (cur == value or abs(new - value) < 2) then
				bar:SetValue_(value)
				smoothing[bar] = nil
			end
		end
	end);
