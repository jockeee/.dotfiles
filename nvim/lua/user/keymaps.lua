--
-- keymaps.lua

-- Leader key, space, do nothing when space is pressed in normal or visual mode
vim.keymap.set({ 'n', 'x' }, '<space>', '<nop>')

-- Clean up search results and extmarks with <esc>
vim.keymap.set('n', '<Esc>', function()
  vim.cmd 'nohlsearch'

  local ok, err = pcall(function()
    require('user.utils').search_index_clear()
  end)
  if not ok then
    vim.notify('Error clearing search index: ' .. err, vim.log.levels.ERROR)
  end
  ---@diagnostic disable-next-line: redefined-local
  local ok, err = pcall(function()
    require('multicursor-nvim').clearCursors()
  end)
  if not ok then
    vim.notify('Error clearing multicursor: ' .. err, vim.log.levels.ERROR)
  end
end)

-- Exit terminal mode in the builtin terminal with <esc> (default: <C-\><C-n>).
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set({ 'n', 'x', 't' }, '`', '<cmd>Floaterminal<cr>', { desc = 'Floaterminal' })

-- Mouse, right click
-- visual mode, yank
vim.keymap.set('x', '<RightMouse>', 'y', { desc = 'Yank' })
-- normal mode, toggle fold
vim.keymap.set('n', '<RightMouse>', function()
  local mouse = vim.fn.getmousepos()
  if mouse.winid ~= vim.api.nvim_get_current_win() then
    vim.api.nvim_set_current_win(mouse.winid)
  end
  vim.api.nvim_win_set_cursor(0, { mouse.line, mouse.column })
  pcall(function()
    vim.cmd 'normal! za'
  end)
end)

-- Yank
vim.keymap.set('n', 'yl', '^vg_y', { desc = 'Yank: line content' })

vim.keymap.set('n', 'yu', function()
  local line = vim.api.nvim_get_current_line()
  local url = line:match 'https?://%S+'
  if url then
    vim.fn.setreg('"', url)
    vim.notify('Yank: ' .. url, vim.log.levels.INFO)
  else
    vim.notify('No URL found on this line', vim.log.levels.WARN)
  end
end, { desc = 'Yank: URL from current line' })

vim.keymap.set('n', 'yc', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  -- Lua strings are 1-based, but col is 0-based
  local left = col + 1
  local right = col + 1

  -- Move left to the first non-space character
  while left > 1 and line:sub(left - 1, left - 1):match '%S' do
    left = left - 1
  end
  -- Move right to the last non-space character
  while right <= #line and line:sub(right + 1, right + 1):match '%S' do
    right = right + 1
  end

  local word = line:sub(left, right)
  if word ~= '' then
    vim.fn.setreg('"', word)
    vim.notify('Yank: ' .. word, vim.log.levels.INFO)
  else
    vim.notify('No non-space word under cursor', vim.log.levels.WARN)
  end
end, { desc = 'Yank: everything between spaces under cursor' })

vim.keymap.set('i', '<C-Del>', '<C-o>dw', { desc = 'Delete word' })

-- Use :checktime to check if file changed outside nvim and reload it
--  :h 'autoread'
vim.keymap.set('n', '<leader>r', '<cmd>checktime<cr>', { desc = 'Reload file' })

-- gx, with try open as github repo
vim.keymap.set('n', 'gx', function()
  local target = vim.fn.expand '<cfile>'
  local is_url = target:match '^http[s]?://' or target:match '^www%.'
  local user, repo = target:match '^(%w[%w%-_%.]*)/(%w[%w%-_%.]*)$'

  if not is_url and (user and repo) then
    local url = string.format('https://github.com/%s/%s', user, repo)
    vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
    return
  end

  vim.fn.jobstart({ 'xdg-open', target }, { detach = true })
end, { desc = 'open, try as github repo' })

-- Keep clipboard content
-- vim.keymap.set('n', 'd', '"ad') -- visual ('x') `d` goes to default register
vim.keymap.set({ 'n', 'x' }, 'c', '"_c')
vim.keymap.set({ 'n', 'x' }, 'C', '"_C')
vim.keymap.set({ 'n', 'x' }, 'D', '"_D')
vim.keymap.set({ 'n', 'x' }, 's', '"_s')
vim.keymap.set({ 'n', 'x' }, 'S', '"_S')
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, 'X', '"_X')

-- Save file
vim.keymap.set({ 'n', 'x' }, '<C-w><C-w>', '<cmd>w<cr>', { desc = 'Save file' })

-- Back/End of word with <left>/<right> keys
vim.keymap.set({ 'n', 'x' }, '<left>', 'b')
vim.keymap.set({ 'n', 'x' }, '<right>', 'e')

-- j/k navigate visual lines (wrapped lines)
-- vim.keymap.set('n', 'j', 'gj')
-- vim.keymap.set('n', 'k', 'gk')
local mux_with_g = function(key)
  return function()
    if vim.v.count == 0 then
      return 'g' .. key
    else
      return key
    end
  end
end
vim.keymap.set({ 'n', 'x' }, 'j', mux_with_g 'j', { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', mux_with_g 'k', { expr = true })

-- Using smart-splits instead
-- Window, focus
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window: left' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window: down' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window: up' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window: right' })
-- Window, resize
-- vim.keymap.set('n', '<M-up>', '<cmd>resize +2<cr>', { desc = 'Window Height, +' })
-- vim.keymap.set('n', '<M-down>', '<cmd>resize -2<cr>', { desc = 'Window Height, -' })
-- vim.keymap.set('n', '<M-left>', '<cmd>vertical resize -2<cr>', { desc = 'Window Width, +' })
-- vim.keymap.set('n', '<M-right>', '<cmd>vertical resize +2<cr>', { desc = 'Window Width, -' })

-- Move lines up/down
vim.keymap.set('n', '<M-j>', '<cmd>m .+1<cr>==', { desc = 'Line: move down' })
vim.keymap.set('n', '<M-k>', '<cmd>m .-2<cr>==', { desc = 'Line: move up' })
vim.keymap.set('i', '<M-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Line: move down' })
vim.keymap.set('i', '<M-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Line: move up' })
vim.keymap.set('x', '<M-j>', ":m '>+1<cr>gv=gv", { desc = 'Lines: move down' })
vim.keymap.set('x', '<M-k>', ":m '<-2<cr>gv=gv", { desc = 'Lines: move up' })

-- Buffer
-- vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
-- vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-h>', function()
  require('user.utils').jl_buf_backward()
end, { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', function()
  require('user.utils').jl_buf_forward()
end, { desc = 'Next Buffer' })

vim.keymap.set('n', '<C-m>', 'H', { desc = 'Move to top of screen' })
vim.keymap.set('n', '<C-,>', 'M', { desc = 'Move to middle of screen' })
vim.keymap.set('n', '<C-.>', 'L', { desc = 'Move to bottom of screen' })

-- Tabs
vim.keymap.set({ 'n', 'x' }, '<leader>+', '<cmd>tabnew<cr>', { desc = 'Tab: new' })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<M-v>', '<cmd>tabprevious<cr>', { desc = 'Tab: previous' })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<M-b>', '<cmd>tabnext<cr>', { desc = 'Tab: next' })

-- this is tab bar order, not buffer swapping in splits.
-- use C-w h/j/k/l for swapping buffers between windows (using smart-splits)
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<S-M-v>', function()
  local current_tab = vim.fn.tabpagenr()
  if current_tab > 1 then
    vim.cmd '-tabmove'
  end
end, { desc = 'Tab: move left' })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<S-M-b>', function()
  local current_tab = vim.fn.tabpagenr()
  local total_tabs = vim.fn.tabpagenr '$'
  if current_tab < total_tabs then
    vim.cmd '+tabmove'
  end
end, { desc = 'Tab: move right' })

-- M-[a-d,z-c] used by harpoon
-- for idx, char in ipairs { 'z', 'x', 'c' } do
--   vim.keymap.set({ 'n', 'x' }, string.format('<M-%s>', char), string.format('%sgt', idx), { desc = 'Tab: switch to tab ' .. idx })
-- end

-- Marks
do
  local prefix = "'"
  local offset = 3

  local function jump_mark_adjust(mark)
    vim.cmd('normal! ' .. prefix .. mark)
    local pos = vim.api.nvim_win_get_cursor(0)
    local target_line = math.max(1, pos[1] - offset)
    vim.api.nvim_win_set_cursor(0, { target_line, 0 })
    vim.cmd 'normal! zt'
    vim.api.nvim_win_set_cursor(0, pos)
  end

  for _, range in ipairs { { 'a', 'z' }, { 'A', 'Z' }, { '0', '9' } } do
    for c = string.byte(range[1]), string.byte(range[2]) do
      local mark = string.char(c)
      vim.keymap.set('n', prefix .. mark, function()
        jump_mark_adjust(mark)
      end, { noremap = true, silent = true, desc = 'Jump to mark, with context' })
    end
  end
end
-- Remap zt/zb to zj/zk
vim.keymap.set('n', 'zj', 'zt', { desc = 'Top this line' })
vim.keymap.set('n', 'zk', 'zb', { desc = 'Bottom this line' })

-- Indenting
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- Search index
local keys = { 'n', 'N', '*', '#', 'g*', 'g#' }
for _, key in ipairs(keys) do
  vim.keymap.set('n', key, key .. '<cmd>lua require("user.utils").search_index()<cr>')
end

-- Quickfix
vim.keymap.set('n', '<M-p>', '<cmd>cprev<cr>', { desc = 'Quickfix: prev' }) -- included in v0.11, [q
vim.keymap.set('n', '<M-n>', '<cmd>cnext<cr>', { desc = 'Quickfix: next' }) -- included in v0.11, ]q

vim.keymap.set('n', '<leader>yf', function()
  vim.fn.setreg('+', vim.fn.expand '%:.')
end, { desc = 'Yank file path' })

-- Markdown, bold
vim.keymap.set({ 'n', 'i' }, '<C-b>', function()
  local mode = vim.api.nvim_get_mode().mode
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- Adjust col for insert mode, col is after the cursor
  if mode == 'i' then
    col = col - 1
    if col < 0 then
      col = 0
    end
  end

  -- Remove bold (**...**) if cursor is inside or on asterisks
  local search_start = 1
  while true do
    local s, e = line:find('%*%*.-%*%*', search_start)
    if not s then
      break
    end
    if col + 1 >= s and col + 1 <= e then
      local word_start, word_end = s + 2, e - 2
      local new_line = line:sub(1, s - 1) .. line:sub(word_start, word_end) .. line:sub(e + 1)
      local new_col = (col + 1 <= word_start or col + 1 > word_end) and (s - 1) or (col - 2)
      vim.api.nvim_set_current_line(new_line)
      vim.api.nvim_win_set_cursor(0, { row, new_col })
      if mode == 'i' then
        vim.cmd 'startinsert'
      end
      return
    end
    search_start = e + 1
  end

  -- Remove **** if cursor is on or between them
  local s, e = line:find '%*%*%*%*'
  while s do
    if col + 1 >= s and col + 1 <= e + 1 then
      vim.api.nvim_set_current_line(line:sub(1, s - 1) .. line:sub(e + 1))
      vim.api.nvim_win_set_cursor(0, { row, math.max(s - 3, 0) })
      if mode == 'i' then
        vim.cmd 'startinsert'
      end
      return
    end
    s, e = line:find('%*%*%*%*', e + 1)
  end

  -- If on a word, surround with **
  local cword = vim.fn.expand '<cword>'
  if cword ~= '' then
    local ws, we = line:find(cword, 1, true)
    while ws and not (col + 1 >= ws and col + 1 <= we) do
      ws, we = line:find(cword, we + 1, true)
    end
    if ws then
      vim.api.nvim_set_current_line(line:sub(1, ws - 1) .. '**' .. cword .. '**' .. line:sub(we + 1))
      vim.api.nvim_win_set_cursor(0, { row, col + 2 })
      if mode == 'i' then
        vim.cmd 'startinsert'
      end
      return
    end
  end

  -- Otherwise, insert **** at cursor and move between
  vim.api.nvim_set_current_line(line:sub(1, col) .. '****' .. line:sub(col + 1))
  vim.api.nvim_win_set_cursor(0, { row, col + 2 })
  if mode == 'i' then
    vim.cmd 'startinsert'
  end
end, { desc = 'Text, bold, **word** or insert/remove ****' })

-- Leader d: Buffer (document)
vim.keymap.set('n', '<leader>dd', '<cmd>bp|bd#<cr>', { desc = 'Close buffer' }) -- bprevious, bdelete# (previous buffer)
vim.keymap.set('n', '<leader>da', '<cmd>%bdelete!<cr>', { desc = 'Close all buffers (incl window/splits)' })
-- vim.keymap.set('n', '<leader>da', function()
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype ~= 'terminal' then
--       vim.api.nvim_buf_delete(buf, {})
--     end
--   end
-- end, { desc = 'Close All Buffers, Except Terminals' })
vim.keymap.set('n', '<leader>dx', '<cmd>bp|bd!#<cr>', { desc = 'Kill buffer (ignore unsaved changes)' })

-- Yank Unicode code point of character under cursor
vim.keymap.set('n', '<leader>uy', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local ch = vim.fn.strcharpart(line, col, 1)

  local cp = vim.fn.strgetchar(ch, 0)
  local out = string.format('u%04x', cp)

  vim.fn.setreg('+', out)
  vim.notify(out)
end, { desc = 'Yank unicode code point' })

-- Convert unicode escapes to utf-8 characters
vim.keymap.set('n', '<leader>ui', function()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for i, line in ipairs(lines) do
    lines[i] = line:gsub('\\[uU]0*([%da-fA-F]+)', function(hex)
      return vim.fn.nr2char(tonumber(hex, 16))
    end)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end, { desc = 'Convert unicode escapes to utf-8 characters' })

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
end, { desc = 'Bash: execute line' })

vim.keymap.set('n', '<leader>dE', function()
  local line = vim.fn.getline '.'
  local output = vim.fn.system('bash -c ' .. vim.fn.shellescape(line))
  vim.fn.setreg('+', output)
end, { desc = 'Bash: execute line, to clipboard' })

-- open tests/curl.sh in a split to the right
vim.keymap.set('n', '<leader>dc', function()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if not git_root or git_root == '' then
    print 'Not in a git repository'
  end
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

-- Leader s: Toggle
-- vim.keymap.set('n', '<leader>sL', function()
--   vim.o.colorcolumn = vim.o.colorcolumn == '' and '100' or ''
--   -- vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == '{}' and { 100 } or {}
-- end, { desc = 'UI color columns' })
vim.keymap.set('n', '<leader>sL', function()
  vim.o.colorcolumn = vim.o.colorcolumn == '' and '81,101' or ''
  -- vim.opt.colorcolumn = vim.inspect(vim.opt.colorcolumn:get()) == '{}' and { 80, 100 } or {}
end, { desc = 'UI color columns' })

local function get_color_cols()
  local ok_colors, colors = pcall(require, 'nordic.colors')
  local ok_util, util = pcall(require, 'nordic.utils')

  local base = (ok_colors and colors and colors.gray0) or '#1f1f1f'

  if ok_util and util and util.blend then
    local col80 = util.blend('#ffffff', base, 0.05)
    local col100 = util.blend('#ffffff', base, 0.11)
    return col80, col100
  else
    return '#2e2e2e', '#3e3e3e'
  end
end

local colorcol_enabled = false
local function UserLineColorColumns()
  local col80, col100 = get_color_cols()

  vim.api.nvim_set_hl(0, 'ColorCol80', { bg = col80 })
  vim.api.nvim_set_hl(0, 'ColorCol100', { bg = col100 })

  if colorcol_enabled then
    vim.fn.clearmatches()
    colorcol_enabled = false
  else
    vim.fn.matchadd('ColorCol80', '\\%81v.')
    vim.fn.matchadd('ColorCol100', '\\%101v.')
    colorcol_enabled = true
  end
end
vim.keymap.set('n', '<leader>sl', UserLineColorColumns, { desc = 'Line color columns' })
vim.api.nvim_create_autocmd('UIEnter', {
  group = vim.api.nvim_create_augroup('u-line-color-columns', { clear = true }),
  callback = UserLineColorColumns,
  desc = 'Set line color columns on startup',
})

-- vim.keymap.set('n', '<leader>sc', '<cmd>set cursorline!<cr>', { desc = 'Cursor line' }) -- lua vim.opt.cursorline = not vim.opt.cursorline:get()
vim.keymap.set('n', '<leader>sr', '<cmd>set relativenumber!<cr>', { desc = 'Relative numbers' }) -- set rnu! or lua vim.opt.relativenumber = not vim.opt.relativenumber:get()
vim.keymap.set('n', '<leader>ss', vim.snippet.stop, { desc = 'Snippet: stop' })
vim.keymap.set('n', '<leader>sS', '<cmd>windo set scrollbind!<cr>', { desc = 'Scrollbind: open windows' })
vim.keymap.set('n', '<leader>st', function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.showtabline = (vim.opt.showtabline:get() == 0) and 1 or 0
end, { desc = 'Tab Line' })

-- leader M: Marks
vim.keymap.set('n', '<leader>M', '<cmd>marks<cr>', { desc = 'Marks' })

-- leader w: Wrap
vim.keymap.set('n', '<leader>w', '<cmd>set wrap!<cr>', { desc = 'Wrap text' }) -- lua vim.opt.wrap = not vim.opt.wrap:get()

-- Leader z: nvim, lua, and tools
vim.keymap.set('n', '<leader>zh', '<cmd>MCPHub<cr>', { desc = 'MCP hub' })
vim.keymap.set('n', '<leader>zm', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>zl', '<cmd>Lazy<cr>', { desc = 'Lazy' })
-- vim.keymap.set('n', '<leader>zs', '<cmd>w !sudo tee %<cr>', { desc = 'Sudo Write' })
-- make different based on filetype? so same keymaps work for both .lua and .sh files
vim.keymap.set('n', '<leader>zs', '<cmd>source %<CR>', { desc = 'Lua: source file' })
vim.keymap.set('n', '<leader>zx', ':.lua<CR>', { desc = 'Lua: execute line' })
vim.keymap.set('x', '<leader>zx', ':lua<CR>', { desc = 'Lua: execute selection' })
