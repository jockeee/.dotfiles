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

-- https://github.com/kwkarlwang/bufjump.nvim/blob/master/lua/bufjump.lua
local jumpbackward = function(num)
  vim.cmd([[execute "normal! ]] .. tostring(num) .. [[\<c-o>"]])
end

local jumpforward = function(num)
  vim.cmd([[execute "normal! ]] .. tostring(num) .. [[\<c-i>"]])
end

M.jl_buf_backward = function()
  local getjumplist = vim.fn.getjumplist()
  local jumplist = getjumplist[1]
  if #jumplist == 0 then
    return
  end

  -- plus one because of one index
  local i = getjumplist[2] + 1
  local j = i
  local curBufNum = vim.fn.bufnr()
  local targetBufNum = curBufNum

  while j > 1 and (curBufNum == targetBufNum or not vim.api.nvim_buf_is_valid(targetBufNum)) do
    j = j - 1
    targetBufNum = jumplist[j].bufnr
  end
  if targetBufNum ~= curBufNum and vim.api.nvim_buf_is_valid(targetBufNum) then
    jumpbackward(i - j)
  end
end

M.jl_buf_forward = function()
  local getjumplist = vim.fn.getjumplist()
  local jumplist = getjumplist[1]
  if #jumplist == 0 then
    return
  end

  local i = getjumplist[2] + 1
  local j = i
  local curBufNum = vim.fn.bufnr()
  local targetBufNum = curBufNum

  -- find the next different buffer
  while j < #jumplist and (curBufNum == targetBufNum or vim.api.nvim_buf_is_valid(targetBufNum) == false) do
    j = j + 1
    targetBufNum = jumplist[j].bufnr
  end
  while j + 1 <= #jumplist and jumplist[j + 1].bufnr == targetBufNum and vim.api.nvim_buf_is_valid(targetBufNum) do
    j = j + 1
  end
  if j <= #jumplist and targetBufNum ~= curBufNum and vim.api.nvim_buf_is_valid(targetBufNum) then
    jumpforward(j - i)
  end
end

return M

