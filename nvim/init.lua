--
-- init.lua

vim.loader.enable()

local fn, g, opt = vim.fn, vim.g, vim.opt

-- disable providers
-- :healthcheck providers
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

g.mapleader = ' '
g.maplocalleader = ' '

pcall(vim.cmd.colorscheme, "nordic")
