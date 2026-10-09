hl.on("window.fullscreen", function(w)
	if w.class ~= "brave-browser" then
		return
	end
	if w.fullscreen == 2 then
		hl.dispatch(hl.dsp.window.fullscreen_state({
			internal = 0,
			client = 2,
			action = "set",
			window = w,
		}))
	end
end)
