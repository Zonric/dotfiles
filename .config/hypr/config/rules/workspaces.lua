hl.workspace_rule({
	workspace = "1",
	monitor = "DP-2",
	default = true,
	persistent = true,
	layout = "scrolling",
})
hl.workspace_rule({
	workspace = "2",
	monitor = "DP-2",
	persistent = true,
	layout = "scrolling",
})
hl.workspace_rule({
	workspace = "3",
	monitor = "DP-2",
	persistent = false,
	layout = "master",
})
hl.workspace_rule({
	workspace = "4",
	monitor = "DP-2",
	persistent = false,
	layout = "scrolling",
})
hl.workspace_rule({
	workspace = "6",
	monitor = "DP-1",
	default = true,
	persistent = true,
	layout = "scrolling",
	layout_opts = {
		direction = "down",
	},
})
hl.workspace_rule({
	workspace = "7",
	monitor = "DP-1",
	persistent = false,
	layout = "master",
})
hl.workspace_rule({
	workspace = "8",
	monitor = "DP-3",
	persistent = true,
	layout = "monocle",
})
hl.workspace_rule({
	workspace = "9",
	monitor = "DP-3",
	default = true,
	persistent = true,
	layout = "monocle",
})
hl.workspace_rule({
	workspace = "10",
	monitor = "DP-2",
	persistent = true,
})

hl.workspace_rule({
	workspace = "special:audio",
	layout = "master",
})
