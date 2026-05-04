--
-- rmagatti/auto-session

vim.pack.add({
  'https://github.com/rmagatti/auto-session',
})

local session = require 'auto-session'

session.setup({
  suppressed_dirs = { '/', '/tmp', '/dev/shm', '~/', '~/Downloads' }, -- d: nil
})
