-- main monitor (laptop)
hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@60",
	position = "0x0",
	scale = "2",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x-1080", -- external monitor at top
	scale = "1",
})
