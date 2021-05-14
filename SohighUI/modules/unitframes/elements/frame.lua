	
	--* cast/bar frame
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF
	
	--* border
	local sections = {'TOPLEFT','TOPRIGHT','TOP','BOTTOMLEFT','BOTTOMRIGHT','BOTTOM','LEFT','RIGHT'}

	local function SetBorderColor(self, r, g, b, a)
		local t = self.borderTextures
		if t then
			if not r or not g and not b then
				r, g, b = 1, 1, 1
			end
			for _, tex in pairs (t) do
				tex:SetVertexColor(r, g, b, a or 1)
			end
		end
	end

	local function SetBorderShadowColor(self, r, g, b, a)
		local t = self.borderShadow
		if t then
			if not r or not g and not b then
				r, g, b = 1, 1, 1
			end
			for _, tex in pairs (t) do
				tex:SetVertexColor(r, g, b, a or 1)
				--E.__createShadow(tex)
			end
		end
	end

	local function SetBorderTexture(self, texture)
		local b = self.borderTextures
		if b then
			if (texture == 'white') then
				texture = A.auraWhite
			elseif texture == 'default' then
				texture = A.auraNormal
			end
			for _, tex in pairs(b) do
				tex:SetTexture(texture)
			end
		end
	end
	-----------------
	local function SetBorderSize(self, size)
		local b = self.borderTextures
		local s = self.borderShadow
		if b then
			for _, tex in pairs(b) do
				tex:Width(size)
				tex:Height(size)
			end
		end
		if s then
			for _, tex in pairs(s) do
				tex:Width(size)
				tex:Height(size) 
			end
		end
	end

	local function GetBorderSize(self)
		if self.borderTextures then
			local size = self.borderTextures.TOPRIGHT:GetWidth()
			return size
		end
	end
	------------------
	local function SetBorderPadding(self, T, B, L, R)
		local b = self.borderTextures
		local s = self.borderShadow
		if b and T then
			if not R and not B and not B and not L then
				R, B, L = T, T, T
			end

			b.TOPLEFT:SetAnchor('TOPLEFT', self, -L, T)
			b.TOPRIGHT:SetAnchor('TOPRIGHT', self, R, T)
			b.TOP:SetAnchor('TOPLEFT', b.TOPLEFT, 'TOPRIGHT')
			b.TOP:SetAnchor('TOPRIGHT', b.TOPRIGHT, 'TOPLEFT')
			b.BOTTOMLEFT:SetAnchor('BOTTOMLEFT', self, -L, -B)
			b.BOTTOMRIGHT:SetAnchor('BOTTOMRIGHT', self, R, -B)
			b.BOTTOM:SetAnchor('BOTTOMLEFT', b.BOTTOMLEFT, 'BOTTOMRIGHT')
			b.BOTTOM:SetAnchor('BOTTOMRIGHT', b.BOTTOMRIGHT, 'BOTTOMLEFT')
			b.LEFT:SetAnchor('TOPLEFT', b.TOPLEFT, 'BOTTOMLEFT')
			b.LEFT:SetAnchor('BOTTOMLEFT', b.BOTTOMLEFT, 'TOPLEFT')
			b.RIGHT:SetAnchor('TOPRIGHT', b.TOPRIGHT, 'BOTTOMRIGHT')
			b.RIGHT:SetAnchor('BOTTOMRIGHT', b.BOTTOMRIGHT, 'TOPRIGHT')

			local space = (self:GetBorderSize()) / 3.5

			s.TOPLEFT:SetAnchor('TOPLEFT', self, -(L+space), (T+space))
			s.TOPRIGHT:SetAnchor('TOPRIGHT', self, (R+space), (T+space))
			s.TOP:SetAnchor('TOPLEFT', s.TOPLEFT, 'TOPRIGHT')
			s.TOP:SetAnchor('TOPRIGHT', s.TOPRIGHT, 'TOPLEFT')
			s.BOTTOMLEFT:SetAnchor('BOTTOMLEFT', self, -(L+space), -(B+space))
			s.BOTTOMRIGHT:SetAnchor('BOTTOMRIGHT', self, (R+space), -(B+space))
			s.BOTTOM:SetAnchor('BOTTOMLEFT', s.BOTTOMLEFT, 'BOTTOMRIGHT')
			s.BOTTOM:SetAnchor('BOTTOMRIGHT', s.BOTTOMRIGHT, 'BOTTOMLEFT')
			s.LEFT:SetAnchor('TOPLEFT', s.TOPLEFT, 'BOTTOMLEFT')
			s.LEFT:SetAnchor('BOTTOMLEFT', s.BOTTOMLEFT, 'TOPLEFT')
			s.RIGHT:SetAnchor('TOPRIGHT', s.TOPRIGHT, 'BOTTOMRIGHT')
			s.RIGHT:SetAnchor('BOTTOMRIGHT', s.BOTTOMRIGHT, 'TOPRIGHT')
		end
	end
	-----------------
	function ns.CreateBorder(self, size, padding, layer)
		if type(self) ~= 'table' or self.borderTextures then return end

		if not (self.borderTextures) then
			local b = {}
			local s = {}

			for i = 1, 8 do 
				local t = self:CreateTexture(nil, layer or 'OVERLAY')
				t:SetParent(self)
				t:SetTexture(A.auraNormal)
				t:SetVertexColor(.1, .1, .1, 1)
				b[sections[i]] = t
			end

			for i = 1, 8 do 
				local t = self:CreateTexture(nil, layer or 'BORDER')
				t:SetParent(self)
				t:SetTexture(A.auraShadow)
				t:SetVertexColor(.21, .21, .23, 1)
				s[sections[i]] = t
			end

			b.TOPLEFT:SetTexCoord(0, 1/3, 0, 1/3)
			b.TOPRIGHT:SetTexCoord(2/3, 1, 0, 1/3)
			b.TOP:SetTexCoord(1/3, 2/3, 0, 1/3)
			b.BOTTOMLEFT:SetTexCoord(0, 1/3, 2/3, 1)
			b.BOTTOMRIGHT:SetTexCoord(2/3, 1, 2/3, 1)
			b.BOTTOM:SetTexCoord(1/3, 2/3, 2/3, 1)
			b.LEFT:SetTexCoord(0, 1/3, 1/3, 2/3)
			b.RIGHT:SetTexCoord(2/3, 1, 1/3, 2/3)

			s.TOPLEFT:SetTexCoord(0, 1/3, 0, 1/3)
			s.TOPRIGHT:SetTexCoord(2/3, 1, 0, 1/3)
			s.TOP:SetTexCoord(1/3, 2/3, 0, 1/3)
			s.BOTTOMLEFT:SetTexCoord(0, 1/3, 2/3, 1)
			s.BOTTOMRIGHT:SetTexCoord(2/3, 1, 2/3, 1)
			s.BOTTOM:SetTexCoord(1/3, 2/3, 2/3, 1)
			s.LEFT:SetTexCoord(0, 1/3, 1/3, 2/3)
			s.RIGHT:SetTexCoord(2/3, 1, 1/3, 2/3)

			self.borderTextures = b
			self.borderShadow = s

			self.SetBorderColor = SetBorderColor
			self.SetBorderShadowColor = SetBorderShadowColor
			self.SetBorderTexture = SetBorderTexture
			self.SetBorderSize = SetBorderSize
			self.GetBorderSize = GetBorderSize
			self.SetBorderPadding = SetBorderPadding

			self:SetBorderSize(size or 11)
			self:SetBorderPadding(padding or 3)
		end
	end