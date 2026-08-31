local mocha = require("mocha")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4,

		border_size = 2,

		col = {
			active_border = { colors = { mocha.blue, mocha.mauve }, angle = 45 },
			inactive_border = mocha.base,
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "scrolling",
	},

	decoration = {
		rounding = 8,
		rounding_power = 4,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		-- shadow = {
		-- 	enabled = true,
		-- 	range = 4,
		-- 	render_power = 3,
		-- 	color = 0xee1a1a1a,
		-- },

		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			new_optimizations = true,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easeOut", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.0, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.0, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3.0,
	bezier = "quick",
	style = "slidevert",
})
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 6, bezier = "easeOut" })

-- reference from looknfeel.conf
-- animation = global, 1, 10, default
-- animation = border, 1, 5.0 , easeOutQuint
-- animation = windows, 1, 4.0 , easeOutQuint
-- animation = windowsOut, 1, 1.5, linear, popin 87%
-- animation = fade, 1, 3.0, quick
-- animation = workspaces, 1, 3.5, quick, slidevert
-- animation = zoomFactor, 1, 6, easeOut  # 6ds = 600ms (not 0.6!)
