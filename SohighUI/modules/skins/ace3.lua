	
	local E, C, L, ET, _ = select(2, shCore()):unpack()
	if C.main.restyleUI ~= true then return end

	--*	Ace3 options skin
	
	local AceGUI = LibStub and LibStub('AceGUI-3.0', true)
	if not AceGUI then return end

	local oldRegisterAsWidget = AceGUI.RegisterAsWidget

	AceGUI.RegisterAsWidget = function(self, widget)
		local TYPE = widget.type
		if TYPE == 'CheckBox' then
			widget.checkbg:dummy()
			widget.highlight:dummy()

			if not widget.skinnedCheckBG then
				widget.skinnedCheckBG = CreateFrame('frame', nil, widget.frame)
				widget.skinnedCheckBG:SetLayout('Overlay')
				widget.skinnedCheckBG:SetAnchor('TOPLEFT', widget.checkbg, 'TOPLEFT', 4, -4)
				widget.skinnedCheckBG:SetAnchor('BOTTOMRIGHT', widget.checkbg, 'BOTTOMRIGHT', -4, 4)
			end

			if widget.skinnedCheckBG.oborder then
				widget.check:SetParent(widget.skinnedCheckBG.oborder)
			else
				widget.check:SetParent(widget.skinnedCheckBG)
			end
		elseif TYPE == 'Dropdown' then
			local frame = widget.dropdown
			local button = widget.button
			local text = widget.text
			frame:StripLayout()

			button:ClearAllPoints()
			button:SetAnchor('RIGHT', frame, 'RIGHT', -20, 0)

			button:ButtonPrevLeft()

			if not frame.bg then
				frame:SetLayout()
				frame.bg:SetAnchor('TOPLEFT', 20, -2)
				frame.bg:SetAnchor('BOTTOMRIGHT', button, 'BOTTOMRIGHT', 2, -2)
			end
			button:SetParent(frame.bg)
			text:SetParent(frame.bg)
			button:HookScript('OnClick', function(this)
				local self = this.obj
				self.pullout.frame:SetLayout()
			end)
		elseif TYPE == 'LSM30_Font' or TYPE == 'LSM30_Sound' or TYPE == 'LSM30_Border' or TYPE == 'LSM30_Background' or TYPE == 'LSM30_Statusbar' then
			local frame = widget.frame
			local button = frame.dropButton
			local text = frame.text
			frame:StripLayout()

			button:ButtonNextRight()
			frame.text:ClearAllPoints()
			frame.text:SetAnchor('RIGHT', button, 'LEFT', -2, 0)

			button:ClearAllPoints()
			button:SetAnchor('RIGHT', frame, 'RIGHT', -10, -6)

			if not frame.bg then
				frame:SetLayout()
				if TYPE == 'LSM30_Font' then
					frame.bg:SetAnchor('TOPLEFT', 20, -17)
				elseif TYPE == 'LSM30_Sound' then
					frame.bg:SetAnchor('TOPLEFT', 20, -17)
					widget.soundbutton:SetParent(frame.bg)
					widget.soundbutton:ClearAllPoints()
					widget.soundbutton:SetAnchor('LEFT', frame.bg, 'LEFT', 2, 0)
				elseif TYPE == 'LSM30_Statusbar' then
					frame.bg:SetAnchor('TOPLEFT', 20, -17)
					widget.bar:ClearAllPoints()
					widget.bar:SetAnchor('TOPLEFT', frame.bg, 'TOPLEFT', 2, -2)
					widget.bar:SetAnchor('BOTTOMRIGHT', frame.bg, 'BOTTOMRIGHT', -2, 2)
					widget.bar:SetParent(frame.bg)
				elseif TYPE == 'LSM30_Border' or TYPE == 'LSM30_Background' then
					frame.bg:SetAnchor('TOPLEFT', 42, -16)
				end

				frame.bg:SetAnchor('BOTTOMRIGHT', button, 'BOTTOMRIGHT', 2, -2)
			end
			button:SetParent(frame.bg)
			text:SetParent(frame.bg)
			button:HookScript('OnClick', function(this, button)
				local self = this.obj
				if self.dropdown then
					self.dropdown:SetLayout()
				end
			end)
		elseif TYPE == 'EditBox' then
			local frame = widget.editbox
			local button = widget.button
			_G[frame:GetName()..'Left']:dummy()
			_G[frame:GetName()..'Middle']:dummy()
			_G[frame:GetName()..'Right']:dummy()
			frame:Height(17)
			frame:CreateBackdrop('Overlay')
			frame.bg:SetAnchor('TOPLEFT', -2, 0)
			frame.bg:SetAnchor('BOTTOMRIGHT', 2, 0)
			frame.bg:SetParent(widget.frame)
			frame:SetParent(frame.bg)
			button:StyleButton()
		elseif TYPE == 'Button' then
			local frame = widget.frame
			frame:StripLayout(true)
			frame:CreateBackdrop('Overlay', true)
			frame.bg:SetAnchor('TOPLEFT', 2, -2)
			frame.bg:SetAnchor('BOTTOMRIGHT', -2, 1)
			widget.text:SetParent(frame.bg)
			frame:HookScript('OnEnter', function()
				frame.bg:SetBackdropBorderColor(E.Color.r, E.Color.g, E.Color.b)
				if frame.bg.overlay then
					frame.bg.overlay:SetVertexColor(E.Color.r, E.Color.g, E.Color.b, 0.3)
				end
			end)
			frame:HookScript('OnLeave', function()
				frame.bg:SetBackdropBorderColor(unpack(A.borderColor))
				if frame.bg.overlay then
					frame.bg.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
				end
			end)
		elseif TYPE == 'Slider' then
			local frame = widget.slider
			local editbox = widget.editbox
			local lowtext = widget.lowtext
			local hightext = widget.hightext
			local HEIGHT = 12

			frame:StripLayout()
			frame:SetLayout('Overlay')
			frame:Height(HEIGHT)
			frame:SetThumbTexture(A.solid)
			frame:GetThumbTexture():SetVertexColor(unpack(A.borderColor))
			frame:GetThumbTexture():SetSize(HEIGHT - 2, HEIGHT - 4)

			editbox:SetLayout()
			editbox:Height(15)
			editbox:SetAnchor('TOP', frame, 'BOTTOM', 0, -1)

			lowtext:SetAnchor('TOPLEFT', frame, 'BOTTOMLEFT', 2, -2)
			hightext:SetAnchor('TOPRIGHT', frame, 'BOTTOMRIGHT', -2, -2)
		end
		return oldRegisterAsWidget(self, widget)
	end

	local oldRegisterAsContainer = AceGUI.RegisterAsContainer

	AceGUI.RegisterAsContainer = function(self, widget)
		local TYPE = widget.type
		if TYPE == 'ScrollFrame' then
			local frame = widget.scrollbar
			T.SkinScrollBar(frame)
		elseif TYPE == 'InlineGroup' or TYPE == 'TreeGroup' or TYPE == 'TabGroup' or TYPE == 'SimpleGroup' or TYPE == 'Frame' or TYPE == 'DropdownGroup' then
			local frame = widget.content:GetParent()
			if TYPE == 'Frame' then
				frame:StripLayout()
				for i = 1, frame:GetNumChildren() do
					local child = select(i, frame:GetChildren())
					if child:GetObjectType() == 'Button' and child:GetText() then
						child:StyleButton()
					else
						child:StripLayout()
					end
				end
			end
			frame:SetLayout()

			if widget.treeframe then
				widget.treeframe:SetLayout()
				frame:SetAnchor('TOPLEFT', widget.treeframe, 'TOPRIGHT', 1, 0)
			end

			if TYPE == 'TabGroup' then
				local oldCreateTab = widget.CreateTab
				widget.CreateTab = function(self, id)
					local tab = oldCreateTab(self, id)
					tab:StripLayout()
					return tab
				end
			end
		end

		return oldRegisterAsContainer(self, widget)
	end