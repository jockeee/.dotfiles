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
  font = wezterm.font('MesloLGS Nerd Font', { weight = 'Regular', stretch = 'Normal', style = 'Normal' }),
  font_size = 16,
  line_height = 1.05,
}

return config -- Return configuration to wezterm
