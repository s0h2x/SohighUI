
	--* Локализация для ruRU клиента [модули]
	local E, C, L, _ = select(2, shCore()):unpack()
	if E.Region == "ruRU" then	
		--// Основные //--
		L_AddonLoaded = '|cf2f3f4ffАддон не был загружен...|r'
		L_SystemError = 'Настройки будут доступны после боя!'
		L_NotInGroup = 'Вы не в группе'
		L_MemoryClean = 'Память очищена'
		
		--// Автоматизация //--
		L_SellTrash = 'Продано %d мусора на сумму %s.'
		L_RepairBank = 'Починка за счет гильд-банка %s.'
		L_Repaired_For = 'Починка на сумму %s.'
		L_Afford_Repair = 'Ремонт вам не по карману.'
		
		--// Комбат текст //--
		L_Combattext_Unlock = '/xct unlock - передвинуть и изменить размер.'
		L_Combattext_Locked = '/xct lock - завершить изменения.'
		L_Combattext_Test = '/xct test - включить тест мод.'
		L_Combattext_Reset = '/xct reset - восстановить по умолчанию.'
		L_Combattext_Kblow = 'Killing Blow'
		L_Combattext_AlreadyUnlock = 'Комбат текст уже разблокирован.'
		L_Combattext_AlreadyLock = 'Комбат текст уже заблокирован.'
		L_Combattext_TestOff = 'Тест мод выключен.'
		L_Combattext_TestOn = 'Тест мод включен.'
		L_Combattext_Popup = 'Чтобы сохранить позицию окон, нужно перезагрузить интерфейс.'
		L_Combattext_Decline = 'Позиция окон не была сохранена, перезагрузите интерфейс.'
		L_Combattext_Unlocked = 'Комбат текст разблокирован.'

		--// Подсказки //--
		L_Tooltip_Target = '*|cffff4444Вы|r*'
		
		--// Карта //--
		L_MapCursor = 'Курсор'
		L_MapBound = 'Вне границы!'
		
		--// Чат //--
		L_ChatAFK = 'АФК'
		L_ChatDND = 'DND'
		L_ChatRW = 'РВ'
		
		--// Дополнительное //--
		L_Misc_Errors = 'Ошибок пока нет.'
		L_Misc_Invite = 'Принято приглашение от '
		L_Misc_Duel = 'Отмененный вызов на дуэль от '
		--L_Misc_Disband = 'Disbanding group...'
		L_Misc_ZoneAb = 'Низина Арати'
		L_Misc_Undress = 'Раздеть'
		
		--// Позиции //--
		L_Anchors_Unlocked = 'Фреймы разблокированы.'
		L_Anchors_Locked = 'Фреймы заблокированы, позиция сохранена.'
		L_Anchors_Infoline1 = 'Зажмите SHIFT чтобы передвинуть'
		L_Anchors_Infoline2 = 'ALT-клик чтобы сбросить позицию'
		L_Anchors_InCombat = 'Нельзя это сделать пока вы в бою.'
		
		--// Подсчет Урона xD //--
		L_DamageMeter = 'Текущий Режим: '

		--// Опции //--
		L_Castbar = 'Кастбар'
		
		--// Помощь //--
		L_SlashCmdHelp = {
			'|cffff00ffДоступные команды:|r',
			'|cffff00ff/cfg, /sui|r - |cf2f3f4ffОткрыть настройки|r |cffff00ffUI|r.',
			'|cffff00ff/clfix|r - |cf2f3f4ffСброс журнала боя.',
			'|cffff00ff/clearchat, /cc|r - |cf2f3f4ffОчистить окно чата.',
			'|cffff00ff/frame|r - |cf2f3f4ffПоказывает информацию о фрейме под курсором.',
			'|cffff00ff/fs|r - |cf2f3f4ffПоказать Framestack (Полезно для разрабов)',
			'|cffff00ff/moveui|r - |cf2f3f4ffПозволяет перемещать элементы интерфейса.',
			'|cffff00ff/rc|r - |cf2f3f4ffПроверка готовности рейда.',
			'|cffff00ff/rd|r - |cf2f3f4ffРаспустить группу/рейд.',
			'|cffff00ff/rl|r - |cf2f3f4ffПерезагрузить интерфейс.',
			'|cffff00ff/cpr, /toraid, /convert|r - |cf2f3f4ffПеревод группы в рейд.',
		}
	end