--
-- https://github.com/nvim-treesitter/nvim-treesitter
-- highlight, edit, and navigate code
--  :help nvim-treesitter
--
-- Incremental selection (included by default)
--  :help nvim-treesitter-incremental-selection-mod
--
-- ensure_installed
--  https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'windwp/nvim-ts-autotag', opts = {} }, -- Use treesitter to auto close and auto rename html tag
  },
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc' },
    auto_install = true, -- autoinstall languages that are not installed
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = { -- set to `false` to disable one of the mappings
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
      markdown = {
        enable = true,
      },
    },
  },
  config = function(_, opts)
    -- ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact with nvim-treesitter.
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
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
