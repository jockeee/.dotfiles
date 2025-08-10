--
-- options.lua
--
-- :h vim.opt
-- :h option-list

local opt = vim.opt

-- Mouse
opt.mouse = 'a'
opt.mousemodel = 'extend' -- default: popup_setpos

-- Clipboard
-- Sync clipboard between os and neovim
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  :help 'clipboard'
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Appearance
opt.termguicolors = true -- true color support (24-bit)
opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
opt.colorcolumn = '' -- right margin column
opt.cursorline = false -- highlight current line
opt.inccommand = 'split' -- d: nosplit, preview substitutions live as you type
opt.signcolumn = 'yes' -- always show sign column
opt.showmode = false -- show current mode (insert, normal, visual, etc) in bottom bar
opt.showcmd = false -- show command in bottom bar -- default: on
opt.showtabline = 1 -- default: 1, 0=never, 1=only if there are at least two tab pages, 2=always
opt.tabline = '%!v:lua.User.Tabline()'
-- opt.guicursor:append 't:blinkon0' -- cursor blinking, it's too beautiful, hypnotic.

opt.pumheight = 10 -- popupmenu, maximum number of items to show in the popup menu
opt.scrolloff = 10 -- lines of context, minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 20 -- columns of context, minimal number of screen columns to keep to the left and to the right of the cursor.

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
--  :help 'confirm'
opt.confirm = false

-- Line Numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.relativenumber = false

-- Tabs & Indentation
opt.tabstop = 4 -- tab width
opt.shiftwidth = 4 -- indent width
opt.expandtab = true -- use spaces instead of tabs
opt.autoindent = true -- use indent from current line when starting a new line

-- Line Wrapping
opt.wrap = false -- default: on
opt.breakindent = true -- wrapped lines will continue visually indented

-- Folding
opt.foldcolumn = '0'
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
-- vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'

-- Search Settings
-- Case-insensitive searching UNLESS \C or capital in search
opt.hlsearch = true -- highlight search results -- default: on
opt.ignorecase = true
opt.smartcase = true -- don't ignore case when capital in search

-- Consider dash (-) as part of keyword
-- opt.iskeyword:append '-'

-- How new splits should be opened
opt.splitright = true -- put new windows right of current -- default: off
opt.splitbelow = true -- put new windows below current -- default: off

-- Save undo history
opt.undofile = true

-- Swap files
-- Careful: All text will be in memory:
--  - Don't use this for big files.
--  - Recovery will be impossible!
opt.swapfile = false

-- Decrease update time
opt.updatetime = 250 -- save swap file and trigger CursorHold
opt.timeoutlen = 1000 -- default: 1000, time in milliseconds to wait for a mapped sequence to complete

-- How neovim will display certain whitespace in the editor.
opt.list = true -- show invisible characters (tabs...)
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Sessions
-- auto-session plugin suggests these sessionoptions
-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
opt.sessionoptions = 'buffers,curdir,folds,localoptions,tabpages,winsize,winpos' -- removed blank, help, terminal
