--
-- utils.lua

-- Show search index at the end of the same line as the cursor
-- https://www.reddit.com/r/neovim/comments/12o6tk5/search_index/

local search_count_extmark_id

local function show_search_index()
  local namespaceId = vim.api.nvim_create_namespace 'search'
  vim.api.nvim_buf_clear_namespace(0, namespaceId, 0, -1)
  local searchCount = vim.fn.searchcount()
  search_count_extmark_id = vim.api.nvim_buf_set_extmark(0, namespaceId, vim.api.nvim_win_get_cursor(0)[1] - 1, 0, {
    virt_text = { { '[' .. searchCount.current .. '/' .. searchCount.total .. ']', 'StatusLine' } },
    virt_text_pos = 'eol',
  })

  vim.cmd 'redraw'
end

local function clear_search_index()
  local namespaceId = vim.api.nvim_get_namespaces()['search']
  vim.api.nvim_buf_del_extmark(0, namespaceId, search_count_extmark_id)
end

-- These keys should work as they normally do, but additionally we want to trigger `show_search_index` with them
local keys = { 'n', 'N', '*', '#', 'g*', 'g#' }
for _, key in ipairs(keys) do
  vim.keymap.set('n', key, function()
    vim.cmd('normal! ' .. key)
    show_search_index()
  end, { noremap = true })
end

-- Remove search highlighting and index when pressing <esc> in normal mode
vim.keymap.set('n', '<esc>', function()
  vim.cmd.nohlsearch()
  clear_search_index()
end)

vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = vim.api.nvim_create_augroup('SearchIndex', { clear = true }),
  callback = function(event)
    -- for some reason "pattern" doesn't work when adding "?"
    if event.match == '/' or event.match == '?' then
      show_search_index()
    end
  end,
})
