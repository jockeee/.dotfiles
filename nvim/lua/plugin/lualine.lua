--
-- nvim-lualine/lualine.nvim

-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.

-- auto-session statusline integration
-- https://github.com/rmagatti/auto-session?#statusline
--    sections = {lualine_c = {require('auto-session.lib').current_session_name}}

-- nvim-tree integration
-- https://github.com/nvim-lualine/lualine.nvim#extensions
--    extensions = { 'nvim-tree' }

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

-- local function relative_fname_limit()
--   local limit = 40
--   local fname = vim.fn.expand '%:p'
--
--   if fname == '' then
--     return ''
--   end
--
--   local cwd = vim.fn.getcwd()
--   local path = fname:sub(#cwd + 2)
--
--   if #path > limit then
--     path = '…' .. path:sub(-(limit - 1))
--   end
--
--   return path
-- end

---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = {
    -- { 'nvim-tree/nvim-web-devicons', event = 'VimEnter' }, -- for pretty icons, requires a nerd font
    { 'AndreM222/copilot-lualine' },
  },
  opts = {
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
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- extensions = { 'nvim-tree' },
  },
  -- config = function(_, opts)
  --   local lualine = require 'lualine'
  --
  --   local codedompanion_spinner = require 'plugin.codecompanion.lualine-spinner'
  --   table.insert(opts.sections.lualine_x, 1, { codedompanion_spinner })
  --   table.insert(opts.inactive_sections.lualine_x, 1, { codedompanion_spinner })
  --
  --   lualine.setup(opts)
  -- end,
}
