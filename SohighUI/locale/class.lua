	
	--* Localized class names.  Index == enUS, value == localized
	local E, C, L, _ = select(2, shCore()):unpack()
	
	function LocalizedClassNames()
		local locale = E.Region
		local classnames = locale == "deDE" and {
				["Warlock"] = "Hexenmeister",
				["Warrior"] = "Krieger",
				["Hunter"] = "Jäger",
				["Mage"] = "Magier",
				["Priest"] = "Priester",
				["Druid"] = "Druide",
				["Paladin"] = "Paladin",
				["Shaman"] = "Schamane",
				["Rogue"] = "Schurke",
		} or locale == "frFR" and {
				["Warlock"] = "D\195\169moniste",
				["Warrior"] = "Guerrier",
				["Hunter"] = "Chasseur",
				["Mage"] = "Mage",
				["Priest"] = "Pr\195\170tre",
				["Druid"] = "Druide",
				["Paladin"] = "Paladin",
				["Shaman"] = "Chaman",
				["Rogue"] = "Voleur",
		} or {
				["Warlock"] = "Warlock",
				["Warrior"] = "Warrior",
				["Hunter"] = "Hunter",
				["Mage"] = "Mage",
				["Priest"] = "Priest",
				["Druid"] = "Druid",
				["Paladin"] = "Paladin",
				["Shaman"] = "Shaman",
				["Rogue"] = "Rogue",
		}
	end