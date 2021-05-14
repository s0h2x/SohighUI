	
	local E, C, _ = select(2, shCore()):unpack()

	if C['ct'].moduleEnable ~= true then return end

	--// The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
	--// Example: Blizzard -> http://www.wowhead.com/spell=42208
	--// Take the number ID at the end of the URL, and add it to the list

	--// General filter outgoing healing
	if C['ct'].healing then
		E.healfilter = {}
		-- E.healfilter[143924] = true		-- Leech
		-- E.healfilter[127802] = true		-- Touch of the Grave
		-- E.healfilter[207694] = true		-- Symbiote Strike
		-- E.healfilter[242597] = true		-- Rethu's Incessant Courage
		-- E.healfilter[241835] = true		-- Starlight of Celumbra
	end

	--// General merge outgoing damage
	if C['ct'].mergeAoE then
		E.merge = {}
		E.aoespam = {}
		E.aoespam[6603] = 3				-- Auto Attack
		-- E.aoespam[195222] = 4			-- Stormlash
		-- E.aoespam[195256] = 4			-- Stormlash
		-- E.aoespam[222197] = 0			-- Volatile Ichor (Unstable Horrorslime Trinket)
		-- E.aoespam[214350] = 3			-- Nightmare Essence (Oakheart's Gnarled Root Trinket)
		-- E.aoespam[230261] = 0			-- Flame Wreath (Aran's Relaxing Ruby Trinket)
		-- E.aoespam[221812] = 5			-- Plague Swarm (Swarming Plaguehive Trinket)
		-- E.aoespam[222711] = 4			-- Poisoned Dreams (Bough of Corruption Trinket)
		-- E.aoespam[229737] = 0			-- Solar Collapse (Fury of the Burning Sky Trinket)
		-- E.aoespam[229700] = 0			-- Orb of Destruction (Pharamere's Forbidden Grimoire Trinket)
		-- E.aoespam[225764] = 1			-- Nether Meteor (Star Gate Trinket)
		-- E.aoespam[242525] = 0.5			-- Terror From Below (Terror From Below Trinket)
		-- E.aoespam[242571] = 4			-- Spectral Bolt (Tarnished Sentinel Medallion Trinket)
		-- E.aoespam[246442] = 4			-- Spectral Blast (Tarnished Sentinel Medallion Trinket)
		-- E.aoespam[188091] = 4			-- Deadly Grace (Potion of Deadly Grace)
		-- E.aoespam[235999] = 1			-- Kil'jaeden's Burning Wish (Trinket)
		-- E.aoespam[257244] = 4			-- Worldforger's Flame (Khaz'goroth's Courage Trinket)
		-- E.aoespam[207694] = 3			-- Symbiote Strike
		-- E.aoespam[210380] = 4			-- Aura of Sacrifice
		-- E.aoespam[252907] = 5			-- Torment the Weak
		-- E.aoespam[252896] = 0.5			-- Chaotic Darkness
		-- E.aoespam[253022] = 0.5			-- Sorrow
	end

	-- Class config
	if (E.Class == 'DRUID') then
		if C['ct'].mergeAoE then
			-- Healing spells
			-- E.aoespam[774] = 4			-- Rejuvenation
			-- E.aoespam[48438] = 7		-- Wild Growth
			-- E.aoespam[8936] = 4			-- Regrowth
			-- E.aoespam[33763] = 4		-- Lifebloom
			-- E.aoespam[157982] = 3		-- Tranquility
			-- E.aoespam[81269] = 4		-- Wild Mushroom
			-- E.aoespam[124988] = 3		-- Nature's Vigil
			-- E.aoespam[144876] = 3		-- Spark of Life (T16)
			-- E.aoespam[155777] = 4		-- Rejuvenation (Germination)
			-- Damaging spells
			-- E.aoespam[213771] = 0		-- Swipe
			-- E.aoespam[192090] = 3		-- Thrash DoT
			-- E.aoespam[164812] = 3		-- Moonfire
			-- E.aoespam[164815] = 3		-- Sunfire
			-- E.aoespam[191037] = 3		-- Starfall
			-- E.aoespam[61391] = 0		-- Typhoon
			-- E.aoespam[155722] = 3		-- Rake
			-- E.aoespam[33917] = 0		-- Mangle
			-- E.aoespam[106785] = 0		-- Swipe
			-- E.aoespam[77758] = 1		-- Thrash (Bear Form)
			-- E.aoespam[106830] = 3		-- Thrash (Cat Form)
			-- E.aoespam[1079] = 3			-- Rip
			-- E.aoespam[124991] = 3		-- Nature's Vigil
			-- E.aoespam[202347] = 3		-- Stellar Flare
			-- E.aoespam[155625] = 3		-- Moonfire (Cat Form)
		end
		if C['ct'].healing then
			-- E.healfilter[145109] = true	-- Ysera's Gift (Self)
			-- E.healfilter[145110] = true	-- Ysera's Gift
			-- E.healfilter[202636] = true	-- Leader of the Pack
		end
	elseif (E.Class == 'HUNTER') then
		if C['ct'].mergeAoE then
			-- E.aoespam[2643] = 0			-- Multi-Shot
			-- E.aoespam[118253] = 3		-- Serpent Sting
			-- E.aoespam[13812] = 3		-- Explosive Trap
			-- E.aoespam[212680] = 3		-- Explosive Shot
			-- E.aoespam[118459] = 3		-- Beast Cleave
			-- E.aoespam[120361] = 3		-- Barrage
			-- E.aoespam[131900] = 3		-- A Murder of Crows
			-- E.aoespam[194599] = 3		-- Black Arrow
			-- E.aoespam[162543] = 3		-- Poisoned Ammo
			-- E.aoespam[162541] = 3		-- Incendiary Ammo
			-- E.aoespam[34655] = 3		-- Deadly Poison (Trap)
			-- E.aoespam[93433] = 3		-- Burrow Attack (Worm)
			-- E.aoespam[92380] = 3		-- Froststorm Breath (Chimaera)
			-- E.aoespam[212436] = 0.5		-- Butchery
			-- E.aoespam[194859] = 9		-- Dragonsfire Conflagration
			-- E.aoespam[194858] = 9		-- Dragonsfire Grenade
			-- E.aoespam[162487] = 6		-- Steel Trap
			-- E.aoespam[200167] = 1.5		-- Throwing Axes
			-- E.aoespam[187708] = 0.5		-- Carve
			-- E.aoespam[203413] = 5		-- Fury of the Eagle
			-- E.aoespam[203525] = 2		-- Talon Strike
			-- E.aoespam[17253] = 6		-- Bite
			-- E.aoespam[185855] = 6		-- Lacerate
			-- E.aoespam[194279] = 6		-- Caltrops
			-- E.aoespam[19434] = 1		-- Trick Shot (Aimed Shot)
			-- E.aoespam[191070] = 1		-- Call of the Hunter (Marked Shot)
			-- E.aoespam[191043] = 1		-- Legacy of the Windrunners (Aimed Shot)
			-- E.aoespam[198670] = 1		-- Piercing Shot
			-- E.aoespam[201594] = 4		-- Stampede
			-- E.aoespam[194392] = 1		-- Volley
			-- E.aoespam[214581] = 2		-- Sidewinders
			-- E.aoespam[212621] = 2		-- Marked Shot
			-- E.aoespam[191413] = 6		-- Bestial Ferocity
			-- E.aoespam[16827] = 6		-- Claw
			-- E.aoespam[201754] = 1		-- Stomp
			-- E.aoespam[63900] = 1		-- Thunderstomp
			-- E.aoespam[197465] = 1		-- Surge of the Stormgod
			-- E.aoespam[207097] = 4		-- Titan's Thunder
			-- Healing spells
			-- E.aoespam[136] = 9			-- Mend Pet
			-- E.merge[214303] = 136		-- Mend Pet (Hati)
			-- E.aoespam[197161] = 8		-- Mimiron's Shell Heal
		end
		if C['ct'].healing then
			-- E.healfilter[197205] = true	-- Spirit Bond
		end
	elseif (E.Class == 'MAGE') then
		if C['ct'].mergeAoE then
			-- E.aoespam[217694] = 3.5		-- Living Bomb
			-- E.aoespam[244813] = 3.5		-- Living Bomb
			-- E.aoespam[44461] = 3.5		-- Living Bomb (AoE)
			-- E.aoespam[2120] = 0			-- Flamestrike
			-- E.aoespam[194432] = 0		-- Aftershocks
			-- E.aoespam[12654] = 3		-- Ignite
			-- E.aoespam[31661] = 0		-- Dragon's Breath
			-- E.aoespam[190357] = 3		-- Blizzard
			-- E.aoespam[122] = 0			-- Frost Nova
			-- E.aoespam[1449] = 0			-- Arcane Explosion
			-- E.aoespam[240689] = 0		-- Time and Space
			-- E.aoespam[120] = 0			-- Cone of Cold
			-- E.aoespam[114923] = 3		-- Nether Tempest
			-- E.aoespam[114954] = 3		-- Nether Tempest (AoE)
			-- E.aoespam[7268] = 1.6		-- Arcane Missiles
			-- E.aoespam[113092] = 0		-- Frost Bomb
			-- E.aoespam[84721] = 3		-- Frozen Orb
			-- E.aoespam[228354] = 1.5		-- Flurry
			-- E.aoespam[242851] = 1.5		-- Glacial Eruption
			-- E.aoespam[228600] = 0		-- Glacial Spike
			-- E.aoespam[205021] = 2		-- Ray of Frost
			-- E.aoespam[148022] = 3		-- Icicle (Mastery)
			-- E.aoespam[31707] = 3		-- Waterbolt (Pet)
			-- E.aoespam[228598] = 0.5		-- Ice Lance
			-- E.aoespam[157981] = 0		-- Blast Wave
			-- E.aoespam[157997] = 1		-- Ice Nova
			-- E.aoespam[157980] = 1		-- Supernova
			-- E.aoespam[135029] = 3		-- Water Jet (Pet)
			-- E.aoespam[155152] = 3		-- Prismatic Crystal
			-- E.aoespam[153596] = 3		-- Comet Storm
			-- E.aoespam[153640] = 3		-- Arcane Orb
			-- E.aoespam[157977] = 0		-- Unstable Magic (Fire)
			-- E.aoespam[157978] = 0		-- Unstable Magic (Frost)
			-- E.aoespam[157979] = 0		-- Unstable Magic (Arcane)
			-- E.aoespam[153564] = 0		-- Meteor
			-- E.aoespam[155158] = 4		-- Meteor Burn
			-- E.aoespam[224637] = 1.6		-- Phoenix's Flames
			-- E.aoespam[194466] = 1.6		-- Phoenix's Flames
			-- E.aoespam[205345] = 4		-- Conflagration Flare Up
			-- E.aoespam[226757] = 4		-- Conflagration
			-- E.aoespam[198928] = 1.2		-- Cinderstorm
			-- E.aoespam[194522] = 3		-- Blast Furnace
			-- E.aoespam[194316] = 3		-- Cauterizing Blink
			-- E.aoespam[235314] = 3		-- Blazing Barrier
			-- E.aoespam[205472] = 4		-- Flame Patch
			-- E.aoespam[88084] = 3		-- Arcane Blast (Mirror Image)
			-- E.aoespam[59638] = 3		-- Frostbolt (Mirror Image)
			-- E.aoespam[88082] = 3		-- Fireball (Mirror Image)
			-- E.merge[211088] = 211076	-- Mark of Aluneth
			-- E.aoespam[211076] = 3		-- Mark of Aluneth
			-- E.merge[210817] = 44425		-- Arcane Rebound
			-- E.aoespam[44425] = 1.2		-- Arcane Barrage
		end
	elseif (E.Class == 'PALADIN') then
		if C['ct'].mergeAoE then
			-- Healing spells
			-- E.aoespam[209540] = 8		-- Light of the Titans
			-- E.aoespam[53652] = 3		-- Beacon of Light
			-- E.aoespam[85222] = 1		-- Light of Dawn
			-- E.aoespam[114163] = 3		-- Eternal Flame
			-- E.aoespam[114852] = 0		-- Holy Prism
			-- E.aoespam[119952] = 3		-- Arcing Light
			-- E.aoespam[144581] = 3		-- Blessing of the Guardians (T16)
			-- E.aoespam[210291] = 6		-- Aura of Mercy
			-- E.aoespam[183811] = 6		-- Judgment of Light
			-- E.aoespam[225311] = 1		-- Light of Dawn
			-- Damaging spells
			-- E.aoespam[205273] = 1		-- Wake of Ashes
			-- E.aoespam[198137] = 5		-- Divine Hammer
			-- E.aoespam[81297] = 3		-- Consecration
			-- E.aoespam[53385] = 0		-- Divine Storm
			-- E.aoespam[88263] = 1		-- Hammer of the Righteous
			-- E.aoespam[31935] = .5		-- Avenger's Shield
			-- E.aoespam[114871] = 0		-- Holy Prism
			-- E.aoespam[114919] = 3		-- Arcing Light
			-- E.aoespam[213757] = 3		-- Execution Sentence
			-- E.aoespam[86704] = 0		-- Ancient Fury
			-- E.aoespam[157122] = 3		-- Holy Shield
			-- E.merge[53595] = 88263		-- Hammer of the Righteous
			-- E.aoespam[209478] = 1		-- Tyr's Enforcer
			-- E.aoespam[209202] = 1		-- Eye of Tyr
			-- E.aoespam[105421] = 1		-- Blinding Light
			-- E.aoespam[204301] = 8		-- Blessed Hammer
			-- E.aoespam[224239] = 1		-- Divine Storm
			-- E.aoespam[20271] = 1		-- Judgment
			-- E.merge[228288] = 20271		-- Judgment Retribution
			-- E.aoespam[217020] = 1		-- Zeal
		end
		if C['ct'].healing then
			-- E.healfilter[204241] = true	-- Consecration
		end
	elseif (E.Class == 'PRIEST') then
		if C['ct'].mergeAoE then
			-- Healing spells
			-- E.aoespam[204883] = 1		-- Circle of Healing
			-- E.aoespam[15290] = 4		-- Vampiric Embrace
			-- E.aoespam[47750] = 3		-- Penance
			-- E.aoespam[132157] = 0		-- Holy Nova
			-- E.aoespam[139] = 3			-- Renew
			-- E.aoespam[596] = 0			-- Prayer of Healing
			-- E.aoespam[64844] = 3		-- Divine Hymn
			-- E.aoespam[32546] = 3		-- Binding Heal
			-- E.aoespam[77489] = 3		-- Echo of Light
			-- E.aoespam[33110] = 3		-- Prayer of Mending
			-- E.aoespam[34861] = 3		-- Holy Word: Sanctify
			-- E.aoespam[81751] = 3		-- Atonement
			-- E.aoespam[120692] = 3		-- Halo
			-- E.aoespam[110745] = 3		-- Divine Star
			-- E.merge[94472] = 81751		-- Atonement
			-- Damaging spells
			-- E.aoespam[205065] = 5		-- Void Torrent
			-- E.aoespam[228361] = 1		-- Void Eruption
			-- E.merge[228360] = 228361	-- Void Eruption
			-- E.aoespam[193473] = 3		-- Mind Flay (Call to the Void)
			-- E.aoespam[237388] = 3		-- Mind Flay (AoE)
			-- E.aoespam[186723] = 3		-- Penance
			-- E.merge[47666] = 186723		-- Penance
			-- E.aoespam[132157] = 0		-- Holy Nova
			-- E.aoespam[589] = 4			-- Shadow Word: Pain
			-- E.aoespam[34914] = 4		-- Vampiric Touch
			-- E.aoespam[15407] = 3		-- Mind Flay
			-- E.aoespam[14914] = 3		-- Holy Fire
			-- E.aoespam[129250] = 3		-- Power Word: Solace
			-- E.aoespam[120696] = 3		-- Halo
			-- E.aoespam[122128] = 3		-- Divine Star
			-- E.aoespam[148859] = 3		-- Shadowy Apparition
		end
		if C['ct'].healing then
			-- E.healfilter[34914] = true	-- Vampiric Touch
			-- E.healfilter[15290] = false	-- Vampiric Embrace
		end
	elseif (E.Class == 'ROGUE') then
		if C['ct'].mergeAoE then
			-- E.aoespam[51723] = 1		-- Fan of Knives
			-- E.aoespam[2818] = 5			-- Deadly Poison
			-- E.aoespam[185311] = 3		-- Crimson Vial
			-- E.aoespam[192380] = 1		-- Poison Knives
			-- E.aoespam[192434] = 5		-- From the Shadows
			-- E.aoespam[192660] = 3.5		-- Poison Bomb
			-- E.aoespam[121473] = 4		-- Shadow Blade
			-- E.merge[121474] = 121473	-- Shadow Blade Off-Hand
			-- E.aoespam[197800] = 1		-- Shadow Nova
			-- E.aoespam[197611] = 1		-- Second Shuriken
			-- E.aoespam[197835] = 1		-- Shuriken Storm
			-- E.aoespam[195452] = 3		-- Nightblade
			-- E.aoespam[209783] = 0.5		-- Goremaw's Bite
			-- E.merge[209784] = 209783	-- Goremaw's Bite Off-Hand
			-- E.aoespam[192760] = 0.5		-- Kingsbane
			-- E.merge[222062] = 192760	-- Kingsbane Off-Hand
			-- E.aoespam[192759] = 5		-- Kingsbane DoT
			-- E.aoespam[703] = 5			-- Garrote
			-- E.aoespam[8680] = 3			-- Wound Poison
			-- E.aoespam[22482] = 3		-- Blade Flurry
			-- E.aoespam[16511] = 3		-- Hemorrhage
			-- E.aoespam[5374] = 0			-- Mutilate
			-- E.aoespam[86392] = 3		-- Main Gauche
			-- E.aoespam[57841] = 3		-- Killing Spree
			-- E.aoespam[1943] = 5			-- Rupture
			-- E.aoespam[152150] = 3		-- Death from Above
			-- E.aoespam[114014] = 3		-- Shuriken Toss
			-- E.aoespam[114014] = 3		-- Shuriken Toss
			-- E.merge[27576] = 5374		-- Mutilate Off-Hand
			-- E.merge[113780] = 2818		-- Deadly Poison
			-- E.merge[57842] = 57841		-- Killing Spree Off-Hand
		end
	elseif (E.Class == 'SHAMAN') then
		if C['ct'].mergeAoE then
			-- Healing spells
			-- E.aoespam[215871] = 6		-- Rainfall
			-- E.aoespam[73921] = 5		-- Healing Rain
			-- E.aoespam[52042] = 5		-- Healing Stream Totem
			-- E.aoespam[1064] = 3			-- Chain Heal
			-- E.aoespam[61295] = 6		-- Riptide
			-- E.aoespam[98021] = 3		-- Spirit Link
			-- E.aoespam[114911] = 3		-- Ancestral Guidance
			-- E.aoespam[114942] = 3		-- Healing Tide
			-- E.aoespam[114083] = 3		-- Restorative Mists
			-- E.aoespam[157503] = 1		-- Cloudburst
			-- E.aoespam[209069] = 6		-- Tidal Totem
			-- E.aoespam[208899] = 6		-- Queen's Decree
			-- E.aoespam[207778] = 1		-- Gift of the Queen
			-- Damaging spells
			-- E.aoespam[191726] = 4		-- Lightning Blast
			-- E.aoespam[197568] = 4		-- Lightning Rod
			-- E.aoespam[197568] = 4		-- Lightning Rod
			-- E.aoespam[205533] = 7		-- Volcanic Inferno
			-- E.aoespam[198485] = 3		-- Thunder Bite
			-- E.aoespam[198483] = 1		-- Snowstorm
			-- E.aoespam[224125] = 4		-- Fiery Jaws
			-- E.aoespam[198480] = 1		-- Fire Nova
			-- E.aoespam[199116] = 4		-- Doom Vortex
			-- E.aoespam[421] = 1			-- Chain Lightning
			-- E.merge[45297] = 421		-- Chain Lightning Overload
			-- E.aoespam[8349] = 0			-- Fire Nova
			-- E.aoespam[77478] = 3		-- Earhquake
			-- E.aoespam[51490] = 0		-- Thunderstorm
			-- E.aoespam[8187] = 3			-- Magma Totem
			-- E.aoespam[188389] = 4		-- Flame Shock
			-- E.aoespam[25504] = 3		-- Windfury Attack
			-- E.aoespam[10444] = 3		-- Flametongue Attack
			-- E.aoespam[3606] = 3			-- Searing Bolt
			-- E.aoespam[170379] = 3		-- Molten Earth
			-- E.aoespam[114074] = 1		-- Lava Beam
			-- E.aoespam[32175] = 0		-- Stormstrike
			-- E.merge[32176] = 32175		-- Stormstrike Off-Hand
			-- E.aoespam[114089] = 3		-- Windlash
			-- E.merge[114093] = 114089	-- Windlash Off-Hand
			-- E.aoespam[115357] = 0		-- Windstrike
			-- E.merge[115360] = 115357	-- Windstrike Off-Hand
			-- E.aoespam[192231] = 3		-- Liquid Magma
			-- E.aoespam[157331] = 3		-- Wind Gust
			-- E.aoespam[197385] = 6		-- Fury of Air
			-- E.aoespam[210801] = 6		-- Crashing Storm
			-- E.aoespam[210854] = 4		-- Hailstorm
			-- E.aoespam[187874] = 1		-- Crash Lightning
			-- E.aoespam[195592] = 1		-- Crash Lightning
		end
	elseif (E.Class == 'WARLOCK') then
		if C['ct'].mergeAoE then
			-- E.aoespam[234153] = 5		-- Drain Life
			-- E.aoespam[196657] = 5		-- Shadow Bolt (Dimensional Rift)
			-- E.aoespam[187394] = 5		-- Chaos Barrage (Dimensional Rift)
			-- E.aoespam[243050] = 5		-- Searing Bolt (Dimensional Rift)
			-- E.aoespam[196100] = 1		-- Demonic Power
			-- E.aoespam[196448] = 3		-- Channel Demonfire
			-- E.aoespam[199581] = 1		-- Soul Flame
			-- E.aoespam[29722] = 1		-- Incinirate (Fire and Brimstone)
			-- E.aoespam[27243] = 3		-- Seed of Corruption
			-- E.aoespam[27285] = 3		-- Seed of Corruption (AoE)
			-- E.aoespam[146739] = 3		-- Corruption
			-- E.aoespam[233490] = 3		-- Unstable Affliction
			-- E.merge[233496] = 233490	-- Unstable Affliction 2nd
			-- E.merge[233497] = 233490	-- Unstable Affliction 3rd
			-- E.merge[233498] = 233490	-- Unstable Affliction 4th
			-- E.merge[233499] = 233490	-- Unstable Affliction 5th
			-- E.aoespam[348] = 3			-- Immolate
			-- E.aoespam[980] = 3			-- Agony
			-- E.aoespam[63106] = 3		-- Siphon Life
			-- E.aoespam[205246] = 3		-- Phantom Singularity
			-- E.aoespam[80240] = 3		-- Havoc
			-- E.aoespam[42223] = 3		-- Rain of Fire
			-- E.aoespam[198590] = 3		-- Drain Soul
			-- E.aoespam[86040] = 3		-- Hand of Gul'dan
			-- E.aoespam[205181] = 3		-- Shadowflame
			-- E.aoespam[30213] = 3		-- Legion Strike (Felguard)
			-- E.aoespam[89753] = 3		-- Felstorm (Felguard)
			-- E.aoespam[20153] = 3		-- Immolation (Infrenal)
			-- E.aoespam[22703] = 0		-- Infernal Awakening
			-- E.aoespam[171017] = 0		-- Meteor Strike (Infrenal)
			-- E.aoespam[104318] = 3		-- Fel Firebolt
			-- E.aoespam[3110] = 3			-- Firebolt (Imp)
			-- E.aoespam[152108] = 1		-- Cataclysm
			-- E.aoespam[171018] = 1		-- Meteor Strike
			-- E.aoespam[85692] = 3		-- Doom Bolt (Doomguard)
			-- E.aoespam[54049] = 3		-- Shadow Bite (Felhunter)
			-- E.aoespam[6262] = 3			-- Healthstone
			-- E.aoespam[3716] = 3			-- Torment (Voidwalker)
			-- E.merge[157736] = 348		-- Immolate (DoT)
		end
		if C['ct'].healing then
			-- E.healfilter[198590] = true	-- Drain Soul
			-- E.healfilter[205246] = true	-- Phantom Singularity
			-- E.healfilter[63106] = true	-- Siphon Life
			-- E.healfilter[108359] = true	-- Dark Regeneration
		end
	elseif (E.Class == 'WARRIOR') then
		if C['ct'].mergeAoE then
			-- E.aoespam[209577] = 1		-- Warbreaker (Arms Artifact)
			-- E.aoespam[215537] = 4		-- Trauma (Arms Talent)
			-- E.aoespam[209933] = 1		-- Touch of Zakajz (Arms Artifact)
			-- E.merge[224253] = 163201	-- Execute (for Arms Talent Sweeping Strikes)
			-- E.aoespam[163201] = 0.5		-- Execute (for Arms Talent Sweeping Strikes)
			-- E.aoespam[12294] = 0.5		-- Mortal Strike (for Arms Talent Sweeping Strikes)
			-- E.merge[199658] = 199850	-- Whirlwind Arms ?
			-- E.aoespam[199850] = 1.5		-- Whirlwind Arms
			-- E.aoespam[203526] = 3		-- Neltharion's Fury
			-- E.aoespam[218617] = 2		-- Rampage
			-- E.merge[184707] = 218617	-- Rampage 2nd
			-- E.merge[184709] = 218617	-- Rampage 3rd
			-- E.merge[201364] = 218617	-- Rampage 4th
			-- E.merge[201363] = 218617	-- Rampage 5th
			-- E.aoespam[199667] = 1.5		-- Whirlwind Fury
			-- E.merge[44949] = 199667		-- Whirlwind Fury Off-Hand
			-- E.aoespam[46968] = 0		-- Shockwave
			-- E.aoespam[6343] = 0			-- Thunder Clap
			-- E.aoespam[1680] = 0			-- Whirlwind
			-- E.aoespam[115767] = 3		-- Deep Wounds
			-- E.aoespam[50622] = 3		-- Bladestorm
			-- E.aoespam[52174] = 0		-- Heroic Leap
			-- E.aoespam[118000] = 0		-- Dragon Roar
			-- E.aoespam[203178] = 3		-- Opportunity Strike
			-- E.aoespam[113344] = 3		-- Bloodbath
			-- E.aoespam[96103] = 0.5		-- Raging Blow
			-- E.aoespam[6572] = 0			-- Revenge
			-- E.aoespam[5308] = 0			-- Execute
			-- E.aoespam[772] = 3			-- Rend
			-- E.aoespam[156287] = 3		-- Ravager
			-- E.aoespam[23881] = 0		-- Bloodthirst
			-- E.aoespam[205546] = 2		-- Odyn's Fury
			-- E.aoespam[243228] = 2		-- Odyn's Fury
			-- E.merge[205547] = 205546	-- Odyn's Fury
			-- E.merge[85384] = 96103		-- Raging Blow Off-Hand
			-- E.merge[95738] = 50622		-- Bladestorm Off-Hand
			-- E.merge[163558] = 5308		-- Execute Off-Hand
		end
		if C['ct'].healing then
			-- E.healfilter[117313] = true	-- Bloodthirst Heal
		end
	end
