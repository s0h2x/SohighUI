	
	--* styles
	local E, C, _ = select(2, shCore()):unpack()
	
	C['Arts'] = {
		--// Font
		['font'] = [[Interface\Addons\SohighUI\styles\fonts\Expressway.ttf]],
		['fontBig'] = [[Interface\Addons\SohighUI\styles\fonts\Expressway_Rg.ttf]],
		['fontNum'] = [[Interface\Addons\SohighUI\styles\fonts\fontNumber.ttf]],
		['fontSize'] = 20,
		['fontShadow'] = {1.25, -1.25},
		['fontStyle'] = 'OUTLINE',
		['fontStyleT'] = 'THINOUTLINE',

		--// Textures
		['borderColor'] = {0, 0, 0, 1},
		['blank'] = [[Interface\AddOns\SohighUI\styles\arts\blank]],
		['glow'] = [[Interface\AddOns\SohighUI\styles\arts\glowTex]],
		['gradient'] = [[Interface\AddOns\SohighUI\styles\arts\sb\Smooth]],
		['solid'] = [[Interface\AddOns\SohighUI\styles\arts\solid]],
		['status'] = [[Interface\AddOns\SohighUI\styles\units\statusbarNealDark]],

		--// Auras
		['auraBorder'] = [[Interface\AddOns\SohighUI\styles\units\borderAura]],
		['auraShadow'] = [[Interface\AddOns\SohighUI\styles\units\borderShadow]],
		['auraNormal'] = [[Interface\AddOns\SohighUI\styles\units\borderNormal]],
		['auraWhite'] = [[Interface\AddOns\SohighUI\styles\units\borderNormalWhite]],
		['auraWatch'] = [[Interface\AddOns\SohighUI\styles\arts\auraWatch]],

		--// Layout
		['shUF'] = [[Interface\AddOns\SohighUI\styles\units\]],
		['abs'] = [[Interface\AddOns\SohighUI\styles\units\absorbTexture]],
		['abspk'] = [[Interface\AddOns\SohighUI\styles\units\absorbSpark]],
		['custom'] = [[Interface\AddOns\SohighUI\styles\units\CUSTOMPLAYER-FRAME]],
		['combat'] = [[Interface\AddOns\SohighUI\styles\units\combat]],
		['owlRotater'] = [[Interface\AddOns\SohighUI\styles\units\owlRotater]],
		['comboPoint'] = [[Interface\AddOns\SohighUI\styles\units\cp]],
		['comboPointBg'] = [[Interface\AddOns\SohighUI\styles\units\cp-bg]],
		['frameColor'] = {.21, .21, .23, 1},
		
		--// Raid
		['borderTarget'] = [[Interface\AddOns\SohighUI\styles\units\raids\borderTarget]],
		['borderIcon'] = [[Interface\AddOns\SohighUI\styles\units\raids\borderIcon]],
		['borderIndicator'] = [[Interface\AddOns\SohighUI\styles\units\raids\borderIndicator]],

		--// Template
		['nextr'] = [[Interface\AddOns\SohighUI\styles\arts\tmp\next-right]],
		['prevl'] = [[Interface\AddOns\SohighUI\styles\arts\tmp\prev-left]],
		['nextrPush'] = [[Interface\AddOns\SohighUI\styles\arts\tmp\next-right_push]],
		['prevlPush'] = [[Interface\AddOns\SohighUI\styles\arts\tmp\prev-left_push]],
		['pushTex'] = [[Interface\AddOns\SohighUI\styles\arts\tmp\push]],
		['collapse'] = [[Interface\AddOns\SohighUI\styles\arts\tmp\plus-minus]],
		['scrollShort'] = [[Interface\AddOns\SohighUI\styles\arts\tmp\scrollbar]],

		--// Arts
		['bagsTex'] = [[Interface\AddOns\SohighUI\styles\arts\bags]],
		['mapTex'] = [[Interface\AddOns\SohighUI\styles\arts\map\minimap-border]],
		['shadowBorder'] = [[Interface\AddOns\SohighUI\styles\arts\shadow]],

		--// Action Bar
		['abBackground'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_background]],
		['abTexPushed'] = [[Interface\AddOns\SohighUI\styles\arts\ab\texturePushed]],
		['abTexNormal'] = [[Interface\AddOns\SohighUI\styles\arts\ab\textureNormal]],
		['abTexHighlight'] = [[Interface\AddOns\SohighUI\styles\arts\ab\textureHighlight]],
		['abBorder'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_circle-border]],
		['abBorderglow'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_circle-glow]],
		['eCapLeftB'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_ec-left-b]],
		['eCapRightB'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_ec-right-b]],
		['eCapLeftS'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_ec-left-s]],
		['eCapRightS'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_ec-right-s]],
		['abSix'] = [[Interface\AddOns\SohighUI\styles\arts\ab\ab_sixbar]],
		['bpackTex'] = [[Interface\AddOns\SohighUI\styles\arts\ab\bpack]],
		['sAbColor'] = {0, 0, 0, .7},
		['abColor'] = {0, 0, 0, .44},

	}
	
	A = C['Arts']