--
-- https://github.com/folke/snacks.nvim
-- A collection of QoL plugins for Neovim
--
-- Pickers
--  :h snacks-picker-sources
--  https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#-sources
--  default keybinds for pickers use <M-char>, same in Explorer.
--    M-h   hidden files

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
    ---@type snacks.image.Config
    image = {
      doc = {
        -- render the image inline in the buffer
        -- if your env doesn't support unicode placeholders, this will be disabled
        -- takes precedence over `opts.float` on supported terminals
        inline = true, -- healthcheck says wezterm is not supported
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = false,
        max_width = 40, -- d: 80
        max_height = 20, -- d: 40
      },
    },
    lazygit = {},
    ---@type snacks.picker.Config
    picker = {
      -- layout = {
      --   preset = 'ivy',
      -- },
      sources = {
        files = {
          hidden = true, -- include dotfiles
          -- no_ignore = true,   -- show files ignored by .gitignore
          exclude = { '*.woff*' },
        },
        explorer = {
          hidden = true, -- include dotfiles
        },
      },
      grep = {
        sort_by = 'filename', -- filename | index | score | none
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
    ---@type snacks.win.Config
    win = {
      backdrop = false,
    },
  },
  config = function(_, opts)
    local snacks = require 'snacks'
    snacks.setup(opts)

    vim.keymap.set('n', '<leader>di', snacks.image.hover, { desc = 'Snacks: image' })

    vim.keymap.set('n', '<leader>g', snacks.lazygit.open, { desc = 'Lazygit' })

    vim.keymap.set('n', '\\', snacks.explorer.open, { desc = 'Explorer' }) -- nvim-tree style
    vim.keymap.set('n', '<leader>/', snacks.picker.lines, { desc = 'Find: buffer' })
    -- vim.keymap.set('n', '<leader>/', function()
    --   snacks.picker.lines {
    --     layout = {
    --       preview = {
    --         width = 0.5,
    --         location = 'right',
    --       },
    --     },
    --   }
    -- end, { desc = 'Find: buffer' })

    vim.keymap.set('n', '<leader><space>', snacks.picker.files, { desc = 'Find: files' })
    vim.keymap.set('n', '<leader>fa', snacks.picker.resume, { desc = 'resume' })
    vim.keymap.set('n', '<leader>fi', snacks.picker.icons, { desc = 'icons' })
    vim.keymap.set('n', '<leader>fb', snacks.picker.pickers, { desc = 'builtin pickers' })
    vim.keymap.set('n', '<leader>fh', snacks.picker.help, { desc = 'help' })
    vim.keymap.set('n', '<leader>ff', snacks.picker.grep, { desc = 'grep' })
    vim.keymap.set('n', '<leader>fk', snacks.picker.keymaps, { desc = 'keymaps' })
    vim.keymap.set('n', '<leader>fg', snacks.picker.git_grep, { desc = 'git grep' })
    vim.keymap.set('n', '<leader>fp', snacks.picker.git_files, { desc = 'git files' }) -- project files
    vim.keymap.set({ 'n', 'x' }, '<leader>fw', snacks.picker.grep_word, { desc = 'word' }) -- string under cursor or selection

    -- lazy plugins
    vim.keymap.set('n', '<leader>fl', function()
      snacks.picker.grep {
        cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy'),
      }
    end, { desc = 'lazy plugins grep' })
    vim.keymap.set('n', '<leader>fL', function()
      snacks.picker.files {
        cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy'),
        prompt_title = 'Lazy plugin files',
      }
    end, { desc = 'lazy plugins files' })
  end,
}
