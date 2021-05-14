	
	local type = type

	local colorTable = setmetatable(
	{
		[100] = {r = .9, g = 0, b = 0},
		[99] = {r = 1, g = 1, b = 0},
	}, {__call = function(self, val)
		local c = self[val]
			if(c) then
				return c.r, c.g, c.b
			elseif(type(val) == 'number') then
				return GetItemQualityColor(val)
			end
		end}
	)

	local createBorder = function(self, point)
		local bc = self:CreateTexture(nil, 'OVERLAY')
		bc:SetTexture(A.auraWatch)

		bc:SetBlendMode'ADD'
		bc:SetAlpha(.8)
		
		bc:SetSize(38)

		bc:SetAnchor('CENTER', point or self)
		self.bc = bc
	end

	local border, r, g, b
	oGlow = setmetatable({
		RegisterColor = function(self, key, r, g, b)
			colorTable[key] = {r = r, g = g, b = b}
		end,
	}, {
		__call = function(self, frame, quality, point)
			if(type(quality) == 'number' and quality > 1 or type(quality) == 'string') then
				if(not frame.bc) then createBorder(frame, point) end

				border = frame.bc
				if(border) then
					r, g, b = colorTable(quality)
					border:SetVertexColor(r, g, b)
					border:Show()
				end
			elseif(frame.bc) then
				frame.bc:Hide()
			end
		end,
	})
