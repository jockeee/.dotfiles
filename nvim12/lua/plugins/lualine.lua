--
-- nvim-lualine/lualine.nvim

vim.pack.add({
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/AndreM222/copilot-lualine',
})

local function cwd_limit()
  local limit = 26
  local cwd = vim.fn.getcwd()
  local home = os.getenv 'HOME'

  if cwd:sub(1, #home) == home then
    cwd = '~' .. cwd:sub(#home + 1)
  end

  if #cwd > limit then
    cwd = '…' .. cwd:sub(-(limit - 1))
  end

  return cwd
end

local lualine = require 'lualine'

lualine.setup({
    options = {
      -- theme = 'auto',
      -- theme = vim.g.colorscheme,
      theme = 'vscode-colors', -- lua/lualine/themes/vscode-colors.lua
      component_separators = '',
      section_separators = '',
    },
    sections = {
      -- lualine_a = {}, -- default: 'mode'
      lualine_a = {},
      lualine_b = {
        { 'branch', icon = '' },
        cwd_limit,
        -- {
        --   relative_fname_limit,
        --   color = { gui = 'bold' },
        -- },
        {
          'filename',
          color = { gui = 'bold' },
          path = 1, -- 0 = filename, 1 = relative path, 2 = absolute path, 3 = relative to home
          file_status = true,
        },
      },
      lualine_c = {
        'aerial',
        'diagnostics',
        'diff',
      },
      lualine_x = {
        { 'copilot', show_colors = false },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = {}, -- default: 'progress'
      lualine_z = { 'location' }, -- default: 'location'
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {
        cwd_limit,
        -- {
        --   relative_fname_limit,
        --   color = { gui = 'bold' },
        -- },
        {
          'filename',
          color = { gui = 'bold' },
          path = 1, -- 0 = filename, 1 = relative path, 2 = absolute path, 3 = relative to home
          file_status = true,
        },
      },
      lualine_c = {
        'aerial',
        'diagnostics',
      },
      lualine_x = {
        { 'copilot', show_colors = false },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = {}, -- default: 'progress'
      lualine_z = { 'location' }, -- default: 'location'
    },
    winbar = {
      lualine_a = {},
      lualine_b = {
        -- 'filename',
        {
          'filename',
          -- color = { gui = 'bold' },
          path = 0, -- 0 = filename, 1 = relative path, 2 = absolute path, 3 = relative to home
          file_status = true,
        },
        'aerial',
        'diagnostics',
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {
        -- 'filename',
        {
          'filename',
          -- color = { gui = 'bold' },
          path = 0, -- 0 = filename, 1 = relative path, 2 = absolute path, 3 = relative to home
          file_status = true,
        },
        'aerial',
        'diagnostics',
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- extensions = { 'nvim-tree' },
})

