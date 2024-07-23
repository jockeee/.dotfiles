--
-- https://github.com/rmagatti/auto-session
-- A small automated session manager for Neovim
--
-- Telescope integration
-- See, load, and delete your sessions using Telescope
-- https://github.com/rmagatti/auto-session?#-session-lens
--    :Telescope session-lens
--
-- Statusline integration
-- https://github.com/rmagatti/auto-session?#statusline
--    sections = {lualine_c = {require('auto-session.lib').current_session_name}}

return {
  'rmagatti/auto-session',
  lazy = false,
  opts = {
    log_level = 'error', -- default: 'info'
    auto_save_enabled = true, -- default: nil
    auto_restore_enabled = true, -- default: nil
    auto_session_enable_last_session = false, -- default: false - Loads the last loaded session if session for cwd does not exist
    auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/', -- default: vim.fn.stdpath 'data' .. '/sessions/'
    auto_session_suppress_dirs = { '/', '~/', '~/Downloads' }, -- default: nil

    -- If you add session name to lualine, this refresh lualine after cwd changes
    -- https://github.com/rmagatti/auto-session?#-behaviour
    -- cwd_change_handling = {
    --   restore_upcoming_session = true, -- default: false
    --   pre_cwd_changed_hook = nil, -- default: nil
    --   post_cwd_changed_hook = function() -- refreshing the lualine status line _after_ the cwd changes
    --     require('lualine').refresh() -- refresh lualine so the new session name is displayed in the status bar
    --   end,
    -- },
  },
}
