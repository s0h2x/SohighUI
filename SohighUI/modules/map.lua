	
	--* world map
	local E, C, L, ET, _ = select(2, shCore()):unpack()

	WorldMapFrameAreaLabel:SetFont(A.font, 45, A.fontStyle)
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.9, 0.83, 0.64)

	WorldMapFrameAreaDescription:SetFont(A.font, 55, A.fontStyle)
	WorldMapFrameAreaDescription:SetShadowOffset(2, -2)

	--*	position
	function SetUIPanelAttribute(frame, name, value)
		local info = UIPanelWindows[frame:GetName()]
		if not info then return end

		if not frame:GetAttribute('UIPanelLayout-defined') then
			frame:SetAttribute('UIPanelLayout-defined', true)
			for name,value in pairs(info) do
				frame:SetAttribute('UIPanelLayout-'..name, value)
			end
		end

		frame:SetAttribute('UIPanelLayout-'..name, value)
	end
	
	UIPanelWindows['WorldMapFrame'] = {area = 'center', pushable = 9}
	hooksecurefunc(WorldMapFrame, 'Show', function(self)
		self:SetScale(0.60)
		self:EnableKeyboard(false)
		BlackoutWorld:dummy()
		WorldMapFrame:StripLayout()
		WorldMapFrame:EnableMouse(false)
	end);
	
	WorldMapDetailFrame:SetLayout()
	WorldMapDetailFrame:SetShadow()
	
	WorldMapPositioningGuide:SetLayout()
	WorldMapPositioningGuide:SetShadow()
	
	WorldMapFrameCloseButton:CloseTemplate()
	ET:HandleButton(WorldMapZoomOutButton)

	table.insert(UISpecialFrames, WorldMapFrame:GetName())

	if WorldMapFrame:GetAttribute('UIPanelLayout-area') ~= 'center' then
		SetUIPanelAttribute(WorldMapFrame, 'area', 'center')
	end

	if WorldMapFrame:GetAttribute('UIPanelLayout-allowOtherPanels') ~= true then
		SetUIPanelAttribute(WorldMapFrame, 'allowOtherPanels', true)
	end

	DropDownList1:HookScript('OnShow', function()
		if DropDownList1:GetScale() ~= UIParent:GetScale() then
			DropDownList1:SetScale(UIParent:GetScale())
		end
	end)

	WorldMapTooltip:SetFrameLevel(WorldMapPositioningGuide:GetFrameLevel() + 110)

	--*	coord
	local coords = CreateFrame('frame', 'CoordsFrame', WorldMapFrame)
	coords:SetFrameLevel(WorldMapFrame:GetFrameLevel() + 2)
	coords:SetFrameStrata(WorldMapFrame:GetFrameStrata())
	coords.PlayerText = coords:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	coords.PlayerText:SetAnchor('BOTTOMLEFT', WorldMapButton, 'BOTTOMLEFT', 5, 5)
	coords.PlayerText:SetJustifyH('LEFT')
	coords.PlayerText:SetText(E.Name..': 0,0')
	coords.PlayerText:SetFont(A.font, 20, A.fontStyle)

	coords.MouseText = coords:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	coords.MouseText:SetJustifyH('LEFT')
	coords.MouseText:SetAnchor('BOTTOMLEFT', coords.PlayerText, 'TOPLEFT', 0, 5)
	coords.MouseText:SetText(L_MapCursor..': 0,0')
	coords.MouseText:SetFont(A.font, 20, A.fontStyle)

	local int = 0
	WorldMapFrame:HookScript('OnUpdate', function(self, elapsed)
		int = int + 1
		if int >= 3 then
			local x, y = GetPlayerMapPosition('player')

			if not GetPlayerMapPosition('player') then
				x = 0
				y = 0
			end

			x = math.floor(100 * x)
			y = math.floor(100 * y)
			if x ~= 0 and y ~= 0 then
				coords.PlayerText:SetText(E.Name..': '..x..','..y)
			else
				coords.PlayerText:SetText(E.Name..': '..'|cffff0000'..L_MapBound..'|r')
			end

			local scale = WorldMapDetailFrame:GetEffectiveScale()
			local width = WorldMapDetailFrame:GetWidth()
			local height = WorldMapDetailFrame:GetHeight()
			local centerX, centerY = WorldMapDetailFrame:GetCenter()
			local x, y = GetCursorPosition()
			local adjustedX = (x / scale - (centerX - (width/2))) / width
			local adjustedY = (centerY + (height/2) - y / scale) / height

			if adjustedX >= 0 and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1 then
				adjustedX = math.floor(100 * adjustedX)
				adjustedY = math.floor(100 * adjustedY)
				coords.MouseText:SetText(L_MapCursor..': '..adjustedX..','..adjustedY)
			else
				coords.MouseText:SetText(L_MapCursor..': |cffff0000'..L_MapBound..'|r')
			end
			int = 0
		end
	end);