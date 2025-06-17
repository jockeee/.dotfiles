--
-- https://github.com/AlexvZyl/nordic.nvim

return {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      local nordic = require 'nordic'

      local fg = '#b1b1b1'
      local bg = '#1f1f1f'

      nordic.setup {
        -- overriding colors in the base palette
        on_palette = function(palette)
          -- Backgrounds
          palette.gray0 = bg -- default: #242933,

          -- Floating windows
          palette.black1 = bg

          -- Cursorline Background
          palette.black0 = bg
        end,

        -- setting colors after the palette has been applied
        -- see: https://github.com/AlexvZyl/nordic.nvim/blob/main/lua/nordic/colors/init.lua
        after_palette = function(palette)
          local U = require 'nordic.utils'
          palette.bg_fold = bg
          palette.bg_visual = U.blend(palette.orange.base, palette.bg, 0.15)
          palette.comment = U.blend(palette.gray0, palette.fg, 0.5)
        end,

        italic_comments = true,
        bright_border = true,
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = 'classic',
        },
      }

      vim.cmd.colorscheme 'nordic'
      vim.g.colorscheme = 'nordic' -- lazy.lua and lualine.lua

      vim.cmd.highlight('MsgArea guifg=' .. fg .. ' guibg=' .. bg)
      -- vim.cmd.highlight('FoldColumn guibg=' .. bg)
      -- vim.cmd.highlight 'ColorColumn guibg=#1b1b29'
      -- vim.cmd.highlight 'StatusLine guibg=#2c2c2c' -- status line "separator", active
      -- vim.cmd.highlight 'StatusLineNC guibg=#2c2c2c' -- status line "separator", inactive
      vim.cmd.highlight('TabLine guifg=#7c7d83 guibg=' .. bg) -- tab not selected
      vim.cmd.highlight('TabLineSel guibg=' .. bg) -- tab selected
      vim.cmd.highlight('TabLineFill guibg=' .. bg) -- tabline row
      vim.cmd.highlight 'WinSeparator guifg=#2c2c2c' -- window separator
      -- vim.cmd.highlight 'LineNr guifg=#2c2c2c' -- line numbers
      -- vim.cmd.highlight '@string.special.url term=none cterm=none'

      -- html
      vim.cmd.highlight '@tag.delimiter.html guifg=#7c7d83' -- html tag delimiter
      vim.cmd.highlight '@none.html guifg=#868686' -- html tag delimiter
    end,
  },
}
