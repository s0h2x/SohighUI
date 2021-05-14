	
	--* develope things
	local E, C, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local format = format
	
	local GetAddOnInfo = GetAddOnInfo
	local GetMouseFocus = GetMouseFocus
	local ReloadUI = ReloadUI
	local ResetCPUUsage = ResetCPUUsage
	local UpdateAddOnCPUUsage, GetAddOnCPUUsage = UpdateAddOnCPUUsage, GetAddOnCPUUsage
	
	SlashCmdList.RELOADUI = function() ReloadUI() end
	SLASH_RELOADUI1 = '/rl'
	SLASH_RELOADUI2 = '/кд'
	SLASH_RELOADUI3 = '.кд'
	
	SlashCmdList.CHECKVERSION = function()
		E.Suitag('Patch:', E.WoWPatch..', '.. 'Build:', E.WoWBuild..', '.. 'Released:', E.WoWPatchReleaseDate..', '.. 'Interface:', E.TocVersion)
		--E.Suitag('Patch:', E.Version..', '.. 'Build:', E.WoWBuild..', '.. 'Released:', E.WoWPatchReleaseDate..', '.. 'Interface:', E.TocVersion)
	end
	SLASH_CHECKVERSION1 = '/patch'
	SLASH_CHECKVERSION2 = '/version'
	
	--* enable lua error by command
	local function LUAERROR(msg, editbox)
		if (msg == 'on') then
			SetCVar('scriptErrors', 1)
			ReloadUI()
		elseif (msg == 'off') then
			SetCVar('scriptErrors', 0)
		else
			E.Suitag('/luaerror on - /luaerror off')
		end
	end
	SLASH_LUAERROR1 = '/luaerror'
	SlashCmdList['LUAERROR'] = LUAERROR
	
	SLASH_FRAMESTACK1 = '/fs'
    SlashCmdList.FRAMESTACK = function()
		E.Suitag(GetMouseFocus():GetName())
    end
	
	local function FRAME(arg)
		if arg ~= '' then
			arg = _G[arg]
		else
			arg = GetMouseFocus()
		end
		if arg ~= nil and arg:GetName() ~= nil then
			local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
			ChatFrame1:AddMessage('|cffCC0000. . . . . . . . . . . . . . . . .')
			ChatFrame1:AddMessage('Name: |cffFFD100'..arg:GetName())
			
			if arg:GetParent() then
				ChatFrame1:AddMessage('Parent: |cffFFD100'..arg:GetParent():GetName())
			end
	 
			ChatFrame1:AddMessage('Width: |cffFFD100'..format('%.2f',arg:GetWidth()))
			ChatFrame1:AddMessage('Height: |cffFFD100'..format('%.2f',arg:GetHeight()))
			ChatFrame1:AddMessage('Strata: |cffFFD100'..arg:GetFrameStrata())
			ChatFrame1:AddMessage('Level: |cffFFD100'..arg:GetFrameLevel())
	 
			if xOfs then
				ChatFrame1:AddMessage('X: |cffFFD100'..format('%.2f',xOfs))
			end
			if yOfs then
				ChatFrame1:AddMessage('Y: |cffFFD100'..format('%.2f',yOfs))
			end
			if relativeTo then
				ChatFrame1:AddMessage('Point: |cffFFD100'..point..'|r anchored to '..relativeTo:GetName()..'`s |cffFFD100'..relativePoint)
			end
			ChatFrame1:AddMessage('|cffCC0000. . . . . . . . . . . . . . . . .')
		elseif (arg == nil) then
			ChatFrame1:AddMessage('Invalid frame name')
		else
			ChatFrame1:AddMessage('Could not find frame info')
		end
	end
	SLASH_FRAME1 = '/frame'
	SlashCmdList['FRAME'] = FRAME
	
	--* Obatin CPU Impact for SohighUI (From ElvUI)
	local num_frames = 0
	local function OnUpdate()
		num_frames = num_frames + 1
	end
	local f = CreateFrame('frame')
	f:Hide()
	f:SetScript('OnUpdate', OnUpdate)

	local toggleMode = false
	SlashCmdList.GETCPUIMPACT = function()
		if(not toggleMode) then
			ResetCPUUsage()
			num_frames = 0
			debugprofilestart()
			f:Show()
			toggleMode = true
			E.Suitag('|cffffe02eCPU Impact being calculated, type /cpuimpact to get results when you are ready.|r')
		else
			f:Hide()
			local ms_passed = debugprofilestop()
			UpdateAddOnCPUUsage()

			E.Suitag('|cffffe02eConsumed ' .. (GetAddOnCPUUsage('SohighUI') / num_frames) .. ' milliseconds per frame. Each frame took ' .. (ms_passed / num_frames) .. ' to render.|r')
			toggleMode = false
		end
	end
	SLASH_GETCPUIMPACT1 = '/cpuimpact'
	SLASH_GETCPUIMPACT2 = '/cpu'