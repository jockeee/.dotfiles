--
-- init.lua

vim.loader.enable()

require 'user.globals'
require 'user.options'
require 'user.lazy'
require 'user.keymaps'
require 'user.lsp'

-- nvim builtin completion with LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method 'textDocument/completion' then vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true }) end
  end,
})

-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
