--
-- https://github.com/nvim-treesitter/nvim-treesitter
-- nvim treesitter configurations and abstraction layer
--
-- highlight, edit, and navigate code
--
-- :help nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
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

-- ensure_installed = {
--   'json',
--   'javascript',
--   'typescript',
--   'tsx',
--   'yaml',
--   'html',
--   'css',
--   'prisma',
--   'markdown',
--   'markdown_inline',
--   'svelte',
--   'graphql',
--   'bash',
--   'lua',
--   'vim',
--   'dockerfile',
--   'gitignore',
--   'query',
--   'vimdoc',
--   'c',
-- },
