-- main monitor (laptop)
hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@60",
	position = "0x0",
	scale = "2",
})

-- use this to mirror from laptop, adjust the resolution
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	mirror = "eDP-1",
})
