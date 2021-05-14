	
	--* suiUF functions
	
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF
	
	local _G = _G
	local tonumber = tonumber
	local select, unpack = select, unpack
	local min, max = math.min, math.max
	local format, match, gsub = string.format, string.match, string.gsub
	
	local colors = E.oUF_colors
	
	local UnitIsDead, UnitIsGhost, UnitIsDeadOrGhost = UnitIsDead, UnitIsGhost, UnitIsDeadOrGhost
	local UnitIsPlayer, UnitIsEnemy, UnitReaction = UnitIsPlayer, UnitIsEnemy, UnitReaction
	local UnitIsConnected, UnitSelectionColor = UnitIsConnected, UnitSelectionColor
	local GetSpellInfo = GetSpellInfo
	
	local UnitPowerType, UnitPower, UnitPowerMax = UnitPowerType, UnitPower, UnitPowerMax
	local UnitIsTapped, UnitIsTappedByPlayer = UnitIsTapped, UnitIsTappedByPlayer
	local UnitClass = UnitClass

	-------------------------------------------------------------------------------
	local function FormatValue(value)
		local absvalue = abs(value)

		if absvalue >= 1e9 then
			return tonumber(format('%.2f', value/1e9))..'b'
		elseif absvalue >= 1e7 then
			return tonumber(format('%.1f', value/1e6))..'m'
		elseif absvalue >= 1e6 then
			return tonumber(format('%.2f', value/1e6))..'m'
		elseif absvalue >= 1e5 then
			return tonumber(format('%.0f', value/1e3))..'k'
		elseif absvalue >= 1e3 then
			return tonumber(format('%.1f', value/1e3))..'k'
		else
			return value
		end
	end
	ns.FormatValue = FormatValue
	
	function ns.cUnit(unit)
		if (unit:match('party%d')) then
			return 'party'
		elseif (unit:match('arena%d')) then
			return 'arena'
		elseif (unit:match('raid%d')) then
			return 'raid'
		elseif (unit:match('partypet%d')) then
			return 'pet'
		else
			return unit
		end
	end

	function ns.MultiCheck(what, ...)
		for i = 1, select('#', ...) do
			if (what == select(i, ...)) then 
				return true 
			end
		end

		return false
	end

	----------------------------------------------------------
	--					Class Colors						--
	----------------------------------------------------------
	local function getClassColor(unit)
		if UnitIsPlayer(unit) then
			local _, class = UnitClass(unit)
			return colors.class[class]
		elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
			return colors.tapped
		elseif UnitIsEnemy(unit, 'player') then
			return colors.reaction[1]
		else
			return colors.reaction[UnitReaction(unit, 'player') or 5]
		end
		return colors.fallback
	end

	local function SetValueText(element, tag, cur, max, color, notMana)
		if (not max or max == 0) then max = 100; end --* not sure why this happens

		if notMana and tag == '$perc' then
			tag = '$cur'
		end

		tag = tag
			:gsub('$cur', format('%s', (cur > 0 and FormatValue(cur)) or ''))
			:gsub('$0cur', format('%s', FormatValue(cur)))
			:gsub('$max', format('%s', FormatValue(max)))
			:gsub('$def', format('-%s', (cur ~= max and FormatValue(max-cur) or '')))
			:gsub('$perc', format('%d%s', cur / max * 100, '%%'))

		element:SetFormattedText('|cff%02x%02x%02x%s|r', color[1]*255, color[2]*255, color[3]*255, tag)
	end

	local function UpdatePortraitColor(self, unit, cur, max)
		if (not UnitIsConnected(unit)) then
			self.Portrait:SetVertexColor(0.5, 0.5, 0.5, 0.7)
		elseif (UnitIsDead(unit)) then
			self.Portrait:SetVertexColor(0.35, 0.35, 0.35, 0.7)
		elseif (UnitIsGhost(unit)) then
			self.Portrait:SetVertexColor(0.3, 0.3, 0.9, 0.7)
		elseif (cur/max * 100 < 25) then
			if (UnitIsPlayer(unit)) then
				if (unit ~= 'player') then
					self.Portrait:SetVertexColor(1, 0, 0, 0.7)
				end
			end
		else
			self.Portrait:SetVertexColor(1, 1, 1, 1)
		end
	end

	----------------------------------------------------------
	--					Health Update						--
	----------------------------------------------------------
	do
		local tagtable = {
			NUMERIC = {cur = '$cur',  			max = '$max',  		mouse = '$0cur/$max'},
			BOTH	= {cur = '$cur - $perc',  	max = '$max',  		mouse = '$0cur/$max'},
			PERCENT = {cur = '$perc',  			max = '$perc', 		mouse = '$cur'},
			MINIMAL = {cur = '$perc', 			max = '', 			mouse = '$cur'},
			DEFICIT = {cur = '$def', 			max = '', 			mouse = '$def'},
		}

		function ns.PostUpdateHealth(Health, unit, cur, max)
			local absent = not UnitIsConnected(unit) and PLAYER_OFFLINE or UnitIsGhost(unit) and GetSpellInfo(8326) or UnitIsDead(unit) and DEAD
			local self = Health:GetParent()
			local uconfig = ns.config[self.cUnit] or ns.config.raid

			if (self.Portrait) then
				UpdatePortraitColor(self, unit, cur, max)
			end

			if absent then
				Health:SetStatusBarColor(0.5, 0.5, 0.5)
				if Health.Value then
					Health.Value:SetText(absent)
				end
				return
			end

			if not cur then
				cur = UnitHealth(unit)
				max = UnitHealthMax(unit) or 1
			end

			local color, _
			if ns.config.TextHealthColorMode == 'CLASS' then
				color = getClassColor(unit)
			elseif ns.config.TextHealthColorMode == 'GRADIENT' then
				color = {oUF.ColorGradient(cur, max, unpack(oUF.smoothGradient or colors.smooth))}
			else
				color = ns.config.TextHealthColor
			end
			
			if uconfig.HealthTag == 'DISABLE' then
				Health.Value:SetText(nil)
			elseif self.isMouseOver then
				SetValueText(Health.Value, tagtable[uconfig.HealthTag].mouse, cur, max, color)
			elseif cur < max then
				SetValueText(Health.Value, tagtable[uconfig.HealthTag].cur, cur, max, color)
			else
				SetValueText(Health.Value, tagtable[uconfig.HealthTag].max, cur, max, color)
			end
		end
	end
	
	----------------------------------------------------------
	--					Power Update						--
	----------------------------------------------------------
	do
		local tagtable = {
			NUMERIC	=	{cur = '$cur',  max = 	'$max',  	mouse = '$0cur/$max'},
			PERCENT	=	{cur = '$perc', max = 	'$perc',  	mouse = '$cur'},
			MINIMAL	=	{cur = '$perc', max = 	'', 		mouse = '$cur'},
		}
		
		ns.PreUpdatePower = function(power, unit)
			local pType = UnitPowerType(unit)
			
			local color = E.oUF_colors.power[pType]	
			if color then		
				power:SetStatusBarColor(color[1], color[2], color[3])
			end
		end

		function ns.PostUpdatePower(Power, unit, cur, max)
			local self = Power:GetParent()
			local uconfig = ns.config[self.cUnit]

			if (UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit)) or (max == 0) then
				Power:SetValue(0)
				if Power.Value then
					Power.Value:SetText('')
				end
				return
			end

			if not Power.Value then return end

			if (not cur) then
				max = UnitPower(unit) or 1
				cur = UnitPowerMax(unit)
			end

			local _, pType = UnitPowerType(unit)
			local color
			if ns.config.TextPowerColorMode == 'CLASS' then
				color = getClassColor(unit)
			elseif ns.config.TextPowerColorMode == 'TYPE' then
				color = colors.power[type] or colors.power.FUEL
			else
				color = ns.config.TextPowerColor
			end

			if uconfig.PowerTag == 'DISABLE' then
				Power.Value:SetText(nil)
			elseif self.isMouseOver then
				SetValueText(Power.Value, tagtable[uconfig.PowerTag].mouse, cur, max, color, type ~= 'MANA')
			elseif cur < max then
				SetValueText(Power.Value, tagtable[uconfig.PowerTag].cur, cur, max, color, type ~= 'MANA')
			else
				SetValueText(Power.Value, tagtable[uconfig.PowerTag].max, cur, max, color, type ~= 'MANA')
			end
		end
	end

	------------------------------------------------------
	--					MouseOvering					--
	------------------------------------------------------
	function ns.UnitFrame_OnEnter(self)
		if self.__owner then
			self = self.__owner
		end
		UnitFrame_OnEnter(self)

		self.isMouseOver = true
		if self.mouseovers then
			for _, text in pairs (self.mouseovers) do
				text:ForceUpdate()
			end
		end

		if (self.DruidMana and self.DruidMana.Value) then
			self.DruidMana.Value:Show()
		end
	end

	function ns.UnitFrame_OnLeave(self)
		if self.__owner then
			self = self.__owner
		end
		UnitFrame_OnLeave(self)

		self.isMouseOver = nil
		if self.mouseovers then
			for _, text in pairs (self.mouseovers) do
				text:ForceUpdate()
			end
		end

		if (self.DruidMana and self.DruidMana.Value) then
			self.DruidMana.Value:Hide()
		end
	end

	------------------------------------------------------
	--					Painting frames					--
	------------------------------------------------------
	do
		local function toRgb(h, s, l)
			if (s <= 0) then 
				return l, l, l 
			end
			h, s, l = h * 6, s, l
			local c = (1 - math.abs(2 * l - 1)) * s
			local x = (1 - math.abs(h % 2 - 1 )) * c
			local m, r, g, b = (l - .5 * c), 0,0,0
			if h < 1 then
				r, g, b = c, x, 0
			elseif h < 2 then
				r, g, b = x, c, 0
			elseif h < 3 then
				r, g, b = 0, c, x
			elseif h < 4 then
				r, g, b = 0, x, c
			elseif h < 5 then
				r, g, b = x, 0, c
			else
				r, g, b = c, 0, x
			end return (r+m), (g+m), (b+m)
		end

		local function toHsl(r, g, b)
			local min, max = math.min(r, g, b), math.max(r, g, b)
			local h, s, l = 0, 0, (max + min) / 2
			if max ~= min then
				local d = max - min
				s = l > 0.5 and d / (2 - max - min) or d / (max + min)
				if max == r then
					local mod = 6
					if g > b then mod = 0 end
					h = (g - b) / d + mod
				elseif max == g then
					h = (b - r) / d + 2
				else
					h = (r - g) / d + 4
				end
			end
			h = h / 6
			return h, s, l
		end

		local function LightenItUp(r, g, b, factor)
			local h, s, l = toHsl(r, g, b)
			l = l + (factor or 0.1)
			if l > 1 then
				l = 1
			elseif l < 0 then
				l = 0
			end
			return toRgb(h, s, l)
		end

		function ns.PaintFrames(texture, factor)
			if texture:GetObjectType() == 'Texture' then
				local r, g, b, a = unpack(A.frameColor)
				if factor then
					r, g, b, a = LightenItUp(r, g, b, factor)
					texture.colorfactor = factor
				end
				texture:SetVertexColor(r, g, b, a)
				table.insert(ns.paintframes, texture)
			end
		end

		function ns.GetPaintColor(factor)
			local r, g, b, a = unpack(A.frameColor)
			if factor then
				r, g, b, a = LightenItUp(r, g, b, a, factor)
			end
			return r, g, b, a
		end
	end

	----------------------------------------------------------
	--					Statusbar Functions					--
	----------------------------------------------------------
	function ns.CreateStatusBar(parent, layer, name, AddBackdrop)
		if type(layer) ~= 'string' then layer = 'BORDER' end
		local bar = CreateFrame('StatusBar', name, parent)
		bar:SetStatusBarTexture(ns.config.statusbar, layer)

		if AddBackdrop then
			bar:SetBackdrop({bgFile = 'Interface\\Buttons\\WHITE8x8'})
			local r,g,b,a = unpack(ns.config.backdropColor)
			bar:SetBackdropColor(r,g,b,a)
		end

		table.insert(ns.statusbars, bar)
		return bar
	end
	
	----------------------------------------------------------
	--					Class Portraits						--
	----------------------------------------------------------
	function ns.UpdateClassPortraits(self, unit)
		local _, unitClass = UnitClass(unit)
		if (unitClass and UnitIsPlayer(unit)) then
			self:SetTexture('Interface\\Addons\\SohighUI\\styles\\units\\UI-CLASSESICON-CIRCLES')
			self:SetTexCoord(unpack(M.index.cit[unitClass]))
		else
			self:SetTexCoord(0, 1, 0, 1)
		end
	end
	
	----------------------------------------------------------
	--						Media							--
	----------------------------------------------------------
	function shUF:SetAllStatusBars()
		local file = A.FetchMedia

		for _, bar in ipairs(ns.statusbars) do
			if bar.SetStatusBarTexture then
				bar:SetStatusBarTexture(file)
			else
				bar:SetTexture(file)
			end
		end
		for i = 1, 3 do
			local bar = _G['MirrorTimer' .. i .. 'StatusBar']
			bar:SetStatusBarTexture(file)
		end
	end
	
	function ns.CreateFontString(parent, size, justify, outline)
		local fs = parent:CreateFontString(nil, 'OVERLAY')
		fs:SetFont(ns.config.fontNormal, (size * ns.config.fontNormalSize), outline or ns.config.fontNormalOutline)
		fs:SetJustifyH(justify or 'CENTER')
		fs:SetShadowOffset(unpack(A.fontShadow))
		fs.basesize = size 
		if outline and type(outline) == 'string' then
			fs.ignoreOutline = true
		end

		tinsert(ns.fontstrings, fs)
		return fs
	end

	function ns.CreateFontStringBig(parent, size, justify, outline)
		local fs = parent:CreateFontString(nil, 'OVERLAY')
		fs:SetFont(ns.config.fontBig, (size * ns.config.fontBigSize), outline or ns.config.fontBigOutline)
		fs:SetJustifyH(justify or 'CENTER')
		fs:SetShadowOffset(unpack(A.fontShadow))
		fs.basesize = size
		if outline and type(outline) == 'string' then
			fs.ignoreOutline = true
		end

		tinsert(ns.fontstringsB, fs)
		return fs
	end
	
	function shUF:SetAllFonts()
		do
			local file = A.Fetch
			local mult = ns.config.fontNormalSize
			for _, fs in ipairs(ns.fontstrings) do
				local flag
				local _, size, oflag = fs:GetFont()
				if fs.ignoreOutline then
					flag = oflag
				else
					flag = A.fontStyle
				end

				if (fs.basesize) then
					if fs.origHeight then -- combatfeedbacktext
						fs.origHeight = fs.basesize * mult
					end
					fs:SetFont(file, fs.basesize * mult, flag)
				else
					fs:SetFont(file, size or 13, flag)
				end
			end
			for i = 1, 3 do
				local text = _G['MirrorTimer'..i..'Text']
				local _, size = text:GetFont()
				text:SetFont(file, size, A.fontStyle)
			end
		end

		do
			local file = A.Fetch
			local mult = ns.config.fontBigSize
			for _, fs in ipairs(ns.fontstringsB) do
				local flag = A.fontStyle
				local _, size, oflag = fs:GetFont()
				if fs.ignoreOutline then
					flag = oflag
				end
				if (fs.basesize) then
					fs:SetFont(file, fs.basesize * mult, flag)
				else
					fs:SetFont(file, size or 14, flag)
				end
			end
		end
	end
	----------------------------------------------------------
