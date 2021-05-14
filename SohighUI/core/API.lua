	
	--* API
	local E, C, L, ET, _ = select(2, shCore()):unpack()

	local _G = _G
	local unpack = unpack
	local select = select
	local assert, type = assert, type
	local getmetatable = getmetatable
	
	local CreateFrame = CreateFrame
	local CreateTexture = CreateTexture
	
	E.HF = CreateFrame('frame', nil, UIParent)
	E.HF:Hide()
	
	local function dummy(object)
		if (object.UnregisterAllEvents) then
			object:UnregisterAllEvents()
			object:SetParent(E.HF)
		else
			object.Show = object.Hide
		end

		object:Hide()
	end
	
	------------------------------------------------------------------
	--							Widget API							--
	------------------------------------------------------------------
	local function GetSize(f)
		return f:GetWidth(), f:GetHeight()
	end

	local function Size(f, width, height)
		width, height = tonumber(width), tonumber(height)

		f:SetWidth(width)
		f:SetHeight(type(height) == 'number' and height or width)
	end
	
	local function SetSize(f, width, height)
		assert(width)
		f:Size(E:Scale(width), E:Scale(height or width))
	end

	local function Width(f, width)
		assert(width)
		f:SetWidth(E:Scale(width))
	end

	local function Height(f, height)
		assert(height)
		f:SetHeight(E:Scale(height))
	end
	
	local function SetAnchor(obj, arg1, arg2, arg3, arg4, arg5)
		if arg2 == nil then arg2 = obj:GetParent() end
		
		if type(arg1) == 'number' then arg1 = E:Scale(arg1) end -- point
		if type(arg2) == 'number' then arg2 = E:Scale(arg2) end -- relFrame
		if type(arg3) == 'number' then arg3 = E:Scale(arg3) end -- relPoint
		if type(arg4) == 'number' then arg4 = E:Scale(arg4) end -- xOffs
		if type(arg5) == 'number' then arg5 = E:Scale(arg5) end -- yOffs

		obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
	end
	
	local function Hook(f, scriptType, handler)
		if f:GetScript(scriptType) then
			f:HookScript(scriptType, handler)
		else
			f:SetScript(scriptType, handler)
		end
	end
	
	------------------------------------------------------------------
	--						Templates API							--
	------------------------------------------------------------------
	local function SetInside(obj, anchor, xOffset, yOffset)
		xOffset = xOffset or 2
		yOffset = yOffset or 2
		anchor = anchor or obj:GetParent()

		if obj:GetPoint() then
			obj:ClearAllPoints()
		end

		obj:SetAnchor('TOPLEFT', anchor, 'TOPLEFT', xOffset, -yOffset)
		obj:SetAnchor('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', -xOffset, yOffset)
	end
	
	local function SetOutside(obj, anchor, xOffset, yOffset)
		xOffset = xOffset or 2
		yOffset = yOffset or 2
		anchor = anchor or obj:GetParent()

		if obj:GetPoint() then
			obj:ClearAllPoints()
		end

		obj:SetAnchor('TOPLEFT', anchor, 'TOPLEFT', -xOffset, yOffset)
		obj:SetAnchor('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', xOffset, -yOffset)
	end
	
	local function StripLayout(object, dummy, alpha)
		if object:IsObjectType('Texture') then
			if dummy then
				object:dummy()
			elseif alpha then
				object:SetAlpha(0)
			else
				object:SetTexture(nil)
			end
		else
			if object.GetNumRegions then
				for i = 1, object:GetNumRegions() do
					local region = select(i, object:GetRegions())
					if region and region.IsObjectType and region:IsObjectType('Texture') then
						if dummy then
							region:dummy()
						elseif alpha then
							region:SetAlpha(0)
						else
							region:SetTexture(nil)
						end
					end
				end
			end
		end
	end

	local function ScrollTemplate(f, r)
		local sc = _G[f:GetName()..'ScrollBar']
		local st = _G[f:GetName()..'ScrollBarThumbTexture']
		local su = _G[f:GetName()..'ScrollBarScrollUpButton']
		local sd = _G[f:GetName()..'ScrollBarScrollDownButton']
		local r = sc:CreateTexture(nil, 'ARTWORK')
		
		st:SetTexture(A.media.scroll)
		st:SetVertexColor(1, 1, 1)
		st:SetSize(4, 200)
		
		su:SetNormalTexture(A.media.rolup)
		su:SetPushedTexture(A.media.rolup)
		su:SetDisabledTexture(A.media.rolup)
		su:SetHighlightTexture(A.media.rolup)
		su:SetSize(36)
		
		sd:SetNormalTexture(A.media.roldwn)
		sd:SetPushedTexture(A.media.roldwn)
		sd:SetDisabledTexture(A.media.roldwn)
		sd:SetHighlightTexture(A.media.roldwn)
		sd:SetSize(36)

		r:SetAnchor('CENTER', st, 0, 0)
		r:SetTexture(A.media.round)
		r:SetVertexColor(1, 1, 1)
		r:SetSize(26)
	end
	
	local function ShortBar(f)
		if f.sbar then return end

		local sb = _G[f:GetName()..'ThumbTexture']
		local up = _G[f:GetName()..'ScrollUpButton']
		local dn = _G[f:GetName()..'ScrollDownButton']
		
		sb:SetTexture(A.scrollShort)
		sb:SetSize(4, sb:GetHeight() +34)
		
		up:SetNormalTexture(A.media.rolup)
		up:SetPushedTexture(A.media.rolup)
		up:SetDisabledTexture(A.media.rolup)
		up:SetHighlightTexture(A.media.rolup)
		up:SetSize(24)
		
		dn:SetNormalTexture(A.media.roldwn)
		dn:SetPushedTexture(A.media.roldwn)
		dn:SetDisabledTexture(A.media.roldwn)
		dn:SetHighlightTexture(A.media.roldwn)
		dn:SetSize(24)
		
		f.sbar = sbar

		return sbar
	end
	
	local function CloseTemplate(f)
		if f.x then return end

		f:SetNormalTexture(A.media.x)
		f:SetPushedTexture(A.media.xPush)
		f:SetDisabledTexture(A.media.x)
		
		f.x = x

		return x
	end
	
	local function ButtonNextRight(f)
		if f.nextr then return end
		
		f:SetNormalTexture(A.nextr)
		f:SetPushedTexture(A.nextrPush)
		f:SetDisabledTexture(A.nextr)
		f:SetHighlightTexture(A.pushTex)
		f:SetSize(64)
		
		f.nextr = nextr

		return nextr
	end
	
	local function ButtonPrevLeft(f)
		if f.prevl then return end
		
		f:SetNormalTexture(A.prevl)
		f:SetPushedTexture(A.prevlPush)
		f:SetDisabledTexture(A.prevl)
		f:SetHighlightTexture(A.pushTex)
		f:SetSize(64)
		
		f.prevl = prevl

		return prevl
	end
	
	local function StyleButton(button, noHover, noPushed, noChecked)
		if button.SetHighlightTexture and not button.hover and not noHover then
			local hover = button:CreateTexture()
			hover:SetInside()
			hover:SetTexture(1, 1, 1, 0.3)
			button:SetHighlightTexture(hover)
			button.hover = hover
		end

		if button.SetPushedTexture and not button.pushed and not noPushed then
			local pushed = button:CreateTexture()
			pushed:SetInside()
			pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
			button:SetPushedTexture(pushed)
			button.pushed = pushed
		end

		if button.SetCheckedTexture and not button.checked and not noChecked then
			local checked = button:CreateTexture()
			checked:SetInside()
			checked:SetTexture(1, 1, 1, 0.3)
			button:SetCheckedTexture(checked)
			button.checked = checked
		end

		local cooldown = button:GetName() and _G[button:GetName()..'Cooldown']
		if cooldown then
			cooldown:ClearAllPoints()
			cooldown:SetInside()
		end
	end
	
	local function FadeIn(f)
		UIFrameFadeIn(f, 0.4, f:GetAlpha(), 1)
	end

	local function FadeOut(f)
		UIFrameFadeOut(f, 0.8, f:GetAlpha(), 0)
	end
	
	local function SetShadow(f, offset)
		if f.shadow then return end
		
		local sd = CreateFrame('frame', nil, f)
		sd.offset = offset or 0
		
		local level = f:GetFrameLevel() > 0 and f:GetFrameLevel() - 1 or 0
		
		sd:SetFrameLevel(level)
		sd:SetBackdrop({
			edgeFile = A.glow,
			edgeSize = 4,
		})
		sd:SetAnchor('TOPLEFT', f, -4 -(sd.offset), 4+(sd.offset))
		sd:SetAnchor('BOTTOMRIGHT', f, 4 +(sd.offset), -4 -(sd.offset))
		sd:SetBackdropBorderColor(0, 0, 0, 1)
		f.shadow = sd

		return sd
	end

	local function SetLayout(f, a, anchor, shadow)
		if f.bg then return end
		
		local p = anchor or f
		local bg = CreateFrame('frame', nil, f)
		local level = f:GetFrameLevel() > 0 and f:GetFrameLevel() - 1 or 0
		
		bg:SetFrameLevel(level)
		bg:SetBackdrop({
			bgFile = A.solid,
			edgeFile = A.solid,
			edgeSize = 1,
		})
		bg:SetAnchor('TOPLEFT', p, -1, 1)
		bg:SetAnchor('BOTTOMRIGHT', p, 1, -1)
		bg:SetBackdropColor(.05, .05, .05, a or .60)
		bg:SetBackdropBorderColor(0, 0, 0, 1)
		
		f.bg = bg

		return bg
	end

	local function SetGradient(f)
		if f.gr then return end
		
		local gr = f:CreateTexture(nil, 'BACKGROUND')
		gr:SetAnchor('TOPLEFT')
		gr:SetAnchor('BOTTOMRIGHT')
		gr:SetTexture(A.gradient)
		gr:SetGradientAlpha('VERTICAL', 0, 0, 0, .3, .35, .35, .35, .35)
		
		f.gr = gr
	end
	
	local function SetTemplate(f)
		f:SetBackdrop({
			bgFile = A.media.guiBackdrop,
			edgeFile = A.media.guiBorder,
			tile = false, tileSize = 0, edgeSize = 20,
			insets = { left = -32, right = -42, top = -40, bottom = -42 }
		})
		f:SetBackdropColor(unpack(A.media.guibackdropColor))
		f:SetBackdropBorderColor(unpack(A.media.guiborderColor))
	end
	
	------------------------------------------------------------------
	--					Merge our API with WoW API					--
	------------------------------------------------------------------
	local function API(object)
		local mt = getmetatable(object).__index
		if not object.dummy then mt.dummy = dummy end
		if not object.GetSize then mt.GetSize = GetSize end
		if not object.Size then mt.Size = Size end
		if not object.SetSize then mt.SetSize = SetSize end
		if not object.Width then mt.Width = Width end
		if not object.Height then mt.Height = Height end
		if not object.SetAnchor then mt.SetAnchor = SetAnchor end
		if not object.Hook then mt.Hook = Hook end
		if not object.SetLayout then mt.SetLayout = SetLayout end
		if not object.StyleButton then mt.StyleButton = StyleButton end
		if not object.SetShadow then mt.SetShadow = SetShadow end
		if not object.SetGradient then mt.SetGradient = SetGradient end
		if not object.SetOutside then mt.SetOutside = SetOutside end
		if not object.SetInside then mt.SetInside = SetInside end
		if not object.FadeIn then mt.FadeIn = FadeIn end
		if not object.FadeOut then mt.FadeOut = FadeOut end
		if not object.SetTemplate then mt.SetTemplate = SetTemplate end
		if not object.ScrollTemplate then mt.ScrollTemplate = ScrollTemplate end
		if not object.ShortBar then mt.ShortBar = ShortBar end
		if not object.ButtonNextRight then mt.ButtonNextRight = ButtonNextRight end
		if not object.ButtonPrevLeft then mt.ButtonPrevLeft = ButtonPrevLeft end
		if not object.CloseTemplate then mt.CloseTemplate = CloseTemplate end
		if not object.StripLayout then mt.StripLayout = StripLayout end
	end
	
	local handled = {['frame'] = true}
	local object = CreateFrame('frame')
	API(object)
	API(object:CreateTexture())
	API(object:CreateFontString())

	object = EnumerateFrames()
	while object do
		if not handled[object:GetObjectType()] then
			API(object)
			handled[object:GetObjectType()] = true
		end

		object = EnumerateFrames(object)
	end