--
-- filetypes.lua

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
