--
-- https://github.com/hrsh7th/nvim-cmp
-- A completion plugin for neovim coded in Lua.

-- autocompletion
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip', -- Snippet Engine for nvim written in Lua
      -- follow latest release
      -- tag = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional)
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },

    'saadparwaiz1/cmp_luasnip', -- luasnip completion source for nvim-cmp

    -- Adds other completion capabilities
    --    nvim-cmp does not ship with all sources by default.
    --    They are split into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    -- If you want to add a bunch of pre-configured snippets, you can use this plugin to help you.
    --    It even has snippets for various frameworks/libraries/etc,
    --    but you will have to set up the ones that are useful for you.
    'rafamadriz/friendly-snippets', -- useful snippets

    'onsails/lspkind.nvim',         -- vscode like pictograms
  },
  config = function()
    -- :h cmp
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    -- https://github.com/L3MON4D3/LuaSnip#add-snippets
    -- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    luasnip.config.setup {}

    cmp.setup {
      snippet = { -- Configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- window = {
      --   completion = cmp.config.window.bordered(),
      --   documentation = cmp.config.window.bordered(),
      -- },
      completion = {
        completeopt = 'menu,menuone,preview,noinsert',
        -- A comma-separated list of options for Insert mode completion
        --    menu      Use a popup menu to show the possible completions
        --    menuone   Use the popup menu also when there is only one match
        --    preview   Show extra information for a currently selected completion in the preview window
        --    noinsert  Do not insert any text for a match until the user selects a match from the menu
      },
      -- Sources for autocompletion
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' }, -- Snippets
        { name = 'buffer' },  -- Words in current buffer
        { name = 'path' },    -- File system paths
      },
      -- Configure lspkind for vscode like pictograms in completion menu
      -- https://github.com/onsails/lspkind.nvim#option-2-nvim-cmp
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = function()
            return math.floor(0.45 * vim.o.columns)
          end,
          ellipsis_char = '...',
          show_labelDetails = true, -- Show label details (e.g. `Function` vs `method`) -- default: off
        },
      },
      -- For an understanding of why these mappings were chosen, see:
      --  :h ins-completion
      mapping = cmp.mapping.preset.insert {
        -- Accept (yes) the completion
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- Accept with tab
        ['<C-y>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-e>'] = cmp.mapping.abort(),                   -- Close the completion menu
        ['<C-n>'] = cmp.mapping.select_next_item(),        -- Select the next item
        ['<C-p>'] = cmp.mapping.select_prev_item(),        -- Select the previous item
        -- ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation backwards
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Scroll documentation forwards
        ['<C-Space>'] = cmp.mapping.complete {}, -- Manually trigger a completion from nvim-cmp

        -- Think of <c-j> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-j> move forward
        -- <c-k> move backward
        ['<C-j>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
    }

    -- vim-dadbod-completion
    --    see: lua/user/plugins/sql.lua
    cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })
  end,
}