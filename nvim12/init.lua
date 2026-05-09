--
-- init.lua

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

require('vim._core.ui2').enable()

require('config')
require('plugins')

-- undotree
--  :h :Undotree
vim.cmd.packadd 'nvim.undotree'
