--
-- https://github.com/nvim-treesitter/nvim-treesitter
-- nvim treesitter configurations and abstraction layer
--
-- highlight, edit, and navigate code
--
-- :help nvim-treesitter
--
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'lua', 'vim', 'vimdoc' },
    auto_install = true, -- autoinstall languages that are not installed
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>', -- set to `false` to disable one of the mappings
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
  },
  config = function(_, opts)
    -- ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact with nvim-treesitter.
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
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
