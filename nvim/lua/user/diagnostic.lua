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
  -- virtual_lines = false, -- show all in buffer
  -- virtual_lines = {
  --   current_line = true, -- show only on current line
  -- },
  -- virtual_text = true,
}

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

-- Diagnostics (https://github.com/neovim/nvim-lspconfig)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic Message' }) -- default in v0.11, [d
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic Message' }) -- default in v0.11, ]d
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' }) -- trouble, leader-xx
