	
	--* PixelPerfect Script for SohighUI
	
	local E, C, _ = select(2, shCore()):unpack()
	
	local floor, min, max = math.floor, math.min, math.max
	
	local CreateFrame = CreateFrame
	local GetCVar, SetCVar = GetCVar, SetCVar
	
	local PixelPerfect = CreateFrame('frame')
	
	PixelPerfectEnable = function()
		local ScreenWidth, ScreenHeight = E.ScreenWidth or 0, E.ScreenHeight or 0

		if (ScreenWidth == 0 or ScreenHeight == 0) then
			E.ScreenWidth, E.ScreenHeight = E.Resolution
			ScreenWidth, ScreenHeight = E.ScreenWidth or 0, E.ScreenHeight or 0
		end
		
		local Height = ScreenHeight > 0 and 768 / ScreenHeight
		local Scale = max(M.UIScaleMin, min(1.15, M.UIScaleMax))
		
		PixelPerfect:RegisterEvent('PLAYER_LOGIN')
		PixelPerfect:SetScript('OnEvent', function(self, event)
			if (C.main.UIScale ~= false) and (event == 'PLAYER_LOGIN') then
				SetCVar('useUiScale', 1)
				SetCVar('uiScale', Scale)
			end
		end);
		
		E.Mult = Height/Scale
		
		function E:Scale(x)
			return E.Mult * floor(x / E.Mult + 0.5)
		end
		
		--[[ DEBUG
		SLASH_SCALE1 = '/scale'
		SlashCmdList.SCALE = function()
			E.Suitag('Scale: ' .. Scale)
			E.Suitag('ScreenWidth: ' .. ScreenWidth)
			E.Suitag('ScreenHeight: ' .. ScreenHeight)
			E.Suitag('Mult: ' .. E.Mult)
			self:SetSize(E:Scale(12), E:Scale(12))
			E.Suitag('E:Scale ' .. self:GetSize())
			E.Suitag('PixelPerfect: Enable')
			UIParent:SetSize(E:Scale(ScreenWidth), E:Scale(ScreenHeight))
			E.Suitag('UIParent: ' .. UIParent:GetWidth(), UIParent:GetHeight())
		end--]]
	end

	PixelPerfectEnable()