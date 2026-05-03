--
-- lsp keymaps

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('u-lsp-keymaps', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'Lsp: ' .. desc })
    end

    -- default in v0.11
    -- grn in Normal mode maps to vim.lsp.buf.rename()
    -- grr in Normal mode maps to vim.lsp.buf.references()
    -- gri in Normal mode maps to vim.lsp.buf.implementation()
    -- gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
    -- gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
    -- CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()
    -- [d and ]d move between diagnostics in the current buffer ([D jumps to the first diagnostic, ]D jumps to the last)

    -- map('grn', vim.lsp.buf.rename, 'rename') -- default in v0.11
    map('grr', require('snacks.picker').lsp_references, 'references') -- word references, under cursor
    map('gri', require('snacks.picker').lsp_implementations, 'implementation') -- when your language has ways of declaring types without an actual implementation
    map('grd', require('snacks.picker').lsp_definitions, 'definition') -- where a variable was first declared, or where a function is defined
    map('grD', require('snacks.picker').lsp_declarations, 'declaration') -- in c, takes you to the header file
    map('grt', require('snacks.picker').lsp_type_definitions, 'type definition') --  when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.
    map('gO', require('snacks.picker').lsp_symbols, 'symbols') -- document symbols are things like variables, functions, types
    -- map('gra', vim.lsp.buf.code_action, 'code actions', { 'n', 'x' }) - default in v0.11
    map('gW', require('snacks.picker').lsp_workspace_symbols, 'workspace symbols') --  searches over your entire project

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- inlay hints
    --  adds information like types, parameter names etc in the editor
    --  example: vim.keymap.set(**mode:** { 'n', 'v' }, **lhs:** '<left>', **rhs:** 'b')
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      vim.keymap.set('n', '<leader>si', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { desc = 'Lsp: inlay hints' })
    end
  end,
})
