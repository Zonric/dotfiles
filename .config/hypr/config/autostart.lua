local config_dir = os.getenv("HOME")
hl.on("hyprland.start", function()
	-- DBus && Portals
	hl.exec_cmd("dbus-update-activation-environment --all")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")

	-- System services
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpaper")

	-- Utils
	hl.exec_cmd("qpwgraph")
	hl.exec_cmd("jack_mixer -c " .. config_dir .. "/.config/jack_mixer/master.xml")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("waybar")
	hl.exec_cmd("clipse -listen")

	-- Ensure my monitors are on the correct workspaces.
	hl.exec_cmd([[hyprctl dispatch 'hl.dsp.focus({monitor="DP-3", workspace="9"})']])
	hl.exec_cmd([[hyprctl dispatch 'hl.dsp.focus({monitor="DP-1", workspace="6"})']])
	hl.exec_cmd([[hyprctl dispatch 'hl.dsp.focus({monitor="DP-2", workspace="1"})']])
end)
