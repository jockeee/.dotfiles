--
-- lua/user/options.lua

-- Mouse
vim.o.mouse = 'a'
vim.o.mousemodel = 'extend' -- d: popup_setpos

-- Clipboard
-- Sync clipboard between os and neovim
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  :h 'clipboard'
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.modeline = false
vim.o.termguicolors = true -- true color support (24-bit)
vim.o.background = 'dark' -- colorschemes that can be light or dark will be made dark
vim.o.cursorline = false -- highlight line which your cursor is on
vim.o.colorcolumn = '' -- right margin column
vim.o.signcolumn = 'yes' -- always show sign column
vim.o.showmode = false -- show current mode (insert, normal, visual, etc) in bottom bar
vim.o.showcmd = false -- show command in bottom bar -- d: on
vim.o.scrolloff = 0 -- d: 0, lines of context, minimal number of screen lines to keep above and below the cursor.
vim.o.sidescrolloff = 0 -- d: 0, cols of context, minimal number of screen columns to keep to the left and right of the cursor.
vim.o.pumheight = 10 -- popupmenu, maximum number of items to show in the popup menu
vim.o.inccommand = 'split' -- d: nosplit, preview substitutions live as you type

-- Cursor blinking, too beautiful, hypnotic
-- d: guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor'
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor'

-- Save file(s) dialog, instead of switching to buffer(s)
vim.o.confirm = false

-- Tabline
vim.o.showtabline = 1 -- d: 1, 0=never, 1=only if there are at least two tab pages, 2=always
vim.o.tabline = '%!v:lua.UserTabline()' -- custom tabline function

-- Line Numbers
vim.o.number = true -- shows absolute line number on cursor line (when relative number is on)
vim.o.relativenumber = false

-- Tabs & Indentation
vim.o.tabstop = 4 -- tab width
vim.o.shiftwidth = 4 -- indent width
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.autoindent = true -- use indent from current line when starting a new line

-- Line Wrapping
vim.o.wrap = false -- d: on
vim.o.breakindent = true -- wrapped lines will continue visually indented

-- Folding
vim.o.foldcolumn = '0'
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
-- vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'

-- Search Settings
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.hlsearch = true -- highlight search results -- d: on
vim.o.ignorecase = true
vim.o.smartcase = true -- don't ignore case when capital in search

-- Consider dash (-) as part of keyword
-- vim.opt.iskeyword:append '-'

-- How new splits should be opened
vim.o.splitright = true -- put new windows right of current -- d: off
vim.o.splitbelow = true -- put new windows below current -- d: off

-- Save undo history
vim.o.undofile = true

-- Swap files
-- swap off:
--  - All text will be in memory.
--  - Don't use swap off for big files.
--  - Recovery will be impossible!
vim.o.swapfile = true

-- Decrease update time
vim.o.updatetime = 250 -- save swap file and trigger CursorHold
vim.o.timeoutlen = 300 -- d: 1000, time in milliseconds to wait for a mapped sequence to complete

-- How neovim will display certain whitespace in the editor.
vim.o.list = true -- show invisible characters (tabs...)
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Sessions
-- auto-session plugin suggests these sessionoptions
-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
vim.o.sessionoptions = 'buffers,curdir,folds,localoptions,tabpages,winsize' -- removed blank, help, terminal
