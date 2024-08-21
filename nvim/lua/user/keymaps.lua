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
vim.keymap.set('n', '<leader>nm', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>nl', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>nq', '<cmd>quitall<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>ns', '<cmd>w !sudo tee %<cr>', { desc = 'Sudo Write' })

-- Leader t: Toggle
vim.keymap.set(
  'n',
  '<leader>tc',
  '<cmd>lua vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == "{}" and { 100 } or {}<cr>',
  { desc = 'Colorcolumn' }
)
