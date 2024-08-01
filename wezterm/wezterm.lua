local wezterm = require("wezterm") -- Pull in the wezterm API
local config = wezterm.config_builder() -- This will hold the configuration.

config = {
	automatically_reload_config = true,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 16,
	background = {
		{
			source = {
				Color = "#1f1f1f",
			},
			width = "100%",
			height = "100%",
		},
	},
}

return config -- return the configuration to wezterm
