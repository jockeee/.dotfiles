--
-- utils.lua

local M = {}

M.hl_search_index = function()
  local ns = vim.api.nvim_create_namespace 'search'
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  local search_pat = '\\c\\%#' .. vim.fn.getreg '/'
  local ring = vim.fn.matchadd('IncSearch', search_pat)
  vim.cmd 'redraw'

  local sc = vim.fn.searchcount()
  vim.api.nvim_buf_set_extmark(0, ns, vim.api.nvim_win_get_cursor(0)[1] - 1, 0, {
    virt_text = { { '[' .. sc.current .. '/' .. sc.total .. ']', 'Comment' } },
    virt_text_pos = 'eol',
  })

  vim.fn.matchdelete(ring)
  vim.cmd 'redraw'
end

M.hl_search_index_clear = function()
  local ns = vim.api.nvim_get_namespaces().search
  if ns ~= nil then
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  end
end

return M
