	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF

	-- Default Profile Name
	shUF.DEFAULT = 'Default'
	-- For handling everything with profiles and settings

	-- [[ Utility Methods ]] --
	local function initDB(db, defaults)
		if type(db) ~= 'table' then db = {} end
		if type(defaults) ~= 'table' then return db end
		for k, v in pairs(defaults) do
			if type(v) == 'table' then
				db[k] = initDB(db[k], v)
			elseif type(v) ~= type(db[k]) then
				db[k] = v
			end
		end
		return db
	end

	local function cleanDB(db, defaults)
		if type(db) ~= 'table' then return {} end
		if type(defaults) ~= 'table' then return db end
		for k, v in pairs(db) do
			if type(v) == 'table' then
				if not next(cleanDB(v, defaults[k])) then
					-- Remove empty subtables
					db[k] = nil
				end
			elseif v == defaults[k] then
				-- Remove default values
				db[k] = nil
			end
		end
		return db
	end

	local function isValidID(id)
		return type(id) == 'string' and #id > 0
	end

	-- [[ Settings Profiles ]] --
	function shUF:CreateProfile(id)
		if isValidID(id) and not suiUF[id] then
			suiUF[id] = initDB(suiUF[id], ns.defaultConfig)
			if (id ~= self.DEFAULT) then
				self:SetProfile(id)
			end
			return true
		end
		return false
	end

	function shUF:DeleteProfile(id)
		if not suiUF[id] or id == self.DEFAULT then return false end
		if (id == self:GetProfileID()) then
			self:SetProfile(self.DEFAULT)
		end

		suiUF[id] = nil
		return true
	end

	function shUF:GetSettings()
		return suiUF[self:GetProfileID()]
	end

	function shUF:GetAllProfiles()
		local tbl = {}
		for k, _ in pairs(suiUF) do
			table.insert(tbl, k)
		end
		table.sort(tbl)
		return tbl
	end

	function shUF:GetProfileID()
		return shUF_db['profile']
	end

	function shUF:SetProfile(id)
		if suiUF[id] then
			local oldID = self:GetProfileID() 
			if oldID ~= id then	-- Clean the old profile
				suiUF[oldID] = cleanDB(suiUF[oldID], ns.defaultConfig)
			end

			shUF_db['profile'] = id
			
			suiUF[id] = initDB(suiUF[id], ns.defaultConfig)
			ns.config = suiUF[id]
			return true
		else
			return self:SetProfile(self.DEFAULT)
		end
	end

	function shUF:ResetProfile(id)
		if suiUF[id] then
			wipe(suiUF[id])
			suiUF[id] = initDB(suiUF[id], ns.defaultConfig)
		end
	end

	function shUF:GetDefaultSettings()
		return ns.defaultConfig
	end

	-- [[ Startup	]] --
	function shUF:SetupSettings()
		-- Per char
		_G.shUF_db = initDB(shUF_db, ns.defaultProfiles)

		-- Settings
		_G.suiUF = initDB(suiUF)

		self:CreateProfile(self.DEFAULT)
		self:SetProfile(self:GetProfileID())
	end

	-- [[ Cleaner 	]] --
	function shUF:PLAYER_LOGOUT(event)
		suiUF[self:GetProfileID()] = cleanDB(suiUF[self:GetProfileID()], ns.defaultConfig)
	end
