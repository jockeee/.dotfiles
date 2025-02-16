--
-- wezterm.lua

local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

--
-- Functions
--

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local function tab_title(tab)
  -- Prefer the title that was set via `tab:set_title()` or `wezterm cli set-tab-title`,
  local title = tab.tab_title
  if title and #title > 0 then
    return title
  end

  --- Active pane's process name
  title = basename(tab.active_pane.foreground_process_name)
  if title and #title > 0 then
    return title
  end

  -- Fallback, active pane's title
  return tab.active_pane.title
end

--
-- Events
--

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)

  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = ' '
  end

  return '  ' .. zoomed .. title
end)

wezterm.on('update-status', function(window, pane)
  local formatted = ''
  local text = ' ' .. wezterm.mux.get_active_workspace() .. ' '

  if window:leader_is_active() then
    -- wezterm.format() returns a string, not a table
    formatted = wezterm.format {
      { Foreground = { Color = '#b1b1b1' } },
      { Background = { Color = '#1f1f1f' } },
      { Text = text },
    }
  else
    -- wezterm.format() returns a string, not a table
    formatted = wezterm.format {
      { Foreground = { Color = '#7c7d83' } },
      { Background = { Color = '#1f1f1f' } },
      { Text = text },
    }
  end

  window:set_left_status(formatted)
end)

wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end

  local home = os.getenv 'HOME'

  local tab, pane, window = mux.spawn_window {
    workspace = 'home',
  }

  local tab, pane, window = mux.spawn_window {
    workspace = '.dot',
    cwd = home .. '/.dotfiles',
  }

  local tab, pane, window = mux.spawn_window {
    workspace = 'nvim',
    cwd = home .. '/.dotfiles/nvim',
  }

  local tab, pane, window = mux.spawn_window {
    workspace = 'code',
    cwd = home .. '/code',
  }

  local tab, pane, window = mux.spawn_window {
    workspace = 'pass',
    cwd = home .. '/.password-store',
  }

  -- Set a workspace for coding
  -- Top pane is for the editor, bottom pane is for the build tool
  -- local project_dir = home .. '/code'
  -- local tab, build_pane, window = mux.spawn_window {
  --   workspace = 'code',
  --   cwd = project_dir,
  --   args = args,
  -- }
  -- local editor_pane = build_pane:split {
  --   direction = 'Top',
  --   size = 0.95,
  --   cwd = project_dir,
  -- }
  -- may as well kick off a build in that pane
  -- build_pane:send_text 'air\n'

  -- We want to startup in this workspace
  mux.set_active_workspace 'home'
end)

--
-- Config
--

local config = {}
if wezterm.config_builder then
  -- Improved warning messages for configuration errors
  -- http://wezterm.org/config/lua/wezterm/config_builder.html
  config = wezterm.config_builder()
end

-- This causes `wezterm` to act as though it was started as `wezterm connect unix` by default, connecting to the unix domain on startup.
config.unix_domains = {
  {
    name = 'unix',
  },
}
config.default_gui_startup_args = { 'connect', 'unix' }

config = {
  automatically_reload_config = true,
  default_workspace = 'home',
  scrollback_lines = 3500,

  --
  -- Visual
  enable_tab_bar = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  window_decorations = 'NONE',
  window_padding = {
    left = 0, -- default: 8
    right = 0, -- default: 8
    top = 8, -- default: 8
    bottom = 0, -- default: 8
  },

  --
  -- Font
  warn_about_missing_glyphs = false,
  font_size = 14,
  line_height = 1.05,
  -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures

  --
  -- Colors
  color_scheme = 'Catppuccin Mocha',
  background = {
    {
      source = {
        Color = '#1f1f1f',
      },
      width = '100%',
      height = '100%',
    },
  },
  -- Dimming of inactive panes
  inactive_pane_hsb = {
    saturation = 1.0, -- 1.0 = keep as-is
    brightness = 1.0, -- 1.0 = keep as-is
  },
  colors = {
    tab_bar = {
      background = '#1f1f1f',
      active_tab = {
        bg_color = '#1f1f1f',
        fg_color = '#b1b1b1',
        intensity = 'Bold', -- default: Normal - Half, Normal, Bold
      },
      inactive_tab = {
        bg_color = '#1f1f1f',
        fg_color = '#7c7d83',
      },
      -- inactive_tab_hover = {
      --   bg_color = '#1f1f1f',
      --   fg_color = '#909090',
      -- },
      new_tab = {
        bg_color = '#1f1f1f',
        fg_color = '#1f1f1f',
      },
      new_tab_hover = {
        bg_color = '#1f1f1f',
        fg_color = '#909090',
      },
    },
  },
}

--
-- Keymaps
--

-- disable_default_key_bindings = true,

-- leader
config.leader = {
  key = 's',
  mods = 'CTRL',
  timeout_milliseconds = 10000, -- default: 1000
}

config.keys = {
  -- Send C-s
  { key = 's', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 's', mods = 'CTRL' } },

  -- Send C-l
  { key = 'l', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 'l', mods = 'CTRL' } },

  -- Workspaces (sessions)
  --
  -- Workspaces are used to group related terminal tabs and panes together.
  -- This is useful for organizing different tasks or projects.
  -- You can switch between workspaces to focus on different tasks without closing and reopening terminal sessions.
  --
  -- Domains represent different environments or contexts in which terminal sessions run.
  -- They can be local shells, remote SSH sessions, or other types of connections.
  -- Domains allow you to manage multiple connections and sessions within the same terminal application.
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES', fuzzy_help_text = ': ' },
  },
  {
    key = 'p',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS|DOMAINS|KEY_ASSIGNMENTS|WORKSPACES|COMMANDS', fuzzy_help_text = ': ' },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncher,
  },

  { key = 'q', mods = 'META', action = wezterm.action { SwitchToWorkspace = { name = 'home' } } },
  { key = 'w', mods = 'META', action = wezterm.action { SwitchToWorkspace = { name = '.dot' } } },
  { key = 'e', mods = 'META', action = wezterm.action { SwitchToWorkspace = { name = 'nvim' } } },
  { key = 'r', mods = 'META', action = wezterm.action { SwitchToWorkspace = { name = 'code' } } },
  { key = 't', mods = 'META', action = wezterm.action { SwitchToWorkspace = { name = 'pass' } } },

  -- Tabs (windows)
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivateLastTab },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },

  -- Panes (splits)
  { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- left to right, split along horizontal line
  { key = '"', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } }, -- top to bottom, split along vertical line
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
  {
    key = '@',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 16 },
    },
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.Multiple {
      wezterm.action.ActivatePaneDirection 'Up',
      wezterm.action.TogglePaneZoomState,
    },
  },

  -- Using smart-splits plugin instead
  -- { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
  -- { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  -- { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  -- { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },

  -- Copy mode
  { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
  { key = 'PageUp', mods = 'NONE', action = wezterm.action.ActivateCopyMode },

  -- Quick select
  { key = 'f', mods = 'LEADER', action = act.QuickSelect },
  {
    key = '/',
    mods = 'LEADER',
    action = wezterm.action.Search { Regex = '[a-f0-9]{6,}' },
  },
}

--
-- Hyperlinks
--

config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wezterm/wezterm | "wezterm/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
-- table.insert(config.hyperlink_rules, {
--   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
--   format = 'https://github.com/$1/$3',
-- })

--
-- Plugins
--

local smart_splits = wezterm.plugin.require 'https://github.com/mrjones2014/smart-splits.nvim'
smart_splits.apply_to_config(config, {
  -- Use separate direction keys for move vs. resize
  direction_keys = {
    move = { 'h', 'j', 'k', 'l' },
    resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL',
    resize = 'META',
  },
  log_level = 'info', -- info, warn, error
})

return config
