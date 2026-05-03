--
-- diagnostic config

-- :h vim.diagnostic.Opts

vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true, -- boolean | 'if_many'
  },
  underline = false, -- { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  -- virtual_lines = false, -- show all in buffer
  -- virtual_lines = {
  --   current_line = true, -- show only on current line
  -- },
  -- virtual_text = true,
}

-- [d prev diagnostic message, any severity
-- ]d next diagnostic message, any severity
vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Diagnostics: prev error' })

vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Diagnostics: next error' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostics: show message' }) -- d: <C-w-d>

vim.keymap.set('n', '<leader>sd', function()
  local config = vim.diagnostic.config()
  local vl = config and config.virtual_lines

  local enabled = false
  if type(vl) == 'table' then
    enabled = vl.current_line or false
  elseif type(vl) == 'boolean' then
    enabled = vl
  end

  vim.diagnostic.config { virtual_lines = not enabled }
end, { desc = 'Diagnostics: virtual lines' })

-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' }) -- trouble, leader-xx
