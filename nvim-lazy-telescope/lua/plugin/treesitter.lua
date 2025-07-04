--
-- nvim-treesitter/nvim-treesitter

-- highlight, edit, and navigate code
--
-- :h nvim-treesitter
-- :h nvim-treesitter-commands
--
-- Incremental selection (included by default)
-- :h nvim-treesitter-incremental-selection-mod
--
-- ensure_installed
--  https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  -- event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'windwp/nvim-ts-autotag', opts = {} }, -- Use treesitter to auto close and auto rename html tag
  },
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    auto_install = true, -- Automatically install missing parsers when entering buffer
    ignore_install = {}, -- List of parsers to ignore installing (or "all")
    highlight = {
      enable = true,
      -- NOTE:
      -- These are the names of the parsers and not the filetype.
      -- (for example if you want to disable highlighting for the `tex` filetype,
      -- you need to include `latex` in this list as this is the name of the parser)
      --
      -- list of language that will be disabled
      -- disable = { "c", "rust" },
      --
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      -- disable = function(lang, buf)
      --     local max_filesize = 100 * 1024 -- 100 KB
      --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --     if ok and stats and stats.size > max_filesize then
      --         return true
      --     end
      -- end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = { 'tmux' },
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = { -- set to `false` to disable one of the mappings
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    markdown = {
      enable = true,
    },
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- ['ac'] = '@class.outer', -- without description
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = { query = '@function.outer', desc = 'Select outer part of a function region' },
          ['if'] = { query = '@function.inner', desc = 'Select inner part of a function region' },
          ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          -- You can also use captures from other query groups like `locals.scm`
          ['as'] = { query = '@local.scope', query_group = 'locals', desc = 'Select language scope' },
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<C-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true or false
        include_surrounding_whitespace = true,
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    vim.treesitter.language.register('html', 'tmpl')

    -- There are additional nvim-treesitter modules that you can use to interact with nvim-treesitter.
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

    -- Defaults for treesitter-context
    -- require('treesitter-context').setup {
    --   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --   multiwindow = false, -- Enable multiwindow support.
    --   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    --   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --   line_numbers = true,
    --   multiline_threshold = 20, -- Maximum number of lines to show for a single context
    --   trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    --   mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    --   -- Separator between context and content. Should be a single character string, like '-'.
    --   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --   separator = nil,
    --   zindex = 20, -- The Z-index of the context window
    --   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    -- }

    local context = require 'treesitter-context'
    context.setup {
      enable = false,
      multiwindow = true,
    }

    vim.keymap.set('n', '<leader>tx', function()
      context.toggle()
    end, { desc = 'Treesitter: Context (top lines)' })
  end,
}

-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
-- Examples
--   'bash',
--   'gitignore',
--   'c',
--   'html',
--   'css',
--   'json',
--   'yaml',
--   'markdown',
--   'markdown_inline',
--   'javascript',
--   'typescript',
--   'tsx',
--   'graphql',
--   'dockerfile',
--   'query',
