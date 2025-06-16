--
-- keymaps.lua

-- Leader key, space, do nothing when space is pressed in normal or visual mode
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>')

-- Clean up search results and extmarks with <esc>
-- vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr><cmd>lua require("user.utils").search_index_clear()<cr>')
vim.keymap.set('n', '<esc>', function()
  vim.cmd 'nohlsearch'
  require('user.utils').search_index_clear()
  require('multicursor-nvim').clearCursors()
end)
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.keymap.set('n', '+', 'i', { desc = 'Terminal Insert Mode', buffer = true })
  end,
})

-- Exit terminal mode in the builtin terminal with <esc> (default: <C-\><C-n>).
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })
vim.keymap.set({ 'n', 'v', 't' }, '`', '<cmd>Floaterminal<cr>', { desc = 'Toggle Floaterminal' })

-- Mouse, right click
-- visual mode, yank
vim.keymap.set('v', '<RightMouse>', 'y', { desc = 'Yank' })
-- normal mode, toggle fold
vim.keymap.set('n', '<RightMouse>', function()
  local mouse = vim.fn.getmousepos()
  vim.api.nvim_win_set_cursor(0, { mouse.line, mouse.column })
  if vim.fn.foldclosed '.' ~= -1 then vim.cmd 'normal! za' end
end, { desc = 'Toggle Fold' })

-- Yank
vim.keymap.set('n', 'yc', '^vg_y', { desc = 'Yank Line Content' })
vim.keymap.set('n', 'yl', '^vg_y', { desc = 'Yank Line Content' })

-- Keep clipboard content
vim.keymap.set({ 'n', 'x' }, 'c', '"ac')
vim.keymap.set({ 'n', 'x' }, 'C', '"aC')
vim.keymap.set('n', 'd', '"ad') -- visual delete 'x' goes to default register
vim.keymap.set({ 'n', 'x' }, 'D', '"aD')
vim.keymap.set({ 'n', 'x' }, 's', '"as')
vim.keymap.set({ 'n', 'x' }, 'S', '"aS')
vim.keymap.set({ 'n', 'x' }, 'x', '"ax')
vim.keymap.set({ 'n', 'x' }, 'X', '"aX')
vim.keymap.set('x', 'p', '"adP')
vim.keymap.set('x', 'P', '"adP')

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

-- Using smart-splits plugin instead
-- Resize windows using <alt> + arrow keys
-- vim.keymap.set('n', '<M-up>', '<cmd>resize +2<cr>', { desc = 'Window Height, +' })
-- vim.keymap.set('n', '<M-down>', '<cmd>resize -2<cr>', { desc = 'Window Height, -' })
-- vim.keymap.set('n', '<M-left>', '<cmd>vertical resize -2<cr>', { desc = 'Window Width, +' })
-- vim.keymap.set('n', '<M-right>', '<cmd>vertical resize +2<cr>', { desc = 'Window Width, -' })

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
vim.keymap.set({ 'i', 'n', 'v', 't' }, '<S-M-v>', function()
  local current_tab = vim.fn.tabpagenr()
  if current_tab > 1 then vim.cmd '-tabmove' end
end, { desc = 'Move Tab Left' })

vim.keymap.set({ 'i', 'n', 'v', 't' }, '<S-M-b>', function()
  local current_tab = vim.fn.tabpagenr()
  local total_tabs = vim.fn.tabpagenr '$'
  if current_tab < total_tabs then vim.cmd '+tabmove' end
end, { desc = 'Move Tab Right' })
for idx, char in ipairs { 'z', 'x', 'c' } do
  vim.keymap.set({ 'n', 'v' }, string.format('<M-%s>', char), string.format('%sgt', idx), { desc = 'Switch to tab ' .. idx })
end

-- Indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Search index
local keys = { 'n', 'N', '*', '#', 'g*', 'g#' }
for _, key in ipairs(keys) do
  vim.keymap.set('n', key, key .. '<cmd>lua require("user.utils").search_index()<cr>', { desc = 'Search Index' })
end

-- Quickfix
vim.keymap.set('n', '<M-p>', '<cmd>cprev<cr>', { desc = 'Quickfix: Prev' }) -- included in mini.bracketed, [q
vim.keymap.set('n', '<M-n>', '<cmd>cnext<cr>', { desc = 'Quickfix: Next' }) -- included in mini.bracketed, ]q

-- Diagnostics (https://github.com/neovim/nvim-lspconfig)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic Message' }) -- included in mini.bracketed
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic Message' }) -- included in mini.bracketed
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic Error Messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' }) -- trouble, leader-xx

-- Leader d: Buffer (document)
vim.keymap.set('n', '<leader>dd', '<cmd>bp|bd#<cr>', { desc = 'Close Buffer' }) -- bprevious, bdelete# (previous buffer)
vim.keymap.set('n', '<leader>da', '<cmd>%bdelete!<cr>', { desc = 'Close All Buffers (incl window/splits)' })
-- vim.keymap.set('n', '<leader>da', function()
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype ~= 'terminal' then
--       vim.api.nvim_buf_delete(buf, {})
--     end
--   end
-- end, { desc = 'Close All Buffers, Except Terminals' })
vim.keymap.set('n', '<leader>dx', '<cmd>bd!<cr>', { desc = 'Kill Buffer (Ignore Unsaved Changes)' })

-- Convert unicode escapes to utf-8 characters
vim.keymap.set('n', '<leader>du', function()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for i, line in ipairs(lines) do
    lines[i] = line:gsub('\\[uU]0*([%da-fA-F]+)', function(hex)
      return vim.fn.nr2char(tonumber(hex, 16))
    end)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end, { desc = 'Convert Unicode Escapes' })

-- Execute line, bash
-- vim.keymap.set('n', '<leader>de', '<cmd>.w !bash<cr>', { desc = 'Execute line, bash' })
vim.keymap.set('n', '<leader>de', function()
  local line = vim.fn.getline '.'
  local cmd = '$ ' .. line .. '\n\n'

  -- curl file download, async job
  if line:match '^curl' and line:match '%-o' then
    vim.fn.jobstart(line, {
      on_stdout = function(_, data)
        if data then
          for _, d in ipairs(data) do
            print(d)
          end
        end
      end,
      on_stderr = function(_, data)
        if data then
          for _, d in ipairs(data) do
            print(cmd .. 'Error: ' .. d)
          end
        end
      end,
      on_exit = function(_, exit_code)
        if exit_code ~= 0 then
          print(cmd .. 'Async command failed with exit code: ' .. exit_code)
        else
          print(cmd .. 'Async command executed successfully')
        end
      end,
    })
    return
  end

  local result = vim.fn.system(line)
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    if exit_code == 127 then
      print(cmd .. 'Command not found')
      return
    elseif line:match '^curl' then
      if exit_code == 7 then
        print(cmd .. "curl: couldn't connect to host")
        return
      end
    else
      print(cmd .. 'Command failed with exit code: ' .. exit_code)
      return
    end
  end

  -- curl command
  if line:match '^curl' then
    local headers, body = '', ''
    local parts = vim.split(result, '\r?\n\r?\n')
    for i, part in ipairs(parts) do
      if i < #parts then
        headers = headers .. part .. '\r\n\r\n'
      else
        body = part
      end
    end

    if body:match '^%s*{' or body:match '^%s*%[' then
      -- json
      local jq_cmd = string.format('echo %s | jq', vim.fn.shellescape(body))
      local jq_result = vim.fn.system(jq_cmd)
      if vim.v.shell_error == 0 then
        print(cmd .. headers .. jq_result)
      else
        print(cmd .. headers .. body)
      end
    else
      -- not json
      print(cmd .. headers .. body)
    end
  else
    print(cmd .. result)
  end
end, { desc = 'Execute line, bash' })
vim.keymap.set('n', '<leader>dE', function()
  local line = vim.fn.getline '.'
  local output = vim.fn.system('bash -c ' .. vim.fn.shellescape(line))
  vim.fn.setreg('+', output)
end, { desc = 'Execute line, bash > clipboard' })

-- open tests/curl.sh in a split to the right
vim.keymap.set('n', '<leader>dc', function()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if not git_root or git_root == '' then print 'Not in a git repository' end
  local tests_curl = git_root .. '/tests/curl.sh'

  if vim.fn.filereadable(tests_curl) == 1 then
    local width_percentage = 50
    local width = math.floor(vim.o.columns * (width_percentage / 100))
    vim.cmd 'vsplit'
    vim.cmd('vertical resize ' .. width)
    vim.cmd('edit ' .. tests_curl)
  else
    print 'No tests/curl.sh file found'
  end
end, { desc = 'Open tests/curl.sh' })

-- Leader z: nvim/Lua
vim.keymap.set('n', '<leader>zm', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>zl', '<cmd>Lazy<cr>', { desc = 'Lazy' })
-- vim.keymap.set('n', '<leader>zs', '<cmd>w !sudo tee %<cr>', { desc = 'Sudo Write' })
-- make different based on filetype? so same keymaps work for both .lua and .sh files
vim.keymap.set('n', '<leader>zs', '<cmd>source %<CR>', { desc = 'Lua: Source file' })
vim.keymap.set('n', '<leader>zx', ':.lua<CR>', { desc = 'Lua: Execute line' })
vim.keymap.set('v', '<leader>zx', ':lua<CR>', { desc = 'Lua: Execute selection' })

-- Leader t: Toggle
vim.keymap.set('n', '<leader>tl', function()
  vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == '{}' and { 96 } or {}
end, { desc = 'Color Column Limits' })
-- vim.keymap.set('n', '<leader>tl', function()
--   vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == '{}' and { 80, 96 } or {}
-- end, { desc = 'Color Column Limits' })
-- vim.keymap.set('n', '<leader>tc', '<cmd>set cursorline!<cr>', { desc = 'Hightlight Line' }) -- lua vim.opt.cursorline = not vim.opt.cursorline:get()
vim.keymap.set('n', '<leader>tr', '<cmd>set relativenumber!<cr>', { desc = 'Relative Number' }) -- set rnu! or lua vim.opt.relativenumber = not vim.opt.relativenumber:get()
vim.keymap.set('n', '<leader>ts', '<cmd>windo set scrollbind!<cr>', { desc = 'Scrollbind, in open windows' })
vim.keymap.set('n', '<leader>tt', function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.showtabline = (vim.opt.showtabline:get() == 0) and 1 or 0
end, { desc = 'Tab Line' })
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = 'Wrap' }) -- lua vim.opt.wrap = not vim.opt.wrap:get()
vim.keymap.set('n', '<leader>W', '<cmd>set wrap!<cr>', { desc = 'Toggle: Wrap' }) -- lua vim.opt.wrap = not vim.opt.wrap:get()
