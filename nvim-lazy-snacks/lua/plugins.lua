--
-- plugins.lua

return {
  -- Lua
  require 'plugins.plenary', -- lua functions that many plugins use

  -- Colorscheme
  require 'plugins.colorscheme.nordic',

  -- Multipurpose
  require 'plugins.mini',
  require 'plugins.snacks',

  -- Functionality
  require 'plugins.auto-session', -- sessions based on working directory

  -- LSP
{
    "mason-org/mason.nvim",
    cmd = { 'Mason' },
    opts = {},
},

}
