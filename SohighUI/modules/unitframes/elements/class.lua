	
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF
	
	local CreateFrame = CreateFrame
	local hooksecurefunc = hooksecurefunc
	
	ns.classModule = {}

--[[	function ns.classModule.PRIEST(self, config, uconfig)
		if (self.IsMainFrame) then
			if self.cUnit == 'player' and config.PRIEST then
				PriestBarFrame:SetParent(self)
				PriestBarFrame_OnLoad(PriestBarFrame)
				PriestBarFrame:ClearAllPoints()
				PriestBarFrame:SetAnchor('TOP', self, 'BOTTOM', 33, 1)
				ns.PaintFrames(PriestBarFrame:GetRegions())
			end
			-- Weakened Soul Bar
			if (config.showWeakenedSoul) then
				local Aurabar = ns.CreateOutsideBar(self, true, 1, 0, 0)
				Aurabar.spellID = 6788
				Aurabar.filter = 'HARMFUL'
				self.Aurabar = Aurabar
			end
		end
	end

	function ns.classModule.ROGUE(self, config, uconfig)
		if self.cUnit == 'player' and config.showSlicenDice then
			local Aurabar = ns.CreateOutsideBar(self, true, 1, .6, 0)
			Aurabar.spellID = 5171
			self.Aurabar = Aurabar
		end
	end
--]]
	function ns.classModule.SHAMAN(self, config, uconfig)
		if (self.cUnit ~= 'player') or not config.SHAMAN then return; end
		TotemFrame:ClearAllPoints()
		TotemFrame:SetAnchor('TOP', self.Power, 'BOTTOM', -6, -0)
		TotemFrame:SetParent(self)
		TotemFrame:SetScale(uconfig.scale * 0.95)
		TotemFrame:Show()

		for i = 1, MAX_TOTEMS do
			local _, totemBorder = _G['TotemFrameTotem'..i]:GetChildren()
			ns.PaintFrames(totemBorder:GetRegions())

			_G['TotemFrameTotem'..i]:SetFrameStrata'LOW'
			_G['TotemFrameTotem'..i.. 'IconCooldown']:SetAlpha(0)
			_G['TotemFrameTotem'..i.. 'IconCooldown'].noCooldownCount = true -- No OmniCC

			_G['TotemFrameTotem'..i.. 'Duration']:SetParent(self)
			_G['TotemFrameTotem'..i.. 'Duration']:SetDrawLayer('OVERLAY')
			_G['TotemFrameTotem'..i.. 'Duration']:ClearAllPoints()
			_G['TotemFrameTotem'..i.. 'Duration']:SetAnchor('BOTTOM', _G['TotemFrameTotem'..i], 0, 3)
			_G['TotemFrameTotem'..i.. 'Duration']:SetFont(config.fontNormal, 11, A.fontStyle)
			_G['TotemFrameTotem'..i.. 'Duration']:SetShadowOffset(0, 0)
		end
	end
		
	function ns.CreateComboPoints(self)
		if (self.cUnit == 'target' or self.cUnit == 'focus') then
		
			--* owl rotater
			local owl = CreateFrame('frame', nil, self.Health)
			owl:SetSize(55)
			owl:SetAnchor('CENTER', self.Portrait.Bg or self.Portrait, 0, -0.5)
			owl:SetAlpha(0.8)

			owl.Texture = owl:CreateTexture(nil, 'BACKGROUND')
			owl.Texture:SetAllPoints(owl)
			owl.Texture:SetTexture(A.owlRotater)
			owl.Texture:SetBlendMode('BLEND')
			owl.Texture.minAlpha = 0.25
			owl.Texture:SetAlpha(0)

			if C['units'].cpAsNumber ~= false then
				self.ComboPoints = self:CreateFontString(nil, 'OVERLAY')
				self.ComboPoints:SetFont(DAMAGE_TEXT_FONT, 26, A.fontStyle)
				self.ComboPoints:SetShadowOffset(0, 0)
				self.ComboPoints:SetAnchor('LEFT', self.Portrait, 'RIGHT', 8, 4)
				self.ComboPoints:SetTextColor(unpack(ns.config.numComboPointsColor))
				self:Tag(self.ComboPoints, '[cpoints]')
			else
				
				self.CPoints = {}
				
				for i = 1, MAX_COMBO_POINTS do
					self.CPoints[i] = self:CreateTexture(nil, 'OVERLAY')
					self.CPoints[i]:SetTexture(A.comboPoint)
					--self.CPoints[i]:SetVertexColor(.73, .33, .83, 1)
					self.CPoints[i]:SetSize(15)
				end

				self.CPoints[1]:SetAnchor('TOPRIGHT', self.Texture, -42, -8)
				self.CPoints[2]:SetAnchor('TOP', self.CPoints[1], 'BOTTOM', 7.33, 6.66)
				self.CPoints[3]:SetAnchor('TOP', self.CPoints[2], 'BOTTOM', 4.66, 4.33)
				self.CPoints[4]:SetAnchor('TOP', self.CPoints[3], 'BOTTOM', 1.33 , 3.66)
				self.CPoints[5]:SetAnchor('TOP', self.CPoints[4], 'BOTTOM', -1.66, 3.66)

				self.CPointsBG = {}
				
					for i = 1, MAX_COMBO_POINTS do
						self.CPointsBG[i] = self:CreateTexture(nil, 'ARTWORK')
						self.CPointsBG[i]:SetTexture(A.comboPointBg)
						self.CPointsBG[i]:SetSize(15)
						self.CPointsBG[i]:SetAllPoints(self.CPoints[i])
						self.CPointsBG[i]:SetAlpha(0)
					end

				hooksecurefunc(self.CPoints[1], 'Show', function()
					for i = 1, MAX_COMBO_POINTS do
						securecall('UIFrameFadeIn', self.CPointsBG[i], 0.25, self.CPointsBG[i]:GetAlpha(), 0.9)
						end
					end);

				hooksecurefunc(self.CPoints[1], 'Hide', function()
					for i = 1, MAX_COMBO_POINTS do
						self.CPointsBG[i]:SetAlpha(0)
						end
					end);

				hooksecurefunc(self.CPoints[5], 'Show', function()
						ns.StartFlash(owl.Texture, 0.4, 0.4, 0, 0)
					end);

				hooksecurefunc(self.CPoints[5], 'Hide', function()
						ns.StopFlash(owl.Texture)
					end);
				end
			end
		end