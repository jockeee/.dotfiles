--
-- https://github.com/nvim-telescope/telescope.nvim
-- Find, Filter, Preview, Pick. All lua, all the time.
--
-- Open a window that shows you all keymaps for the current Telescope picker
--    Insert mode: <c-/>
--    Normal mode: ?

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  event = 'VimEnter',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make', -- `build` is used to run some command when the plugin is installed/updated.
      cond = function() -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
        return vim.fn.executable 'make' == 1
      end,
    },
    -- UI select
    -- https://github.com/nvim-telescope/telescope-ui-select.nvim
    -- Sets `vim.ui.select` to telescope.
    -- It means Neovim core stuff can fill the telescope picker, example would be `lua vim.lsp.buf.code_action()`.
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          -- In lua patterns, dashes are interpreted as quantifier, so you have to escape them
          -- 'lazy%-lock.json',
        },
        vimgrep_arguments = {
          -- Default grep command and arguments
          'rg',
          '--color=never',
          '--no-heading', -- don't group matches by each file
          '--with-filename',
          '--line-number',
          '--column', -- show column numbers
          '--smart-case',

          -- Extra arguments
          -- '--no-ignore-vcs', -- don't exclude files specified in .gitignore
          '--follow', -- follow symbolic links
          '--hidden', -- search in hidden files (dotfiles)

          -- Exclude the following patterns from search
          -- '--glob=!**/.idea/*',
          -- '--glob=!**/.vscode/*',
          -- '--glob=!**/build/*',
          -- '--glob=!**/dist/*',
          '--glob=!**/.git/*',
          '--glob=!**/yarn.lock',
          '--glob=!**/package-lock.json',
          '--glob=!**/vendor/*',
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- default: false
          find_command = {
            -- Default find command and arguments
            'rg',
            '--files',

            -- Extra arguments
            -- '--no-ignore-vcs', -- don't exclude files specified in .gitignore

            -- Exclude the following patterns from search
            -- '--glob=!**/.idea/*',
            -- '--glob=!**/.vscode/*',
            -- '--glob=!**/build/*',
            -- '--glob=!**/dist/*',
            '--glob=!**/.git/*',
            '--glob=!**/yarn.lock',
            '--glob=!**/package-lock.json',
            '--glob=!**/vendor/*',
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'

    -- Find in current buffer
    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0, -- transparency
        previewer = false,
      })
    end, { desc = 'Find in current buffer' })

    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find File' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffer' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
    vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Find Grep' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find Git File' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymap' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Fesume' })
    vim.keymap.set('n', '<leader>fs', '<cmd>Telescope session-lens<cr>', { desc = 'Find auto-sessions' }) -- auto-session
    vim.keymap.set('n', '<leader>fS', builtin.builtin, { desc = 'Find Telescope Select' })
    vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find Todos' }) -- todo-comments.nvim
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find Word Under Cursor' })
  end,
}
