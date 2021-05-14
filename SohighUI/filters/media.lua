		
	--* GUI Artworks
	local E, C, _ = select(2, shCore()):unpack()

	A['media'] = {
		
		--// main
		['guiBackdrop'] = [[Interface\AddOns\SohighUI\styles\gui\main_backdrop]],
		['guiBorder'] = [[Interface\AddOns\SohighUI\styles\gui\main_border]],
		['guibackdropColor'] = { .018,.018,.015,.75},
		['guiborderColor'] = { .5, .1, .5, .6 },
		['guiInfoBoxColor'] = {.68, .68, .65, .4},
		
		--// scroll
		['scroll'] = [[Interface\AddOns\SohighUI\styles\gui\main_scroll]],
		['rolup'] = [[Interface\AddOns\SohighUI\styles\gui\main_scroll-up]],
		['roldwn'] = [[Interface\AddOns\SohighUI\styles\gui\main_scroll-down]],
		['round'] = [[Interface\AddOns\SohighUI\styles\gui\main_scroll-round]],

		--// widget
		['chbx'] = [[Interface\AddOns\SohighUI\styles\gui\main_checkbox]],
		['chbxCheck'] = [[Interface\AddOns\SohighUI\styles\gui\main_checkbox-check]],
		['header'] = [[Interface\AddOns\SohighUI\styles\gui\main_header]],
		['highlight'] = [[Interface\AddOns\SohighUI\styles\gui\main_highlight]],
		['select'] = [[Interface\AddOns\SohighUI\styles\gui\main_select]],
		['slider'] = [[Interface\AddOns\SohighUI\styles\gui\main_slider]],
		['thmb'] = [[Interface\AddOns\SohighUI\styles\gui\main_slider-thumb]],
		['x'] = [[Interface\AddOns\SohighUI\styles\gui\x]],
		['xPush'] = [[Interface\AddOns\SohighUI\styles\gui\x_push]],
		
		--// arts
		['logo'] = [[Interface\AddOns\SohighUI\styles\arts\SohighUI]],
		['line'] = [[Interface\AddOns\SohighUI\styles\gui\main_line]],
		
		--// sounds
		['click'] = [[Interface\AddOns\SohighUI\styles\sound\buttonclick.wav]],
		['wgclick'] = [[Interface\AddOns\SohighUI\styles\sound\click.wav]],
	}

	A.Media = C['ArtMedia']
