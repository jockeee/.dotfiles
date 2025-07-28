--
-- https://github.com/catppuccin/nvim
-- Soothing pastel theme for (Neo)vim

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      -- styles = {
      --   comments = {}, -- Default: "italics"
      -- },
      -- color_overrides = {
      --   mocha = {
      --     base = '#1f1f1f', -- background color
      --   },
      -- },
      custom_highlights = function()
        return {
          Comment = { fg = '#818181' },
          ColorColumn = { bg = '#1b1b29' }, -- column limit
          MsgArea = { fg = '#b1b1b1', bg = '#1f1f1f' },
          TabLine = { bg = '#1f1f1f' }, -- tab not selected
          TabLineSel = { bg = '#1f1f1f' }, -- tab selected
          TabLineFill = { bg = '#1f1f1f' }, -- tabline row
          ['@string.special.url'] = { style = {} },
        }
      end,
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.g.colorscheme = 'catppuccin' -- lazy.lua and lualine.lua

      -- vim.cmd.highlight '@comment guifg=#818181'
      -- vim.cmd.highlight 'MsgArea guifg=#b1b1b1 guibg=#1f1f1f'
      -- vim.cmd.highlight 'ColorColumn guibg=#1b1b29' -- column limit
      -- vim.cmd.highlight 'TabLine guibg=#1f1f1f' -- tab not selected
      -- vim.cmd.highlight 'TabLineSel guibg=#1f1f1f' -- tab selected
      -- vim.cmd.highlight 'TabLineFill guibg=#1f1f1f' -- tabline row
      -- vim.cmd.highlight '@string.special.url term=none cterm=none'
    end,
  },
}
