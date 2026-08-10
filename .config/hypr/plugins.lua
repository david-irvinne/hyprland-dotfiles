-- scroll overview
hl.config({
	plugin = {
		scrolloverview = {
			gesture_distance = 300, -- how far is the "max" for the gesture
			scale = 0.4, -- preferred overview scale
			workspace_gap = 100,
			layout = "vertical", -- vertical or horizontal
			wallpaper = 0, -- 0: global only, 1: per-workspace only, 2: both
			blur = false, -- blur only the main overview wallpaper

			-- shadow = {
			-- 	enabled = true,
			-- 	range = 50,
			-- },
		},
	},
})

hl.plugin.scrolloverview.gesture({ fingers = 3, mod = "SUPER", direction = "vertical" })

-- Toggle ScrollOverview with SUPER+g
hl.bind("SUPER + TAB", function()
	hl.plugin.scrolloverview.overview("toggle all")
end)
