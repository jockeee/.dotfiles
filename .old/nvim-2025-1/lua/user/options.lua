--
-- options.lua
--
--  :h vim.opt
--  :h option-list

-- Mouse
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend' -- default: popup_setpos

-- Clipboard
-- Sync clipboard between os and neovim
vim.opt.clipboard = 'unnamedplus'

-- Appearance
vim.opt.termguicolors = true -- true color support (24-bit)
vim.opt.background = 'dark'  -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = 'yes'   -- always show sign column
vim.opt.showmode = false     -- show current mode (insert, normal, visual, etc) in bottom bar
vim.opt.colorcolumn = ''     -- right margin column
vim.opt.showcmd = false      -- show command in bottom bar -- default: on
vim.opt.showtabline = 0      -- hide tabline

-- Line Numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)
vim.opt.relativenumber = false

-- Tabs & Indentation
vim.opt.tabstop = 4       -- tab width
vim.opt.shiftwidth = 4    -- indent width
vim.opt.expandtab = true  -- use spaces instead of tabs
vim.opt.autoindent = true -- use indent from current line when starting a new line

-- Line Wrapping
vim.opt.wrap = false       -- default: on
vim.opt.breakindent = true -- wrapped lines will continue visually indented

-- Folding
vim.opt.foldcolumn = '1'
vim.opt.foldmethod = 'manual'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true -- default: on

-- Search Settings
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.hlsearch = true  -- highlight search results -- default: on
vim.opt.ignorecase = true
vim.opt.smartcase = true -- don't ignore case when capital in search

-- Consider dash (-) as part of keyword
-- vim.opt.iskeyword:append '-'

-- How new splits should be opened
vim.opt.splitright = true -- put new windows right of current -- default: off
vim.opt.splitbelow = true -- put new windows below current -- default: off

-- Save undo history
vim.opt.undofile = true
vim.opt.undolevels = 1000 -- default: 1000

-- Decrease update time
vim.opt.updatetime = 250  -- save swap file and trigger CursorHold
vim.opt.timeoutlen = 1000 -- default: 1000, time in milliseconds to wait for a mapped sequence to complete, also "time until which-key triggers"

-- How neovim will display certain whitespace in the editor.
vim.opt.list = false -- show invisible characters (tabs...)
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false -- highlight current line

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10 -- lines of context

-- Minimal number of screen columns to keep to the left and to the right of the cursor.
vim.opt.sidescrolloff = 20 -- columns of context

-- PopUpMenu
vim.opt.pumheight = 10 -- maximum number of items to show in the popup menu

-- Sessions
-- auto-session plugin suggests these sessionoptions
-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
