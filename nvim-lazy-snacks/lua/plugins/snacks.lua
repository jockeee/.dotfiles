return {
  'folke/snacks.nvim',
  event = 'VimEnter',
  ---@type snacks.Config
  opts = {
    bigfile = {},
    picker = {
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      sources = {
        files = {
          hidden = true, -- include dotfiles
          -- no_ignore = true,   -- don't respect .gitignore
        },
      },
    },
  },
  config = function(_, opts)
    local snacks = require 'snacks'
    snacks.setup(opts)

    -- TODO: configure win, no numbers, a bit smaller
    -- vim.ui.select = snacks.picker.select

    vim.keymap.set('n', '<leader><leader>', snacks.picker.files, { desc = 'Files' })
    vim.keymap.set('n', '<leader>fa', snacks.picker.resume, { desc = 'Resume' })
    vim.keymap.set('n', '<leader>fb', snacks.picker.pickers, { desc = 'Builtin Pickers' })
    vim.keymap.set('n', '<leader>fh', snacks.picker.help, { desc = 'Help' })
    vim.keymap.set('n', '<leader>fk', snacks.picker.keymaps, { desc = 'Keymap' })
  end

  -- come back, get luals up first, will be easier to find stuff

  -- vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Find in current buffer' })
  -- vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
  -- vim.keymap.set('n', '<leader>fe', telescope.extensions.emoji.emoji, { desc = 'Emoji' })
  -- -- vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Grep' }) -- Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)
  -- -- vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, { desc = 'Grep Args' })
  -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
  -- vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymap' })
  -- vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Git File' }) -- Fuzzy search through the output of git ls-files command, respects .gitignore
  -- vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'LSP: References' })
  -- vim.keymap.set('n', '<leader>fs', '<cmd>Telescope session-lens<cr>', { desc = 'auto-sessions' }) -- auto-session
  -- vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Todos' }) -- todo-comments.nvim
  -- vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Word Under Cursor' }) -- Searches for the string under your cursor or selection in your current working directory
  --
  -- -- Find Files (ivy)
  -- vim.keymap.set('n', '<leader>fi', function()
  --   local opts = require('telescope.themes').get_ivy {
  --     -- cwd = vim.fn.stdpath 'config',
  --   }
  --   require('telescope.builtin').find_files(opts)
  -- end, { desc = 'Files (ivy)' })
  --
  -- --
  -- -- https://github.com/tjdevries/advent-of-nvim/blob/master/nvim/lua/config/telescope/multigrep.lua
  -- -- TJ - Advent of Neovim
  -- --
  -- -- It splits prompt on double space
  -- --    1st piece: -e Pattern to search for
  -- --    2nd piece: -g Include or exclude files and directories for searching that match the given glob
  -- --
  -- -- Examples
  -- --    Prompt                      Description
  -- --    ------------------------------------------------------------------------------------------
  -- --    foo bar  *.lua              search for 'foo bar' and show only files with '.lua' extension
  -- --    foo bar  **/plugins/**      search for 'foo bar' and show only files with 'plugins' in path
  -- vim.keymap.set('n', '<leader>ff', require('user.telescope.multigrep').live_multigrep, { desc = 'Grep' })
}
