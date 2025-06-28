--
-- lsp keymaps

local g_lsp_keymaps = vim.api.nvim_create_augroup('g-lsp-keymaps', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = g_lsp_keymaps,
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'lsp ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, 'rename') -- most language servers support renaming across files
    map('gra', vim.lsp.buf.code_action, 'code actions', { 'n', 'x' })
    map('grr', require('snacks.picker').lsp_references, 'references') -- word references, under cursor
    map('gri', require('snacks.picker').lsp_implementations, 'implementation') -- when your language has ways of declaring types without an actual implementation
    map('grd', require('snacks.picker').lsp_definitions, 'definition') -- where a variable was first declared, or where a function is defined
    map('grD', require('snacks.picker').lsp_declarations, 'declaration') -- in c, this takes you to the header file
    map('gO', require('snacks.picker').lsp_symbols, 'symbols') -- document symbols are things like variables, functions, types
    map('gW', require('snacks.picker').lsp_workspace_symbols, 'workspace symbols') --  searches over your entire project
    map('grt', require('snacks.picker').lsp_type_definitions, 'type definition') --  when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- inlay hints
    --  adds information like types, parameter names etc in the editor
    --  example: vim.keymap.set(**mode:** { 'n', 'v' }, **lhs:** '<left>', **rhs:** 'b')
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      vim.keymap.set('n', '<leader>ti', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { desc = 'lsp inlay hints' })
    end
  end,
})
