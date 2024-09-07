--
-- autocmds.lua

-- nvim startup, if no arguments was specified, open telescope find_files()
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Open telescope find_files() on startup',
  group = vim.api.nvim_create_augroup('open-telescope-find_files', { clear = true }),
  callback = function()
    if vim.fn.argv(0) == '' then
      -- package_exists check prevents error when lazy is doing installs on startup,
      -- where I guess we reach VimEnter but lazy hasn't loaded any plugins yet.
      local package_exists

      -- if there are more than one window open in the current tab, do nothing (could be lazy ui)
      if #vim.api.nvim_tabpage_list_wins(0) > 1 then
        return
      end

      -- If an auto-session session exists for current working directory, do nothing (unless it's an empty buffer)
      package_exists, _ = pcall(require, 'auto-session')
      if package_exists then
        if require('auto-session').session_exists_for_cwd() then
          -- If there are more than an empty buffer open, do nothing
          if vim.api.nvim_list_bufs() ~= 1 and vim.api.nvim_buf_get_name(0) ~= '' then
            return
          end
        end
      end

      -- Open telescope find_files()
      package_exists, _ = pcall(require, 'telescope.builtin')
      if package_exists then
        require('telescope.builtin').find_files()
      end
    end
  end,
})

-- highlight when yanking (copying) text
--  :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
