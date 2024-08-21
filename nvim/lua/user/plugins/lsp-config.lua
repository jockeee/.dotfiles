--
-- lsp config

-- https://github.com/neovim/nvim-lspconfig

-- Brief Aside: **What is LSP?**
--
-- LSP is an acronym you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`

-- LSP configuration & plugins
return {
  'neovim/nvim-lspconfig',
  lazy = false,
  -- event = { 'BufReadPre', 'BufNewFile' },
  -- cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = {
    -- https://github.com/williamboman/mason.nvim
    -- Package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    --
    -- https://github.com/williamboman/mason-lspconfig.nvim
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
    'williamboman/mason-lspconfig.nvim',
    --
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    -- Install and upgrade third party tools automatically
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    --
    -- https://github.com/j-hui/fidget.nvim
    -- Notifications and LSP progress messages
    {
      'j-hui/fidget.nvim',
      opts = {
        progress = { -- make fidget less noisy
          suppress_on_insert = true, -- suppress new messages while in insert mode -- default: false
          ignore_done_already = true, -- ignore new tasks that are already complete -- default: false
          ignore_empty_message = true, -- ignore new tasks that don't contain a message  default: false

          display = {
            done_ttl = 1, -- time a message persist after completion
          },
        },
      },
    },
    --
    -- https://github.com/folke/neodev.nvim
    -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
    --
    -- Neodev configures Lua LSP for your Neovim config, runtime and plugins.
    -- Used for completion, annotations and signatures of Neovim apis
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        -- Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, 'Goto declaration')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
        -- FROM https://github.com/neovim/nvim-lspconfig
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf })

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map('K', vim.lsp.buf.hover, 'Show documentation')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gi', require('telescope.builtin').lsp_implementations, 'Goto implementation')
        -- FROM https://github.com/neovim/nvim-lspconfig
        -- keymap clash, gi is 'Move to the last insertion and INSERT', could remap but going with kickstart.nvim keymap gI
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = event.buf })

        -- FROM https://github.com/neovim/nvim-lspconfig
        -- keymap clash, C-k is for window navigation, you give it code signatures
        vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: ' .. 'Signature help' })

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type definition')
        -- FROM https://github.com/neovim/nvim-lspconfig
        -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = event.buf })

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map('<leader>cr', vim.lsp.buf.rename, 'Rename')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document symbols')

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')

        -- FROM https://github.com/neovim/nvim-lspconfig
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = event.buf, desc = 'LSP: ' .. 'Add workspace folder' })
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = event.buf, desc = 'LSP: ' .. 'Remove workspace folder' })
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = event.buf, desc = 'LSP: ' .. 'List workspace folders' })

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        -- OLD map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        -- FROM https://github.com/neovim/nvim-lspconfig
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP: ' .. 'Code action' })

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

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP Specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- :help lspconfig-all for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      -- tsserver = {},

      -- bash
      bashls = {}, -- LSP: A language server for Bash

      -- lua
      lua_ls = { -- LSP: Lua language server
        -- cmd = {...},
        -- filetypes {...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },

      -- Web
      html = {}, -- LSP: Language Server Protocol implementation for HTML
      emmet_ls = {}, -- LSP: Emmet support based on LSP
      tailwindcss = {}, -- LSP: Language Server Protocol implementation for Tailwind CSS
      htmx = {}, -- LSP: An experimental LSP for HTMX  INFO: Requires Rust build tools (cargo)

      -- Golang
      gopls = {}, -- LSP: the official Go language server developed by the Go team  INFO: Requires Go
      templ = {}, -- LSP: language server for the templ HTML templating language

      -- PHP
      intelephense = {}, -- LSP: Professional PHP tooling for any Language Server Protocol capable editor
      phpactor = {}, -- LSP: Phpactor is an intelligent Completion and Refactoring tool for PHP

      -- Python
      pylsp = { -- LSP: Fork of the python-language-server project, maintained by the Spyder IDE team and the community.
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                enabled = true,
                ignore = { 'E501', 'W503' },
              },
              mypy = { enabled = true },
            },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu
    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})

    vim.list_extend(ensure_installed, {
      -- Bash
      'shfmt', -- Formatter: A shell formatter (sh/bash/mksh)
      -- Lua
      'stylua', -- Formatter: An opinionated Lua code formatter
      -- Html
      'prettier', -- Formatter: Prettier is an opinionated code formatter
      'prettierd', -- Formatter: Prettier, as a daemon, for ludicrous formatting speed-- https://github.com/fsouza/prettierd#vim--neovim
      -- Golang  INFO: Requires Go binary in PATH
      'gofumpt', -- Formatter: A stricter gofmt
      'goimports-reviser', -- Formatter: sorts goimports by 3-4 groups (stdlib, general, company, project dependencies)
      'delve', -- DAP: Delve is a debugger for the Go programming language
      -- PHP  INFO: Requires PHP binary in PATH
      'easy-coding-standard', -- Linter/Formatter: Use Coding Standard with 0-knowledge of PHP-CS-Fixer and PHP_CodeSniffer
      -- 'phpstan', -- Linter: PHP Static Analysis Tool - discover bugs in your code without running it!
      -- 'php-debug-adapter', -- DAP: PHP Debug Adapter
      -- Python
      'black', -- Formatter: Black, the uncompromising Python code formatter
      'isort', -- Formatter: isort is a Python utility / library to sort imports alphabetically
      'mypy', -- Linter: Mypy is a static type checker for Python
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed by the server configuration above.
          -- Useful when disabling certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
