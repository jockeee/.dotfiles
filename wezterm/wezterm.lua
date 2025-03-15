--
-- wezterm.lua

local wezterm = require 'wezterm'
local act = wezterm.action
local color_bg = '#1f1f1f'

local config = {}
if wezterm.config_builder then
  -- Improved warning messages for configuration errors
  -- http://wezterm.org/config/lua/wezterm/config_builder.html
  config = wezterm.config_builder()
end

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_decorations = 'NONE',
  window_padding = {
    left = 8, -- default: 8
    right = 8, -- default: 8
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
        Color = color_bg,
      },
      width = '100%',
      height = '100%',
    },
  },
}

--
-- Keymaps
--

-- config.disable_default_key_bindings = true,

-- leader
config.leader = {
  key = 'b',
  mods = 'CTRL',
  timeout_milliseconds = 10000, -- default: 1000
}

config.keys = {
  -- Send C-b
  { key = 'b', mods = 'LEADER|CTRL', action = act.SendKey { key = 'b', mods = 'CTRL' } },

  -- close pane
  -- https://wezterm.org/config/lua/config/skip_close_confirmation_for_processes_named.html
  { key = 'X', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
}

return config
