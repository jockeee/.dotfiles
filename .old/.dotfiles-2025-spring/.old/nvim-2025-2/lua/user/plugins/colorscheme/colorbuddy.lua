--
-- https://github.com/tjdevries/colorbuddy.nvim
-- Your color buddy for making cool neovim color schemes

return {
  {
    'tjdevries/colorbuddy.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbuddy'
      vim.g.colorscheme = 'gruvbuddy' -- lazy.lua and lualine.lua

      vim.cmd.highlight 'TabLine guibg=#1f1f1f' -- tab not selected
      vim.cmd.highlight 'TabLineSel guibg=#1f1f1f' -- tab selected
      vim.cmd.highlight 'TabLineFill guibg=#1f1f1f' -- tabline row
      vim.cmd.highlight '@string.special.url term=none cterm=none'
    end,
  },
}
