--
-- https://github.com/nvim-lualine/lualine.nvim
-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
--
-- auto-session statusline integration
-- https://github.com/rmagatti/auto-session?#statusline
--    sections = {lualine_c = {require('auto-session.lib').current_session_name}}
--
-- nvim-tree integration
-- https://github.com/nvim-lualine/lualine.nvim#extensions
--    extensions = { 'nvim-tree' }

-- TODO: you like chris@machines lualine, check his config.

return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' }, -- for pretty icons, requires a nerd font
    { 'AndreM222/copilot-lualine' },
  },
  opts = {
    options = {
      theme = vim.g.user_colorscheme_lualine,
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { '' }, -- default: 'mode'
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = {
        { 'copilot', show_colors = true },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { 'nvim-tree' },
  },
}
