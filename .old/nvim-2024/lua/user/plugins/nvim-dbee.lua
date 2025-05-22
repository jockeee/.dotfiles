--
-- https://github.com/kndndrj/nvim-dbee
-- Interactive database client for neovim

return {
  'kndndrj/nvim-dbee',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require('dbee').install()
  end,
  keys = {
    { '<leader>b', '<cmd>Dbee toggle<cr>', desc = 'SQL: Dbee' },
  },
  config = function()
    local dbee = require 'dbee'
    dbee.setup {
      sources = {
        require('dbee.sources').FileSource:new(vim.fn.stdpath 'cache' .. '/dbee/persistence.json'),
      },
    }
  end,
}
