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
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
    -- UI select
    -- https://github.com/nvim-telescope/telescope-ui-select.nvim
    -- Sets `vim.ui.select` to telescope.
    -- It means Neovim core stuff can fill the telescope picker, example would be `lua vim.lsp.buf.code_action()`.
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local _, lga_actions = pcall(require, 'telescope-live-grep-args.actions')

    telescope.setup {
      defaults = {
        file_ignore_patterns = {
          -- In lua patterns, dashes are interpreted as quantifier, so you have to escape them
          -- 'lazy%-lock.json',
          '.woff2',
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
          '--glob=!**/vendor/*',
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
            -- '--no-ignore-vcs', -- don't exclude files specified in .gitignore

            -- Exclude the following patterns from search
            -- '--glob=!**/.idea/*',
            -- '--glob=!**/.vscode/*',
            -- '--glob=!**/build/*',
            -- '--glob=!**/dist/*',
            '--glob=!**/vendor/*',
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
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
              -- freeze the current list and start a fuzzy search in the frozen list
              ['<C-space>'] = lga_actions.to_fuzzy_refine,
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = 'dropdown', -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'live_grep_args')

    local builtin = require 'telescope.builtin'

    -- Find in current buffer
    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0, -- transparency
        previewer = true,
      })
    end, { desc = 'Find in current buffer' })

    -- vim.keymap.set('n', '<leader>/', function()
    --   local opts = {}
    -- end, { desc = 'Find in current buffer' })

    vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Files' })
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Files' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, { desc = 'Grep Args' })
    -- vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Git File' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymap' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume' })
    vim.keymap.set('n', '<leader>fs', '<cmd>Telescope session-lens<cr>', { desc = 'auto-sessions' }) -- auto-session
    vim.keymap.set('n', '<leader>fS', builtin.builtin, { desc = 'Telescope Select' })
    vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Todos' }) -- todo-comments.nvim
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Word Under Cursor' })
  end,
}
