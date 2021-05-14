	
	--* anchors, credit: Abu
	local E, C, L, _ = select(2, shCore()):unpack()
	
	--[[ Anchor frames for player, targer, focus, party, raid & boss ]]
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	--*	functions for showing phony unitframes
	local enableDummies
	do 
		local function toggleUnitFrame(obj, show)
			if show then
				obj.old_unit = obj.unit
				obj.unit = 'player'
				obj.old_OnUpdate = obj:GetScript('OnUpdate')

				obj:SetScript('OnUpdate', nil)
				obj:SetAlpha(1)
				UnregisterUnitWatch(obj)
				RegisterUnitWatch(obj, true)

				obj:Show()
				if obj.CCastbar then
					obj.CCastbar:DummyCastbar()
				end
			elseif (obj.old_unit) then
				obj.unit = obj.old_unit or obj.unit
				obj.old_unit = nil

				UnregisterUnitWatch(obj) -- Reset the object
				RegisterUnitWatch(obj)

				if obj.old_OnUpdate then
					obj:SetScript('OnUpdate', obj.old_OnUpdate)
					obj.old_OnUpdate = nil
				end

				obj:UpdateAllElements('OnShow')
			end
		end

		local function showSingleUnit(self, show)
			for _, obj in pairs(oUF.objects) do
				local unit = obj:GetAttribute('unit')
				if (unit) then
					for i = 1, #self.units do
						if (unit == self.units[i]) then
							toggleUnitFrame(obj, show)
						end
					end
				end
			end
		end

		function enableDummies(anchor)
			if anchor.isHeader then
				anchor:SetScript('OnShow', function(self)
					SecureStateDriverManager:SetAttribute('setframe', self.object)
					self.oldstate_driver = SecureStateDriverManager:GetAttribute('setstate'):gsub('state%-visibility%s', '') -- i suck at string formatting
					--local numMembers = math.max(GetNumSubgroupMembers(LE_PARTY_CATEGORY_HOME) or 0, GetNumSubgroupMembers(LE_PARTY_CATEGORY_INSTANCE) or 0)
					--self.object:SetAttribute('startingIndex', (numMembers - 3))
					--RegisterAttributeDriver(self.object, 'state-visibility', 'show')

					for i = 1, self.object:GetNumChildren() do
						local obj = select(i, self.object:GetChildren())
						toggleUnitFrame(obj, true)
					end
				end)
				anchor:SetScript('OnHide', function(self)
					self.object:SetAttribute('showParty', true)
					--RegisterAttributeDriver(self.object, 'state-visibility', self.oldstate_driver)
					self.oldstate_driver = nil
					self.object:SetAttribute('startingIndex', nil)

					for i = 1, self.object:GetNumChildren() do
						local obj = select(i, self.object:GetChildren())
						toggleUnitFrame(obj, false)
					end
				end)
			else
				anchor:SetScript('OnShow', function(self)
					showSingleUnit(self, true)
				end)
				anchor:SetScript('OnHide', function(self)
					showSingleUnit(self)
				end)
			end
		end
	end

	-------------------------------------------------------------------------
	--								Positions						 	   --
	-------------------------------------------------------------------------
	--* set points
	local POINT, PARENT = 'TOP', UIParent

	local function anchor_GetCurrent(anchor)
		local point, _, rpoint, x, y = anchor:GetPoint()

		-- GetPoint doesnt give from the point 'TOP' so lets figure it out
		local width, height = anchor:GetWidth(), anchor:GetHeight()

		if point:find('LEFT') then
			x = x + (width / 2 )
		elseif  point:find('RIGHT') then
			x = x - (width / 2)
		end

		if point:find('BOTTOM') then
			y = y + height
		elseif (not point:find('TOP')) then
			y = y + height/2
		end

		local scale = anchor.object:GetEffectiveScale() / UIParent:GetScale()
		return POINT, PARENT, rpoint, math.floor(x/scale + .5), math.floor(y/scale + .5)
	end

	local function anchor_GetSaved(anchor, default)
		local data
		if (not default) then
			data = ns.config[anchor.key1][anchor.key2]
			if type(data) == 'table' then
				data = nil
			end
		end
		if (not data) then
			data = ns.defaultConfig[anchor.key1][anchor.key2]
		end

		local rp, x, y = string.split('/', data)
		return POINT, PARENT, rp, tonumber(x), tonumber(y)
	end

	local function anchor_Save(anchor, reset)
		local _, rp, x, y
		if reset then
			_, _, rp, x, y = anchor_GetSaved(anchor, true)
		else
			_, _, rp, x, y = anchor_GetCurrent(anchor)
		end
		ns.config[anchor.key1][anchor.key2] = string.format('%s/%d/%d', rp, x, y)
	end

	-------------------------------------------------------------------------
	--*	creating anchors

	local AnchorFrames = {}
	local function CreateAnchor(frame, name, key1, key2, tlP, brP, strata)
		local anchor = CreateFrame('Button', name..'Anchor', UIParent)
		anchor:EnableMouse(true)
		anchor:SetFrameStrata(strata or 'HIGH')
		anchor:SetMovable(true)
		anchor:RegisterForDrag('LeftButton')
		anchor:RegisterForClicks('AnyUp')
		anchor:SetClampedToScreen(true)

		anchor.topleftPoint = type(tlP) == 'string' and tlP or tlP:GetName()
		anchor.botrightPoint = type(tlP) == 'string' and tlP or tlP:GetName()
		
		anchor.object = frame
		anchor.key1 = key1
		anchor.key2 = key2

		anchor:SetScript('OnMouseUp', function(self, button)
			if (IsAltKeyDown()) and (button == 'LeftButton') then
				anchor_Save(self, true)
			end
			self:Update()
		end);

		anchor:SetScript('OnDragStart', function(self)
			if IsShiftKeyDown() then
				self.isMoving = true
				self:StartMoving()
				self:Release()
			end
		end);

		anchor:SetScript('OnDragStop', function(self)
			if self.isMoving then
				self:StopMovingOrSizing()
				anchor_Save(self)
				self:Update()
			end
			self.isMoving = nil
		end);

		anchor.Update = function(self)
			local obj = self.object
			obj:ClearAllPoints()
			obj:SetAnchor(anchor_GetSaved(self))
			
			self:ClearAllPoints()
			self:SetAnchor('TOPLEFT', self.topleftPoint)
			self:SetAnchor('BOTTOMRIGHT', self.botrightPoint)
		end

		anchor.Release = function(self)
			local obj = self.object
			obj:ClearAllPoints()
			obj:SetAnchor(POINT, self)
		end

		--* tooltips
		anchor:SetScript('OnEnter', function(self)
			GameTooltip:SetOwner(self, 'ANCHOR_TOP')
			GameTooltip:AddLine(self.objectname)
			GameTooltip:AddLine(L_Anchors_Infoline1, 1,1,1)
			GameTooltip:AddLine(L_Anchors_Infoline2, 1,1,1)
			GameTooltip:Show()
		end);
		
		anchor:SetScript('OnLeave', function(self)
			GameTooltip:Hide()
		end);

		AnchorFrames[#AnchorFrames + 1] = anchor
		return anchor
	end

	function ns.CreateUnitAnchor(frame, tlP, brP, strata, ...) -- ... = unit(s)
		local key1 = frame.cUnit or ...
		local anchor = CreateAnchor(frame, frame:GetName():gsub('%d', ''), key1, 'position', tlP, brP, strata)

		anchor.units = {...}
		anchor.isHeader = frame:GetAttribute('oUF-headerType') and true or false
		anchor.objectname = L[key1]

		enableDummies(anchor)
		
		--* forces the creation of header children, so we get the full size
		if anchor.isHeader then
			anchor:GetScript('OnShow')(anchor)
		end

		anchor:Update()
		anchor:Hide()

		return anchor
	end

	function ns.CreateCastbarAnchor(frame)
		local name = frame:GetName()
		local key1 = frame:GetParent().cUnit

		local a = CreateAnchor(frame, name, key1, 'cbposition', name, name)
		a.objectname = key1..' '..L_Castbar

		a:Update()
		a:Hide()

		return a
	end

	function shUF:PLAYER_REGEN_DISABLED()
		self:Print(L_Anchors_Locked)
		self:ToggleAllAnchors(true)
	end

	local LOCKED = true
	function shUF:ToggleAllAnchors(force_Lock)
		
		if LOCKED and (not force_Lock) then
			if InCombatLockdown() then return self:Print(L_Anchors_InCombat); end
			self:RegisterEvent('PLAYER_REGEN_DISABLED')
			self:Print(L_Anchors_Unlocked)

			for i = 1, #AnchorFrames do
				AnchorFrames[i]:Show()
			end

		elseif (not LOCKED) then
			self:UnregisterEvent('PLAYER_REGEN_DISABLED')
			self:Print(L_Anchors_Locked)	

			for i = 1, #AnchorFrames do
				AnchorFrames[i]:Hide()
			end
		end

		LOCKED = (not LOCKED)
		return LOCKED
	end

	function shUF:UpdateAnchorPositions()
		if InCombatLockdown() then
			self:Print(L_Anchors_InCombat)
			return
		end
		for i = 1, #AnchorFrames do
			AnchorFrames[i]:Update()
		end
	end

	function shUF:GetAnchorFrames()
		return AnchorFrames
	end