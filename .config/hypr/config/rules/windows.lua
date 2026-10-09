hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- hl.window_rule({
-- 	name = "float_filemanager",
-- 	match = { title = "^(yazi|.*- Thunar)$" },
-- 	size = { "(monitor_w*0.75)", "(monitor_h*0.75)" },
-- 	opaque = true,
-- 	center = true,
-- 	float = true,
-- 	stay_focused = true,
-- })

require("config.rules.fakefullscreen")

hl.window_rule({
	name = "No_Opacity",
	match = {
		class = "(firefox|pcmanfm-qt)",
	},
	opaque = true,
})

hl.window_rule({
	name = "floater",
	match = {
		class = "(pcmanfm-qt|qtt|xdg-desktop-portal-gtk)",
	},
	opaque = true,
	float = true,
})

hl.window_rule({
	name = "float_clipmanager",
	match = { title = "^(clipse)$" },
	size = { "(monitor_w*0.35)", "(monitor_h*0.5)" },
	opaque = true,
	center = true,
	float = true,
	focus_on_activate = true,
	stay_focused = true,
	dim_around = true,
	animation = "slide top",
})

hl.window_rule({
	name = "Idle_Inhibit",
	match = { class = "firefox" },
	idle_inhibit = "fullscreen",
})

hl.window_rule({
	name = "SnailMail",
	match = { class = "org.mozilla.Thunderbird" },
	opaque = true,
	workspace = "8 silent",
})

hl.window_rule({
	name = "VoiceComms",
	match = { class = "^(teamspeak-client|Zulip|vesktop)$" },
	opaque = true,
	group = "set always",
	workspace = "9 silent",
})

hl.window_rule({
	name = "Special_Audio",
	match = { class = "^(org.rncbc.qpwgraph|jack_mixer)$" },
	opacity = "1.0 override",
	workspace = "special:audio silent",
})

--- GAMES ---

hl.window_rule({
	name = "Steam_Main",
	match = { title = "^([sS]team|Friends List|Players|Game Servers|Special Offers)$" },
	workspace = "10 silent",
})

hl.window_rule({
	name = "Steam_Alts",
	match = { title = "^(Players|Game Servers|Special Offers)$" },
	workspace = "10 silent",
	float = true,
})
hl.window_rule({
	name = "SteamGames",
	match = {
		class = "steam_app_.*",
	},
	workspace = "10 silent",
})

hl.window_rule({
	name = "Wurm_Game",
	match = {
		class = "\\(Zonric\\) Wurm Unlimited",
	},
	opaque = true,
	fullscreen = true,
})

hl.window_rule({
	name = "Wurm_Launcher",
	match = {
		class = "com.wurmonline.client.launcherfx.WurmMain",
	},
	opaque = true,
	float = true,
})
