--
-- https://github.com/rmagatti/auto-session
-- A small automated session manager for nvim
--
-- Telescope integration
-- See, load, and delete your sessions using Telescope
-- https://github.com/rmagatti/auto-session?#-session-lens
--    :Telescope session-lens
--

return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim', -- if you want to use sesssion lens
  },
  opts = {
    log_level = 'error', -- default: 'error'
    auto_save_enabled = true, -- default: true
    auto_restore_enabled = true, -- default: true
    auto_session_enable_last_session = false, -- default: false - Loads the last loaded session if session for cwd does not exist
    auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/', -- default: vim.fn.stdpath 'data' .. '/sessions/'
    auto_session_suppress_dirs = { '/', '~/', '~/Downloads' }, -- default: nil
    silent_restore = false, -- default: true
  },
}
