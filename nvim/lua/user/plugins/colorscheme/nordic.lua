--
-- https://github.com/AlexvZyl/nordic.nvim

return {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'nordic'
      vim.g.colorscheme = 'nordic' -- lazy.lua and lualine.lua

      local bg = '#242933' -- default nordic bg color, #242933

      -- vim.cmd.highlight 'Normal guibg=#1f1f1f'
      vim.cmd.highlight 'MsgArea guifg=#b1b1b1 guibg=#1f1f1f'
      vim.cmd.highlight('FoldColumn guibg=' .. bg)
      -- vim.cmd.highlight 'ColorColumn guibg=#1b1b29'
      -- vim.cmd.highlight 'StatusLine guibg=#2c2c2c' -- status line "separator", active
      -- vim.cmd.highlight 'StatusLineNC guibg=#2c2c2c' -- status line "separator", inactive
      -- vim.cmd.highlight 'TabLine guibg=#1f1f1f' -- tab not selected
      -- vim.cmd.highlight 'TabLineSel guibg=#1f1f1f' -- tab selected
      -- vim.cmd.highlight 'TabLineFill guibg=#1f1f1f' -- tabline row
      -- vim.cmd.highlight '@string.special.url term=none cterm=none'
    end,
  },
}
