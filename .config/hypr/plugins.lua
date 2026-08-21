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

			input = {
				touchpad_scroll_factor = 3.5,
			},

			-- shadow = {
			-- 	enabled = true,
			-- 	range = 50,touchpad_scroll_factor
			-- },
		},
	},
})
hl.plugin.scrolloverview.gesture({ fingers = 4, direction = "vertical" })
