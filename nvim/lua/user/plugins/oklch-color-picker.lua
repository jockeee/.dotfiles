--
-- https://github.com/eero-lehtinen/oklch-color-picker.nvim
-- A graphical color picker and highlighter for Neovim
--
-- WARNING: Uses prebuilt binaries from https://github.com/eero-lehtinen/oklch-color-picker
--
-- Configuration
--  https://github.com/eero-lehtinen/oklch-color-picker.nvim#default-options
--  https://github.com/eero-lehtinen/oklch-color-picker.nvim#configuration

return {
  'eero-lehtinen/oklch-color-picker.nvim',
  event = 'VeryLazy',
  opts = {
    -- Download binaries automatically.
    auto_download = true,
  },
  config = function(_, opts)
    local okcp = require 'oklch-color-picker'
    okcp.setup(opts)

    vim.keymap.set('n', '<leader>fc', okcp.pick_under_cursor, { desc = 'Color Picker' })
  end,
}
