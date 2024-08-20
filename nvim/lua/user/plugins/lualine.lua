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
    { 'AndreM222/copilot-lualine', event = 'VimEnter' },
  },
  opts = {
    options = {
      theme = 'mycolors', -- default: auto
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { '' }, -- default: 'mode'
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        'filename',
        'diagnostics',
        {
          'filename',
          file_status = false,
          path = 1, -- 0 = filename, 1 = relative path, 2 = absolute path, 3 = relative to home
        },
      },
      lualine_x = {
        { 'copilot', show_colors = false },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }, -- default: 'location'
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        'filename',
        'diagnostics',
        {
          'filename',
          file_status = false,
          path = 1, -- 0 = filename, 1 = relative path, 2 = absolute path, 3 = relative to home
        },
      },
      lualine_x = {
        { 'copilot', show_colors = false },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }, -- default: 'location'
    },
    extensions = { 'nvim-tree' },
  },
}
