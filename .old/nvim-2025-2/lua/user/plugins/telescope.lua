--
-- https://github.com/nvim-telescope/telescope.nvim
-- Find, Filter, Preview, Pick. All lua, all the time.
--
-- :Telescope builtin
--
-- Default keymaps
--    To see the full list of mappings, check out lua/telescope/mappings.lua and the default_mappings table.
--    https://github.com/nvim-telescope/telescope.nvim#default-mappings
--
--    C-f   Scroll left in preview window
--    C-k   Scroll right in preview window
--    M-f   Scroll left in results window
--    M-k   Scroll right in results window
--
--    C-q   Send all items not filtered to quickfixlist (qflist)
--    M-q   Send all selected items to qflist
--
-- Show mappings for current picker
--    C-/   Insert mode
--    ?     Normal mode

return {
  'nvim-telescope/telescope.nvim',
  -- branch = '0.1.x',
  event = 'VimEnter',
  dependencies = {
    {
      -- FZF sorter for telescope written in c
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      -- Makes telescope search faster
      --
      -- fzf syntax is supported:
      --    Token     Match type                  Description
      --    ------------------------------------------------------------------------
      --    sbtrkt    fuzzy-match                 Items that match sbtrkt
      --    'wild     exact-match (quoted)        Items that include wild
      --    ^music    prefix-exact-match          Items that start with music
      --    .mp3$     suffix-exact-match          Items that end with .mp3
      --    !fire     inverse-exact-match         Items that do not include fire
      --    !^music   inverse-prefix-exact-match  Items that do not start with music
      --    !.mp3$    inverse-suffix-exact-match  Items that do not end with .mp3
      --
      -- OR operator `|`
      --    Query:    ^core go$ | rb$ | py$
      --    Matches:  entries that start with core and end with either go, rb, or py.
      'nvim-telescope/telescope-fzf-native.nvim',
      -- command to run when the plugin is installed/updated.
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
      -- condition used to determine whether this plugin should be installed and loaded.
      -- cond = function()
      --   return vim.fn.executable 'make' == 1
      -- end,
    },

    -- UI select
    -- https://github.com/nvim-telescope/telescope-ui-select.nvim
    -- Sets `vim.ui.select` to telescope = nvim core stuff can use the telescope picker.
    -- For example, nvim displays below with telescope picker instead:
    --    vim.lsp.buf.code_action()
    'nvim-telescope/telescope-ui-select.nvim',

    -- {
    --   'nvim-telescope/telescope-live-grep-args.nvim',
    --   -- Keymaps
    --   --    ['<C-k>'] = lga_actions.quote_prompt(),
    --   --    ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
    --   --    freeze the current list and start a fuzzy search in the frozen list
    --   --    ['<C-space>'] = lga_actions.to_fuzzy_refine,
    --   -- Grep argument examples
    --   --    (Some examples are ripgrep specific)
    --   --    Prompt                      Args                      Description
    --   --    --------------------------------------------------------------------------
    --   --    foo bar                     foo bar                   search for 'foo bar'
    --   --    "foo bar" baz               foo bar, baz              search for 'foo bar' in dir 'baz'
    --   --    --no-ignore "foo bar        --no-ignore, foo bar      search for 'foo bar' ignoring ignores
    --   --    "foo" --iglob **/test/**                              search for 'foo' in any 'test' path
    --   --    "foo" ../other-project      foo, ../other-project     search for 'foo' in ../other-project
    --   --
    --   -- If the prompt value does not begin with ', " or - the entire prompt is treated as a single argument.
    --   -- This behaviour can be turned off by setting the auto_quoting option to false.
    --   --
    --   -- This extension accepts the same options as builtin.live_grep,
    --   -- check out `:h live_grep` and `:h vimgrep_arguments` for more information.
    --   -- It also accepts `theme` and `layout_config`.
    --   --
    --   -- This will not install any breaking changes.
    --   -- For major updates, this must be adjusted manually.
    --   version = '^1.0.0',
    -- },

    {
      'allaman/emoji.nvim',
      -- ft = "markdown", -- adjust to your needs
      dependencies = {
        -- util for handling paths
        'nvim-lua/plenary.nvim',
        -- optional for nvim-cmp integration
        -- "hrsh7th/nvim-cmp",
        -- optional for telescope integration
        'nvim-telescope/telescope.nvim',
        -- optional for fzf-lua integration via vim.ui.select
        -- "ibhagwan/fzf-lua",
      },
      opts = {
        -- default is false, also needed for blink.cmp integration!
        -- enable_cmp_integration = true,
        -- optional if your plugin installation directory
        -- is not vim.fn.stdpath("data") .. "/lazy/
        -- plugin_path = vim.fn.expand '$HOME/plugins/',
      },
    },
  },
  config = function()
    local telescope = require 'telescope'
    -- local lga_actions = require 'telescope-live-grep-args.actions'

    telescope.setup {
      defaults = {
        mappings = {
          n = {
            ['q'] = require('telescope.actions').close,
          },
        },
        file_ignore_patterns = {
          -- In lua patterns, dashes are interpreted as quantifier, so you have to escape them
          -- 'lazy%-lock.json',
          '.woff2',
        },
        vimgrep_arguments = {
          'rg',
          -- Default arguments
          '--color=never',
          '--no-heading', -- don't group matches by each file
          '--with-filename',
          '--line-number',
          '--column', -- show column numbers
          '--smart-case',

          -- Extra arguments
          -- '--no-ignore-vcs', -- don't exclude files specified in .gitignore
          '--follow', -- follow symbolic links = show symlinked files
          '--hidden', -- search in hidden files (dotfiles) = show hidden files

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
          -- hidden = true, -- default: false, show hidden files
          -- follow = true, -- default: false, show symlinked files

          find_command = {
            'rg',
            -- Defualt arguments
            '--files',

            -- Extra arguments
            -- '--no-ignore-vcs', -- don't exclude files specified in .gitignore
            '--follow', -- follow symbolic links = show symlinked files
            '--hidden', -- search in hidden files (dotfiles) = show hidden files

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
        fzf = {
          --   -- You dont need to set any of these options.
          --   -- These are the default ones.
          --   fuzzy = true,                   -- false will only do exact matching
          --   override_generic_sorter = true, -- override the generic sorter
          --   override_file_sorter = true,    -- override the file sorter
          --   case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          --   -- the default case_mode is "smart_case"
        },

        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },

        -- live_grep_args = {
        --   auto_quoting = true, -- true = if the prompt value does not begin with ', " or - the entire prompt is treated as a single argument.
        --   -- define mappings, e.g.
        --   mappings = {         -- extend mappings
        --     i = {
        --       ['<C-k>'] = lga_actions.quote_prompt(),
        --       ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
        --       -- freeze the current list and start a fuzzy search in the frozen list
        --       ['<C-space>'] = lga_actions.to_fuzzy_refine,
        --     },
        --   },
        --   -- ... also accepts theme settings, for example:
        --   -- theme = 'dropdown', -- use dropdown theme
        --   -- theme = { }, -- use own theme spec
        --   -- layout_config = { mirror=true }, -- mirror preview pane
        -- },
      },
    }

    -- Enable telescope extensions, if they are installed
    require('telescope').load_extension 'fzf'
    -- require('telescope').load_extension 'live_grep_args'
    require('telescope').load_extension 'ui-select'
    require('telescope').load_extension 'emoji'

    local builtin = require 'telescope.builtin'

    -- Find in current buffer
    -- Overriding default behavior and theme
    -- vim.keymap.set('n', '<leader>/', function()
    --   -- You can pass additional configuration to telescope to change theme, layout, etc.
    --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    --     winblend = 0, -- transparency
    --     previewer = true,
    --   })
    -- end, { desc = 'Find in current buffer' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Find in current buffer' })

    -- Find nvim config files
    vim.keymap.set(
      'n',
      '<leader>fn',
      function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath 'config',
        }
      end,
      { desc = 'nvim' }
    )

    -- Find lazy files
    vim.keymap.set('n', '<leader>fl', function()
      require('telescope.builtin').find_files {
        ---@diagnostic disable-next-line: param-type-mismatch
        cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy'),
      }
    end, { desc = 'Lazy' })

    -- vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Files' })
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fa', builtin.resume, { desc = 'Resume' })
    vim.keymap.set('n', '<leader>fb', builtin.builtin, { desc = 'Telescope: builtin' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>fe', telescope.extensions.emoji.emoji, { desc = 'Emoji' })
    -- vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Grep' }) -- Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)
    -- vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, { desc = 'Grep Args' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymap' })
    vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Git File' }) -- Fuzzy search through the output of git ls-files command, respects .gitignore
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'LSP: References' })
    vim.keymap.set('n', '<leader>fs', '<cmd>Telescope session-lens<cr>', { desc = 'auto-sessions' }) -- auto-session
    vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Todos' }) -- todo-comments.nvim
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Word Under Cursor' }) -- Searches for the string under your cursor or selection in your current working directory

    -- Find Files (ivy)
    vim.keymap.set('n', '<leader>fi', function()
      local opts = require('telescope.themes').get_ivy {
        -- cwd = vim.fn.stdpath 'config',
      }
      require('telescope.builtin').find_files(opts)
    end, { desc = 'Files (ivy)' })

    --
    -- https://github.com/tjdevries/advent-of-nvim/blob/master/nvim/lua/config/telescope/multigrep.lua
    -- TJ - Advent of Neovim
    --
    -- It splits prompt on double space
    --    1st piece: -e Pattern to search for
    --    2nd piece: -g Include or exclude files and directories for searching that match the given glob
    --
    -- Examples
    --    Prompt                      Description
    --    ------------------------------------------------------------------------------------------
    --    foo bar  *.lua              search for 'foo bar' and show only files with '.lua' extension
    --    foo bar  **/plugins/**      search for 'foo bar' and show only files with 'plugins' in path
    vim.keymap.set('n', '<leader>ff', require('user.telescope.multigrep').live_multigrep, { desc = 'Grep' })

    -- Play around
    -- vim.keymap.set('n', '<leader>qd', function()
    --   local opts = require('telescope.themes').get_dropdown {
    --     cwd = vim.fn.stdpath 'config',
    --   }
    --   require('telescope.builtin').find_files(opts)
    -- end, { desc = 'Telescope Dropdown' })
  end,
}
