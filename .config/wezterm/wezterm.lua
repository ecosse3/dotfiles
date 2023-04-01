-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Keymappings
config.keys = {
	-- Window management
	{ key = "f", mods = "CMD", action = act.MoveTabRelative(1) },
	{ key = "b", mods = "CMD", action = act.MoveTabRelative(-1) },
	{ key = "1", mods = "CMD|SHIFT", action = act.ActivateTab(0) },
	{ key = "2", mods = "CMD|SHIFT", action = act.ActivateTab(1) },
	{ key = "3", mods = "CMD|SHIFT", action = act.ActivateTab(2) },
	{ key = "4", mods = "CMD|SHIFT", action = act.ActivateTab(3) },
	{ key = "5", mods = "CMD|SHIFT", action = act.ActivateTab(4) },
	{ key = "6", mods = "CMD|SHIFT", action = act.ActivateTab(5) },
	{ key = "7", mods = "CMD|SHIFT", action = act.ActivateTab(6) },
	{ key = "8", mods = "CMD|SHIFT", action = act.ActivateTab(7) },
	{ key = "9", mods = "CMD|SHIFT", action = act.ActivateTab(8) },
	{ key = "0", mods = "CMD|SHIFT", action = act.ActivateTab(9) },

	-- Tab management
	{ key = "j", mods = "CMD", action = act.ActivateTabRelative(-1) },
	{ key = "k", mods = "CMD", action = act.ActivateTabRelative(1) },

	-- Splits
	{ mods = "CMD|SHIFT", key = "h", action = act.SplitHorizontal({ args = {} }) },
	{ mods = "CMD|SHIFT", key = "v", action = act.SplitVertical({ args = {} }) },
	{ mods = "CMD", key = "a", action = act.ActivatePaneDirection("Left") },
	{ mods = "CMD", key = "d", action = act.ActivatePaneDirection("Right") },
	{ mods = "CMD|SHIFT", key = "k", action = act.ActivatePaneDirection("Up") },
	{ mods = "CMD|SHIFT", key = "j", action = act.ActivatePaneDirection("Down") },
	{ mods = "CMD", key = "e", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Copy Mode
	{ mods = "CMD", key = "x", action = act.ActivateCopyMode },

	-- Toggle Zoom Mode
	{ mods = "CMD", key = "z", action = act.TogglePaneZoomState },

	-- Launcher
	{
		mods = "CMD",
		key = "l",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
}

-- Config options

config.enable_kitty_keyboard = true
config.tab_bar_at_bottom = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 2,
}
config.color_scheme = "Tokyo Night (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font")
config.harfbuzz_features = { "zero", "cv05", "cv02", "ss05", "ss04" }
config.font_size = 16.0
config.enable_scroll_bar = true
config.window_background_opacity = 0.90
config.hide_tab_bar_if_only_one_tab = true

config.launch_menu = {
	{
		-- Optional label to show in the launcher. If omitted, a label
		-- is derived from the `args`
		label = "Blanket Mobile",
		-- The argument array to spawn.  If omitted the default program
		-- will be used as described in the documentation above
		args = { "zsh", "-l" },
		-- You can specify an alternative current working directory;
		-- if you don't specify one then a default based on the OSC 7
		-- escape sequence will be used (see the Shell Integration
		-- docs), falling back to the home directory.
		cwd = "/Users/lukasz.kurpiewski/Projects/blanket",
		-- You can override environment variables just for this command
		-- by setting this here.  It has the same semantics as the main
		-- set_environment_variables configuration option described above
		-- set_environment_variables = { FOO = "bar" },
	},
}

wezterm.on("gui-startup", function(cmd)
	-- allow `wezterm start -- something` to affect what we spawn
	-- in our initial window
	local args = {}
	if cmd then
		args = cmd.args
	end

	local project_dir = wezterm.home_dir .. "/Projects/blanket"

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Spawns default session                                   │
	--  ╰──────────────────────────────────────────────────────────╯
	local default_tab, default_pane, default_window = mux.spawn_window({
		workspace = "default",
	})

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ Spawns "Blanket"                                         │
	--  ╰──────────────────────────────────────────────────────────╯
  -- bottom split
	local blanket_tab, blanket_pane, blanket_window = mux.spawn_window({
		workspace = "blanket",
		cwd = project_dir,
		args = args,
	})
	blanket_pane:send_text("npm start -- --reset-cache\n")

  -- top split
	local top_split = blanket_pane:split({
		direction = "Top",
		size = 0.9,
		cwd = project_dir,
	})
	top_split:send_text("nvim\n")

	--  ╭──────────────────────────────────────────────────────────╮
	--  │ nvim tab                                                 │
	--  ╰──────────────────────────────────────────────────────────╯
  -- left split
	local nvim_tab, nvim_pane = blanket_window:spawn_tab({})
	nvim_pane:send_text("wezterm cli send-text 'npm run ios && clear' && clear\n")

	-- right split
	local right_split = nvim_pane:split({
		direction = "Right",
		size = 0.5,
		cwd = project_dir,
	})
	right_split:send_text("wezterm cli send-text 'npm run android && exit' && clear\n")
  nvim_pane:activate()

	-- I want to startup in the default workspace
	mux.set_active_workspace("default")
end)

-- and finally, return the configuration to wezterm
return config
