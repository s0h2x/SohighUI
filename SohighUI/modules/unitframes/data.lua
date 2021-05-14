	
	--* frame data
	
	local E, C, _ = select(2, shCore()):unpack()
	
	local ns = oUF
	local oUF = ns.oUF or _G.oUF
	local pathFat = A.shUF..[[fat\]]
	local pathNormal = A.shUF..[[normal\]]
	
	ns.__dn = {
		targetTexture = {
			elite = pathNormal .. 'Target-Elite',
			rareelite = pathNormal ..  'Target-Rare-Elite',
			rare = pathNormal ..  'Target-Rare',
			worldboss = pathNormal ..  'Target-Elite',
			normal = pathNormal ..	'Target',
		},
		player = {
			siz = { w = 175, h = 42	},
			tex = { w = 232, h = 100, x = -20,  y = -7,  t = pathNormal..'Target', c = {1, 0.09375, 0, 0.78125}},
			hpb = { w = 118, h = 19,  x = 50,   y = 16,  },
			hpt = {                   x = 0,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 118, h = 20,  x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			nam = { w = 110, h = 10,  x = 0,    y = 17,  j = 'CENTER', s = 14 },
			por = { w = 64,  h = 64,  x = -41,  y = 6,   },
			glo = { w = 242, h = 92,  x = 13,   y = 0,   t = pathNormal..'Target-Flash', c = {0.945, 0, 0, 0.182}},
		},
		target = { --* & focus
			siz = { w = 175, h = 42	},
			tex = { w = 230, h = 100, x = 20,   y = -7,  t = pathNormal..'Target', c = {0.09375, 1, 0, 0.78125}},
			hpb = { w = 118, h = 19,  x = -50,  y = 16,  },
			hpt = {                   x = 0,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 118, h = 20,  x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			nam = { w = 110, h = 10,  x = 0,    y = 17,  j = 'CENTER', s = 14 },
			por = { w = 64,  h = 64,  x = 41,   y = 6,   },
			glo = { w = 239, h = 94,  x = -24,  y = 1,   t = pathNormal..'Target-Flash', c = {0, 0.945, 0, 0.182}},
		},
		targettarget = { --* & focus target
			siz = { w = 85,  h = 20   },
			tex = { w = 128, h = 64,  x = 16,   y = -10, t = pathNormal..'TargetOfTarget', c = {0, 1, 0, 1}},
			hpb = { w = 43,  h = 6,   x = 2,    y = 14,  },
			hpt = {                   x = -4,   y = -3,  j = 'CENTER', s = 12 },
			mpb = { w = 37,  h = 7,   x = -1,   y = 0,   },
			-----------------------------------------------
			nam = { w = 65,  h = 10,  x = 11,   y = -18, j = 'LEFT',   s = 13 },
			por = { w = 40,  h = 40,  x = -40,  y = 10,  },
			------------------------------------------------
		},
		pet = {
			siz = { w = 110, h = 37   },
			tex = { w = 128, h = 64,  x = 4,    y = -10, t = pathNormal..'Pet', c = {0, 1, 0, 1}},
			hpb = { w = 69,  h = 8,   x = 16,   y = 7,   },
			hpt = {                   x = 1,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 69,  h = 8,   x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			--nam = { w = 110, h = 10,  x = 20,   y = 15,  j = 'LEFT',   s = 14 },
			por = { w = 37,  h = 37,  x = -41,  y = 10,  },
			glo = { w = 128, h = 64,  x = -4,   y = 12,  t = pathNormal..'Party-Flash', c = {0, 1, 1, 0}},
		},
		party = {
			siz = { w = 115, h = 35   },
			tex = { w = 128, h = 64,  x = 2,    y = -16, t = pathNormal..'Party', c = {0, 1, 0, 1}},
			hpb = { w = 69,  h = 7,   x = 17,   y = 17,  },
			hpt = {                   x = 1,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 70,  h = 7,   x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = -2,  j = 'CENTER', s = 12 },
			nam = { w = 110, h = 10,  x = 0,    y = 15,  j = 'CENTER', s = 14 },
			por = { w = 37,  h = 37,  x = -39,  y = 7,   },
			glo = { w = 128, h = 63,  x = -3,   y = 4,   t = pathNormal..'Party-Flash', c = {0, 1, 0, 1}},
		},
		boss = {
			siz = { w = 132, h = 46   },
			tex = { w = 250, h = 129, x = 31,   y = -24, t = pathNormal..'Boss', c = {0, 1, 0, 1}},
			hpb = { w = 115, h = 9,   x = -38,  y = 17,  },
			hpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			mpb = { w = 115, h = 8,   x = 0,    y = -3,  },
			mpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			nam = { w = 110, h = 10,  x = 0,    y = 16,  j = 'CENTER', s = 14 },
			------------------------------------------------
			glo = { w = 241, h = 100, x = -2,   y = 3,   t = pathNormal..'Boss-Flash', c = {0.0, 0.945, 0.0, 0.73125}},
		},
	}

	ns.__db = {		
		targetTexture = {
			elite = pathFat .. 'Target-Elite',
			rareelite = pathFat ..  'Target-Rare-Elite',
			rare = pathFat ..  'Target-Rare',
			worldboss = pathFat ..  'Target-Elite',
			normal = pathFat ..  'Target',
		},
		player = {
			siz = { w = 175, h = 42   },
			tex = { w = 232, h = 100, x = -20,  y = -7,  t = pathFat..'Target', c = {1, 0.09375, 0, 0.78125}},
			hpb = { w = 118, h = 26,  x = 50,   y = 13,  },
			hpt = {                   x = 0,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 118, h = 14,  x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			nam = { w = 110, h = 10,  x = 0,    y = 19,  j = 'CENTER', s = 14 },
			por = { w = 64,  h = 64,  x = -42,  y = 7,   },
			glo = { w = 242, h = 92,  x = 13,   y = -1,  t = pathFat..'Target-Flash', c = {0.945, 0, 0, 0.182}},
		},
		target = {
			siz = { w = 175, h = 42   },
			tex = { w = 230, h = 100, x = 20,   y = -7,  t = pathFat..'Target', c = {0.09375, 1, 0, 0.78125}},
			hpb = { w = 118, h = 26,  x = -50,  y = 13,  },
			hpt = {                   x = 0,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 118, h = 14,  x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			nam = { w = 110, h = 10,  x = 0,    y = 18,  j = 'CENTER', s = 14 },
			por = { w = 64,  h = 64,  x = 41,   y = 6,   },
			glo = { w = 239, h = 94,  x = -24,  y = 1,   t = pathNormal..'Target-Flash', c = {0, 0.945, 0, 0.182}},
		},
		targettarget = ns.__dn.targettarget, --* same for now
		pet = {
			siz = { w = 110, h = 37   },
			tex = { w = 128, h = 64,  x = 4,    y = -10, t = pathFat..'Pet', c = {0, 1, 0, 1}},
			hpb = { w = 69,  h = 12,  x = 16,   y = 9,   },
			hpt = {                   x = 1,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 69,  h = 8,   x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = 0,   j = 'CENTER', s = 13 },
			--nam = { w = 110, h = 10,  x = 20,   y = 15,  j = 'LEFT',   s = 14 },
			por = { w = 37,  h = 37,  x = -41,  y = 10,  },
			glo = { w = 128, h = 64,  x = -4,   y = 12,  t = pathFat..'Party-Flash', c = {0, 1, 1, 0}},
		},
		party = {
			siz = { w = 115, h = 35   },
			tex = { w = 128, h = 64,  x = 2,    y = -16, t = pathFat..'Party', c = {0, 1, 0, 1}},
			hpb = { w = 69,  h = 12,  x = 17,   y = 15,  },
			hpt = {                   x = 0,    y = 1,   j = 'CENTER', s = 13 },
			mpb = { w = 70,  h = 7,   x = 0,    y = 0,   },
			mpt = {                   x = 0,    y = -1,	 j = 'CENTER', s = 12 },
			nam = { w = 110, h = 10,  x = 0,    y = 15,  j = 'CENTER', s = 14 },
			por = { w = 37,  h = 37,  x = -39,  y = 7,   },
			glo = { w = 128, h = 63,  x = -3,   y = 4,   t = pathFat..'Party-Flash', c = {0, 1, 0, 1}},
		},
		boss = ns.__dn.boss,
	}