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

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values

local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then return nil end

      local pieces = vim.split(prompt, '  ')
      local args = { 'rg' }
      if pieces[1] then
        table.insert(args, '-e')
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, '-g')
        table.insert(args, pieces[2])
      end

      return vim
        .iter({
          args,
          {
            -- Default arguments
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
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Multi Grep',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

-- M.setup = function()
--   vim.keymap.set("n", "<leader>ff", live_multigrep)
-- end

M.live_multigrep = live_multigrep

return M
