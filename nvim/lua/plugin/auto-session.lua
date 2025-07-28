--
-- rmagatti/auto-session

-- A small automated session manager for nvim

-- Session picker
-- https://github.com/rmagatti/auto-session#-session-picker

---@type LazySpec
return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>fs', '<cmd>SessionSearch<CR>', desc = 'sessions' },
  },
  ---@module 'auto-session'
  ---@type AutoSession.Config
  opts = {
    -- root_dir = vim.fn.stdpath 'data' .. '/sessions/', -- d: vim.fn.stdpath 'data' .. '/sessions/'
    -- auto_save = true, -- d: true
    -- auto_restore = true, -- d: true
    -- auto_restore_last_session = false, -- d: false - Loads the last loaded session if session for cwd does not exist
    suppressed_dirs = { '/', '/tmp', '/dev/shm', '~/', '~/Downloads' }, -- d: nil
    -- log_level = 'error', -- d: 'error'
    session_lens = {
      picker_opts = {
        -- snacks, layout
        -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
        preset = 'default',
        preview = false,
        layout = {
          width = 0.3,
          min_width = 80,
          height = 0.25,
        },
      },
      -- Telescope only: If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
      load_on_setup = false, -- d: true, keep false if telescope is not installed
    },
  },
}
