	
	--* GUI /* core /* credit Tukz

	local _G = _G
	local unpack, type = unpack, type
	local format, sub = string.format, string.sub
	local ceil, min, max = math.ceil, math.min, math.max
	
	local CreateFrame = CreateFrame
	local lasttab, wgr = nil, nil
	local offset = 5

	local widget_group = {
		['main'] = 1,
		['bar']	= 2,
		['units'] = 3,
		['bags'] = 4,
		['tooltip']	= 5,
		['ct'] = 6,
	}
	
	--*	__s, __o, __h, __i, __g, __h, __u, __i
	
	--* widget-data
	local function widget(text, parent)
		local E, C, L, _ = SohighUI:unpack()
		
		local __wg = CreateFrame('Button', '__wgGR_'..text, parent, 'UIPanelCloseButton')
		local label = __wg:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		label:SetFont(A.font, 16, A.fontStyle)
		label:SetText(text)
		__wg:Width(label:GetStringWidth())
		__wg:Height(label:GetStringHeight())
		__wg:SetFontString(label)
		__wg:SetHighlightTexture(A.media.highlight)
		__wg:SetNormalTexture''
		__wg:SetPushedTexture''

		return __wg
	end

	--* check tables
	local function sui__walue(group, option, __w)
		if not suiCFG then
			suiCFG = {}
		end
		if not suiCFG[group] then
			suiCFG[group] = {}
		end

		suiCFG[group][option] = __w
	end
	
	local function __wgshowGR(group, __wgGR)
		local E, C, L, _ = SohighUI:unpack()
		
		if lasttab then
			lasttab:SetText(lasttab:GetText().sub(lasttab:GetText(), 11, -3))
			lasttab:SetNormalTexture''
		end
		
		if wgr then _G['suigui_'..wgr]:Hide() end
		
		if _G['suigui_'..group] then
			local lang = 'suigui_'..group suiLC(lang)
			_G['suigui_'..group]:Show()

			--* scroll-reset
			local height = _G['suigui_' ..	group]:GetHeight()
			local max = height > 250 and height - 240 or 1
			if (max == 1) then
				_G.wgscrollScrollBar:SetValue(1)
				_G.wgscrollScrollBar:Hide()
			else
				_G.wgscrollScrollBar:SetMinMaxValues(0, max)
				_G.wgscrollScrollBar:Show()
				_G.wgscrollScrollBar:SetValue(1)
			end
			
			_G.wgscroll:SetScrollChild(_G['suigui_'..group])
			
			wgr = group
			lasttab = __wgGR
		end
	end

	local function db__style_show()
		local E, C, L, _ = SohighUI:unpack()
		
		if suigui_ then
			__wgshowGR('main')
			suigui_:Show()
			return
		end
		
		--* main
		local db__style = CreateFrame('frame', 'suigui_', UIParent)
		db__style:SetAnchor('CENTER')
		db__style:SetSize(510, 420)
		
		db__style:SetFrameStrata('DIALOG')
		db__style:SetTemplate()
		
		--* movable
		db__style:EnableMouse(true)
		db__style:SetMovable(true)
		db__style:SetClampedToScreen(true)
		db__style:SetScript('OnMouseUp', suigui_.StopMovingOrSizing)
		db__style:SetScript('OnMouseDown', function(self, b)
			if (b == 'LeftButton') then self:StartMoving() end
		end);

		--* header
		db__style.header = suigui_:CreateTexture(nil, 'ARTWORK')
		db__style.header:SetAnchor('TOP', suigui_, 0, 51)
		db__style.header:SetTexture(A.media.header)
		
		--* close
		db__style.x = CreateFrame('Button', nil, suigui_, 'UIPanelCloseButton')
		db__style.x:SetAnchor('TOPRIGHT', -6, -6)
		db__style.x:CloseTemplate()
		db__style.x:SetScript('OnClick', function() suigui_:Hide() sbx:Hide() end);
		
		--* sorted
		local function sortGroupTable(a, b)
			return widget_group[a] < widget_group[b]
		end

		local function pairsByKey(t, f)
			local a = {}
			for n in pairs(t) do
				table.insert(a, n)
			end
			table.sort(a, sortGroupTable)
			local i = 0
			local iter = function()
				i = i + 1
				if a[i] == nil then
					return nil
				else
					return a[i], t[a[i]]
				end
			end
			return iter
		end

		local GetOrderedIndex = function(t)
			local OrderedIndex = {}

			for key in pairs(t) do
				table.insert(OrderedIndex, key)
			end
			
			table.sort(OrderedIndex)
			return OrderedIndex
		end

		local OrderedNext = function(t, state)
			local Key

			if (state == nil) then
				t.OrderedIndex = GetOrderedIndex(t)
				Key = t.OrderedIndex[1]
				return Key, t[Key]
			end

			Key = nil
			for i = 1, #t.OrderedIndex do
				if (t.OrderedIndex[i] == state) then
					Key = t.OrderedIndex[i + 1]
				end
			end

			if Key then return Key, t[Key] end
			t.OrderedIndex = nil
			return
		end

		local PairsByKeys = function(t) return OrderedNext, t, nil end
		
		--* widget-group
		for group, parent in pairsByKey(widget_group) do
			local lang = 'suigui_'..group suiLC(lang)
			local __wgGR = widget(E.option, suigui_)
			__wgGR:SetSize(120, 32)
			__wgGR:SetAnchor('TOPLEFT', 15-(offset), -25)
			__wgGR:SetTextColor(.68, .68, .65)
			__wgGR:SetHighlightTextColor(1, 1, 1)
			__wgGR:SetScript('OnClick', function(self)
				__wgshowGR(group, __wgGR)
				PlaySoundFile(A.media.click)
				self:SetNormalTexture(A.media.select)
				self:SetText(format('|cff%02x%02x%02x%s|r', 255, 255, 251, E.option))
				if infobox then infobox:dummy() end
			end);
			offset = offset -75
		end
		
		local apply = widget(L_GUI_APPLY, suigui_)
		apply:SetSize(170, 32)
		apply:SetAnchor('BOTTOM', db__style, 'BOTTOM', 0, 24)
		apply:SetTextColor(.68, .68, .65)
		apply:SetHighlightTextColor(1, 1, 1)
		apply:SetNormalTexture(A.media.highlight)
		apply:SetScript('OnClick', function(self) ReloadUI() end);
		apply:Hide()
		
		--* scrollframe
		local sf = CreateFrame('ScrollFrame', 'wgscroll', db__style, 'UIPanelScrollFrameTemplate')
		sf:SetAnchor('LEFT', -4, 0)
		sf:SetAnchor('RIGHT', 4, 0)
		sf:SetAnchor('TOP', 0, -56)

		--* scrollstuff
		wgscroll:ScrollTemplate()

		--* scrollbox
		local sb = CreateFrame('Slider', 'sbx', sf)
		sb:Width(sf:GetWidth())
		sb:Height(sf:GetHeight())
		sf:SetScrollChild(sb)
		
		for group in pairs(widget_group) do
			
			--* holder
			local hf = CreateFrame('frame', 'suigui_'..group, sbx)
			hf:SetAnchor('CENTER')
			hf:Width(suigui_:GetWidth())
		
			local offset = 45
			local cb, id, str, sl = 1, 1, 1, 1
			
			for option, __w in PairsByKeys(C[group]) do
				if type(__w) == 'boolean' then
					local chbx = CreateFrame('CheckButton', 'suigui_'..group..option, hf, 'UICheckButtonTemplate')
					local lang = 'suigui_'..group..option suiLC(lang)
					chbx:SetNormalTexture(A.media.chbx)
					chbx:SetCheckedTexture(A.media.chbxCheck)
					chbx:SetChecked(__w)
					chbx:SetSize(28)
					chbx:SetScript('OnClick', function(self)
						sui__walue(group, option, (self:GetChecked() and true or false))
						PlaySoundFile(A.media.wgclick)
						apply:Show()
					end);

					if (cb > 6) then																	 --*16
						chbx:SetAnchor('TOPLEFT', hf, 'BOTTOMLEFT',((cb%2 == 0 and 12) or 60)*5, ceil(cb/6)*26 +(ceil(cb/2)-2)*34)
					else
						chbx:SetAnchor('TOPLEFT', hf, 'BOTTOMLEFT',((cb%2 == 0 and 12) or 60)*5, ceil(cb/2)*15 +(ceil(cb/2)-2)*20)
					end
					
					cb = cb+1
					offset = offset+20
					
					_G[lang..'Text']:SetText(E.option)
					_G[lang..'Text']:SetTextColor(.96, .96, .89)
					_G[lang..'Text']:SetFont(A.font, 14, A.fontStyle)
					
					--* TODO Maybe, if it's really needed...
					--[[local tip = 'suigui_'..group..option
					chbx:SetScript('OnEnter', function(self)
						tipLC(tip)
						GameTooltip:SetOwner(self, 'ANCHOR_TOPRIGHT')
						GameTooltip:SetText(E.tip, .6, .1, .2, 1, true)
						GameTooltip:Show()
					end);
					
					chbx:SetScript('OnLeave', function() GameTooltip:Hide() end);
					--]]
				elseif type(__w) == 'number' then
					local dropmenu = CreateFrame('Button', 'suigui_'..group..option, hf, 'UIDropDownMenuTemplate')
					local lang = 'suigui_'..group..option suiLC(lang)
					
					dropmenu:SetAnchor('TOPLEFT', hf, ((id%2 == 0 and 16) or 64)*5, ceil(id/2)*10 +(ceil(id/2)-7)*8)
					
					local text = dropmenu:CreateFontString(nil, 'OVERLAY')
					text:SetAnchor('CENTER', -20, 2)
					text:SetFont(A.font, 13, A.fontStyle)
					text:SetText(E.option)
					text:SetTextColor(1, 1, 1, 1)
					
					id = id+1
					
					local function list()
						local info = {}
						local n = 1
						for k, v in pairs(M.assert[option]) do
							info.text = v
							info.value = n
							info.func = function()
								UIDropDownMenu_SetSelectedID(dropmenu, this:GetID())
								C[group][option] = this:GetID()
								init__sb() init__fonts()
								sui__walue(group, option, tonumber(C[group][option]))
							end
							info.checked = nil
							info.checkable = nil
							UIDropDownMenu_AddButton(info, 1)
							n = n + 1
						end
					end
					
					UIDropDownMenu_Initialize(dropmenu, list)
					UIDropDownMenu_SetSelectedID(dropmenu, C[group][option])
				
				elseif type(__w) == 'table' then
					local slider = CreateFrame('Slider', 'suigui_'..group..option, hf, 'OptionsSliderTemplate')
					--slider:SetAnchor('TOPLEFT', hf, ((sl%2 == 0 and 16)or 65)*5, ceil(sl/2)*10 +(ceil(sl/2)-8)*8)
					
					if (sl == 2) then
						slider:SetAnchor('TOPLEFT', hf, 'BOTTOMLEFT',((sl%2 == 0 and 16) or 60)*5, ceil(sl/6)*26 +(ceil(sl/2)-5)*34)
					elseif (sl > 2) then
						slider:SetAnchor('TOPLEFT', hf, 'BOTTOMLEFT',((sl%2 == 0 and 16) or 60)*5, ceil(sl/4)*21 +(ceil(sl/2)-4)*36)
					else
						slider:SetAnchor('TOPLEFT', hf, ((sl%2 == 0 and 16)or 16)*5, ceil(sl/2)*10 +(ceil(sl/2)-8)*8)
					end
					
					local thb = slider:GetThumbTexture()
					thb:SetVertexColor(1, .3, 0)
					slider:SetThumbTexture(thb)
					slider:SetBackdrop({ bgFile = A.media.slider })
					
					local lang = 'suigui_'..group..option suiLC(lang)
					
					_G[slider:GetName()..'Text']:SetText(E.option)
					_G[slider:GetName()..'High']:SetTextColor(1, .49, .4)
					_G[slider:GetName()..'High']:SetFont(A.font, 12, A.fontStyle)
					_G[slider:GetName()..'Low']:SetFont(A.font, 12, A.fontStyle)
					_G[slider:GetName()..'Text']:SetFont(A.font, 13, A.fontStyle)

					local fw = slider:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
					fw:SetAnchor('TOP', slider, 'BOTTOM', 0, -1)
					fw:SetText(format('%.1f', C[group][option].value))
					fw:SetTextColor(1, 1, 1)
					fw:SetFont(A.font, 12, A.fontStyle)
					
					slider:SetMinMaxValues(__w.min, __w.max)
					slider:SetValueStep(__w.step)
					slider:SetValue(C[group][option].value)
					slider:SetScript('OnValueChanged', function(self)
						local sgw = slider:GetValue()
						C[group][option].value = sgw
						sui__walue(group, option, (C[group][option]))
						fw:SetText(format('%.1f', sgw))
						if (slider:IsMouseEnabled()) then
							if C['main'].fontSize then
								self:SetScript('OnUpdate', init__fonts)
								init__fonts(sgw)
							end
							if C['main'].shadow then
								self:SetScript('OnUpdate', E.SetShadowLevel)
								E.SetShadowLevel(sgw)
							end
							if C['bags'] then
								self:SetScript('OnUpdate', E.init__bags)
								E.init__bags(sgw)
							end
							if C['bar'].scale then
								self:SetScript('OnUpdate', E.SetBarScale)
								E.SetBarScale(sgw)
							end
						end
					end);
					slider:SetScript('OnMouseUp', function() apply:Show() end);
					sl = sl+1
					
				elseif type(__w) == 'string' then
					local wg_info = hf:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
					local lang = 'suigui_'..group..option suiLC(lang)
					wg_info:SetFont(A.font, 13, A.fontStyle)
					wg_info:SetText(E.option)
					wg_info:SetTextColor(1, 1, 1, .8)
					
					if (str > 1) then
						wg_info:SetAnchor('TOP', hf, 'BOTTOM', str%1 == 0 and 0, ceil(str/1)*98 + (ceil(str/1)-6)*28)
					else
						wg_info:SetAnchor('TOP', hf, 'TOP', str%2 == 0 and 0, ceil(str/2)*15 + (ceil(str/2)-12)*19)
					end

					local wg__line = hf:CreateTexture(nil, 'ARTWORK')
					wg__line:SetAnchor('CENTER', wg_info, 0, 2)
					wg__line:SetTexture(A.media.line)
					wg__line:SetVertexColor(.68, .68, .65, .4)
					
					str = str+1
				end
			end
			
			hf:Height(offset)
			hf:Hide()
		end
		
		--* welcome-info
		infobox = CreateFrame('frame', 'suigui_', sb)
		infobox:SetSize(suigui_:GetSize())
		infobox:SetAllPoints(sb)
		if infobox then info__box() else __wgshowGR('main') end
		
		table.insert(UISpecialFrames, suigui_:GetName())
		table.insert(UISpecialFrames, sbx:GetName())
	end

	do
		SLASH_CONFIG1 = '/sui'
		SLASH_CONFIG2 = '/cfg'
		function SlashCmdList.CONFIG()
			local E, C, L, _ = SohighUI:unpack()
			if InCombatLockdown() then E.Suitag(L_SYSTEM_ERROR) return end
			if not suigui_ or not suigui_:IsShown() then
				db__style_show() HideUIPanel(GameMenuFrame)
			else
				infobox:dummy() suigui_:Hide() sbx:Hide()
			end
		end
	end