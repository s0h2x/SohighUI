	
	--* castbar element
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF
	local colors = E.oUF_colors

	local ignorePetSpells = {
		3110,	--*	firebolt (imp)
		31707,	--*	waterbolt (water elemental)
	}

	-----------------------------------------------------------------------
	--* 	Channeling ticks, based on Castbars by Xbeeps				--*
	-----------------------------------------------------------------------
	
	local CastingBarFrameTicksSet
	do
		local GetSpellInfo, GetCombatRatingBonus = GetSpellInfo, GetCombatRatingBonus
		local BaseTickDuration = {
		-- Negative means not modified by haste
			
			--* Warlock
			[GetSpellInfo(689) or '']		= 1, --  Drain Life
			[GetSpellInfo(1120) or '']		= 2, --  Drain Soul
			[GetSpellInfo(755) or '']		= 1, --  Health Funnel
			[GetSpellInfo(5740) or '']		= 2, --  Rain of Fire
			[GetSpellInfo(1949) or '']		= 1, --  Hellfire
			
			--* Druid
			[GetSpellInfo(740) or '']		= 2, --  Tranquility
			[GetSpellInfo(16914) or ''] 	= 1, --  Hurricane
			
			--* Priest
			[GetSpellInfo(25387) or ''] 	= 1, --  Mind Flay
			[GetSpellInfo(17313) or ''] 	= 1, --  Mind Flay (Insanity)
			[GetSpellInfo(32000) or ''] 	= 1, --  Mind Sear
			[GetSpellInfo(34917) or ''] 	= 1, --  Vampiric Touch
			[GetSpellInfo(25375) or ''] 	= 1, --  Mind Blast
			
			--* Mage
			[GetSpellInfo(10) or ''] 		= 1, --  Blizzard
			[GetSpellInfo(5143) or ''] 		= 0.4, --  Arcane Missiles
			[GetSpellInfo(12051) or ''] 	= 2, --  Evocation
		}

		function CastingBarFrameTicksSet(Castbar, unit, name, stop)
			Castbar.ticks = Castbar.ticks or {}
			local function CreateATick()
				local spark = Castbar:CreateTexture(nil, 'OVERLAY')
				spark:SetTexture('Interface\\CastingBar\\UI-CastingBar-Spark')
				spark:SetVertexColor(1, 1, 1, 1)
				spark:SetBlendMode'ADD'
				spark:Width(10)
				table.insert(Castbar.ticks, spark)
				return spark
			end
			for _,tick in ipairs(Castbar.ticks) do
				tick:Hide()
			end
			if (stop) then return end
			if (Castbar) then
				local baseTickDuration = BaseTickDuration[name]
				local tickDuration
				if (baseTickDuration) then
					if (baseTickDuration > 0) then
						local castTime = select(7, GetSpellInfo(2060))
						if (not castTime or (castTime == 0)) then
							castTime = 2500 / (1 + (GetCombatRatingBonus(CR_HASTE_SPELL) or 0) / 100)
						end
						tickDuration = (castTime / 2500) * baseTickDuration
					else
						tickDuration = -baseTickDuration
					end                
				end
				if (tickDuration) then
					local width = Castbar:GetWidth()
					local delta = (tickDuration * width / Castbar.max)
					local i = 1
					while (delta * i) < width do
						if i > #Castbar.ticks then CreateATick() end
						local tick = Castbar.ticks[i]
						tick:Height(Castbar:GetHeight() * 1.5)
						tick:SetAnchor('CENTER', Castbar, 'LEFT', delta * i, 0)
						tick:Show()
						i = i + 1
					end
				end
			end
		end
	end

	-----------------------------------------------------------------------
	--* 						Setup Castbars 							--*
	----------------------------------------------------------------------- 
	function ns.CreateCastbars(self)
		local BasePos = {
			focus	= 	{'BOTTOM', 'TOP', 0, 30},
			party	= 	{'TOPLEFT', 'TOPRIGHT', 10, -20},
		}

		local uconfig = ns.config[self.cUnit]
		if not uconfig.cbshow then return end

		local Castbar = ns.CreateStatusBar(self, 'BORDER', self:GetName()..'Castbar')
		Castbar:SetSize(uconfig.cbwidth, uconfig.cbheight)
		
		Castbar:SetLayout()
		Castbar:SetShadow()
		--ns.CreateBorder(Castbar, 11, 3)

		if (self.cUnit == 'player' or self.cUnit == 'target' or self.cUnit == 'pet') then
			ns.CreateCastbarAnchor(Castbar)
		else
			local point, rpoint, x, y = unpack(BasePos[self.cUnit])
			Castbar:SetAnchor(point, self, rpoint, x + uconfig.cboffset[1], y + uconfig.cboffset[2])
		end

		Castbar.Background = Castbar:CreateTexture(nil, 'BACKGROUND')
		Castbar.Background:SetTexture('Interface\\Buttons\\WHITE8x8')
		Castbar.Background:SetAllPoints(Castbar)
		
		local CastbarIconBg = CreateFrame('frame', nil, Castbar)
		CastbarIconBg:SetLayout()
		CastbarIconBg:SetShadow()

		if (self.cUnit == 'player') then
			local SafeZone = Castbar:CreateTexture(nil, 'BORDER') 
			SafeZone:SetTexture(ns.config.statusbar)
			SafeZone:SetVertexColor(unpack(ns.config.castbarSafezoneColor))
			table.insert(ns.statusbars, SafeZone)
			Castbar.SafeZone = SafeZone

			local Flash = CreateFrame('frame', nil, Castbar)
			Flash:SetAllPoints(Castbar)
			Flash:SetLayout()
			Flash:SetShadow()
			
			Flash.bg:SetBackdropBorderColor(.7, 1, 0.6)
			Flash.bg:SetBackdropColor(.7, 1, 0.6)
			
			Flash.shadow:SetBackdropBorderColor(.7, 1, 0.6)

			--ns.CreateBorder(Flash, 11, 3)
			--Flash:SetBorderTexture('white')
			--Flash:SetBorderColor(1, 1, 0.6)
			--[[if (uconfig.cbicon == 'RIGHT') then
				Flash:SetBorderPadding(3, 3, 3, 4 + uconfig.cbheight)
			elseif (uconfig.cbicon == 'LEFT') then
				Flash:SetBorderPadding(3, 3, 4 + uconfig.cbheight, 3)
			end--]]
			Castbar.Flash = Flash
			Castbar.Ticks = C['units'].castbarTicks
		end
		
		local Spark = Castbar:CreateTexture(nil, 'ARTWORK')
		Spark:SetSize(15, uconfig.cbheight * 2)
		Spark:SetBlendMode'ADD'
		Castbar.Spark = Spark

		if (uconfig.cbicon ~= 'NONE') then
			local Icon = Castbar:CreateTexture(nil, 'ARTWORK')
			Icon:SetSize(uconfig.cbheight + 9)
			Icon:SetTexCoord(unpack(E.TexCoords))
			Icon:SetParent(CastbarIconBg.bg)
			Icon:StyleButton(nil, true)
			
			CastbarIconBg:SetAllPoints(Icon)
			CastbarIconBg:SetFrameLevel(Castbar:GetFrameLevel() +2)
			if (uconfig.cbicon == 'RIGHT') then
				Icon:SetAnchor('LEFT', Castbar, 'RIGHT', 0, 0)
				--Castbar:SetBorderPadding(3, 3, 3, 4 + uconfig.cbheight)
			elseif (uconfig.cbicon == 'LEFT') then
				Icon:SetAnchor('RIGHT', Castbar, 'LEFT', 0, 0)
				--Castbar:SetBorderPadding(3, 3, 4 + uconfig.cbheight, 3)
			end
			Castbar.Icon = Icon
		end

		Castbar.Time = ns.CreateFontString(Castbar, 13, 'RIGHT')
		Castbar.Time:SetAnchor('RIGHT', Castbar, -5, 0)

		Castbar.Text = ns.CreateFontString(Castbar, 13, 'LEFT')
		Castbar.Text:SetAnchor('LEFT', Castbar, 4, 0)

		Castbar.PostCastStart = ns.PostCastStart
		Castbar.PostCastFailed = ns.PostCastFailed
		Castbar.PostCastInterrupted = ns.PostCastInterrupted
		Castbar.PostCastInterruptible = ns.UpdateCastbarColor
		Castbar.PostCastNotInterruptible = ns.UpdateCastbarColor
		Castbar.PostCastStop = ns.PostStop
		Castbar.PostChannelStop = ns.PostStop
		Castbar.PostChannelStart = ns.PostChannelStart

		self.CCastbar = Castbar
	end

	function ns.PostCastStart(Castbar, unit, name, castid)
		if (unit == 'pet') then
			Castbar:SetAlpha(1)
			for _, spellID in pairs(ignorePetSpells) do
				if (UnitCastingInfo('pet') == GetSpellInfo(spellID)) then
					Castbar:SetAlpha(0)
				end
			end
		end
		ns.UpdateCastbarColor(Castbar, unit)
		if (Castbar.SafeZone) then
			Castbar.SafeZone:SetDrawLayer('BORDER', -1)
		end
	end

	function ns.PostCastFailed(Castbar, unit, spellname, castid)
		if (Castbar.Text) then
			Castbar.Text:SetText(FAILED) 
		end
		Castbar:SetStatusBarColor(1, 0, 0) --* Red
		if (Castbar.max) then 
			Castbar:SetValue(Castbar.max)
		end
	end

	function ns.PostCastInterrupted(Castbar, unit, spellname, castid)
		--Castbar:SetStatusBarColor(.8, .1, .2)	--?
		if (Castbar.max) then --* Some spells go through without cast bar
			Castbar:SetValue(Castbar.max)
		end
	end

	function ns.PostStop(Castbar, unit, spellname, castid)
		--* Castbar:SetValue(Castbar.max)
		if (Castbar.Ticks) then
			CastingBarFrameTicksSet(Castbar, unit, name, true)
		end
	end

	function ns.PostChannelStart(Castbar, unit, name)
		if (unit == 'pet' and Castbar:GetAlpha() == 0) then
			Castbar:SetAlpha(1)
		end

		ns.UpdateCastbarColor(Castbar, unit)
		if Castbar.SafeZone then
			Castbar.SafeZone:SetDrawLayer('BORDER', 1)
		end
		if (Castbar.Ticks) then
			CastingBarFrameTicksSet(Castbar, unit, name)
		end
	end

	function ns.UpdateCastbarColor(Castbar, unit)
		local color
		local bR, bG, bB = ns.GetPaintColor(0.2)
		local text = 'default'
		local _, targetClass = UnitClass(unit)

		if C['units'].castbarColor ~= false then
			if (targetClass ~= nil) then
				color = E.oUF_colors.class[targetClass]
			else
				color = colors.reaction[UnitReaction(unit, 'player') or 1]
			end
		elseif Castbar.interrupt then
			color = colors.uninterruptible
			text = 'white'
			bR, bG, bB = 0.8, 0.7, 0.2
		else
			color = colors.reaction[UnitReaction(unit, 'player') or 1]
		end
		
		--Castbar:SetBorderTexture(A.abTexNormal)
		--Castbar:SetBorderColor(bR, bG, bB)

		local r, g, b = color[1], color[2], color[3]
		Castbar:SetStatusBarColor(r * 0.8, g * 0.8, b * 0.8)
		Castbar.Background:SetVertexColor(r * 0.2, g * 0.2, b * 0.2)
	end