--
-- https://github.com/shaunsingh/nord.nvim

return {
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'nord'
      vim.g.colorscheme = 'nord' -- lazy.lua and lualine.lua

      vim.cmd.highlight 'MsgArea guifg=#b1b1b1 guibg=#1f1f1f'
      vim.cmd.highlight 'ColorColumn guibg=#1b1b29'
      vim.cmd.highlight 'TabLine guibg=#1f1f1f' -- tab not selected
      vim.cmd.highlight 'TabLineSel guibg=#1f1f1f' -- tab selected
      vim.cmd.highlight 'TabLineFill guibg=#1f1f1f' -- tabline row
      vim.cmd.highlight '@string.special.url term=none cterm=none'
    end,
  },
}
