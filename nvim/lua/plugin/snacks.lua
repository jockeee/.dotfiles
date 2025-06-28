--
-- https://github.com/folke/snacks.nvim
-- A collection of QoL plugins for Neovim
--
-- Pickers
--  :h snacks-picker-sources
--  https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#-sources

-- files and grep support adding options like:
--  `foo -- -e=lua` to the command, so you can filter the results.

---@type LazySpec
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    bigfile = {},
    explorer = {},
    image = {},
    lazygit = {},
    ---@type snacks.picker.Config
    picker = {
      layout = {
        preset = 'ivy',
      },
      sources = {
        files = {
          hidden = true, -- include dotfiles
          -- no_ignore = true,   -- show files ignored by .gitignore
        },
        explorer = {
          hidden = true, -- include dotfiles
        },
      },
      matcher = {
        frecency = true, -- frecency bonus, like zoxide for pickers
      },
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 80,
        },
      },
    },
    styles = {
      lazygit = {
        -- lazygit uses Snacks.terminal to open the terminal window with lazygit,
        -- and that also uses Snacks.win to create the window for the terminal and that's where you'll find these options.
        -- fill the whole screen
        height = 0,
        width = 0,
      },
    },
  },
  config = function(_, opts)
    local snacks = require 'snacks'
    snacks.setup(opts)

    vim.keymap.set('n', '<leader>g', snacks.lazygit.open, { desc = 'Lazygit' })

    vim.keymap.set('n', '\\', snacks.explorer.open, { desc = 'Explorer' }) -- nvim-tree style
    vim.keymap.set('n', '<leader>/', snacks.picker.lines, { desc = 'Find: buffer' })

    vim.keymap.set('n', '<leader><space>', snacks.picker.files, { desc = 'Find: files' })
    vim.keymap.set('n', '<leader>fa', snacks.picker.resume, { desc = 'resume' })
    vim.keymap.set('n', '<leader>fi', snacks.picker.icons, { desc = 'icons' })
    vim.keymap.set('n', '<leader>fb', snacks.picker.pickers, { desc = 'builtin pickers' })
    vim.keymap.set('n', '<leader>fh', snacks.picker.help, { desc = 'help' })
    vim.keymap.set('n', '<leader>ff', snacks.picker.grep, { desc = 'grep' })
    vim.keymap.set('n', '<leader>fk', snacks.picker.keymaps, { desc = 'keymaps' })
    vim.keymap.set('n', '<leader>fg', snacks.picker.git_grep, { desc = 'git grep' })
    vim.keymap.set('n', '<leader>fp', snacks.picker.git_files, { desc = 'git files' }) -- project files
    vim.keymap.set('n', '<leader>fw', snacks.picker.grep_word, { desc = 'word' }) -- string under cursor or selection

    -- Open a project from zoxide
    -- :lua Snacks.picker.zoxide(opts?)
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#zoxide
    -- vim.keymap.set('n', '<leader>fz', snacks.picker.zoxide, { desc = 'zoxide' })
  end,
}
