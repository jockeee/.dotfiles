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

-- Function to switch to a workspace or create it if it doesn't exist
local function switch_to_workspace_or_create(workspace, cwd)
  local current_workspace = mux.get_active_workspace()
  local all_workspaces = mux.get_workspace_names()

  if workspace == current_workspace then
    return
  end

  for _, w in ipairs(all_workspaces) do
    if w == workspace then
      mux.set_active_workspace(workspace)
      wezterm.GLOBAL.previous_workspace = current_workspace
      return
    end
  end

  -- If workspace doesn't exist, create and switch to it by spawning a new window
  mux.spawn_window {
    workspace = workspace,
    cwd = cwd,
  }
  mux.set_active_workspace(workspace)
  wezterm.GLOBAL.previous_workspace = current_workspace
end

local switch_to_previous_workspace = function(window, pane)
  local current_workspace = mux.get_active_workspace() -- window:active_workspace()
  local previous_workspace = wezterm.GLOBAL.previous_workspace

  if current_workspace == previous_workspace or wezterm.GLOBAL.previous_workspace == nil then
    return
  end

  switch_to_workspace_or_create(previous_workspace)
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
  local home = os.getenv 'HOME'

  mux.spawn_window {
    workspace = 'home',
    cwd = home,
  }

  mux.spawn_window {
    workspace = '.dot',
    cwd = home .. '/.dotfiles',
  }

  mux.spawn_window {
    workspace = 'nvim',
    cwd = home .. '/.dotfiles/nvim',
  }

  mux.spawn_window {
    workspace = 'code',
    cwd = home .. '/code',
  }

  mux.spawn_window {
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

  {
    key = 'p',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS|DOMAINS|KEY_ASSIGNMENTS|WORKSPACES|COMMANDS', fuzzy_help_text = ': ' },
  },

  -- Workspaces (sessions)
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES', fuzzy_help_text = ': ' },
  },
  { key = 'L', mods = 'LEADER', action = wezterm.action_callback(function()
    switch_to_previous_workspace()
  end) },

  -- Switch to workspace
  -- {
  --   key = 'q',
  --   mods = 'META',
  --   action = wezterm.action_callback(function()
  --     local workspace = 'home'
  --     local workspaces = mux.get_workspace_names()
  --
  --     if workspace == mux.get_active_workspace() then
  --       return
  --     end
  --
  --     for _, w in ipairs(workspaces) do
  --       if w == workspace then
  --         mux.set_active_workspace(workspace)
  --         return
  --       end
  --     end
  --
  --     local home = os.getenv 'HOME'
  --     mux.spawn_window {
  --       workspace = workspace,
  --       cwd = home,
  --     }
  --     mux.set_active_workspace(workspace)
  --   end),
  -- },
  -- { key = 'q', mods = 'META', action = act.SwitchToWorkspace { name = 'home' } },
  -- { key = 'w', mods = 'META', action = act.SwitchToWorkspace { name = '.dot' } },
  -- { key = 'e', mods = 'META', action = act.SwitchToWorkspace { name = 'nvim' } },
  -- { key = 'r', mods = 'META', action = act.SwitchToWorkspace { name = 'code' } },
  -- { key = 't', mods = 'META', action = act.SwitchToWorkspace { name = 'pass' } },

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
  { key = 'PageUp', mods = 'NONE', action = wezterm.action.ActivateCopyMode },

  -- Quick select
  { key = 'f', mods = 'LEADER', action = act.QuickSelect },
  {
    key = '/',
    mods = 'LEADER',
    action = wezterm.action.Search { Regex = '[a-f0-9]{6,}' },
  },
}

local def_workspaces = {
  q = { name = 'home', cwd = os.getenv 'HOME' },
  w = { name = '.dot', cwd = os.getenv 'HOME' .. '/.dotfiles' },
  e = { name = 'nvim', cwd = os.getenv 'HOME' .. '/.dotfiles/nvim' },
  r = { name = 'code', cwd = os.getenv 'HOME' .. '/code' },
  t = { name = 'pass', cwd = os.getenv 'HOME' .. '/.password-store' },
}

for key, ws in pairs(def_workspaces) do
  table.insert(config.keys, {
    key = key,
    mods = 'META',
    action = wezterm.action_callback(function()
      switch_to_workspace_or_create(ws.name, ws.cwd)
    end),
  })
end

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
