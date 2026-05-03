--
-- init.lua

-- require('vim._core.ui2').enable({})

require('config')

-- undotree
--  :h :Undotree
vim.cmd.packadd 'nvim.undotree'

require('plugins')
