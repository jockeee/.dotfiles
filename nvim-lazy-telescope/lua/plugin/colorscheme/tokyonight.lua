--
-- https://github.com/folke/tokyonight.nvim

return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  init = function()
    vim.cmd.colorscheme 'tokyonight'
    vim.g.colorscheme = 'tokyonight' -- lazy.lua and lualine.lua
  end,
}
