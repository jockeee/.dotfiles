--
-- rmagatti/auto-session

vim.pack.add({
  'https://github.com/rmagatti/auto-session',
})

local as = require 'auto-session'

as.setup({
  suppressed_dirs = { '/', '/tmp', '/dev/shm', '~/', '~/Downloads' }, -- d: nil
})
