--
-- init.lua

vim.loader.enable()

Config = {}

function Config.dofile(relative_path)
  if not relative_path:match("%.lua$") then
    relative_path = relative_path .. ".lua"
  end

  local full_path = vim.fs.joinpath(vim.fn.stdpath("config"), relative_path)
  dofile(full_path)
end

Config.dofile('globals')
Config.dofile('options')
Config.dofile('mini')
Config.dofile('keymaps')


--
-- autocmds
--

-- nvim builtin completion with LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
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

