--
-- AlexvZyl/nordic.nvim

---@type LazySpec
return {
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      local nordic = require 'nordic'
      local util = require 'nordic.utils'

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
          palette.bg = bg
          palette.bg_fold = bg
          palette.bg_visual = util.blend(palette.orange.base, palette.bg, 0.15) -- visual selection background
          palette.comment = util.blend(palette.gray0, palette.fg, 0.5) -- comment color
        end,

        italic_comments = true,
        bright_border = true,
        -- telescope = {
        --   style = 'classic', -- classic, flat
        -- },
      }

      nordic.load()
      vim.g.colorscheme = 'nordic'

      local palette = require 'nordic.colors'

      vim.api.nvim_set_hl(0, 'Pmenu', { bg = palette.bg }) -- completion menu
      vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'FloatBorder' })

      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = palette.bg }) -- floating window background
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = palette.bg, fg = palette.gray3 }) -- floating window border
      -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = util.blend('#000000', palette.bg, 0.15) })

      vim.api.nvim_set_hl(0, 'CursorLine', { bg = util.blend('#000000', palette.bg, 0.15) })
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

      -- Only keep fields valid for nvim_set_hl
      local function filtered_highlight(hl)
        local valid_keys = {
          fg = true,
          bg = true,
          sp = true,
          bold = true,
          standout = true,
          underline = true,
          undercurl = true,
          underdouble = true,
          underdotted = true,
          underdashed = true,
          strikethrough = true,
          italic = true,
          reverse = true,
          nocombine = true,
          default = true,
          link = true,
          blend = true,
        }
        local filtered = {}
        for k, v in pairs(hl) do
          if valid_keys[k] then
            filtered[k] = v
          end
        end
        return filtered
      end

      -- Remove underline from Search highlight
      local hl_search = vim.api.nvim_get_hl(0, { name = 'Search' })
      hl_search = filtered_highlight(hl_search)
      hl_search.underline = nil
      vim.api.nvim_set_hl(0, 'Search', hl_search)

      -- Markdown
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', {
        bg = util.blend(palette.fg, palette.bg, 0.06),
      })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', {
        -- bold = true,
        fg = util.blend(palette.bg, palette.fg, 0.12),
        bg = util.blend(palette.fg, palette.bg, 0.06),
      })
      -- vim.api.nvim_set_hl(0, '@markup.raw.block.markdown', {
      --   fg = util.blend(palette.bg, palette.fg, 0.12),
      -- })

      -- LSP reference
      -- local orangedark = utils.blend(palette.orange.dim, palette.bg, 0.08)
      vim.api.nvim_set_hl(0, 'LspReferenceText', {
        -- bg = orangedark,
        -- bg = utils.blend(palette.orange.dim, palette.bg, 0.08),
        bg = util.blend(palette.green.base, palette.bg, 0.12),
      })
      vim.api.nvim_set_hl(0, 'LspReferenceRead', {
        -- bg = orangedark,
        -- bg = utils.blend(palette.orange.dim, palette.bg, 0.08),
        bg = util.blend(palette.blue1, palette.bg, 0.12),
      })
      vim.api.nvim_set_hl(0, 'LspReferenceWrite', {
        -- bg = orangedark,
        -- bg = utils.blend(palette.orange.dim, palette.bg, 0.08),
        bg = util.blend(palette.red.base, palette.bg, 0.12),
      })

      -- Treesitter HTML
      vim.api.nvim_set_hl(0, '@tag.delimiter.html', { fg = '#7c7d83' }) -- html tag delimiter
      vim.api.nvim_set_hl(0, '@none.html', { fg = '#868686' }) -- html special none
      vim.api.nvim_set_hl(0, '@string.special.url', { bold = false, underline = false })
    end,
  },
}
