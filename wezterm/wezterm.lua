--
-- wezterm.lua

-- TODO: sessionizer

local wezterm = require 'wezterm'
local act = wezterm.action

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

  return '   ' .. zoomed .. title
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

--
-- Config
--

local config = {}
if wezterm.config_builder then
  -- Improved warning messages for configuration errors
  -- http://wezterm.org/config/lua/wezterm/config_builder.html
  config = wezterm.config_builder()
end

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
  -- Disable dimming of inactive panes
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
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

  --
  -- Keymaps

  -- disable_default_key_bindings = true,

  -- leader
  leader = {
    key = 's',
    mods = 'CTRL',
    timeout_milliseconds = 10000, -- default: 1000
  },

  keys = {
    -- Send C-s
    { key = 's', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 's', mods = 'CTRL' } },

    -- Workspaces (sessions)
    { key = 'w', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' } },

    -- Tabs (windows)
    { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'l', mods = 'LEADER', action = wezterm.action.ActivateLastTab },
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },

    -- Panes (splits)
    { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- left to right, split along horizontal line
    { key = '"', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } }, -- top to bottom, split along vertical line
    { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },

    -- Using smart-splits plugin for this
    -- { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
    -- { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
    -- { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
    -- { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },

    -- Copy mode
    { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
    {
      key = 'PageUp',
      mods = 'NONE',
      action = wezterm.action.Multiple {
        wezterm.action.CopyMode 'ClearPattern',
        wezterm.action.ActivateCopyMode,
      },
    },

    -- Quick select
    { key = 'f', mods = 'LEADER', action = act.QuickSelect },
    {
      key = '/',
      mods = 'LEADER',
      action = wezterm.action.Search { Regex = '[a-f0-9]{6,}' },
    },
  },
}

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
