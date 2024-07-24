--
-- https://github.com/nvim-telescope/telescope.nvim
-- Find, Filter, Preview, Pick. All lua, all the time.
--
-- :help telescope
-- :help telescope.setup
-- :help telescope.builtin
--
-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current Telescope picker.
-- This is really useful to discover what Telescope can do as well as how to actually do it!

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make', -- `build` is used to run some command when the plugin is installed/updated.

      cond = function() -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
        return vim.fn.executable 'make' == 1
      end,
    },
    -- telescope-ui-select sets vim.ui.select to telescope.
    -- That means for example that neovim core stuff can fill the telescope picker.
    -- Example would be lua vim.lsp.buf.code_action().
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons', -- for pretty icons, requires a nerd font
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          -- '%.lockb', -- hides buns binary lock file from the results
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
          '--no-ignore-vcs', -- don't exclude files specified in .gitignore
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
            '--no-ignore-vcs', -- don't exclude files specified in .gitignore

            -- Exclude the following patterns from search
            -- '--glob=!**/.idea/*',
            -- '--glob=!**/.vscode/*',
            -- '--glob=!**/build/*',
            -- '--glob=!**/dist/*',
            '--glob=!**/.git/*',
            '--glob=!**/yarn.lock',
            '--glob=!**/package-lock.json',
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

    -- Find in open files
    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Find in open files',
      }
    end, { desc = 'Find in open files' })

    -- Find file (dropdown)
    vim.keymap.set('n', '<C-p>', function()
      builtin.find_files(require('telescope.themes').get_dropdown {
        layout_config = {
          width = 0.8,
        },
      })
    end, { desc = 'Find file (dropdown)' })

    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find file' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffer' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find diagnostics' })
    vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Find by grep' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymap' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find old (recent) file' })
    vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Find git file' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find resume' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'Find select telescope' })
    vim.keymap.set('n', '<leader>fS', '<cmd>Telescope session-lens<cr>', { desc = 'Find auto-sessions' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
  end,
}
