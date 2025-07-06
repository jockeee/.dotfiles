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
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_save = true, -- default: true
    auto_restore = true, -- default: true
    auto_restore_last_session = false, -- default: false, loads the last saved session if session for cwd does not exist
    auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/', -- default: vim.fn.stdpath 'data' .. '/sessions/'
    suppressed_dirs = { '/', '~/', '~/Downloads' }, -- default: nil
    log_level = 'error', -- default: 'error'
  },
}
