--
-- lsp highlight references

local enabled = false
if not enabled then return end

local g_lsp_highlight_ref = vim.api.nvim_create_augroup('g-lsp-highlight-references', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = g_lsp_highlight_ref,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local g_lsp_highlight = vim.api.nvim_create_augroup('g-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = g_lsp_highlight,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = g_lsp_highlight,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('g-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'g-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})
