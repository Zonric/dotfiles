local app = {
	terminal = "ghostty",
	fileMan = "ghostty --title=yazi -e yazi",
	guiFileMan = "pcmanfm-qt",
	menu = "rofi -show run",
	winsel = "rofi -show window",
	--- BROWSERS ---
	browser = "firefox",
	browser_private = "firefox --private-window",
	-- browser = "brave",
	-- browser_private = "brave --incognito",
	--
	notifyman = "swaync-client -t -sw",
	clipman = "ghostty --title=clipse -e clipse",
	colorpicker = "hyprpicker -labr --scale=8 --radius=150",
}

-- local function get_configpath(app)
-- 	local path = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
-- 	return path .. "/" .. app
-- end
-- local rofiimg = get_configpath("rofi/scripts/cliphist-rofi-img")

local MOD = "SUPER"
hl.bind(
	MOD .. " + up",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	MOD .. " + down",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

hl.bind(MOD .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MOD .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(MOD .. " + mouse:274", hl.dsp.window.pin({ window = "activewindow" }))

local real_fs = false
hl.on("window.fullscreen", function(w)
	if w.class ~= "brave-browser" then
		return
	end
	hl.timer(function()
		if real_fs then
			if w.fullscreen == 0 then
				real_fs = false
			end
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
	end, { timeout = 30, type = "oneshot" })
end)
hl.bind(MOD .. " + f", function()
	real_fs = true
	hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", window = "activewindow" }))
end)

hl.bind(MOD .. " + e", hl.dsp.exec_cmd(app.fileMan))
hl.bind(MOD .. " + g", hl.dsp.event("custom.jump"))
hl.bind(MOD .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. " + i", hl.dsp.focus({ urgent_or_last = true }))
hl.bind(MOD .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(MOD .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(MOD .. " + n", hl.dsp.exec_cmd(app.notifyman))
hl.bind(MOD .. " + p", hl.dsp.exec_cmd(app.colorpicker))
hl.bind(MOD .. " + q", hl.dsp.window.close())
hl.bind(MOD .. " + r", hl.dsp.exec_cmd(app.menu))
hl.bind(MOD .. " + v", hl.dsp.exec_cmd(app.clipman))
hl.bind(MOD .. " + w", hl.dsp.exec_cmd(app.browser))

hl.bind(MOD .. " + SHIFT + e", hl.dsp.exec_cmd(app.guiFileMan))
hl.bind(MOD .. " + SHIFT + f", hl.dsp.window.float({ action = "toggle", window = "activewindow" }))
hl.bind(MOD .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(MOD .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(MOD .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(MOD .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(MOD .. " + SHIFT + r", hl.dsp.exec_cmd(app.winsel))
hl.bind(MOD .. " + SHIFT + w", hl.dsp.exec_cmd(app.browser_private))

hl.bind(MOD .. " + backspace", hl.dsp.layout("mfact exact 0.65"))
hl.bind(MOD .. " + comma", hl.dsp.focus({ monitor = "-1" }))
hl.bind(MOD .. " + equal", hl.dsp.workspace.toggle_special("audio"))
hl.bind(MOD .. " + grave", hl.dsp.workspace.toggle_special("sysadmin"))
hl.bind(MOD .. " + minus", hl.dsp.workspace.toggle_special("math"))
hl.bind(MOD .. " + period", hl.dsp.focus({ monitor = "+1" }))
hl.bind(MOD .. " + return", hl.dsp.exec_cmd(app.terminal))
hl.bind(MOD .. " + slash", hl.dsp.layout("swapsplit"))

hl.bind(MOD .. " + SHIFT + backspace", hl.dsp.layout("mfact exact 0.5"))
hl.bind(MOD .. " + SHIFT + comma", hl.dsp.window.move({ monitor = "-1" }))
hl.bind(MOD .. " + SHIFT + equal", hl.dsp.window.move({ workspace = "special:audio", follow = false }))
hl.bind(MOD .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:sysadmin", follow = false }))
hl.bind(MOD .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:math", follow = false }))
hl.bind(MOD .. " + SHIFT + period", hl.dsp.window.move({ monitor = "+1" }))

hl.bind(MOD .. " + ALT + h", hl.dsp.window.resize({ x = -45, y = 0, relative = true }))
hl.bind(MOD .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = -45, relative = true }))
hl.bind(MOD .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = 45, relative = true }))
hl.bind(MOD .. " + ALT + l", hl.dsp.window.resize({ x = 45, y = 0, relative = true }))

hl.bind(
	MOD .. " + tab",
	hl.dsp.exec_cmd(
		"hyprctl -j activewindow | jq -e '.grouped | length > 1' > /dev/null && hyprctl dispatch 'hl.dsp.group.next({window=true})' || hyprctl dispatch 'hl.dsp.layout(\"cyclenext\")'"
	)
)

hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.scripts/wayland/screenshot.sh full"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("~/.scripts/wayland/screenshot.sh selection-anotate"))
hl.bind("Print", hl.dsp.exec_cmd("~/.scripts/wayland/screenshot.sh selection"))

-- Switch workspaces with MOD + [0-9]
-- Move active window to a workspace with MOD + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(MOD .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(MOD .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
