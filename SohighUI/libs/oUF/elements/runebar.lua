--[[ Runebar:
	Authors: Zariel, Haste
]]

if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end -- doesn't really matter

-- local parent, ns = ...
-- local oUF = ns.oUF
local parent = debugstack():match[[\AddOns\(.-)\]] -- parent part of the local parent, ns = ...
local global = GetAddOnMetadata(parent, 'X-oUF')
assert(global, 'X-oUF needs to be defined in the parent add-on.')
local oUF = _G[global]

oUF.colors.runes = {
	{1, 0, 0};
	{0, .5, 0};
	{0, 1, 1};
	{.9, .1, 1};
}

local OnUpdate = function(self, elapsed)
	local duration = self.duration + elapsed
	if(duration >= self.max) then
		return self:SetScript("OnUpdate", nil)
	else
		self.duration = duration
		return self:SetValue(duration)
	end
end

local UpdateType = function(self, event, rune, alt)
	local colors = self.colors.runes[GetRuneType(rune) or alt]
	local rune = self.Runes[rune]
	local r, g, b = colors[1], colors[2], colors[3]

	rune:SetStatusBarColor(r, g, b)

	if(rune.bg) then
		local mu = rune.bg.multiplier or 1
		rune.bg:SetVertexColor(r * mu, g * mu, b * mu)
	end
end

local UpdateRune = function(self, event, rid)
	local rune = self.Runes[rid]
	if(rune) then
		local start, duration, runeReady = GetRuneCooldown(rune:GetID())
		if(start) then
			if(runeReady) then
				rune:SetMinMaxValues(0, 1)
				rune:SetValue(1)
				rune:SetScript("OnUpdate", nil)
			else
				rune.duration = GetTime() - start
				rune.max = duration
				rune:SetMinMaxValues(1, duration)
				rune:SetScript("OnUpdate", OnUpdate)
			end
		end
	end
end

local Update = function(self, event)
	for i=1, 6 do
		UpdateRune(self, event, i)
	end
end

local Enable = function(self, unit)
	local runes = self.Runes
	if(runes and unit == 'player') then
		for i=1, 6 do
			local rune = runes[i]
			rune:SetID(i)
			-- From my minor testing this is a okey solution. A full login always remove
			-- the death runes, or at least the clients knowledge about them.
			UpdateType(self, nil, i, math.floor((i+1)/2))

			if(not rune:GetStatusBarTexture()) then
				rune:SetStatusBarTexture[[Interface\TargetingFrame\UI-StatusBar]]
			end
		end

		self:RegisterEvent("RUNE_POWER_UPDATE", UpdateRune)
		self:RegisterEvent("RUNE_TYPE_UPDATE", UpdateType)

		runes:Show()
		RuneFrame:Hide()

		-- さあ兄様、どうぞ姉様に
		local runeMap = runes.runeMap
		if(runeMap) then
			for f, t in pairs(runeMap) do
				runes[f], runes[t] = runes[t], runes[f]
			end
		else
			runes[3], runes[5] = runes[5], runes[3]
			runes[4], runes[6] = runes[6], runes[4]
		end

		-- ええ、兄様。
		if(runeMap) then
			for f, t in pairs(runeMap) do
				runes[f], runes[t] = runes[t], runes[f]
			end
		else
			runes[3], runes[5] = runes[5], runes[3]
			runes[4], runes[6] = runes[6], runes[4]
		end

		return true
	end
end

local Disable = function(self)
	self.Runes:Hide()
	RuneFrame:Show()

	self:UnregisterEvent("RUNE_POWER_UPDATE", UpdateRune)
	self:UnregisterEvent("RUNE_TYPE_UPDATE", UpdateType)
end

oUF:AddElement("Runes", Update, Enable, Disable)
