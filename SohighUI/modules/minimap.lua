	
	--* minimap
	local E, C, L, _ = select(2, shCore()):unpack()
	
	local unpack, select = unpack, select
	local collectgarbage = collectgarbage
	local floor, format = math.floor, string.format
	local modf = math.modf
	
	local CreateFrame = CreateFrame
	
	local showLFT = true			-- enable disable fps/latency and clock
	local showclock = true			-- ONLY show clock (local time)
	local zoneTextOnMap = false		-- move zone info into minimap frame
	
	--* Latency / FPS / Time
	if (showLFT ~= false) then
		local LFT = CreateFrame('Button', 'LFT', Minimap)
		LFT:SetAnchor(unpack(C.Anchors.LFT))
		LFT:SetSize(Minimap:GetWidth()+4, A.fontSize+1)
		LFT:SetFrameLevel(0)

		local text = LFT:CreateFontString(nil, 'OVERLAY')
		text:SetAnchor('CENTER', LFT, 4, 0)
		text:SetFontObject(NumberFontNormal)
		text:SetShadowOffset(0,0)
		text:SetTextColor(E.Color.r, E.Color.g, E.Color.b)

		local function addonCompare(a, b)
			return a.memory > b.memory
		end

		local function MemFormat(m)
			if (m > 1024) then
				return format('%.2f MiB', m/1024)
			else
				return format('%.2f KiB', m)
			end
		end

		local function ColorGradient(perc, ...)
			if (perc > 1) then
				local r, g, b = select(select('#', ...) -2, ...) return r, g, b
			elseif (perc < 0) then
				local r, g, b = ... return r, g, b
			end

			local num = select('#', ...)/3
			local segment, relperc = modf(perc*(num-1))
			local r1, g1, b1, r2, g2, b2 = select((segment*3) +1, ...)

			return r1+(r2-r1) * relperc, g1+(g2-g1)*relperc, b1+(b2-b1) * relperc
		end

		local function TimeFormat(time)
			local t = format('%.1ds', floor(mod(time, 60)))
			if (time > 60) then
				time = floor(time/60)
				t = format('%.1dm ', mod(time, 60)) .. t
				if (time > 60) then
					time = floor(time/60)
					t = format('%.1dh ', mod(time, 24)) .. t
					if (time > 24) then
						time = floor(time/24)
						t = format('%dd ',time) .. t
					end
				end
			end
			return t
		end

		local function ColorizeLatency(p)
			if (p < 100) then
				return {r = 0, g = 1, b = 0}
			elseif (p < 300) then
				return {r = 1, g = 1, b = 0}
			else
				return {r = 1, g = 0, b = 0}
			end
		end

		local function ColorizeFramerate(f)
			if (f < 10) then
				return {r = 1, g = 0, b = 0}
			elseif (f < 30) then
				return {r = 1, g = 1, b = 0}
			else
				return {r = 0, g = 1, b = 0}
			end
		end

		local lastUpdate = 0
		local updateDelay = 1
		LFT:SetScript('OnUpdate', function(self, elapsed)
			lastUpdate = lastUpdate + elapsed
			if (lastUpdate > updateDelay) then
				lastUpdate = 0
				local time = date('|c00ffffff%H|r:|c00ffffff%M|r')
				fps = GetFramerate()
				fps = '|c00ffffff'..floor(fps+0.5)..'|r fps  '
				lag = select(3, GetNetStats())
				lag = '|c00ffffff'..lag..'|r ms  '
				text:SetText(lag..fps..time)
			end
		end);

		LFT:SetScript('OnEnter', function()
			GameTooltip:SetOwner(LFT)
			collectgarbage()
			
			local memory, i, addons, total, entry, total
			local latcolor = ColorizeLatency(select(3, GetNetStats()))
			local fpscolor = ColorizeFramerate(GetFramerate())
			
			GameTooltip:AddLine(date('%A, %d %B, %Y'), 1, 1, 1)
			GameTooltip:AddDoubleLine('Framerate:', format('%.1f fps', GetFramerate()), E.Color.r, E.Color.g, E.Color.b, fpscolor.r, fpscolor.g, fpscolor.b)
			GameTooltip:AddDoubleLine('Latency:', format('%d ms', select(3, GetNetStats())), E.Color.r, E.Color.g, E.Color.b, latcolor.r, latcolor.g, latcolor.b)
			GameTooltip:AddDoubleLine('System Uptime:', TimeFormat(GetTime()), E.Color.r, E.Color.g, E.Color.b, 1, 1, 1)
			GameTooltip:AddDoubleLine('. . . . . . . . . . .', '. . . . . . . . . . .', 1, 1, 1, 1, 1, 1)
	
			addons = {}
			total = 0
			UpdateAddOnMemoryUsage()
			
			for i = 1, GetNumAddOns(), 1 do
				if (GetAddOnMemoryUsage(i) > 0) then
					memory = GetAddOnMemoryUsage(i)
					entry = {name = GetAddOnInfo(i), memory = memory}
					table.insert(addons, entry)
					total = total + memory
				end
			end
			
			table.sort(addons, addonCompare)

			for _, entry in pairs(addons) do
				local cr, cg, cb = ColorGradient((entry.memory/800), 0, 1, 0, 1, 1, 0, 1, 0, 0)
				GameTooltip:AddDoubleLine(entry.name, MemFormat(entry.memory), 1, 1, 1, cr, cg, cb)
			end
			
			local cr, cg, cb = ColorGradient((entry.memory/800), 0, 1, 0, 1, 1, 0, 1, 0, 0) 
			GameTooltip:AddDoubleLine('. . . . . . . . . . .', '. . . . . . . . . . .', 1, 1, 1, 1, 1, 1)
			GameTooltip:AddDoubleLine('Total', MemFormat(total), E.Color.r, E.Color.g, E.Color.b, cr, cg, cb)
			GameTooltip:AddDoubleLine('Blizzard stuff', MemFormat(collectgarbage('count')), E.Color.r, E.Color.g, E.Color.b, cr, cg, cb)
			GameTooltip:Show()
		end);

		LFT:SetScript('OnLeave', function() GameTooltip:Hide() end);
		LFT:SetScript('OnClick', function()
			if (not IsAltKeyDown()) then
				UpdateAddOnMemoryUsage()
				local memBefore = gcinfo()
				collectgarbage()
				UpdateAddOnMemoryUsage()
				CombatLogClearEntries()
				local memAfter = gcinfo()
				E.Suitag(L_MemoryClean..' |cff00FF00' .. MemFormat(memBefore - memAfter))
			end
		end);
	end
	
	local cluster = {
		--'MinimapBorder',
		'MiniMapMailBorder',
		'MiniMapMeetingStoneBorder',
		'MiniMapBattlefieldBorder',
	}
	
	for _, m in pairs(cluster) do
		--_G[m]:SetVertexColor(.2,.2,.2,.8)
		_G[m]:StripLayout()
	end
	
	MinimapBorder:ClearAllPoints()
	MinimapBorder:SetAnchor(unpack(C.Anchors.mapBorder))
	MinimapBorder:SetSize(MinimapCluster:GetSize())
	MinimapBorder:SetTexture(A.mapTex, 'BACKGROUND')
	
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()	
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript('OnMouseWheel', function(self, d)
		if (d > 0) then Minimap_ZoomIn() else Minimap_ZoomOut() end
	end);
	
	GameTimeTexture:Hide()
	MinimapBorderTop:Hide()
	MiniMapWorldMapButton:Hide()
	--MinimapToggleButton:Hide()
	MiniMapTrackingBorder:Hide()
	MiniMapMailFrame:ClearAllPoints()
	MiniMapMailFrame:SetAnchor(unpack(C.Anchors.mapMail))
	
	--* BF
	MiniMapBattlefieldFrame:SetNormalTexture''
	MiniMapBattlefieldFrame:SetPushedTexture''
	MiniMapBattlefieldFrame:SetHighlightTexture''
	MiniMapBattlefieldFrame:SetDisabledTexture''
	MiniMapBattlefieldFrame:SetScale(1.4)
	
	--* tracking
	--MiniMapTracking:StripLayout()
    MiniMapTrackingIcon:ClearAllPoints()
    MiniMapTrackingIcon:SetAnchor(unpack(C.Anchors.mapTrackIcnTL))
    MiniMapTrackingIcon:SetAnchor(unpack(C.Anchors.mapTrackIcnBR))
    MiniMapTrackingIcon.SetAnchor = E.hoop
    MiniMapTrackingIcon:SetTexCoord(unpack(E.TexCoords))
	
    MiniMapTrackingBackground:Hide()
	
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:SetAnchor(unpack(C.Anchors.mapTrack))
	MiniMapTracking:SetSize(24)
	
	MinimapZoneTextButton:ClearAllPoints()
	MinimapZoneTextButton:SetAnchor(unpack(C.Anchors.mapZone))
	MinimapZoneTextButton:SetParent(Minimap)
	
	MinimapNorthTag:SetVertexColor(1, .4, 0)
	
	--* move and clickable
	Minimap:SetMovable(true)
	Minimap:SetUserPlaced(true)
	Minimap:SetClampedToScreen(true)
	Minimap:SetScript('OnMouseDown', function()
		if (IsShiftKeyDown()) then
			Minimap:ClearAllPoints()
			Minimap:StartMoving()
		end
	end);

	Minimap:SetScript('OnMouseUp', function(self, button)
	Minimap:StopMovingOrSizing()
		if (button == 'RightButton') then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, -(Minimap:GetWidth() * 0.7), -3)
		else
			Minimap_OnClick(self)
		end
	end);
	
	if (showclock ~= false) then
		LoadAddOn('Blizzard_TimeManager')
		
		local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
		clockFrame:Hide()
		clockTime:Show()
		clockTime:SetFont(A.font, 12, A.fontStyle)
		TimeManagerClockButton:SetAnchor(unpack(C.Anchors.mapTime))
	else
		LoadAddOn('Blizzard_TimeManager')
		TimeManagerClockButton:Hide()
	end
	
	if (zoneTextOnMap ~= false) then
		ZoneTextString:SetAnchor(unpack(C.Anchors.mapZoneText))
		SubZoneTextString:SetAnchor(unpack(C.Anchors.mapSubZoneText))
	else
		ZoneTextString:SetAnchor(unpack(C.Anchors.zoneText))
		SubZoneTextString:SetAnchor(unpack(C.Anchors.subZoneText))
	end
	
	MinimapToggleButton:CloseTemplate()
	MinimapToggleButton:ClearAllPoints()
	MinimapToggleButton:SetAnchor(unpack(C.Anchors.mapToggle))
