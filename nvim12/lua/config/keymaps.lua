--
-- config/keymaps.lua

-- Leader key, space, do nothing when space is pressed in normal or visual mode
vim.keymap.set({ 'n', 'x' }, '<space>', '<nop>')

-- Escape
--  Clean up search results and extmarks with <Esc>
vim.keymap.set('n', '<Esc>', function()
  vim.cmd 'nohlsearch'

  local ok, err = pcall(function() require('config.utils').search_index_clear() end)
  if not ok then vim.notify('Error clearing search index: ' .. err, vim.log.levels.ERROR) end

  ok, err = pcall(function() require('multicursor-nvim').clearCursors() end)
  if not ok then vim.notify('Error clearing multicursor: ' .. err, vim.log.levels.ERROR) end
end)

-- Save file
vim.keymap.set({ 'n', 'x' }, '<C-w><C-w>', '<cmd>w<cr>', { desc = 'Save file' })

-- Reload file
-- Use :checktime to check if file changed outside nvim and reload it
--  :h 'autoread'
vim.keymap.set('n', '<leader>r', '<cmd>checktime<cr>', { desc = 'Reload file' })

-- Keep clipboard content
-- vim.keymap.set('n', 'd', '"ad') -- visual (x) `d` goes to default register
vim.keymap.set({ 'n', 'x' }, 'c', '"_c')
vim.keymap.set({ 'n', 'x' }, 'C', '"_C')
vim.keymap.set({ 'n', 'x' }, 'D', '"_D')
vim.keymap.set({ 'n', 'x' }, 's', '"_s')
vim.keymap.set({ 'n', 'x' }, 'S', '"_S')
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, 'X', '"_X')

-- Back/end of word with left/right keys
vim.keymap.set({ 'n', 'x' }, '<Left>', 'b')
vim.keymap.set({ 'n', 'x' }, '<Right>', 'e')

-- Navigate visual lines
-- j/k navigates into visual lines (wrapped lines) if not prefixed with a count, i.e. `5j`
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
local mux_with_g = function(key)
  local gkey = 'g' .. key
  return function() return vim.v.count == 0 and gkey or key end
end
vim.keymap.set({ 'n', 'x' }, 'j', mux_with_g 'j', { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', mux_with_g 'k', { expr = true })

-- Buffer
-- vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
-- vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-h>', function() require('config.utils').jl_buf_backward() end, { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', function() require('config.utils').jl_buf_forward() end, { desc = 'Next Buffer' })

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

-- Cursor
vim.keymap.set('n', '<C-m>', 'H', { desc = 'Cursor: Move to top of screen' })
vim.keymap.set('n', '<C-,>', 'M', { desc = 'Cursor: Move to middle of screen' })
vim.keymap.set('n', '<C-.>', 'L', { desc = 'Cursor: Move to bottom of screen' })

-- Tabs
vim.keymap.set({ 'n', 'x' }, '<leader>+', '<cmd>tabnew<cr>', { desc = 'Tab: new' })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<M-v>', '<cmd>tabprevious<cr>', { desc = 'Tab: previous' })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<M-b>', '<cmd>tabnext<cr>', { desc = 'Tab: next' })

-- Change tab bar order (this is not buffer swapping in splits)
-- use C-w h/j/k/l for swapping buffers between windows/splits (using smart-splits)
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<S-M-v>', function()
  local current_tab = vim.fn.tabpagenr()
  if current_tab > 1 then vim.cmd '-tabmove' end
end, { desc = 'Tab: move left' })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<S-M-b>', function()
  local current_tab = vim.fn.tabpagenr()
  local total_tabs = vim.fn.tabpagenr '$'
  if current_tab < total_tabs then vim.cmd '+tabmove' end
end, { desc = 'Tab: move right' })

-- Indenting
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- Quickfix
vim.keymap.set('n', '<M-p>', '<cmd>cprev<cr>', { desc = 'Quickfix: prev' }) -- included in v0.11, [q
vim.keymap.set('n', '<M-n>', '<cmd>cnext<cr>', { desc = 'Quickfix: next' }) -- included in v0.11, ]q

---
--- Leader d: Buffer (document)
---

vim.keymap.set('n', '<leader>da', '<cmd>%bdelete!<cr>', { desc = 'Close all buffers (incl window/splits)' })
vim.keymap.set('n', '<leader>dd', '<cmd>bp|bd#<cr>', { desc = 'Close buffer' }) -- bprevious, bdelete# (previous buffer)
vim.keymap.set('n', '<leader>dp', '<cmd>let @+ = expand("%:p")<cr>', { desc = 'Copy file path' })
vim.keymap.set('n', '<leader>du', '<cmd>Undotree<cr>', { desc = 'undo tree' })
vim.keymap.set('n', '<leader>dx', '<cmd>bp|bd!#<cr>', { desc = 'Kill buffer (ignore unsaved changes)' })

---
--- Leader p: plugins (vim.pack)
---

-- :h vim.pack-examples
-- :h vim.pack.update()
--
-- ]] and [[ to navigate through plugin sections.
--
-- Some features are provided via LSP:
--    textDocument/documentSymbol   gO    via lsp-defaults or vim.lsp.buf.document_symbol() - show structure of the buffer.
--    textDocument/hover            K     via lsp-defaults or vim.lsp.buf.hover() show more information at cursor.
--                                        Like details of particular pending change or newer tag.
--    textDocument/codeAction       gra   via lsp-defaults or vim.lsp.buf.code_action() - show code actions relevant for "plugin at cursor".
--                                        Like "delete" (if plugin is not active), "update" or "skip updating" (if there are pending updates).

vim.keymap.set('n', '<leader>zu', vim.pack.update, { desc = 'update plugins' })
vim.keymap.set('n', '<leader>zl', function() vim.pack.update(nil, { offline = true }) end, { desc = 'list plugins' })

---
--- Leader s: Toggle
---

-- color columns
vim.keymap.set('n', '<leader>sL', function() vim.o.colorcolumn = vim.o.colorcolumn == '' and '81,101' or '' end, { desc = 'UI color columns' })

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

-- line color columns
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

---
--- Leader z: nvim, lua, and tools
---

vim.keymap.set('n', '<leader>zm', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>zs', '<cmd>source %<CR>', { desc = 'Lua: source file' })
vim.keymap.set('n', '<leader>zx', ':.lua<CR>', { desc = 'Lua: execute line' })
vim.keymap.set('x', '<leader>zx', ':lua<CR>', { desc = 'Lua: execute selection' })

---
--- "Extras"
---

-- gx, with "try open as github repo"
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

--
-- Markdown
--

-- Markdown, codeblock
vim.keymap.set('n', '<Leader>mm', function()
  vim.notify 'test'
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { '```', '', '```' })
  vim.api.nvim_win_set_cursor(0, { row, 3 }) -- opening ``` is now on the original line
  vim.cmd 'startinsert!'
end, { desc = 'md: code block' })

-- Markdown, bold
vim.keymap.set({ 'n', 'i' }, '<C-b>', function()
  local mode = vim.api.nvim_get_mode().mode
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- Adjust col for insert mode, col is after the cursor
  if mode == 'i' then
    col = col - 1
    if col < 0 then col = 0 end
  end

  -- Remove bold (**...**) if cursor is inside or on asterisks
  local search_start = 1
  while true do
    local s, e = line:find('%*%*.-%*%*', search_start)
    if not s then break end
    if col + 1 >= s and col + 1 <= e then
      local word_start, word_end = s + 2, e - 2
      local new_line = line:sub(1, s - 1) .. line:sub(word_start, word_end) .. line:sub(e + 1)
      local new_col = (col + 1 <= word_start or col + 1 > word_end) and (s - 1) or (col - 2)
      vim.api.nvim_set_current_line(new_line)
      vim.api.nvim_win_set_cursor(0, { row, new_col })
      if mode == 'i' then vim.cmd 'startinsert' end
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
      if mode == 'i' then vim.cmd 'startinsert' end
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
      if mode == 'i' then vim.cmd 'startinsert' end
      return
    end
  end

  -- Otherwise, insert **** at cursor and move between
  vim.api.nvim_set_current_line(line:sub(1, col) .. '****' .. line:sub(col + 1))
  vim.api.nvim_win_set_cursor(0, { row, col + 2 })
  if mode == 'i' then vim.cmd 'startinsert' end
end, { desc = 'md: Text, bold, **word** or insert/remove ****' })

---
--- Yank
---

-- yank "line content"
vim.keymap.set('n', 'yl', '^vg_y', { desc = 'yank: line content' })

-- yank "url on this line"
vim.keymap.set('n', 'yu', function()
  local line = vim.api.nvim_get_current_line()
  local url = line:match 'https?://%S+'
  if url then
    vim.fn.setreg('"', url)
    vim.notify('yank: ' .. url, vim.log.levels.INFO)
  else
    vim.notify('No URL found on this line', vim.log.levels.WARN)
  end
end, { desc = 'yank: url on this line' })

-- yank "whatever under cursor" (everything between spaces under cursor)
vim.keymap.set('n', 'yc', function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
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
    vim.notify('yank: ' .. word, vim.log.levels.INFO)
  else
    vim.notify('yank: no non-space word under cursor', vim.log.levels.WARN)
  end
end, { desc = 'yank: w/e under cursor' })

---
--- Unicode
---

-- Yank unicode code point of character under cursor
vim.keymap.set('n', '<leader>uy', function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
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
    lines[i] = line:gsub('\\[uU]0*([%da-fA-F]+)', function(hex) return vim.fn.nr2char(tonumber(hex, 16)) end)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end, { desc = 'Convert unicode escapes to utf-8 characters' })

---
--- Floaterminal
---

-- Exit terminal mode in the builtin terminal with <esc> (default: <C-\><C-n>).
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set({ 'n', 'x', 't' }, '`', '<cmd>Floaterminal<cr>', { desc = 'Floaterminal' })

---
--- Mouse, right click
---

-- visual mode = yank
vim.keymap.set('x', '<RightMouse>', 'y', { desc = 'Yank' })

-- normal mode = toggle fold
vim.keymap.set('n', '<RightMouse>', function()
  local mouse = vim.fn.getmousepos()
  if mouse.winid ~= vim.api.nvim_get_current_win() then vim.api.nvim_set_current_win(mouse.winid) end
  vim.api.nvim_win_set_cursor(0, { mouse.line, mouse.column })
  pcall(function() vim.cmd 'normal! za' end)
end)
