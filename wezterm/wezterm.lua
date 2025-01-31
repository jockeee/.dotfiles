local wezterm = require 'wezterm' -- Pull in the Wezterm API
local config = wezterm.config_builder() -- This will hold the configuration

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
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
  -- window_padding = {
  --   left = 0, -- default: 8
  --   right = 0, -- default: 8
  --   top = 8, -- default: 8
  --   bottom = 0, -- default: 8
  -- },
  font_size = 14,
  line_height = 1.05,
  -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
}

return config -- Return configuration to wezterm
