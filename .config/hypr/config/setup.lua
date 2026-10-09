hl.env("AQ_TRACE", "1")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRLAND_TRACE", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.config({
	input = {
		kb_model = "",
		kb_layout = "us",
		kb_variant = "",
		kb_options = "caps:escape",
		kb_rules = "",
		kb_file = "",
		numlock_by_default = true,
		follow_mouse = 2,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
			disable_while_typing = true,
		},
	},
	-- ecosystem = {
	--   enforce_permissions = true,
	-- },
})

-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|sbin|local/bin)/hyprpm", "plugin", "allow")
-- hl.permission("/usr/(bin|sbin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(bin|sbin|local/bin)/slurp", "screencopy", "allow")
-- hl.permission("/usr/(bin|sbin|local/bin)/wayfreeze", "screencopy", "allow")
