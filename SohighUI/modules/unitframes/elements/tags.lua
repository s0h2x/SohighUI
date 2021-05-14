	
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	oUF.Tags.Events['druidmana'] = 'UNIT_POWER', 'UNIT_DISPLAYPOWER', 'UNIT_MAXPOWER'
	oUF.Tags.Methods['druidmana'] = function(unit)
		local min, max = UnitPower(unit, SPELL_POWER_MANA), UnitPowerMax(unit, SPELL_POWER_MANA)
		if (min == max) then
			return ns.FormatValue(min)
		else
			return ns.FormatValue(min)..'/'..ns.FormatValue(max)
		end
	end

	--[[oUF.Tags.Methods['pvptimer'] = function(unit)
		if (not IsPVPTimerRunning() and GetPVPTimer() >= 0) then
			return ''
		end

		return FormatTime(math.floor(GetPVPTimer()/1000))
	end-]]

	oUF.Tags.Methods['level'] = function(unit)
		local level = UnitLevel(unit)
		if (level <= 0 or UnitIsCorpse(unit)) and (unit == 'player' or unit == 'target' or unit == 'focus') then
			return '|TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:12:12:0:0|t' -- boss skull icon
		end

		local colorL = GetDifficultyColor(level)
		return format('|cff%02x%02x%02x%s|r', colorL.r*255, colorL.g*255, colorL.b*255, level)
	end

	oUF.Tags.Methods['name'] = function(unit)
		local color
		local unitName, unitRealm = UnitName(unit)
		local _, class = UnitClass(unit)

		if (unitRealm) and (unitRealm ~= '') then
			unitName = unitName..' (*)'
		end

		if (ns.config.TextNameColorMode == 'CLASS') then
			if UnitIsPlayer(unit) then
				color = E.oUF_colors.class[class]
			elseif UnitIsEnemy(unit, 'player') then
				color = E.oUF_colors.reaction[1]
			else 
				color = E.oUF_colors.reaction[UnitReaction(unit, 'player') or 5]
			end
		end
		if not color then
			color = ns.config.TextNameColor
		end

		return format('|cff%02x%02x%02x%s|r', color[1]*255, color[2]*255, color[3]*255, unitName)
	end
		
	oUF.Tags.Events['threat'] = 'UNIT_THREAT_LIST_UPDATE'
	oUF.Tags.Methods['threat'] = function(unit)
		local tanking, status, percent = UnitDetailedThreatSituation('player', 'target')
		if(percent and percent > 0) then
			return ('%s%d%%|r'):format(Hex(GetThreatStatusColor(status)), percent)
		end
	end

	oUF.Tags.Methods['health'] = function(unit)
		local min, max = UnitHealth(unit), UnitHealthMax(unit)
		local status = not UnitIsConnected(unit) and 'Offline' or UnitIsGhost(unit) and 'Ghost' or UnitIsDead(unit) and 'Dead'

		if(status) then
			return status
		elseif(unit == 'target' and UnitCanAttack('player', unit)) then
			return ('%s (%d|cff0090ff%%|r)'):format(E.ShortValue(min), min / max * 100)
		elseif(unit == 'player' and min ~= max) then
			return ('|cffff8080%d|r %d|cff0090ff%%|r'):format(min - max, min / max * 100)
		elseif(min ~= max) then
			return ('%s |cff0090ff/|r %s'):format(E.ShortValue(min), E.ShortValue(max))
		else
			return max
		end
	end

	oUF.Tags.Methods['power'] = function(unit)
		local power = UnitPower(unit)
		if(power > 0 and not UnitIsDeadOrGhost(unit)) then
			local _, type = UnitPowerType(unit)
			local colors = _COLORS.power
			return ('%s%d|r'):format(Hex(colors[type] or colors['RUNES']), power)
		end
	end

	oUF.Tags.Events['diffcolor'] = 'UNIT_LEVEL'
	oUF.Tags.Methods['diffcolor'] = function(unit)
		local r, g, b
		local level = UnitLevel(unit)
		if (level < 1) then
			r, g, b = 0.69, 0.31, 0.31
		else
			local DiffColor = UnitLevel('target') - E.Level
			if (DiffColor >= 5) then
				r, g, b = 0.69, 0.31, 0.31
			elseif (DiffColor >= 3) then
				r, g, b = 0.71, 0.43, 0.27
			elseif (DiffColor >= -2) then
				r, g, b = 0.84, 0.75, 0.65
			elseif (-DiffColor <= GetQuestGreenRange()) then
				r, g, b = 0.33, 0.59, 0.33
			else
				r, g, b = 0.55, 0.57, 0.61
			end
		end
		return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
	end

	local utf8sub = function(string, i, dots)
		if not string then return end
		local bytes = string:len()
		if (bytes <= i) then
			return string
		else
			local len, pos = 0, 1
			while(pos <= bytes) do
				len = len + 1
				local c = string:byte(pos)
				if (c > 0 and c <= 127) then
					pos = pos + 1
				elseif (c >= 192 and c <= 223) then
					pos = pos + 2
				elseif (c >= 224 and c <= 239) then
					pos = pos + 3
				elseif (c >= 240 and c <= 247) then
					pos = pos + 4
				end
				if (len == i) then break end
			end

			if (len == i and pos <= bytes) then
				return string:sub(1, pos - 1)..(dots and '...' or '')
			else
				return string
			end
		end
	end

	oUF.Tags.Events['getnamecolor'] = 'UNIT_HAPPINESS'
	oUF.Tags.Methods['getnamecolor'] = function(unit)
		local reaction = UnitReaction(unit, 'player')
		if (unit == 'pet' and GetPetHappiness()) then
			local c = E.oUF_colors.happiness[GetPetHappiness()]
			return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
		elseif (UnitIsPlayer(unit)) then
			return _TAGS['raidcolor'](unit)
		elseif (reaction) then
			local c = E.oUF_colors.reaction[reaction]
			return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
		else
			r, g, b = .84,.75,.65
			return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
		end
	end

	oUF.Tags.Events['nameshort'] = 'UNIT_NAME_UPDATE'
	oUF.Tags.Methods['nameshort'] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 10, false)
	end

	oUF.Tags.Events['namemedium'] = 'UNIT_NAME_UPDATE'
	oUF.Tags.Methods['namemedium'] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 15, true)
	end

	oUF.Tags.Events['namelong'] = 'UNIT_NAME_UPDATE'
	oUF.Tags.Methods['namelong'] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 20, true)
	end

	oUF.Tags.Events['nameverylong'] = 'UNIT_NAME_UPDATE'
	oUF.Tags.Methods['nameverylong'] = function(unit)
		local name = UnitName(unit)
		return utf8sub(name, 36, true)
	end

	oUF.Tags.Events['dead'] = 'UNIT_HEALTH'
	oUF.Tags.Methods['dead'] = function(unit)
		if UnitIsDeadOrGhost(unit) then
			return tukuilocal.unitframes_ouf_deaddps
		end
	end

	oUF.Tags.Events['afk'] = 'PLAYER_FLAGS_CHANGED'
	oUF.Tags.Methods['afk'] = function(unit)
		if UnitIsAFK(unit) then
			return CHAT_FLAG_AFK
		end
	end