--
-- diagnostic config

-- :h vim.diagnostic.Opts

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = false, -- { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  -- virtual_lines = {
  --   current_line = true,
  -- },
  -- virtual_lines = true,
  -- virtual_text = {
  --   current_line = true,
  --   spacing = 8,
  --   source = 'if_many',
  -- },
}

-- Toggle virtual lines
vim.keymap.set('n', '<leader>sv', function()
  local config = vim.diagnostic.config()
  local current = config and config.virtual_lines

  local enabled = false
  if type(current) == 'table' then
    ---@diagnostic disable-next-line: undefined-field
    enabled = current.enabled or false
  elseif type(current) == 'boolean' then
    enabled = current
  end

  vim.diagnostic.config { virtual_lines = not enabled }
end, { desc = 'Diagnostic: virtual lines' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic: show message' })

-- Diagnostics (https://github.com/neovim/nvim-lspconfig)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic Message' }) -- default in v0.11, [d
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic Message' }) -- default in v0.11, ]d
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' }) -- trouble, leader-xx
