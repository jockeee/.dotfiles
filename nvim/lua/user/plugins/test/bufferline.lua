--
-- https://github.com/akinsho/bufferline.nvim
-- A snazzy buffer line for Neovim
--
-- Only show tabpages
--    This can be done by setting the `mode` option to `tabs`.
--    This will change the bufferline to a tabline that has a lot of the same features/styling but not all.
--
-- :h bufferline-configuration
-- :h bufferline-styling

return {
  {
    'akinsho/bufferline.nvim',
    event = 'WinEnter',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require 'bufferline'
      bufferline.setup {
        options = {
          mode = 'tabs',
          style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
          separator_style = 'slope',
          show_buffer_icons = false,
          show_buffer_close_icons = false,
          custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= 'NvimTree' then return true end
          end,
          -- offsets = {
          --   {
          --     filetype = 'NvimTree',
          --     text = 'File Explorer',
          --     text_align = 'left',
          --     separator = false,
          --   },
          -- },
        },
      }
    end,
  },
}
