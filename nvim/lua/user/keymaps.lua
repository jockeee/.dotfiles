--
-- keymaps.lua

-- Leader key, space, do nothing when space is pressed in normal or visual mode
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>')

-- Clean up search results and extmarks with <esc>
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr><cmd>lua require("user.utils").hl_search_index_clear()<cr>')

-- Exit terminal mode in the builtin terminal with <esc> (default: <C-\><C-n>).
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- Save file
vim.keymap.set({ 'i', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- j/k navigate visual lines (wrapped lines)
-- vim.keymap.set('n', 'j', 'gj')
-- vim.keymap.set('n', 'k', 'gk')
-- https://www.reddit.com/r/neovim/comments/19axx0v/how_do_i_stop_nvim_from_jumping_whole_lines/
local mux_with_g = function(key)
  local gkey = 'g' .. key
  return function()
    if vim.v.count == 0 then
      return gkey
    else
      return key
    end
  end
end
vim.keymap.set({ 'n', 'v' }, 'j', mux_with_g 'j', { expr = true })
vim.keymap.set({ 'n', 'v' }, 'k', mux_with_g 'k', { expr = true })

-- Resize windows using <ctrl> + arrow keys
vim.keymap.set('n', '<C-up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-down>', '<cmd>resize -2<cr>', { desc = 'decrease Window Height' })
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Height' })

-- Move lines up/down
vim.keymap.set('n', '<M-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<M-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<M-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<M-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<M-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<M-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Indenting (gv re-selects last selection)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Search index
local keys = { 'n', 'N', '*', '#', 'g*', 'g#' }
for _, key in ipairs(keys) do
  vim.keymap.set('n', key, key .. '<cmd>lua require("user.utils").hl_search_index()<cr>', { desc = 'Search Index' })
end

-- Diagnostics (https://github.com/neovim/nvim-lspconfig)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic Message' }) -- included in mini.bracketed
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic Message' }) -- included in mini.bracketed
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic Error Messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' }) -- trouble, leader-xx

-- Buffer
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

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
  { desc = 'Color Column' }
)
vim.keymap.set('n', '<leader>th', '<cmd>set cursorline!<cr>', { desc = 'Hightlight Line' }) -- lua vim.opt.cursorline = not vim.opt.cursorline:get()
vim.keymap.set('n', '<leader>tr', '<cmd>set relativenumber!<cr>', { desc = 'Relative Number' }) -- set rnu! or lua vim.opt.relativenumber = not vim.opt.relativenumber:get()
vim.keymap.set('n', '<leader>ts', '<cmd>windo set scrollbind!<cr>', { desc = 'Scrollbind, in open windows' })
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = 'Wrap' }) -- lua vim.opt.wrap = not vim.opt.wrap:get()
