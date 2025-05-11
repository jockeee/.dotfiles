--
-- https://github.com/neovim/nvim-lspconfig
-- Quickstart configs for Nvim LSP

-- Brief Aside: **What is LSP?**
--
-- LSP stands for Language Server Protocol.
-- It's a protocol that helps editors and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, nvim!
--
-- LSP provides nvim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Language Servers are external tools that must be installed separately from nvim.
-- This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully and elegantly composed help section.
-- :h lsp-vs-treesitter

return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      -- { -- optional blink completion source for require statements and module annotations
      --   "saghen/blink.cmp",
      --   version = '*',
      --   opts = {
      --     sources = {
      --       -- add lazydev to your completion providers
      --       default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      --       providers = {
      --         lazydev = {
      --           name = "LazyDev",
      --           module = "lazydev.integrations.blink",
      --           -- make lazydev completions top priority (see `:h blink.cmp`)
      --           score_offset = 100,
      --         },
      --       },
      --     },
      --   },
      -- },
    },
    config = function()
      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- require('lspconfig').lua_ls.setup { capabilites = capabilities }

      local lua_ls_path = vim.fn.stdpath('cache') .. '/lua-language-server/'
      local lua_ls_meta_path = vim.fn.stdpath('cache') .. '/lua-language-server/meta/'

      require('lspconfig').lua_ls.setup {
        -- cmd = {...},
        -- filetypes { ...},
        -- capabilities = {},
        cmd = {
          'lua-language-server',
          '--logpath=',
          lua_ls_path,
          '--metapath=',
          lua_ls_meta_path,
        },
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      }

      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then
      --       return
      --     end
      --
      --     -- using conform format_on_save
      --     -- if client:supports_method('textDocument/formatting') then
      --     --   -- Format current buffer on save
      --     --   vim.api.nvim_create_autocmd('BufWritePre', {
      --     --     buffer = args.buf,
      --     --     callback = function()
      --     --       vim.lsp.buf.format { bufnr = args.buf, id = client.id }
      --     --     end,
      --     --   })
      --     -- end
      --   end,
      -- })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          -- FROM https://github.com/neovim/nvim-lspconfig
          -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf })

          -- Opens a popup that displays documentation about the word under your cursor
          --  :help K for why this keymap
          map('K', vim.lsp.buf.hover, 'Show Documentation')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gi', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          -- FROM https://github.com/neovim/nvim-lspconfig
          -- keymap clash, gi is 'Move to the last insertion and INSERT', could remap but going with kickstart.nvim keymap gI
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = event.buf })

          -- FROM https://github.com/neovim/nvim-lspconfig
          -- keymap clash, C-k is for window navigation, you give it code signatures
          vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help,
            { buffer = event.buf, desc = 'LSP: ' .. 'Signature Help' })

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>dD', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          -- FROM https://github.com/neovim/nvim-lspconfig
          -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = event.buf })

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document symbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')

          -- FROM https://github.com/neovim/nvim-lspconfig
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,
            { buffer = event.buf, desc = 'LSP: ' .. 'Add workspace folder' })
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
            { buffer = event.buf, desc = 'LSP: ' .. 'Remove workspace folder' })
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { buffer = event.buf, desc = 'LSP: ' .. 'List workspace folders' })

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          -- OLD map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
          -- FROM https://github.com/neovim/nvim-lspconfig
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
            { buffer = event.buf, desc = 'LSP: ' .. 'Code action' })

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, 'Goto references')
          -- FROM https://github.com/neovim/nvim-lspconfig
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = event.buf })

          -- format document
          -- use conform instead (in autoformat.lua) which fallbacks to LSP if no other formatter is available
          -- FROM https://github.com/neovim/nvim-lspconfig
          -- keymap clash, you use L-f for find grouping, changed it to L-df for 'document format', easy to type as well.
          -- map('<leader>f', function()
          --   vim.lsp.buf.format { async = true }
          -- end, 'Document format')

          -- The following two autocommands are used to highlight references of the word under your cursor when your cursor rests there for a little while.
          --  :help CursorHold for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          -- Note: Usage of vim.lsp.buf.document_highlight() requires the following highlight groups to be defined or you won't be able to see the actual highlights.
          --   hl-LspReferenceText
          --   hl-LspReferenceRead
          --   hl-LspReferenceWrite
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them.
          -- This may be unwanted, since they displace some of your code.
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Inlay Hints')
          end
        end,
      })
    end,
  },
}
