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

--  ╭──────────────────────────────────────────────────────────╮
--  │ Keymappings                                              │
--  ╰──────────────────────────────────────────────────────────╯
config.keys = {
  -- Window management
  { mods = "CMD",       key = ".", action = act.MoveTabRelative(1) },
  { mods = "CMD",       key = ",", action = act.MoveTabRelative(-1) },
  { mods = "CMD|SHIFT", key = "1", action = act.ActivateTab(0) },
  { mods = "CMD|SHIFT", key = "2", action = act.ActivateTab(1) },
  { mods = "CMD|SHIFT", key = "3", action = act.ActivateTab(2) },
  { mods = "CMD|SHIFT", key = "4", action = act.ActivateTab(3) },
  { mods = "CMD|SHIFT", key = "5", action = act.ActivateTab(4) },
  { mods = "CMD|SHIFT", key = "6", action = act.ActivateTab(5) },
  { mods = "CMD|SHIFT", key = "7", action = act.ActivateTab(6) },
  { mods = "CMD|SHIFT", key = "8", action = act.ActivateTab(7) },
  { mods = "CMD|SHIFT", key = "9", action = act.ActivateTab(8) },
  { mods = "CMD|SHIFT", key = "0", action = act.ActivateTab(9) },

  -- Tab management
  { mods = "CMD",       key = "j", action = act.ActivateTabRelative(-1) },
  { mods = "CMD",       key = "k", action = act.ActivateTabRelative(1) },

  -- Panes
  { mods = "CMD|SHIFT", key = "h", action = act.SplitHorizontal({ args = {} }) },
  { mods = "CMD|SHIFT", key = "v", action = act.SplitVertical({ args = {} }) },
  { mods = "CMD",       key = "a", action = act.ActivatePaneDirection("Left") },
  { mods = "CMD",       key = "d", action = act.ActivatePaneDirection("Right") },
  { mods = "CMD|SHIFT", key = "k", action = act.ActivatePaneDirection("Up") },
  { mods = "CMD|SHIFT", key = "j", action = act.ActivatePaneDirection("Down") },
  { mods = "CMD",       key = "e", action = act.CloseCurrentPane({ confirm = true }) },
  { mods = "CMD",       key = "r", action = act.RotatePanes("Clockwise") },

  -- Copy Mode
  { mods = "CMD",       key = "x", action = act.ActivateCopyMode },

  -- Toggle Zoom Mode (Full Screen)
  { mods = "CMD",       key = "f", action = act.TogglePaneZoomState },

  -- Launcher
  {
    mods = "CMD",
    key = "Backspace",
    action = act.ShowLauncherArgs({
      flags = "FUZZY|WORKSPACES|LAUNCH_MENU_ITEMS",
    }),
  },

  -- Rename tab
  {
    mods = "CMD|SHIFT",
    key = "T",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, _pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- Rename workspace
  {
    mods = "CMD|SHIFT",
    key = "W",
    action = act.PromptInputLine({
      description = "Enter new name for workspace",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    }),
  },
}

--  ╭──────────────────────────────────────────────────────────╮
--  │ Config options                                           │
--  ╰──────────────────────────────────────────────────────────╯

config.enable_kitty_keyboard = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 2,
}
config.color_scheme = "Tokyo Night (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font")
config.harfbuzz_features = { "zero", "cv05", "cv02", "ss05", "ss04" }
config.font_size = 18.0
config.enable_scroll_bar = true
config.window_background_opacity = 0.90

config.launch_menu = {}

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

config.colors = {
  tab_bar = {
    background = "#1a1b26",
    active_tab = {
      bg_color = "#755E87",
      fg_color = "#c0caf5",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = "#1a1b26",
      fg_color = "#6b7089",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    inactive_tab_hover = {
      bg_color = "#1f2335",
      fg_color = "#6b7089",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    new_tab = {
      bg_color = "#1a1b26",
      fg_color = "#6b7089",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    new_tab_hover = {
      bg_color = "#1f2335",
      fg_color = "#6b7089",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
  },
}

--  ╭──────────────────────────────────────────────────────────╮
--  │ Multiplexer                                              │
--  ╰──────────────────────────────────────────────────────────╯
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
  -- right split
  local blanket_tab, blanket_pane, blanket_window = mux.spawn_window({
    workspace = "blanket",
    cwd = project_dir,
    args = args,
  })
  -- mux.rename_workspace(wezterm.mux.get_active_workspace(), "nvim")
  blanket_pane:send_text("fnm use && npm start -- --reset-cache\n")

  -- left split
  local top_split = blanket_pane:split({
    direction = "Left",
    size = 0.95,
    cwd = project_dir,
  })
  top_split:send_text("nvim\n")

  --  ╭──────────────────────────────────────────────────────────╮
  --  │   second tab                                             │
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

--  ╭──────────────────────────────────────────────────────────╮
--  │ Neovim Zen Mode Integration                              │
--  ╰──────────────────────────────────────────────────────────╯

wezterm.on('user-var-changed', function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while (number_value > 0) do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)


-- and finally, return the configuration to wezterm
-- it has to be at the end of file
return config
