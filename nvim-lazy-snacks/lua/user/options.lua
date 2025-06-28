--
-- options.lua

local fn, g, o, opt = vim.fn, vim.g, vim.o, vim.opt

-- Mouse
-- vim.opt.mouse = 'a'
-- vim.opt.mousemodel = 'extend' -- default: popup_setpos

-- Clipboard
-- Sync clipboard between os and neovim
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  :help 'clipboard'
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Appearance
o.termguicolors = true -- true color support (24-bit)
o.background = 'dark' -- colorschemes that can be light or dark will be made dark
o.colorcolumn = '' -- right margin column
o.cursorline = false -- highlight line which your cursor is on
o.inccommand = 'split' -- default: nosplit, preview substitutions live as you type
o.pumheight = 10 -- popupmenu, maximum number of items to show in the popup menu
o.signcolumn = 'yes' -- always show sign column
o.showmode = false -- show current mode (insert, normal, visual, etc) in bottom bar
o.scrolloff = 10 -- lines of context, minimal number of screen lines to keep above and below the cursor.
o.showcmd = false -- show command in bottom bar -- default: on
o.showtabline = 1 -- default: 1, 0=never, 1=only if there are at least two tab pages, 2=always
o.sidescrolloff = 20 -- columns of context, minimal number of screen columns to keep to the left and to the right of the cursor.
o.tabline = '%!v:lua.User.Tabline()'
-- opt.guicursor:append 't:blinkon0' -- cursor blinking, it's too beautiful, hypnotic.

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
o.confirm = true

-- Line Numbers
o.number = true -- shows absolute line number on cursor line (when relative number is on)
o.relativenumber = false

-- Tabs & Indentation
o.tabstop = 4 -- tab width
o.shiftwidth = 4 -- indent width
o.expandtab = true -- use spaces instead of tabs
o.autoindent = true -- use indent from current line when starting a new line

-- Line Wrapping
o.wrap = false -- default: on
o.breakindent = true -- wrapped lines will continue visually indented

-- Folding
o.foldcolumn = '0'
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
-- vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'

-- Search Settings
-- Case-insensitive searching UNLESS \C or capital in search
o.hlsearch = true -- highlight search results -- default: on
o.ignorecase = true
o.smartcase = true -- don't ignore case when capital in search

-- Consider dash (-) as part of keyword
-- vim.opt.iskeyword:append '-'

-- How new splits should be opened
o.splitright = true -- put new windows right of current -- default: off
o.splitbelow = true -- put new windows below current -- default: off

-- Save undo history
o.undofile = true

-- Swap files
-- Careful: All text will be in memory:
--  - Don't use this for big files.
--  - Recovery will be impossible!
o.swapfile = false

-- Decrease update time
o.updatetime = 250 -- save swap file and trigger CursorHold
o.timeoutlen = 1000 -- default: 1000, time in milliseconds to wait for a mapped sequence to complete

-- How neovim will display certain whitespace in the editor.
o.list = true -- show invisible characters (tabs...)
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Sessions
-- auto-session plugin suggests these sessionoptions
-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
o.sessionoptions = 'buffers,curdir,folds,localoptions,tabpages,winsize,winpos' -- removed blank, help, terminal
