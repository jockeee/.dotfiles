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

-- Golang: Add missing imports on save using gopls
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    -- if not (#vim.lsp.get_clients() > 0) then
    --   return
    -- end

    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout.
    -- Depending on your machine and codebase, you may want longer.
    -- Add an additional argument after params if you find that you have to write the file twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})
