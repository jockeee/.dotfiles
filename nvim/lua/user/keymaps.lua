--
-- keymaps.lua

-- Leader key, space, do nothing when space is pressed in normal or visual mode
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>')

-- Clean up search results and extmarks with <esc>
vim.keymap.set('n', '<esc>', function()
  vim.cmd 'nohlsearch'
  require('user.utils').hl_search_index_clear()
  require('multicursor-nvim').clearCursors()
end)

-- Exit terminal mode in the builtin terminal with <esc> (default: <C-\><C-n>).
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- Save file
vim.keymap.set({ 'i', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

vim.keymap.set({ 'n', 'v' }, '<left>', 'b')
vim.keymap.set({ 'n', 'v' }, '<right>', 'e')

-- j/k navigate visual lines (wrapped lines)
-- vim.keymap.set('n', 'j', 'gj')
-- vim.keymap.set('n', 'k', 'gk')
-- https://www.reddit.com/r/neovim/comments/19axx0v/how_do_i_stop_nvim_from_jumping_whole_lines/
local mux_with_g = function(key)
  return function()
    if vim.v.count == 0 then
      return 'g' .. key
    else
      return key
    end
  end
end
vim.keymap.set({ 'n', 'v' }, 'j', mux_with_g 'j', { expr = true })
vim.keymap.set({ 'n', 'v' }, 'k', mux_with_g 'k', { expr = true })

-- Resize windows using <ctrl> + arrow keys
vim.keymap.set('n', '<M-up>', '<cmd>resize +2<cr>', { desc = 'Window Height, +' })
vim.keymap.set('n', '<M-down>', '<cmd>resize -2<cr>', { desc = 'Window Height, -' })
vim.keymap.set('n', '<M-left>', '<cmd>vertical resize -2<cr>', { desc = 'Window Width, +' })
vim.keymap.set('n', '<M-right>', '<cmd>vertical resize +2<cr>', { desc = 'Window Width, -' })

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
  vim.keymap.set('n', key, function()
    -- Execute the normal action for the key
    vim.cmd.normal(key)
    -- Then, call the custom function
    require('user.utils').hl_search_index()
  end, { desc = 'Search Index' })
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

-- Leader q: Neovim
vim.keymap.set('n', '<leader>qm', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>ql', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>qs', '<cmd>w !sudo tee %<cr>', { desc = 'Sudo Write' })
vim.keymap.set('n', '<leader>qq', '<cmd>tabclose<cr>', { desc = 'Close Tab' })

-- Leader t: Toggle
vim.keymap.set('n', '<leader>tc', function()
  vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == '{}' and { 100 } or {}
end, { desc = 'Color Column' })
vim.keymap.set('n', '<leader>th', '<cmd>set cursorline!<cr>', { desc = 'Hightlight Line' }) -- lua vim.opt.cursorline = not vim.opt.cursorline:get()
vim.keymap.set('n', '<leader>tr', '<cmd>set relativenumber!<cr>', { desc = 'Relative Number' }) -- set rnu! or lua vim.opt.relativenumber = not vim.opt.relativenumber:get()
vim.keymap.set('n', '<leader>ts', '<cmd>windo set scrollbind!<cr>', { desc = 'Scrollbind, in open windows' })
vim.keymap.set('n', '<leader>tt', function()
  vim.opt.showtabline = (vim.opt.showtabline:get() == 0) and 2 or 0
end, { desc = 'Tab Line' })
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = 'Wrap' }) -- lua vim.opt.wrap = not vim.opt.wrap:get()
