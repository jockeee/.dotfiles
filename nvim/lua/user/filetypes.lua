--
-- lua/user/filetypes.lua

-- css
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'css',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2

    -- /usr/share/nvim/runtime/ftplugin/css.vim sets iskeyword to include '-'
    vim.opt_local.iskeyword:remove '-'
  end,
})

-- html
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

-- lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

-- yaml.ansible
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('DetectAnsibleYaml', { clear = true }),
  pattern = { '*.yml', '*.yaml' },
  callback = function()
    local path = vim.api.nvim_buf_get_name(0)

    -- Heuristic #1: Directory path hint
    if path:match '/roles/' or path:match '/tasks/' or path:match '/playbooks/' then
      vim.bo.filetype = 'yaml.ansible'
      return
    end

    -- Heuristic #2: Content-based hint (first 20 lines)
    local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
    for _, line in ipairs(lines) do
      if
        line:match '^%s*hosts:'
        or line:match '^%s*tasks:'
        or line:match '^%s*roles:'
        or line:match '^%s*vars:'
        or line:match '^%s*- name:'
        or line:match '^%s*become:'
      then
        vim.bo.filetype = 'yaml.ansible'
        return
      end
    end

    -- No Ansible markers found: leave filetype as plain "yaml"
  end,
})
