	
	--* Learn all available skills (TrainAll by SDPhantom)
	
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.misc ~= true then return end

	local _G = _G
	local select = select
	
	local CreateFrame = CreateFrame
	local hooksecurefunc = hooksecurefunc
	
	local TrainAllButton = CreateFrame'frame'
	TrainAllButton:RegisterEvent('ADDON_LOADED')
	TrainAllButton:SetScript('OnEvent', function(self, event, addon)
		if (addon == 'Blizzard_TrainerUI') then
			local button = CreateFrame('Button', 'ClassTrainerTrainAllButton', ClassTrainerFrame, 'UIPanelButtonTemplate')
			button:SetText(TRAIN..' '..ALL)
			
			if C.main.restyleUI ~= false then
				ET:HandleButton(button)
				button:SetAnchor('TOPRIGHT', ClassTrainerTrainButton, 'TOPLEFT', -3, 0)
			else
				button:SetAnchor('TOPRIGHT', ClassTrainerTrainButton, 'TOPLEFT', 0, 0)
			end
			
			button:Width(min(150, button:GetTextWidth() + 20))
			button:Height(21)
			button:SetScript('OnClick', function()
				for i = 1, GetNumTrainerServices() do
					if select(3, GetTrainerServiceInfo(i)) == 'available' then
						BuyTrainerService(i)
					end
				end
			end);
			hooksecurefunc('ClassTrainerFrame_Update', function()
				for i = 1, GetNumTrainerServices() do
					if ClassTrainerTrainButton:IsEnabled() and select(3, GetTrainerServiceInfo(i)) == 'available' then
						button:Enable()
						return
					end
				end
				button:Disable()
			end);
		end
	end);