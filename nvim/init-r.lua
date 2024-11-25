--
-- init-r.lua

--
-- Colors
--

vim.cmd.colorscheme 'habamax'
vim.cmd.highlight 'StatusLine guifg=#b1b1b1 guibg=#353535 '
vim.cmd.highlight 'MsgArea    guifg=#b1b1b1'

--
-- Globals
--

-- Netrw
vim.g.netrw_liststyle = 3 -- Tree view

--
-- Options
--

-- Mouse
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend' -- default: popup_setpos

-- Clipboard
-- Sync clipboard between os and neovim
vim.opt.clipboard = 'unnamedplus'

-- Appearance
vim.opt.termguicolors = true -- true color support (24-bit)
vim.opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = 'yes' -- always show sign column
vim.opt.showmode = false -- show current mode (insert, normal, visual, etc) in bottom bar
vim.opt.colorcolumn = '' -- right margin column
vim.opt.showcmd = false -- show command in bottom bar -- default: on

-- Line Numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)
vim.opt.relativenumber = true

-- Tabs & Indentation
vim.opt.tabstop = 4 -- tab width
vim.opt.shiftwidth = 4 -- indent width
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.autoindent = true -- use indent from current line when starting a new line

-- Line Wrapping
vim.opt.wrap = true -- default: on
vim.opt.breakindent = true -- wrapped lines will continue visually indented

-- Folding
vim.opt.foldcolumn = '1'
vim.opt.foldmethod = 'manual'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true -- default: on

-- Search Settings
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.hlsearch = true -- highlight search results -- default: on
vim.opt.ignorecase = true
vim.opt.smartcase = true -- don't ignore case with capitals

-- Consider dash (-) as part of keyword
vim.opt.iskeyword:append '-'

-- How new splits should be opened
vim.opt.splitright = true -- put new windows right of current -- default: off
vim.opt.splitbelow = true -- put new windows below current -- default: off

-- Save undo history
vim.opt.undofile = true
vim.opt.undolevels = 1000 -- default: 1000

-- Decrease update time
vim.opt.updatetime = 250 -- save swap file and trigger CursorHold
vim.opt.timeoutlen = 1000 -- default: 1000, time in milliseconds to wait for a mapped sequence to complete, also "time until which-key triggers"

-- How neovim will display certain whitespace in the editor.
vim.opt.list = false -- show invisible characters (tabs...)
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false -- default: off, highlighting of the current line

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10 -- lines of context

-- Minimal number of screen columns to keep to the left and to the right of the cursor.
vim.opt.sidescrolloff = 20 -- columns of context

-- PopUpMenu
vim.opt.pumheight = 10 -- maximum number of items to show in the popup menu

--
-- Autocmds
--

-- highlight when yanking (copying) text
--  :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--
-- Keymaps
--

--
-- keymaps.lua

-- Leader key, space, do nothing when space is pressed in normal or visual mode
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>')

-- Clear highlights (search) with <esc>
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

-- Exit terminal mode in the builtin terminal with <esc> (default: <c-\><c-n>).
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'Exit Terminal Mode' })

-- Save file
vim.keymap.set({ 'i', 'n', 's' }, '<c-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Resize windows using <ctrl> + arrow keys
vim.keymap.set('n', '<c-up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<c-down>', '<cmd>resize -2<cr>', { desc = 'decrease Window Height' })
vim.keymap.set('n', '<c-left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<c-right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Height' })

-- Move lines up/down
vim.keymap.set('n', '<m-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<m-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<m-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<m-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<m-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<m-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Indenting (gv re-selects last selection)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Diagnostics (https://github.com/neovim/nvim-lspconfig)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic Message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic Message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic Error Messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' })

-- Leader d: Buffer (document)
vim.keymap.set('n', '<leader>dd', '<cmd>bd<cr>', { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>da', '<cmd>%bdelete<cr>', { desc = 'Delete All Buffers' })
vim.keymap.set('n', '<leader>dx', '<cmd>bd!<cr>', { desc = 'Kill Buffer (Ignore Unsaved Changes)' })

-- Leader n: Neovim
vim.keymap.set('n', '<leader>nq', '<cmd>quitall<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>ns', '<cmd>w !sudo tee %<cr>', { desc = 'Sudo Write' })

-- Leader t: Toggle
vim.keymap.set('n', '<leader>tc', function()
  vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == '{}' and { 100 } or {}
end, { desc = 'Color Column' })
