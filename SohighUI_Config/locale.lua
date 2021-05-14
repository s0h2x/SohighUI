	
	--* locale config {GUI}
	
	suiLC = function(lang)
		local E, C, L, _ = SohighUI:unpack()

		--// Main //--
		if lang == 'suigui_main' then lang = L_GUI_MAIN end
		if lang == 'suigui_mainmaxUIScale' then lang = L_GUI_MAIN_UISCALE end
		if lang == 'suigui_mainrestyleUI' then lang = L_GUI_MAIN_RESTYLEUI end
		if lang == 'suigui_mainspellAnnounce' then lang = L_GUI_MAIN_ANNOUNCE end
		if lang == 'suigui_maindurability' then lang = L_GUI_MAIN_DURABILITY end
		if lang == 'suigui_mainmisc' then lang = L_GUI_MAIN_MISC end
		if lang == 'suigui_maindeclineDuel' then lang = L_GUI_MAIN_DECLINEDUEL end
		if lang == 'suigui_mainautoInvite' then lang = L_GUI_MAIN_AUTOINVITE end
		if lang == 'suigui_mainautoGreed' then lang = L_GUI_MAIN_AUTOGREED end
		if lang == 'suigui_mainautoRelease' then lang = L_GUI_MAIN_AUTORELEASE end
		if lang == 'suigui_mainautoQuest' then lang = L_GUI_MAIN_AUTOQUEST end
		if lang == 'suigui_mainautoLoot' then lang = L_GUI_MAIN_AUTOLOOT end
		if lang == 'suigui_mainautoMerchant' then lang = L_GUI_MAIN_AUTOMERCHANT end
		if lang == 'suigui_main_dpsMeter' then lang = L_GUI_MAIN_DPSMETER end
		if lang == 'suigui_main_dpsMeterLayout' then lang = L_GUI_MAIN_DPSMETERLAYOUT end
		if lang == 'suigui_main_dpsMeterTitle' then lang = L_GUI_MAIN_DPSMETERTITLE end
		if lang == 'suigui_main_dpsMeterFade' then lang = L_GUI_MAIN_DPSMETERFADE end
		if lang == 'suigui_main_dpsMeterCombat' then lang = L_GUI_MAIN_DPSMETERCOMBAT end
		if lang == 'suigui_main_dpsMeterLock' then lang = L_GUI_MAIN_DPSMETERLOCK end
		if lang == 'suigui_mainfont' then lang = L_GUI_MAIN_FONT end
		if lang == 'suigui_mainshadow' then lang = L_GUI_MAIN_SHADOW end
		if lang == 'suigui_mainfontSize' then lang = L_GUI_MAIN_FONTSIZE end
		
		if lang == 'suigui_mainw' then lang = L_GUI_MAIN_INFO1 end
		if lang == 'suigui_mainz' then lang = L_GUI_MAIN_INFO2 end
		if lang == 'suigui_mainx' then lang = L_GUI_MAIN_INFO3 end
		if lang == 'suigui_mainy' then lang = L_GUI_MAIN_INFO4 end
		
		--// Action Bar //--
		if lang == 'suigui_bar' then lang = L_GUI_AB end
		if lang == 'suigui_barenable' then lang = L_GUI_AB_ENABLE end
		if lang == 'suigui_barscale' then lang = L_GUI_AB_SCALE end
		if lang == 'suigui_barstyleAB' then lang = L_GUI_AB_STYLE end
		if lang == 'suigui_barmacroName' then lang = L_GUI_AB_MACRO end
		if lang == 'suigui_barbackground' then lang = L_GUI_AB_BACKGROUND end
		if lang == 'suigui_barstripArts' then lang = L_GUI_AB_STRIPARTS end
		if lang == 'suigui_barcaps' then lang = L_GUI_AB_ENDCAPS end
		if lang == 'suigui_bar_bpackIcon' then lang = L_GUI_AB_BPACK end
		if lang == 'suigui_bar_menuIcon' then lang = L_GUI_AB_MENU end
		
		--// Bags //--
		if lang == 'suigui_bags' then lang = L_GUI_BAGS end
		if lang == 'suigui_bagsenable' then lang = L_GUI_BAGS_ENABLE end
		if lang == 'suigui_bagsbagSize' then lang = L_GUI_BAGS_SIZE end
		if lang == 'suigui_bagsbagSpace' then lang = L_GUI_BAGS_SPACE end
		if lang == 'suigui_bagsbagColumns' then lang = L_GUI_BAGS_COLUMNS end
		if lang == 'suigui_bagsbankColumns' then lang = L_GUI_BAGS_BANKCOLUMNS end
		if lang == 'suigui_bagsw' then lang = L_GUI_BAGS_INFO1 end
		
		--// Chat //--
		if lang == 'suigui_main_chat' then lang = L_GUI_CHAT_ENABLE end
		if lang == 'suigui_main_chatOrient' then lang = L_GUI_CHAT_ORIENT end
		if lang == 'suigui_main_chatEmote' then lang = L_GUI_CHAT_EMOTE end
		if lang == 'suigui_main_chatTime' then lang = L_GUI_CHAT_TIME end
		if lang == 'suigui_main_chatTab' then lang = L_GUI_CHAT_TAB end
		if lang == 'suigui_main_chatCopy' then lang = L_GUI_CHAT_COPY end
		
		--// UF //--
		if lang == 'suigui_units' then lang = L_GUI_UNITS end
		if lang == 'suigui_unitsclassPortraits' then lang = L_GUI_UNITS_CLASSPORTRAIT end
		if lang == 'suigui_unitsunitStyleFat' then lang = L_GUI_UNITS_FAT_STYLE end
		if lang == 'suigui_unitsstatusbar' then lang = L_GUI_UNITS_STATUSBARS end
		if lang == 'suigui_unitssmoothing' then lang = L_GUI_UNITS_SMOOTH end
		if lang == 'suigui_unitsauraTimer' then lang = L_GUI_UNITS_AURATIMER end
		if lang == 'suigui_unitsauraAnchor' then lang = L_GUI_UNITS_AURAPOS end
		if lang == 'suigui_unitsauraPlayer' then lang = L_GUI_UNITS_AURASELF end
		if lang == 'suigui_unitsenchantoUF' then lang = L_GUI_UNITS_ENCHANTOUF end
		if lang == 'suigui_unitscombatText' then lang = L_GUI_UNITS_COMBATTEXT end
		if lang == 'suigui_unitsthreatGlow' then lang = L_GUI_UNITS_THREATGLOW end
		if lang == 'suigui_unitsstatusFlash' then lang = L_GUI_UNITS_STATUSFLASH end
		if lang == 'suigui_unitsstatusCombat' then lang = L_GUI_UNITS_COMBAT end
		if lang == 'suigui_unitscomboPoints' then lang = L_GUI_UNITS_COMBOPOINTS end
		if lang == 'suigui_unitscpAsNumber' then lang = L_GUI_UNITS_CPNUMBER end
		if lang == 'suigui_unitsshowParty' then lang = L_GUI_UNITS_SHOWPARTY end
		if lang == 'suigui_unitspartyInRaid' then lang = L_GUI_UNITS_PARTYRAID end
		if lang == 'suigui_unitscastbarTicks' then lang = L_GUI_UNITS_CBTICK end
		if lang == 'suigui_unitscastbarColor' then lang = L_GUI_UNITS_CBCOLORS end
		if lang == 'suigui_unitsabsorbBar' then lang = L_GUI_UNITS_ABSORB end
		if lang == 'suigui_unitshealComm' then lang = L_GUI_UNITS_HEALCOMM end
		
		if lang == 'suigui_unitsw' then lang = L_GUI_UNITS_INFO1 end
		if lang == 'suigui_unitsz' then lang = L_GUI_UNITS_INFO2 end
		if lang == 'suigui_unitsx' then lang = L_GUI_UNITS_INFO3 end
		
		--// Tip //--
		if lang == 'suigui_tooltip' then lang = L_GUI_TIP end
		if lang == 'suigui_tooltipenable' then lang = L_GUI_TIP_ENABLE end
		if lang == 'suigui_tooltipshowInCombat' then lang = L_GUI_TIP_HIDE_INCOMBAT end
		if lang == 'suigui_tooltipshowUnits' then lang = L_GUI_TIP_HIDE_UNITS end
		if lang == 'suigui_tooltipcursor' then lang = L_GUI_TIP_CURSOR end
		
		if lang == 'suigui_tooltipw' then lang = L_GUI_TIP_INFO1 end
		
		--// CombatText //--
		if lang == 'suigui_ct' then lang = L_GUI_CT end
		if lang == 'suigui_ctmoduleEnable' then lang = L_GUI_CT_ENABLE end
		if lang == 'suigui_ctshowBlizzOut' then lang = L_GUI_CT_BLIZZNUM end
		if lang == 'suigui_ctstyleDps' then lang = L_GUI_CT_DMGSTYLE end
		if lang == 'suigui_ctdps' then lang = L_GUI_CT_DAMAGE end
		if lang == 'suigui_cthealing' then lang = L_GUI_CT_HEALING end
		if lang == 'suigui_cthealingOver' then lang = L_GUI_CT_OVERHEAL end
		if lang == 'suigui_ct_petDps' then lang = L_GUI_CT_PETDMG end
		if lang == 'suigui_ct_dotDps' then lang = L_GUI_CT_DOTDMG end
		if lang == 'suigui_ct_hotDps' then lang = L_GUI_CT_HOTS end
		if lang == 'suigui_ct_colorDps' then lang = L_GUI_CT_COLORS end
		if lang == 'suigui_ctcrit_prefix' then lang = L_GUI_CT_CRITPREFIX end
		if lang == 'suigui_ctcrit_postfix' then lang = L_GUI_CT_POSTFIX end
		if lang == 'suigui_cticons' then lang = L_GUI_CT_ICONS end
		if lang == 'suigui_cticonSize' then lang = L_GUI_CT_ICONSIZE end
		if lang == 'suigui_ctthreshold' then lang = L_GUI_CT_THRESHOLD end
		if lang == 'suigui_ctheal_threshold' then lang = L_GUI_CT_HEALTHRESHOLD end
		if lang == 'suigui_ctscrollable' then lang = L_GUI_CT_SCROLLABLE end
		if lang == 'suigui_ctmax_lines' then lang = L_GUI_CT_MAXLINE end
		if lang == 'suigui_cttime_visible' then lang = L_GUI_CT_SHOWTIME end
		if lang == 'suigui_ctshowKilling' then lang = L_GUI_CT_KILLINGBLOW end
		if lang == 'suigui_ctmergeAoE' then lang = L_GUI_CT_AOESPAM end
		if lang == 'suigui_ctmergeMelee' then lang = L_GUI_CT_MELEE end
		if lang == 'suigui_ct_tellDispel' then lang = L_GUI_CT_DISPEL end
		if lang == 'suigui_ct_tellInter' then lang = L_GUI_CT_INTERRUPT end
		if lang == 'suigui_ctdirection' then lang = L_GUI_CT_DIRECTION end
		if lang == 'suigui_ctshortNum' then lang = L_GUI_CT_SHORTNUMBERS end
		
		if lang == 'suigui_ctw' then lang = L_GUI_CT_INFO1 end
		if lang == 'suigui_ctz' then lang = L_GUI_CT_INFO2 end
		if lang == 'suigui_ctx' then lang = L_GUI_CT_INFO3 end
		
		E.option = lang
	end