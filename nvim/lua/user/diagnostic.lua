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
  -- virtual_lines = true, -- show all in buffer
  -- virtual_lines = {
  --   current_line = true, -- show only on current line
  -- },
  -- virtual_text = true,
  -- virtual_text = {
  --   enabled = false,
  --   spacing = 8,
  --   source = 'if_many',
  -- },
}

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic: show message' })

-- virtual_lines, off
vim.keymap.set('n', '<leader>sDo', function()
  vim.diagnostic.config {
    virtual_lines = false,
  }
end, { desc = 'off' })

-- virtual_lines, buffer
vim.keymap.set('n', '<leader>sDb', function()
  vim.diagnostic.config {
    virtual_lines = true,
  }
end, { desc = 'buffer' })

-- virtual_lines, current line
vim.keymap.set('n', '<leader>sDl', function()
  vim.diagnostic.config {
    virtual_lines = {
      current_line = true,
    },
  }
end, { desc = 'current line' })

-- virtual_text, off
vim.keymap.set('n', '<leader>sdo', function()
  vim.diagnostic.config {
    virtual_text = false,
  }
end, { desc = 'off' })

-- virtual_text, buffer
vim.keymap.set('n', '<leader>sdb', function()
  vim.diagnostic.config {
    virtual_text = {
      current_line = false,
      spacing = 8,
      source = 'if_many',
    },
  }
end, { desc = 'buffer' })

vim.keymap.set('n', '<leader>sdl', function()
  vim.diagnostic.config {
    virtual_text = {
      current_line = true,
      spacing = 8,
      source = 'if_many',
    },
  }
end, { desc = 'current line' })

-- vim.keymap.set('n', '<leader>sv', function()
--   local config = vim.diagnostic.config()
--   local current = config and config.virtual_lines
--
--   local enabled = false
--   if type(current) == 'table' then
--     enabled = current.current_line or false
--   elseif type(current) == 'boolean' then
--     enabled = current
--   end
--
--   vim.diagnostic.config { virtual_lines = { current_line = not enabled } }
-- end, { desc = 'Diagnostic: virtual lines' })

-- Diagnostics (https://github.com/neovim/nvim-lspconfig)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic Message' }) -- default in v0.11, [d
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic Message' }) -- default in v0.11, ]d
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' }) -- trouble, leader-xx
