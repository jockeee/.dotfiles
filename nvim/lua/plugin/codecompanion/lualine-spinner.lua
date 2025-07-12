local M = {}

local spinner_symbols = {
  '⠋',
  '⠙',
  '⠹',
  '⠸',
  '⠼',
  '⠴',
  '⠦',
  '⠧',
  '⠇',
  '⠏',
}
local spinner_index = 1
local processing = false

-- Setup autocmd to watch for CodeCompanion events
do
  local group = vim.api.nvim_create_augroup('CodeCompanionLualine', { clear = true })

  vim.api.nvim_create_autocmd('User', {
    pattern = { 'CodeCompanionRequestStarted', 'CodeCompanionRequestFinished' },
    group = group,
    callback = function(args)
      processing = args.match == 'CodeCompanionRequestStarted'
    end,
  })
end

-- Lualine component function
function M.component()
  if processing then
    spinner_index = (spinner_index % #spinner_symbols) + 1
    return spinner_symbols[spinner_index]
  end
  return ''
end

return M.component
