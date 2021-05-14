
	--// layout [oUF]
	--// author Abu, optimization/bport for 20400 by sohigh.

	local E, C, L, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF
	local config

	local function GetDBUnit(cUnit)
		if (cUnit == 'focus') then
			return 'target'
		elseif (cUnit == 'focustarget') then
			return 'targettarget'
		elseif (cUnit == 'player') then
			return 'player'
		elseif (cUnit == 'raid') then
			return 'raid'
		end
		return cUnit
	end

	local function GetData(cUnit)
		local dbUnit = GetDBUnit(cUnit)
		if C['units'].unitStyleFat ~= false then
			return ns.__db[dbUnit]
		end
		return ns.__dn[dbUnit]
	end

	local function GetTargetTexture(cUnit, type)
		local dbUnit = GetDBUnit(cUnit)
		if dbUnit == 'player' then
			if (ns.config.playerStyle == 'custom') then
				return ns.config.customPlayerTexture
			end
			type = ns.config.playerStyle
		end

		--// only 'target', 'focus' & 'player' gets this far
		local data = C['units'].unitStyleFat ~= true and ns.__dn.targetTexture or ns.__db.targetTexture
		if data[type] then
			return data[type]
		else
			return data['normal']
		end
	end
	
	local function UpdateFlashStatus(self)
		if (UnitIsDeadOrGhost('player')) then
			ns.StopFlash(self.StatusFlash)
			return
		end

		if (UnitAffectingCombat('player')) then
			self.StatusFlash:SetVertexColor(1, 0.1, 0.1, 1)
			if C['units'].statusCombat ~= false then
				self.Combat:Show()
				self.Level:Hide()
			end
			if (not ns.IsFlashing(self.StatusFlash)) then
				ns.StartFlash(self.StatusFlash, 0.5, 0.5, 0.1, 0.1)
			end
		elseif (IsResting() and not UnitAffectingCombat('player')) then
			self.StatusFlash:SetVertexColor(1, 0.88, 0.25, 1)

			if (not ns.IsFlashing(self.StatusFlash)) then
				ns.StartFlash(self.StatusFlash, 0.5, 0.5, 0.1, 0.1)
			end
		else
			ns.StopFlash(self.StatusFlash)
			if C['units'].statusCombat ~= false then
				self.Combat:Hide()
				self.Level:Show()
			end
		end
	end

	local function UpdatePlayerFrame(self, ...)
		local data = GetData(self.cUnit)
		
		self.Texture:SetSize(data.tex.w, data.tex.h)

		self.Texture:SetAnchor('CENTER', self, data.tex.x, data.tex.y)
		self.Texture:SetTexture(GetTargetTexture('player'))
		self.Texture:SetTexCoord(unpack(data.tex.c))

		self.Health:SetSize(data.hpb.w, data.hpb.h)
		self.Health:SetAnchor('CENTER', self.Texture, data.hpb.x, data.hpb.y)
		
		self.Power:SetSize(data.mpb.w, data.mpb.h)
		self.Power:SetAnchor('TOPLEFT', self.Health, 'BOTTOMLEFT', data.mpb.x, data.mpb.y)

		self.Health.Value:SetAnchor('CENTER', self.Health, data.hpt.x, data.hpt.y)
		self.Power.Value:SetAnchor('CENTER', self.Power, data.mpt.x, data.mpt.y)

		self.Name:Width(data.nam.w)
		self.Name:SetAnchor('TOP', self.Health, data.nam.x, data.nam.y)
		
		self.Portrait:SetAnchor('CENTER', self.Texture, data.por.x, data.por.y)
		self.Portrait:SetSize(data.por.w, data.por.h)

		if self.ThreatGlow then
			self.ThreatGlow:SetSize(data.glo.w, data.glo.h)
			self.ThreatGlow:SetAnchor('TOPLEFT', self.Texture, data.glo.x, data.glo.y)
			self.ThreatGlow:SetTexture(data.glo.t)
			self.ThreatGlow:SetTexCoord(unpack(data.glo.c))
		end
		
		self.PvP:ClearAllPoints()
		
		--ns.Configure_HealComm(self, _, unit)

		--[[*______________Combat Red Glow______________*]]--
		if C['units'].statusFlash ~= false then
			self.StatusFlash = self:CreateTexture(nil, 'ARTWORK')
			self.StatusFlash:SetTexture(data.glo.t)
			self.StatusFlash:SetTexCoord(unpack(data.glo.c))
			self.StatusFlash:SetBlendMode('ADD')
			self.StatusFlash:SetSize(data.glo.w, data.glo.h)
			self.StatusFlash:SetAnchor('TOPLEFT', self.Texture, data.glo.x, data.glo.y)
			self.StatusFlash:SetAlpha(0)

			UpdateFlashStatus(self, _, unit)
			
			self:RegisterEvent('PLAYER_DEAD', UpdateFlashStatus)
			self:RegisterEvent('PLAYER_UNGHOST', UpdateFlashStatus)
			self:RegisterEvent('PLAYER_ALIVE', UpdateFlashStatus)
			self:RegisterEvent('PLAYER_UPDATE_RESTING', UpdateFlashStatus)
			self:RegisterEvent('PLAYER_REGEN_ENABLED', UpdateFlashStatus)
			self:RegisterEvent('PLAYER_REGEN_DISABLED', UpdateFlashStatus)
		end
		
		if (self.StatusFlash) then
			UpdateFlashStatus(self)
		end
	end

	local function UpdateUnitFrameLayout(frame, unit)
		local cUnit = frame.cUnit
		local data = GetData(cUnit)
		local uconfig = ns.config[cUnit]

		--// frame Size
		frame:SetSize(data.siz.w, data.siz.h)
		frame:SetScale(uconfig.scale or 1)
		frame:EnableMouse((not ns.config.clickThrough) or (frame.IsPartyFrame))

		--// player frame, its special
		if (cUnit == 'player') then 
			return UpdatePlayerFrame(frame); 
		elseif (not data) then 
			return; 
		end

		--// Texture
		frame.Texture:SetTexture(data.tex.t)
		frame.Texture:SetSize(data.tex.w, data.tex.h)
		
		frame.Texture:SetAnchor('CENTER', frame, data.tex.x, data.tex.y)
		frame.Texture:SetTexCoord(unpack(data.tex.c))
		
		--// HealthBar
		frame.Health:SetSize(data.hpb.w, data.hpb.h)
		frame.Health:SetAnchor('CENTER', frame.Texture, data.hpb.x, data.hpb.y)
		
		--// ManaBar
		frame.Power:SetSize(data.mpb.w, data.mpb.h)
		frame.Power:SetAnchor('TOPLEFT', frame.Health, 'BOTTOMLEFT', data.mpb.x, data.mpb.y)
		
		--// HealthText
		frame.Health.Value:SetAnchor('CENTER', frame.Health, data.hpt.x, data.hpt.y)
		
		--// ManaText (not for tots)
		if frame.Power.Value then 
			frame.Power.Value:SetAnchor('CENTER', frame.Power, data.mpt.x, data.mpt.y)
		end
		
		--// NameText
		if frame.Name then
			frame.Name:SetSize(data.nam.w, data.nam.h)
			frame.Name:SetAnchor('TOP', frame.Health, data.nam.x, data.nam.y)
		end
		
		--// Portrait
		if frame.Portrait then
			frame.Portrait:SetSize(data.por.w, data.por.h)
			frame.Portrait:SetAnchor('CENTER', frame.Texture, data.por.x, data.por.y)
		end
		
		--// Threat Glow (if enabled)
		if frame.ThreatGlow then
			frame.ThreatGlow:SetSize(data.glo.w, data.glo.h)
			frame.ThreatGlow:SetAnchor('TOPLEFT', frame.Texture, data.glo.x, data.glo.y)
			frame.ThreatGlow:SetTexture(data.glo.t)
			frame.ThreatGlow:SetTexCoord(unpack(data.glo.c))
		end
		
		if C['units'].healComm ~= false then
			frame.HealCommBar = ns.Construct_HealComm(frame)
			ns.Configure_HealComm(frame)
		end
	end

	function shUF:UpdateBaseFrames(optUnit)
		if InCombatLockdown() then return; end
		config = ns.config
		if optUnit and optUnit:find('%d') then
			optUnit = optUnit:match('^.%a+')
		end

		for _, obj in pairs(oUF.objects) do
			local unit = obj.cUnit
			if (obj.style == 'shUF' and unit) and (not optUnit or optUnit == unit:match('^.%a+')) then
				UpdateUnitFrameLayout(obj, unit)
			end
		end
	end

	local function CreateUnitLayout(self, unit)
		local cUnit = ns.cUnit(unit)
		self.cUnit = cUnit
		
		local uconfig = ns.config[cUnit]
		local data = GetData(cUnit)

		self.IsMainFrame = ns.MultiCheck(cUnit, 'player', 'target', 'focus')
		self.IsTargetFrame = ns.MultiCheck(cUnit, 'targettarget', 'focustarget')
		self.IsPartyFrame = cUnit:match('party')
		self.mouseovers = {}
		self:SetAttribute('type2', 'menu')
		self.menu = E.SpawnMenu

		if (self.IsTargetFrame) then
			self:SetFrameLevel(4)
		end

		--[[*______________Mouse Interraction______________*]]--
		self:RegisterForClicks('AnyUp')
		
		self:HookScript('OnEnter', ns.UnitFrame_OnEnter)
		self:HookScript('OnLeave', ns.UnitFrame_OnLeave)

		if (config.focBut ~= 'NONE') then
			if (cUnit == 'focus') then
				self:SetAttribute(config.focMod..'type'..config.focBut, 'macro')
				self:SetAttribute('macrotext', '/clearfocus')
			else
				self:SetAttribute(config.focMod..'type'..config.focBut, 'focus')
			end
		end

		--[[*______________Load Castbar______________*]]--
		if (config.castbars and uconfig and uconfig.cbshow) then
			ns.CreateCastbars(self, cUnit)
		end

		--[[*______________Textures______________*]]--
		self.Texture = self:CreateTexture(nil, 'BORDER')
		ns.PaintFrames(self.Texture)	--//darkness
		self.Texture:SetDrawLayer('BORDER', 3)

		--[[*______________HealthBar______________*]]--
		self.Health = ns.CreateStatusBar(self, nil, nil, true)
		self.Health:SetFrameLevel(self:GetFrameLevel()-1)
		table.insert(self.mouseovers, self.Health)
		self.Health.PostUpdate = ns.PostUpdateHealth
		self.Health.frequentUpdates = cUnit == 'player'
		self.Health.Smooth = true

		if (config.healthcolormode == 'CUSTOM') then 
			self.Health:SetStatusBarColor(unpack(config.healthcolor))
		end
		
		self.Health.colorTapping = (config.healthcolormode ~= 'CUSTOM')
		self.Health.colorClass = (config.healthcolormode == 'CLASS')
		self.Health.colorReaction = (config.healthcolormode == 'CLASS')
		self.Health.colorSmooth = (config.healthcolormode == 'NORMAL')

		--[[*______________HealthText______________*]]--
		self.Health.Value = ns.CreateFontString(self, data.hpt.s, data.hpt.j)

		--[[*______________PowerBar______________*]]--
		self.Power = ns.CreateStatusBar(self, nil, nil, true)
		self.Power:SetFrameLevel(self:GetFrameLevel()-1)
		table.insert(self.mouseovers, self.Power)
		self.Power.PreUpdate = ns.PreUpdatePower
		self.Power.PostUpdate = ns.PostUpdatePower
		self.Power.frequentUpdates = cUnit == 'player'
		self.Power.Smooth = true

		if (config.powercolormode == 'CUSTOM') then
			self.Power:SetStatusBarColor(unpack(config.powercolor))
		end
		
		self.Power.colorClass = (config.powercolormode == 'CLASS')
		self.Power.colorPower = (config.powercolormode == 'TYPE')

		--[[*______________PowerText______________*]]--
		if (data.mpt) then
			self.Power.Value = ns.CreateFontString(self, data.mpt.s, data.mpt.j)
		end

		--[[*______________NameText______________*]]--
		if (data.nam) then
			self.Name = ns.CreateFontStringBig(self, data.nam.s, data.nam.j)
			self:Tag(self.Name, '[name]')
		end

		--[[*______________Portrait______________*]]--
		if (data.por) then
			self.Portrait = self.Health:CreateTexture(nil, 'BACKGROUND')
			self.Portrait.Override = function(self, event, unit)
				if (not unit or not UnitIsUnit(self.unit, unit)) then return; end
				local portrait = self.Portrait
			end
		end
		
		if C['units'].classPortraits ~= false then
			self.Portrait.PostUpdate = ns.UpdateClassPortraits
		else
			self.Portrait:SetTexCoord(0, 1, 0, 1)
			SetPortraitTexture(self.Portrait, unit)
		end

		if (self.IsMainFrame) then
			
			--[[*______________LevelText______________*]]--
			self.Level = self:CreateFontString(nil, 'ARTWORK')
			self.Level:SetFont(A.fontNum, 16, 'THINOUTLINE')
			self.Level:SetShadowOffset(0, 0)
			self.Level:SetAnchor('CENTER', self.Texture, (cUnit == 'player' and -63) or 63, -16)
			self:Tag(self.Level, '[level]')

			--[[*______________PvP Icon______________*]]--
			self.PvP = self:CreateTexture(nil, 'OVERLAY')
			self.PvP:SetAnchor('TOPRIGHT', self.Texture, -7, -20)
			self.PvP:SetSize(54, 54)
			
			--[[*______________Combat Icon______________*]]--
			self.Combat = self:CreateTexture(nil, 'OVERLAY')
			self.Combat:SetAnchor('CENTER', self.Level, 1, 0)
			self.Combat:SetSize(31, 33)

			-- optional flag to show overhealing
			-- self.allowHealCommOverflow = true
			
			--[[*______________Absorb______________*]]--
			if C['units'].absorbBar ~= false then
				local absorb = CreateFrame('StatusBar', nil, self.Health)
				absorb:SetStatusBarTexture(A.abs, 'OVERLAY')
				absorb:SetFrameLevel(self:GetFrameLevel() - 1)
				absorb:SetStatusBarColor(1,1,1,1)
				absorb:GetStatusBarTexture():SetBlendMode('ADD')
				absorb:SetAnchor('BOTTOMLEFT', self.Health, 'BOTTOMLEFT')
				absorb:SetAnchor('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, 5)
			end
			
			--[[*______________CFT______________*]]--
			if C['units'].combatText ~= false then
				self.CombatFeedbackText = ns.CreateFontString(self, 18, 'CENTER', A.fontStyle)
				self.CombatFeedbackText:SetAnchor('CENTER', self.Portrait)
			end
		end
		
		--[[*______________Threat Glow______________*]]--
		if C['units'].threatGlow ~= false and (data.glo) then
			self.ThreatGlow = self:CreateTexture(nil, 'BACKGROUND', -1)
		end

		--*[[ 	Portrait Timer	]]	
		--[[if (config.portraitTimer and self.Portrait) then
			self.PortraitTimer = CreateFrame('Frame', nil, self.Health)
			
			self.PortraitTimer.Icon = self.PortraitTimer:CreateTexture(nil, 'BACKGROUND')
			self.PortraitTimer.Icon:SetAllPoints(self.Portrait)

			self.PortraitTimer.Remaining = ns.CreateFontString(self.PortraitTimer, data.por.w/3.5, 'CENTER', A.fontStyle)
			self.PortraitTimer.Remaining:SetAnchor('CENTER', self.PortraitTimer.Icon)
			self.PortraitTimer.Remaining:SetTextColor(1, 1, 1)
		end]]--

		self.RaidIcon = self:CreateTexture(nil, 'OVERLAY', self)
		self.RaidIcon:SetTexture('Interface\\TargetingFrame\\UI-RaidTargetingIcons')

		if (cUnit == 'boss') then
			self.RaidIcon:SetAnchor('CENTER', self, 'TOPRIGHT', -9, -10)
			self.RaidIcon:SetSize(26)
			
			self.Name.Bg = self.Health:CreateTexture(nil, 'BACKGROUND')
			self.Name.Bg:Height(18)
			self.Name.Bg:SetTexCoord(0.2, 0.8, 0.3, 0.85)
			self.Name.Bg:SetAnchor('BOTTOMRIGHT', self.Health, 'TOPRIGHT')
			self.Name.Bg:SetAnchor('BOTTOMLEFT', self.Health, 'TOPLEFT') 
			self.Name.Bg:SetTexture(A.shUF.. 'nameBackground')
		else
			--[[*______________Icons______________*]]--
			self.RaidIcon:SetAnchor('CENTER', self.Portrait, 'TOP', 0, -1)
			self.RaidIcon:SetSize(data.por.w/2.5, data.por.w/2.5)

			self.MasterLooter = self:CreateTexture(nil, 'OVERLAY', self)
			self.MasterLooter:SetSize(16)
			if (cUnit == 'target' or cUnit == 'focus') then
				self.MasterLooter:SetAnchor('TOPLEFT', self.Portrait, 3, 3)
			elseif (self.IsTargetFrame) then
				self.MasterLooter:SetAnchor('CENTER', self.Portrait, 'TOPLEFT', 3, -3)
			elseif (self.IsPartyFrame) then  
				self.MasterLooter:SetSize(14)
				self.MasterLooter:SetAnchor('TOPLEFT', self.Texture, 29, 0)
			end

			self.Leader = self:CreateTexture(nil, 'OVERLAY', self)
			self.Leader:SetSize(16)
			if (cUnit == 'target' or cUnit == 'focus') then
				self.Leader:SetAnchor('TOPRIGHT', self.Portrait, -3, 2)
			elseif (self.IsTargetFrame) then
				self.Leader:SetAnchor('TOPLEFT', self.Portrait, -3, 4)
			elseif (self.IsPartyFrame) then
				self.Leader:SetSize(14)
				self.Leader:SetAnchor('CENTER', self.Portrait, 'TOPLEFT', 1, -1)
			end
			
			if (not self.IsTargetFrame) then
				self.PhaseIcon = self:CreateTexture(nil, 'OVERLAY')
				self.PhaseIcon:SetAnchor('CENTER', self.Portrait, 'BOTTOM')
				if (self.IsMainFrame) then
					self.PhaseIcon:SetSize(26, 26)
				else
					self.PhaseIcon:SetSize(18, 18)
				end
			end

			self.OfflineIcon = self:CreateTexture(nil, 'OVERLAY')
			self.OfflineIcon:SetAnchor('TOPRIGHT', self.Portrait, 7, 7)
			self.OfflineIcon:SetAnchor('BOTTOMLEFT', self.Portrait, -7, -7)

			if (cUnit == 'player' or self.IsPartyFrame) then
				self.ReadyCheck = self:CreateTexture(nil, 'OVERLAY')
				self.ReadyCheck:SetAnchor('TOPRIGHT', self.Portrait, -7, -7)
				self.ReadyCheck:SetAnchor('BOTTOMLEFT', self.Portrait, 7, 7)
				self.ReadyCheck.delayTime = 2
				self.ReadyCheck.fadeTime = 0.7
			end

			if (self.IsPartyFrame or cUnit == 'player' or cUnit == 'target') then
				self.LFDRole = self:CreateTexture(nil, 'OVERLAY')
				self.LFDRole:SetSize(20)
				
				if (cUnit == 'player') then
					self.LFDRole:SetAnchor('BOTTOMRIGHT', self.Portrait, -2, -3)
				elseif (unit == 'target') then
					self.LFDRole:SetAnchor('TOPLEFT', self.Portrait, -10, -2)
				else
					self.LFDRole:SetAnchor('BOTTOMLEFT', self.Portrait, -5, -5)
				end
			end
		end

		UpdateUnitFrameLayout(self, cUnit)
		
		--[[*______________Load ClassMod______________*]]--
		if ns.classModule[E.Class] and config then
			ns.classModule[E.Class](self, config, uconfig)
		end
		
		--[[*______________Combo Points______________*]]--
		if C['units'].comboPoints ~= false then
			ns.CreateComboPoints(self)
		end
			
		--[[*______________Player Frame______________*]]--
		if (cUnit == 'player') then
			--// Resting icon
			self.Resting = self:CreateTexture(nil, 'OVERLAY')
			self.Resting:SetAnchor('CENTER', self.Level, -0.5, 0)
			self.Resting:SetSize(31, 34)
		end
		
		--[[*______________Focus&Target______________*]]--
		if (cUnit == 'target' or cUnit == 'focus') then
			
			--// Questmob Icon	
			self.QuestIcon = self:CreateTexture(nil, 'OVERLAY')
			self.QuestIcon:SetSize(32, 32)
			self.QuestIcon:SetAnchor('CENTER', self.Health, 'TOPRIGHT', 1, 10)

			table.insert(self.__elements, function(self, _, unit)
				self.Texture:SetTexture(GetTargetTexture(self.cUnit, UnitClassification(unit)))
			end)
		end

		--[[*______________Auras______________*]]--
		if (cUnit == 'player' and C['units'].enchantoUF ~= false) then
			
			--// weapon enchants
			self.Enchant = CreateFrame('frame', nil, self)
			self.Enchant:SetSize(21.5)
			self.Enchant.size = 21.5
			self.Enchant.spacing = 4
			--self.Enchant.showBlizzard = true

			self.Enchant:SetAnchor('LEFT', self, 'TOPLEFT', -38, -32)
			self.Enchant['growth-y'] = 'RIGHT'
			self.Enchant.initialAnchor = 'LEFT'
			
			self.Enchant.PostCreateEnchantIcon = ns.PostCreateAuraIcon
			self.Enchant.PostUpdateEnchantIcons = ns.PostUpdateEnchantIcons
		end

		if (cUnit == 'focus' or cUnit == 'target' or (cUnit == 'player' and C['units'].auraPlayer ~= false)) then
			local isFocus = (cUnit == 'focus')
			local GAP = 4.5
			local SIZE = isFocus and 26 or 20
			
			local function PositionAuras(frame, pos)
				if (pos == 'TOP') then
					frame:Height((SIZE+GAP) * (isFocus and 3 or 3))
					frame:Width((SIZE+GAP) * (isFocus and 3 or 6))
					frame:SetAnchor('BOTTOMLEFT', self, 'TOPLEFT', -3, 20)
					frame.initialAnchor = 'BOTTOMLEFT'
					frame['growth-x'] = 'RIGHT'
					frame['growth-y'] = 'UP'
					if (cUnit == 'player' and C['units'].auraPlayer ~= false) then
						frame:SetAnchor('BOTTOMRIGHT', self, 'TOPRIGHT', 3, 20)
						frame.initialAnchor = 'BOTTOMRIGHT'
						frame['growth-x'] = 'LEFT'
						frame['growth-y'] = 'UP'
					end
				elseif (pos == 'BOTTOM') then
					frame:Height((SIZE+GAP) * (isFocus and 3 or 3))
					frame:Width((SIZE+GAP) * (isFocus and 3 or 4))
					frame:SetAnchor('TOPLEFT', self, 'BOTTOMLEFT', -3, -8)
					frame.initialAnchor = 'TOPLEFT'
					frame['growth-x'] = 'RIGHT'
					frame['growth-y'] = 'DOWN'
					if (cUnit == 'player' and C['units'].auraPlayer ~= false) then
						frame:SetAnchor('TOPRIGHT', self, 'BOTTOMRIGHT', 3, -8)
						frame.initialAnchor = 'TOPRIGHT'
						frame['growth-x'] = 'LEFT'
						frame['growth-y'] = 'DOWN'
					end
				elseif (pos == 'LEFT') then
					frame:Height((SIZE+GAP) * (isFocus and 3 or 3))
					frame:Width((SIZE+GAP) * (isFocus and 5 or 8))
					frame:SetAnchor('TOPRIGHT', self, 'TOPLEFT', -8, -1.5)
					frame.initialAnchor = 'TOPRIGHT'
					frame['growth-x'] = 'LEFT'
					frame['growth-y'] = 'DOWN'
				end
				frame.spacing = GAP
				frame.size = SIZE
				frame.PostCreateIcon = ns.PostCreateAuraIcon
				frame.PostUpdateIcon = ns.PostUpdateAuraIcon
				frame.parent = self
			end

			if (C['units'].auraAnchor == 4) then
				self.Auras = CreateFrame('frame', nil, self)
				PositionAuras(self.Auras, 'TOP')
				self.Auras.gap = true
				if isFocus then
					self.Auras.numBuffs = 10
					self.Auras.numDebuffs = 10
				end
			elseif (C['units'].auraAnchor == 5) then
				self.Auras = CreateFrame('frame', nil, self)
				PositionAuras(self.Auras, 'BOTTOM')
				self.Auras.gap = true
				if isFocus then
					self.Auras.numBuffs = 10
					self.Auras.numDebuffs = 10
				end
			else
				if (C['units'].auraAnchor == 1) then
					self.Buffs = CreateFrame('frame', nil, self)
					PositionAuras(self.Buffs, 'TOP')
					self.Buffs.num = isFocus and 15 or 20
					
					self.Debuffs = CreateFrame('frame', nil, self)
					PositionAuras(self.Debuffs, 'BOTTOM')
					self.Debuffs.num = isFocus and 15 or 20
					
				elseif (C['units'].auraAnchor == 2) then
					self.Buffs = CreateFrame('frame', nil, self)
					PositionAuras(self.Buffs, 'BOTTOM')
					self.Buffs.num = isFocus and 15 or 20
					
					self.Debuffs = CreateFrame('frame', nil, self)
					PositionAuras(self.Debuffs, 'TOP')
					self.Debuffs.num = isFocus and 15 or 20
				else
					self.Buffs = CreateFrame('frame', nil, self)
					PositionAuras(self.Buffs, 'LEFT')
					self.Buffs.num = isFocus and 15 or 20
					
					self.Debuffs = CreateFrame('frame', nil, self)
					PositionAuras(self.Debuffs, 'BOTTOM')
					self.Debuffs.num = isFocus and 15 or 20
				end
			end

		elseif (self.IsTargetFrame and uconfig.enableAura) then
			local GAP = 4
			local SIZE = 20
			self.Debuffs = CreateFrame('frame', nil, self)
			self.Debuffs:SetAnchor('TOPLEFT', self.Health, 'TOPRIGHT', 7, 10)
			self.Debuffs.size = SIZE
			self.Debuffs.spacing = GAP
			self.Debuffs:Width((SIZE + GAP)*3)
			self.Debuffs:Height((SIZE + GAP)*2)
			self.Debuffs.initialAnchor = 'TOPLEFT'
			self.Debuffs['growth-y'] = 'DOWN'
			self.Debuffs['growth-x'] = 'RIGHT'
			self.Debuffs.num = 6

			self.Debuffs.PostCreateIcon = ns.PostCreateAuraIcon
			self.Debuffs.PostUpdateIcon = ns.PostUpdateAuraIcon
			self.Debuffs.parent = self
		
		elseif (cUnit == 'pet') then
			local GAP = 4
			local SIZE = 20
			self.Debuffs = CreateFrame('frame', nil, self)
			self.Debuffs.size = SIZE
			self.Debuffs:Width((SIZE + GAP)*6)
			self.Debuffs:Height(SIZE + GAP)
			self.Debuffs.spacing = GAP
			self.Debuffs:SetAnchor('TOPLEFT', self.Power, 'BOTTOMLEFT', 1, -3)
			self.Debuffs.initialAnchor = 'TOPLEFT'
			self.Debuffs['growth-x'] = 'RIGHT'
			self.Debuffs['growth-y'] = 'DOWN'
			self.Debuffs.num = 9

			self.Debuffs.PostCreateIcon = ns.PostCreateAuraIcon
			self.Debuffs.PostUpdateIcon = ns.PostUpdateAuraIcon
			self.Debuffs.parent = self
		
		elseif (self.IsPartyFrame) then
			local GAP = 4
			local SIZE = 20

			self.Debuffs = CreateFrame('Frame', nil, self)
			self.Debuffs:SetFrameStrata('BACKGROUND')
			self.Debuffs:Height(SIZE + GAP)
			self.Debuffs:Width((SIZE + GAP)*4)
			self.Debuffs.size = SIZE
			self.Debuffs.spacing = GAP
			self.Debuffs:SetAnchor('TOPLEFT', self.Health, 'TOPRIGHT', 5, 1)
			self.Debuffs.initialAnchor = 'LEFT'
			self.Debuffs['growth-y'] = 'DOWN'
			self.Debuffs['growth-x'] = 'RIGHT'
			self.Debuffs.num = 4

			self.Debuffs.PostCreateIcon = ns.PostCreateAuraIcon
			self.Debuffs.PostUpdateIcon = ns.PostUpdateAuraIcon
			self.Debuffs.parent = self

			self.Buffs = CreateFrame('Frame', nil, self)
			self.Buffs:SetFrameStrata('BACKGROUND')
			self.Buffs:Height(SIZE + GAP)
			self.Buffs:Width((SIZE + GAP)*4)
			self.Buffs.size = SIZE
			self.Buffs.spacing = GAP
			self.Buffs:SetAnchor('TOPLEFT', self.Health, 'BOTTOMLEFT', 2, -11)
			self.Buffs.initialAnchor = 'LEFT'
			self.Buffs['growth-y'] = 'DOWN'
			self.Buffs['growth-x'] = 'RIGHT'
			self.Buffs.num = 4

			self.Buffs.PostCreateIcon = ns.PostCreateAuraIcon
			self.Buffs.PostUpdateIcon = ns.PostUpdateAuraIcon
			self.Buffs.parent = self
		end
		
		--[[*______________Range Fader______________*]]--
		if (cUnit == 'pet' or self.IsPartyFrame) then
			self.Range = {
				insideAlpha = 1,
				outsideAlpha = 0.8,
			}
		end
		self.CFade = {
			FadeInMin = .2,
			FadeInMax = 1,
			FadeTime = 0.5,
		}
		return self
	end

	oUF:Factory(function(self)
		config = ns.config

		self:RegisterStyle('shUF', CreateUnitLayout)
		self:SetActiveStyle('shUF')

		local player = self:Spawn('player', 'shUFPlayer')
		ns.CreateUnitAnchor(player, player, player, nil, 'player')

		local pet = self:Spawn('pet', 'shUFPet')
		ns.CreateUnitAnchor(pet, pet, pet, nil, 'pet')

		local target = self:Spawn('target', 'shUFTarget')
		ns.CreateUnitAnchor(target, target, target, nil, 'target')

		local targettarget = self:Spawn('targettarget', 'shUFTargetTarget')
		targettarget:SetAnchor('TOPLEFT', target, 'BOTTOMRIGHT', -78, -15)

		local focus = self:Spawn('focus', 'shUFFocus')
		ns.CreateUnitAnchor(focus, focus, focus, nil, 'focus')

		local focustarget = self:Spawn('focustarget', 'shUFFocusTarget')
		focustarget:SetAnchor('TOPLEFT', focus, 'BOTTOMRIGHT', -78, -15)

		if C['units'].showParty ~= false then
			local party = oUF:SpawnHeader('shUFParty', nil, (C['units'].partyInRaid and 'custom [group:raid] show;[group:party] show;hide') or 'custom [target=raid6,exists] hide;show',
				'oUF-initialConfigFunction',[[
					self:SetSize(105, 30)
				]],
				'showParty', true,
				'yOffset', -30
			)
			ns.CreateUnitAnchor(party, party, party, nil, 'party')
		end

		--[[*______________MirrorBars______________*]]--
		for i = 1, MIRRORTIMER_NUMTIMERS do
			local bar = _G['MirrorTimer'.. i]
			bar:SetParent(UIParent)
			bar:SetScale(1.1)
			bar:SetSize(220, 14)

			ns.CreateBorder(bar, 11, 3)

			if (i > 1) then
				local p1, p2, p3, p4, p5 = bar:GetPoint()
				bar:SetAnchor(p1, p2, p3, p4, p5 - 10)
			end

			local statusbar = _G['MirrorTimer'.. i ..'StatusBar']
			statusbar:SetStatusBarTexture(config.statusbar)
			statusbar:SetAllPoints(bar)

			local backdrop = select(1, bar:GetRegions())
			backdrop:SetTexture('Interface\\Buttons\\WHITE8x8')
			backdrop:SetVertexColor(0, 0, 0, 0.5)
			backdrop:SetAllPoints(bar)

			local border = _G['MirrorTimer'.. i ..'Border']
			border:Hide()

			local text = _G['MirrorTimer'.. i ..'Text']
			text:SetFont(config.fontNormal, 13, config.fontNormalOutline)
			table.insert(ns.fontstrings, text)
			text:ClearAllPoints()
			text:SetAnchor('CENTER', bar)
			bar.text = text
		end	
	end);
