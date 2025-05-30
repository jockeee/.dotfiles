--
-- https://github.com/uga-rosa/ccc.nvim
-- Color picker and highlighter plugin for Neovim.
--
-- Alternatives:
--  https://github.com/echasnovski/mini.hipatterns/blob/main/doc/mini-hipatterns.txt says:
--  # Comparisons ~
-- - 'folke/todo-comments':
--     - Oriented for "TODO", "NOTE", "FIXME" like patterns, while this module
--       can work with any Lua patterns and computable highlight groups.
--     - Has functionality beyond text highlighting (sign placing,
--       "telescope.nvim" extension, etc.), while this module only focuses on
--       highlighting text.
-- - 'folke/paint.nvim':
--     - Mostly similar to this module, but with slightly less functionality,
--       such as computed pattern and highlight group, asynchronous delay, etc.
-- - 'NvChad/nvim-colorizer.lua':
--     - Oriented for color highlighting, while this module can work with any
--       Lua patterns and computable highlight groups.
--     - Has more built-in color spaces to highlight, while this module out of
--       the box provides only hex color highlighting
--       (see |MiniHipatterns.gen_highlighter.hex_color()|). Other types are
--       also possible to implement.
-- - 'uga-rosa/ccc.nvim':
--     - Has more than color highlighting functionality, which is compared to
--       this module in the same way as 'NvChad/nvim-colorizer.lua'.

return {
  'uga-rosa/ccc.nvim',
  event = 'BufReadPre',
  config = function()
    local ccc = require 'ccc'
    ccc.setup {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      inputs = {
        ccc.input.rgb, -- default
        ccc.input.hsl, -- default
        ccc.input.cmyk, -- default
        ccc.input.oklch,
      },
      outputs = {
        ccc.output.hex, -- default
        ccc.output.hex_short, -- default
        ccc.output.css_rgb, -- default
        ccc.output.css_hsl, -- default
        ccc.output.css_oklch,
      },
    }

    vim.keymap.set('n', '<leader>fc', '<cmd>CccPick<cr>', { desc = 'Color Picker' })
    vim.keymap.set('n', '<leader>cc', '<cmd>CccConvert<cr>', { desc = 'Convert Color' })
    vim.keymap.set('n', '<leader>tc', '<cmd>CccHighlighterToggle<cr>', { desc = 'Color Highlight' })
  end,
}
