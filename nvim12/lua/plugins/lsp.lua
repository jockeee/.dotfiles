--
-- plugins/lsp.lua

vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/DrKJeff16/wezterm-types',
}

require('mason').setup()

-- define servers to use
-- override config settings provided by `nvim-lspconfig` and files in lsp/
--
-- Default nvim-lspconfig configs used:
--  ~/.local/share/nvim/site/pack/core/opt/nvim-lspconfig/lua/lspconfig/configs
local servers = {
  lua_ls = {
    -- Configure lua_ls workspace upfront rather than lazily (lazydev).
    -- This avoids per-file re-indexing delays at the cost of a slower startup.
    --
    -- Without this, tools like lazydev inject libraries per-file, causing a brief
    -- window of missing `vim.*` completions and warnings each time a new file opens.
    --
    -- Short version: pay the indexing cost once at startup, not on every new file.
    -- startup cost vs per-file cost tradeoff
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT', -- tell luals which Lua version is running, so it uses the right standard library definitions.
          path = { 'lua/?.lua', 'lua/?/init.lua' }, -- tell luals where to look when resolving require() calls
        },
        workspace = {
          checkThirdParty = false, -- stops luals from prompting "do you want to configure third party libraries?" when it detects things like luassert.
          -- Tells luals "these are Lua files you should understand"
          library = vim.tbl_extend(
            'force',
            -- Removing your config dir from the library means luals won't treat your own config as
            -- a "library", it will treat it as the workspace instead, which is the correct relationship.
            -- https://github.com/neovim/nvim-lspconfig/issues/3189
            vim.tbl_filter(function(dir) return not dir:match(vim.fn.stdpath 'config' .. '/?a?f?t?e?r?') end, vim.api.nvim_get_runtime_file('', true)),
            -- ^^^ returns every directory in Neovim's runtime path.
            -- ^^^ This includes Neovim's own runtime, all plugins, and your config dir.
            {
              '${3rd}/luv/library', -- type definitions for vim.uv (libuv bindings)
              '${3rd}/busted/library', -- type definitions for the busted test framework
              -- included via nvim_get_runtime_file() - vim.fn.stdpath 'data' .. '/site/pack/core/opt/wezterm-types',
            }
          ),
        },
      })
    end,
    -- https://luals.github.io/wiki/settings
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = {
          disable = { 'missing-fields' }, -- Ignore Lua_LS's noisy `missing-fields` warnings
        },
        format = {
          enable = false, -- Disable formatting (formatting is done by stylua)
        },
        hint = {
          enable = true, -- inlay hints
        },
      },
    },
  },

  bashls = {},
  fish_lsp = {},

  ruff = {}, -- python

  jsonls = {
    -- init_options = {
    --   provideFormatter = false,
    -- },
    settings = {
      json = {
        format = {
          tabSize = 2,
          insertSpaces = true,
        },
      },
    },
  },
  yamlls = {
    filetypes = { 'yaml' }, -- d: 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values'
  },
  ansiblels = {
    cmd_env = {
      -- don't run any inventory scripts (which only will timeout b/c host unreachable)
      ANSIBLE_INVENTORY = vim.fn.expand '~/dev/automation/ansible/inventory/hosts',
    },
  },

  gopls = {
    filetypes = { 'go', 'gomod', 'gowork' }, -- d: 'go', 'gomod', 'gowork', 'gotmpl'
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        completeUnimported = false,
        staticcheck = true,
        gofumpt = true,
      },
      -- templateExtensions = { 'tmpl' }, -- add filetype first
    },
  },

  ols = {}, -- odin
}

local tools = {
  -- lua
  'stylua', -- formatter

  -- bash
  'shfmt', -- formatter
  'shellcheck', -- linter

  'yamlfmt', -- generic YAML
  'yamlfix', -- "the most ansible-aware of the bunch"
  -- 'ansible-lint', -- using w/e version the distro package manager has

  -- go
  'gofumpt', -- formatter, a stricter gofmt
  'goimports-reviser', -- formatter, sorts goimports by 3-4 groups (stdlib, general, company, project dependencies)
  'staticcheck', -- linter
  'delve', -- dap, debugger

  -- sql
  'sqlfluff', -- formatter and linter

  -- xml
  'xmlformatter',
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, tools)
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for server, config in pairs(servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- textDocument/documentColor
    if client and client:supports_method('textDocument/documentColor', ev.buf) then
      if client.name == 'lua_ls' then
        vim.lsp.document_color.enable(false, { bufnr = ev.buf })
      else
        vim.lsp.document_color.enable(true, { bufnr = ev.buf })
      end

      vim.keymap.set(
        'n',
        '<Leader>sc',
        function() vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled { bufnr = 0 }, { bufnr = 0 }) end,
        { desc = 'lsp: documentColors' }
      )
    end

    -- textDocument/documentHighlight
    -- if client and client:supports_method('textDocument/documentHighlight', ev.buf) then
    --   local highlight_augroup = vim.api.nvim_create_augroup('config-lsp-highlight', { clear = false })
    --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    --     buffer = ev.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --
    --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    --     buffer = ev.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    --
    --   vim.api.nvim_create_autocmd('LspDetach', {
    --     group = vim.api.nvim_create_augroup('config-lsp-detach', { clear = true }),
    --     callback = function(ev2)
    --       vim.lsp.buf.clear_references()
    --       vim.api.nvim_clear_autocmds { group = 'config-lsp-highlight', buffer = ev2.buf }
    --     end,
    --   })
    -- end

    -- lsp default features
    --  lsp-diagnostic    vim.diagnostic.config
    --  workspace/didChangeWatchedFiles (except on Linux)
    --
    -- :checkhealth vim.lsp
    --
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- if capabilities.workspace then
    --   capabilities.workspace.didChangeWatchedFiles = nil
    -- end
    -- vim.lsp.config('*', {
    --   capabilities = capabilities,
    -- })
    --
    --  omnifunc    vim.lsp.omnifunc    C-x C-o
    --  tagfunc     vim.lsp.tagfunc
    --                  enables features like go-to-definition, :tjump,
    --                  and keymaps like C-], C-w_], C-w_} to utilize the language server.
    --  formatexpr  vim.lsp.formatexpr
    --                  format lines with gq, if the language server supports it.
    --                  To opt out of this use gw instead of gq, or clear 'formatexpr' on LspAttach.
    --  K           vim.lsp.buf.hover
    --                  unless 'keywordprg' is customized or a custom keymap for K exists.
    --  Document colors are enabled for highlighting color references in a document.
    --                  To opt out call `vim.lsp.document_color.enable(false, { bufnr = ev.buf })` on LspAttach.
    --
    -- vim.api.nvim_create_autocmd('LspAttach', {
    --   callback = function(ev)
    --     -- Unset 'formatexpr'
    --     vim.bo[ev.buf].formatexpr = nil
    --     -- Unset 'omnifunc'
    --     vim.bo[ev.buf].omnifunc = nil
    --     -- Unmap K
    --     vim.keymap.del('n', 'K', { buf = ev.buf })
    --     -- Disable document colors
    --     vim.lsp.document_color.enable(false, { bufnr = ev.buf })
    --   end,
    -- })
    --
    -- lsp defaults keymaps
    --  You can remove GLOBAL keymaps at any time using vim.keymap.del or :unmap.
    --
    --  gra     vim.lsp.buf.code_action       Normal and Visual mode
    --  gri     vim.lsp.buf.implementation
    --  grn     vim.lsp.buf.rename
    --  grr     vim.lsp.buf.references
    --  grt     vim.lsp.buf.type_definition
    --  grx     vim.lsp.codelens.run
    --  gO      vim.lsp.buf.document_symbol
    --  CTRL-S  vim.lsp.buf.signature_help    Insert mode
    --
    --  v_an and v_in fall back to LSP vim.lsp.buf.selection_range if treesitter is not active.
    --  gx handles `textDocument/documentLink`.

    -- map('grn', vim.lsp.buf.rename, 'rename') -- default in v0.11
    -- vim.keymap.set('n', 'grr', require('snacks.picker').lsp_references, { desc = 'references' }) -- word references, under cursor
    -- vim.keymap.set('n', 'gri', require('snacks.picker').lsp_implementations, { desc = 'implementation' }) -- when your language has ways of declaring types without an actual implementation
    -- vim.keymap.set('n', 'grd', require('snacks.picker').lsp_definitions, { desc = 'definition' }) -- where a variable was first declared, or where a function is defined
    -- vim.keymap.set('n', 'grD', require('snacks.picker').lsp_declarations, { desc = 'declaration' }) -- in c, takes you to the header file
    -- vim.keymap.set('n', 'grt', require('snacks.picker').lsp_type_definitions, { desc = 'type definition' }) --  when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.
    -- vim.keymap.set('n', 'gO', require('snacks.picker').lsp_symbols, { desc = 'symbols' }) -- document symbols are things like variables, functions, types
    -- -- vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = 'code actions', { 'n', 'x' } }) -- default in v0.11
    -- vim.keymap.set('n', 'gW', require('snacks.picker').lsp_workspace_symbols, { desc = 'workspace symbols' }) --  searches over your entire project
    --
    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
    --
    -- -- inlay hints
    -- --  adds information like types, parameter names
    -- --    vim.keymap.set(mode: { 'n', 'v' }, lhs: '<left>', rhs: 'b')
    -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    --   vim.keymap.set('n', '<leader>si', function()
    --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    --   end, { desc = 'Lsp: inlay hints' })
    -- end
  end,
})
