--
-- nvim-treesitter/nvim-treesitter

-- highlight, edit, and navigate code
--
-- :h nvim-treesitter
-- :h nvim-treesitter-commands
--
-- Incremental selection (included by default)
--  :h nvim-treesitter-incremental-selection-mod
--
-- Show current context, "miniview" to the function you're in,
-- when it scrolls off the screen.
--  https://github.com/nvim-treesitter/nvim-treesitter-context
--
-- Supported languages
--  https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false, -- This plugin does not support lazy-loading
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'windwp/nvim-ts-autotag', -- Use treesitter to auto close and auto rename html tag
      opts = {
        enable_close = false, -- d: true, Auto close tags
        -- enable_rename = true, -- d: true, Auto rename pairs of tags
        -- enable_close_on_slash = false, -- d: false, Auto close on trailing </
      },
    },
  },

  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Lazy will do `require('nvim-treesitter.configs').setup(opts)`
  opts = {
    -- ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }, -- kickstart.nvim
    ensure_installed = {
      'bash',
      'c',
      'css',
      'diff',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'php',
      'python',
      'query',
      'regex',
      'vim',
      'vimdoc',
    },
    auto_install = true, -- autoinstall languages that are not installed
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      -- additional_vim_regex_highlighting = { 'ruby' },
      additional_vim_regex_highlighting = false,
    },
    -- indent = { enable = true, disable = { 'ruby' } },
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
      move = {
        enable = true,
        set_jumps = true,

        goto_next_start = {
          [']b'] = '@codeblock.inner', -- markdown code block
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
          [']t'] = '@tag.outer',
        },
        goto_next_end = {
          [']B'] = '@codeblock.inner', -- markdown code block
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
          [']T'] = '@tag.outer',
        },
        goto_previous_start = {
          ['[b'] = '@codeblock.inner', -- markdown code block
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[t'] = '@tag.outer',
        },
        goto_previous_end = {
          ['[B'] = '@codeblock.inner', -- markdown code block
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
          ['[T'] = '@tag.outer',
        },
      },
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
          -- markdown
          ['ib'] = { query = '@codeblock.inner', desc = 'Select inner part of Markdown code block' },
          ['ab'] = { query = '@codeblock.outer', desc = 'Select entire Markdown code block' },
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
          ['@codeblock.inner'] = 'V', -- linewise selection for code block content
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
        include_surrounding_whitespace = false, -- d: false
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader><right>'] = '@parameter.inner', -- swap with next parameter
        },
        swap_previous = {
          ['<leader><left>'] = '@parameter.inner', -- swap with previous parameter
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    require('nvim-ts-autotag').setup()

    -- vim.treesitter.language.register('html', 'tmpl')

    -- Context
    --
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

    vim.keymap.set('n', '<leader>sx', function()
      context.toggle()
    end, { desc = 'Treesitter: Context (top lines)' })
  end,
}
