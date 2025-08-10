--
-- keymaps.lua

-- Leader key, space, do nothing when space is pressed in normal or visual mode
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>')

-- Clean up search results and extmarks with <esc>
-- vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr><cmd>lua require("user.utils").hl_search_index_clear()<cr>')
vim.keymap.set('n', '<esc>', function()
  vim.cmd 'nohlsearch'
  require('user.utils').hl_search_index_clear()
  -- require('multicursor-nvim').clearCursors()
end)

-- Exit terminal mode in the builtin terminal with <esc> (default: <C-\><C-n>).
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- Yank with right mouse button
vim.keymap.set('v', '<RightMouse>', 'y', { desc = 'Yank' })

-- Save file
vim.keymap.set({ 'n', 'v' }, '<C-w><C-w>', '<cmd>w<cr>', { desc = 'Save File' })

-- Back/End of word with <left>/<right> keys
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

-- Resize windows using <alt> + arrow keys
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

-- Buffer
-- vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
-- vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-h>', function()
  require('user.utils').jl_buf_backward()
end, { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', function()
  require('user.utils').jl_buf_forward()
end, { desc = 'Next Buffer' })

-- Tabs
vim.keymap.set({ 'n', 'v' }, '<leader>+', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set({ 'i', 'n', 'v', 't' }, '<M-v>', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
vim.keymap.set({ 'i', 'n', 'v', 't' }, '<M-b>', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
for idx, char in ipairs { 'z', 'x', 'c' } do
  vim.keymap.set({ 'n', 'v' }, string.format('<M-%s>', char), string.format('%sgt', idx))
end

-- Indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Search index
local keys = { 'n', 'N', '*', '#', 'g*', 'g#' }
for _, key in ipairs(keys) do
  vim.keymap.set('n', key, key .. '<cmd>lua require("user.utils").hl_search_index()<cr>', { desc = 'Search Index' })
end

-- Quickfix
vim.keymap.set('n', '<M-h>', '<cmd>cprev<cr>', { desc = 'Quickfix: Prev' }) -- included in mini.bracketed, [q
vim.keymap.set('n', '<M-l>', '<cmd>cnext<cr>', { desc = 'Quickfix: Next' }) -- included in mini.bracketed, ]q

-- Diagnostics (https://github.com/neovim/nvim-lspconfig)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic Message' }) -- included in mini.bracketed
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic Message' }) -- included in mini.bracketed
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic Error Messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' }) -- trouble, leader-xx

-- Leader d: Buffer (document)
vim.keymap.set('n', '<leader>dd', '<cmd>bd<cr>', { desc = 'Close Buffer' })
vim.keymap.set('n', '<leader>da', '<cmd>%bdelete<cr>', { desc = 'Close All Buffers' })
vim.keymap.set('n', '<leader>dx', '<cmd>bd!<cr>', { desc = 'Kill Buffer (Ignore Unsaved Changes)' })

-- Execute line with bash
vim.keymap.set('n', '<leader>de', '<cmd>.w !bash<cr>', { desc = 'Execute line, bash' })
vim.keymap.set('n', '<leader>dj', '<cmd>.w !bash | jq<cr>', { desc = 'Execute line, bash | jq' })
vim.keymap.set('n', '<leader>dE', function()
  local line = vim.fn.getline '.'
  local output = vim.fn.system('bash -c ' .. vim.fn.shellescape(line))
  vim.fn.setreg('+', output)
end, { desc = 'Execute line, bash > clipboard' })

-- open project/curl.sh in a split to the right
vim.keymap.set('n', '<leader>dc', function()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if not git_root or git_root == '' then
    print 'Not in a git repository'
  end
  local project_curl = git_root .. '/project/curl.sh'

  if vim.fn.filereadable(project_curl) == 1 then
    local width_percentage = 40
    local width = math.floor(vim.o.columns * (width_percentage / 100))
    vim.cmd 'vsplit'
    vim.cmd('vertical resize ' .. width)
    vim.cmd('edit ' .. project_curl)
  else
    print 'No project/curl.sh file found'
  end
end, { desc = 'Open project/curl' })

-- Leader z: nvim/Lua
vim.keymap.set('n', '<leader>zm', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>zl', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>zs', '<cmd>w !sudo tee %<cr>', { desc = 'Sudo Write' })
-- make different based on filetype? so same keymaps work for both .lua and .sh files
vim.keymap.set('n', '<leader>zs', '<cmd>source %<CR>', { desc = 'Lua: Source file' })
vim.keymap.set('n', '<leader>zx', ':.lua<CR>', { desc = 'Lua: Execute line' })
vim.keymap.set('v', '<leader>zx', ':lua<CR>', { desc = 'Lua: Execute selection' })

-- Leader t: Toggle
vim.keymap.set('n', '<leader>tc', function()
  vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == '{}' and { 80, 96 } or {}
end, { desc = 'Color Column' })
-- vim.keymap.set('n', '<leader>th', '<cmd>set cursorline!<cr>', { desc = 'Hightlight Line' }) -- lua vim.opt.cursorline = not vim.opt.cursorline:get()
vim.keymap.set('n', '<leader>tr', '<cmd>set relativenumber!<cr>', { desc = 'Relative Number' }) -- set rnu! or lua vim.opt.relativenumber = not vim.opt.relativenumber:get()
vim.keymap.set('n', '<leader>ts', '<cmd>windo set scrollbind!<cr>', { desc = 'Scrollbind, in open windows' })
vim.keymap.set('n', '<leader>tt', function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.showtabline = (vim.opt.showtabline:get() == 0) and 2 or 0
end, { desc = 'Tab Line' })
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = 'Wrap' }) -- lua vim.opt.wrap = not vim.opt.wrap:get()
