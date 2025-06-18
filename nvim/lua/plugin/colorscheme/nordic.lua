--
-- AlexvZyl/nordic.nvim

return {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      local nordic = require 'nordic'
      local utils = require 'nordic.utils'

      local bg = '#1f1f1f'
      local fg = '#b1b1b1'

      nordic.setup {
        on_palette = function(palette)
          -- Override base palette
          palette.gray0 = bg -- gray0 used for default background
          -- palette.black1 = bg -- floating window background
          -- palette.black0 = bg -- cursorline background
        end,

        -- setting colors after the palette has been applied
        -- see: https://github.com/AlexvZyl/nordic.nvim/blob/main/lua/nordic/colors/init.lua
        after_palette = function(palette)
          palette.bg_fold = bg
          palette.bg_visual = utils.blend(palette.orange.base, palette.bg, 0.15)
          palette.comment = utils.blend(palette.gray0, palette.fg, 0.5)
        end,

        italic_comments = true,
        bright_border = true,
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = 'classic', --
        },
      }

      vim.cmd.colorscheme 'nordic'
      vim.g.colorscheme = 'nordic' -- lazy.lua and lualine.lua

      local palette = require 'nordic.colors'

      -- UI
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = bg })
      vim.api.nvim_set_hl(0, 'CursorLine', {
        bg = utils.blend('#000000', palette.bg, 0.15),
      })
      vim.api.nvim_set_hl(0, 'MsgArea', { fg = fg, bg = bg })
      vim.api.nvim_set_hl(0, 'TabLine', { fg = '#7c7d83', bg = bg }) -- tab not selected
      vim.api.nvim_set_hl(0, 'TabLineSel', { bg = bg }) -- tab selected
      vim.api.nvim_set_hl(0, 'TabLineFill', { bg = bg }) -- tabline row
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#2c2c2c' }) -- window separator
      -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#2c2c2c" })
      -- vim.api.nvim_set_hl(0, "FoldColumn", { bg = bg })
      -- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1b1b29" })
      -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#2c2c2c" })
      -- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#2c2c2c" })

      -- LSP reference highlights
      local orangedark = utils.blend(palette.orange.dim, palette.bg, 0.08)

      vim.api.nvim_set_hl(0, 'LspReferenceText', {
        bg = orangedark,
        -- bg = utils.blend(palette.orange.dim, palette.bg, 0.08),
      })

      vim.api.nvim_set_hl(0, 'LspReferenceRead', {
        bg = orangedark,
        -- bg = utils.blend(palette.orange.dim, palette.bg, 0.08),
        -- bg = utils.blend(palette.blue1, palette.bg, 0.10),
      })

      vim.api.nvim_set_hl(0, 'LspReferenceWrite', {
        bg = orangedark,
        -- bg = utils.blend(palette.orange.dim, palette.bg, 0.08),
        -- bg = utils.blend(palette.red.base, palette.bg, 0.12),
      })

      -- Treesitter HTML
      vim.api.nvim_set_hl(0, '@tag.delimiter.html', { fg = '#7c7d83' }) -- html tag delimiter
      vim.api.nvim_set_hl(0, '@none.html', { fg = '#868686' }) -- html special none
      -- vim.api.nvim_set_hl(0, "@string.special.url", { bold = false, underline = false })
    end,
  },
}
