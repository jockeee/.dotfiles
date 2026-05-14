--
-- folke/snacks.nvim

vim.pack.add {
  'https://github.com/folke/snacks.nvim',
}

require('snacks').setup {
  bigfile = {},
  explorer = {},
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
  win = {
    backdrop = false,
  },
}

vim.keymap.set('n', '<leader>di', Snacks.image.hover, { desc = 'snacks: image' })

vim.keymap.set('n', '<leader>g', Snacks.lazygit.open, { desc = 'lazygit' })

vim.keymap.set('n', '\\', Snacks.explorer.open, { desc = 'Explorer' }) -- nvim-tree style
vim.keymap.set('n', '<leader>/', Snacks.picker.lines, { desc = 'find: buffer lines' })
-- vim.keymap.set('n', '<leader>/', function()
--   Snacks.picker.lines {
--     layout = {
--       preview = {
--         width = 0.5,
--         location = 'right',
--       },
--     },
--   }
-- end, { desc = 'Find: buffer lines' })

vim.keymap.set('n', '<leader><space>', Snacks.picker.files, { desc = 'find: files' })
vim.keymap.set('n', '<leader>fa', Snacks.picker.resume, { desc = 'resume' })
vim.keymap.set('n', '<leader>fb', Snacks.picker.pickers, { desc = 'builtin pickers' })
vim.keymap.set('n', '<leader>ff', Snacks.picker.grep, { desc = 'grep' })
vim.keymap.set('n', '<leader>fg', Snacks.picker.git_grep, { desc = 'project, grep' }) -- repo
vim.keymap.set('n', '<leader>fG', Snacks.picker.git_files, { desc = 'project, files' }) -- repo files
vim.keymap.set('n', '<leader>fh', Snacks.picker.help, { desc = 'help' })
vim.keymap.set('n', '<leader>fi', Snacks.picker.icons, { desc = 'icons' })
vim.keymap.set('n', '<leader>fk', Snacks.picker.keymaps, { desc = 'keymaps' })
-- vim.keymap.set('n', '<leader>fs', Snacks.picker.todo_comments, { desc = 'todo' })
vim.keymap.set({ 'n', 'x' }, '<leader>fw', Snacks.picker.grep_word, { desc = 'word' }) -- string under cursor or selection

-- plugin code, grep
vim.keymap.set('n', '<leader>fp', function()
  Snacks.picker.grep {
    cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'site', 'pack', 'core', 'opt'), -- ~/.local/share/nvim/site/pack/core/opt
    title = '~/.local/share/nvim/site/pack/core/opt (grep)',
  }
end, { desc = 'plugin code, grep' })
-- plugin code, files
vim.keymap.set('n', '<leader>fP', function()
  Snacks.picker.files {
    cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'site', 'pack', 'core', 'opt'), -- ~/.local/share/nvim/site/pack/core/opt
    title = '~/.local/share/nvim/site/pack/core/opt (files)',
  }
end, { desc = 'plugin code, files' })
