
	local E, C, _ = select(2, shCore()):unpack()
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	local unpack = unpack
	local floor, format = floor, string.format
	local ceil = math.ceil
	
	--[[*______________Auras______________*]]--
	local FormatTime = function(s)
		local day, hour, minute = 86400, 3600, 60
		if s >= day then
			return format('%dd', ceil(s / hour))
		elseif s >= hour then
			return format('%dh', ceil(s / hour))
		elseif s >= minute then
			return format('%dm', ceil(s / minute))
		elseif s >= minute / 12 then
			return floor(s)
		end
		return format('%.1f', s)
	end
	
	local CreateAuraTimer = function(self, elapsed)		
		if(not self.elapsed) then
			self.elapsed = 0
		end
		if self.timeLeft then
			self.elapsed = self.elapsed + elapsed		
			if self.elapsed >= 0.1 then
				self.timeLeft = self.timeLeft - self.elapsed
				if self.timeLeft > 0 then
					local time = FormatTime(self.timeLeft)			
					self.remaining:SetText(time)
					if self.timeLeft <= 5 then
						self.remaining:SetTextColor(0.99, 0.31, 0.31)
					else
						self.remaining:SetTextColor(.9, .8, .2)
					end				
				else
					self.remaining:Hide()
					self:SetScript('OnUpdate', nil)
				end
				self.elapsed = 0
			end
		end
	end
	
	local getPlayerAuraDuration = function(isBuff, key, providedRank)
		local duration
		for i = 1, 40 do
			local name, rank, time
			name, rank = GetPlayerBuffName(i)		
			if not name then
				break
			end
			if (name == key and providedRank == rank) then
				buffKeyIndex = GetPlayerBuff(i)
				duration = GetPlayerBuffTimeLeft(buffKeyIndex)
				break
			end
		end	
		return duration
	end
	
	local UnitAura = function(unit, index, filter)
		if(filter == 'HELPFUL') then
			local name, rank, texture, count, duration,timeleft = UnitBuff(unit, index)
			if(unit == 'player') then
				if(timeleft == nil) then
					timeleft = getPlayerAuraDuration(true, name, rank)
				end		
			end		
			return name, rank, texture, count, nil, duration, timeleft, nil, nil, nil, nil
		elseif (filter == 'HARMFUL') then
			local name, rank, texture, count, dtype, duration, timeleft = UnitDebuff(unit, index)
			if(unit == 'player') then
				if(timeleft == nil) then
					timeleft = getPlayerAuraDuration(true, name, rank)
				end		
			end	
			return name, rank, texture, count, dtype, duration, timeleft, nil, nil, nil, nil
		end
		return false
	end

	ns.PostCreateAuraIcon = function(element, button)
		button:SetFrameLevel(1)
		button.overlay:SetTexture(A.auraBorder, 'BORDER')
		button.overlay:SetTexCoord(0, 1, 0, 1)
		button.overlay:ClearAllPoints()
		button.overlay:SetAnchor('TOPRIGHT', button.icon, 1.35, 1.35)
		button.overlay:SetAnchor('BOTTOMLEFT', button.icon, -1.35, -1.35)
		button.overlay:SetVertexColor(.24, .24, .24, 1)

		button.Shadow = button:CreateTexture(nil, 'BACKGROUND')
		button.Shadow:SetAnchor('TOPLEFT', button.icon, 'TOPLEFT', -4, 4)
		button.Shadow:SetAnchor('BOTTOMRIGHT', button.icon, 'BOTTOMRIGHT', 4, -4)
		button.Shadow:SetTexture(A.auraShadow)
		button.Shadow:SetVertexColor(0, 0, 0, 1)

		button.count:SetFont(A.font, 12, A.fontStyle)
		button.count:SetShadowOffset(0, 0)
		button.count:SetAnchor('BOTTOMRIGHT', 2, 0)

		button.cd.noOCC = false				-- hide OmniCC CDs
		button.cd.noCooldownCount = false	-- hide CDC CDs
		
		if element.gap and not element.PostUpdateGapIcon then
			element.PostUpdateGapIcon = function(element, unit, icon, visibleBuffs)
				icon.Shadow:Hide()
			end
		end

		--button.cd:SetReverse()
		button.cd:ClearAllPoints()
		button.cd:SetAnchor('TOPRIGHT', button.icon, 'TOPRIGHT', -1, -1)
		button.cd:SetAnchor('BOTTOMLEFT', button.icon, 'BOTTOMLEFT', 1, 1)
		button.cd:SetFrameLevel(button:GetFrameLevel() +1)

		button.remaining = ns.CreateFontString(button, 12, 'CENTER', 'THINOUTLINE')
		button.remaining:SetAnchor('CENTER', button, 'TOP', 0, 0)

		button.icon:SetTexCoord(unpack(E.TexCoords))
	end
	
	ns.PostUpdateEnchantIcons = function(icons)
		local icon1 = icons[1]
		if icon1 then
			if icon1.expTime then
				if (icon1.expTime - GetTime() > 0) then
					if C.units.auraTimer ~= false then
						icon1.remaining:Show()
					else
						icon1.remaining:Hide()
					end
				else
					icon1.remaining:Hide()
				end
				icon1.timeLeft = icon1.expTime - GetTime()
			else
				icon1.timeLeft = nil
			end
			icon1:SetScript('OnUpdate', CreateAuraTimer)
		end
		local icon2 = icons[2]
		if icon2 then
			if icon2.expTime then
				if (icon2.expTime - GetTime() > 0) then
					if C.units.auraTimer ~= false then
						icon2.remaining:Show()
					else
						icon2.remaining:Hide()
					end
				else
					icon2.remaining:Hide()
				end
				icon2.timeLeft = (icon2.expTime - GetTime()) or nil
			else
				icon2.timeLeft = nil
			end
			icon2:SetScript('OnUpdate', CreateAuraTimer)
		end
	end

	ns.PostUpdateAuraIcon = function(icons, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)	
		local _, _, _, _, dtype, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, icon.filter)		
		
		icon.overlay:Show()
		icon.Shadow:Show()
		
		if(icon.debuff) then
			--if(not UnitIsFriend('player', unit) and icon.owner ~= 'player') then
				--icon.overlay:SetVertexColor(0, 0, 0, 1)
				--icon.icon:SetDesaturated(false)
			--else
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				icon.overlay:SetVertexColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
				icon.icon:SetDesaturated(false)
			--end
		end
		
		if (timeleft and timeleft > 0) then			
			if C.units.auraTimer ~= false then
				icon.cd:Show()
			else
				icon.cd:Hide()
			end
		else
			icon.cd:Hide()
		end

		icon.duration = duration
		icon.timeLeft = expirationTime
		icon.first = true
		icon:SetScript('OnUpdate', CreateAuraTimer)
	end