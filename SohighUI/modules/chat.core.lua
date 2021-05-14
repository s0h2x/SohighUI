
	--* core[chat]
	local E, C, L, _ = select(2, shCore()):unpack()
	
	local _G = _G
	local ipairs = ipairs
	
	local CreateFrame = CreateFrame
	
	local function chat__init()

		--* db for modules
		sui_database()
		
		--* module Init
		for _, m in ipairs(sui.modules) do _G[m]() end
	end

	local function chat_OnEvent(self, event, ...)
		if (event == 'PLAYER_ENTERING_WORLD') then
			self:UnregisterEvent('PLAYER_ENTERING_WORLD')
			chat__init()
		end
	end

	sui = CreateFrame('frame')
	sui:RegisterEvent('PLAYER_ENTERING_WORLD')
	sui:SetScript('OnEvent', chat_OnEvent)
	sui.modules = {}