--
-- https://github.com/nvim-lualine/lualine.nvim
-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.

-- TODO: you like chris@machines lualine, check his tutorial out.

return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- for pretty icons, requires a nerd font
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
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { 'nvim-tree' },
  },
}
