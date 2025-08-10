--
-- init.lua

require 'user.globals'
require 'user.filetypes'
require 'user.options'
require 'user.lazy'
require 'user.keymaps'

require 'user.autocmds'.startup()
require 'user.autocmds'.highlight_yank()
require 'user.autocmds'.go()
