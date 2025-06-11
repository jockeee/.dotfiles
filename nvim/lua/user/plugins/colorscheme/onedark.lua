--
-- https://github.com/navarasu/onedark.nvim
-- Based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles

return {
  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'warmer',
      code_style = {
        comments = 'italic', -- default: italic
      },
    },
    init = function()
      vim.cmd.colorscheme 'onedark'
      vim.g.colorscheme = 'onedark' -- lazy.lua and lualine.lua
    end,
  },
}
