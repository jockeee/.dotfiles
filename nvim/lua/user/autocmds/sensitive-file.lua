--
-- sensitive file

local g_sensitive_file = vim.api.nvim_create_augroup('g-sensitive-file', { clear = true })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Disable swap, backup, undo, copilot for certain filetypes and paths',
  group = g_sensitive_file,
  callback = function()
    local path = vim.fn.expand '%:p' or ''
    local filetype = vim.bo.filetype
    local path_lower = path:lower()

    local temp_dirs = {
      '/tmp/',
      '/var/tmp/',
      '/dev/shm/',
      vim.fn.expand '~/.cache/',
    }

    local function path_starts_with_any(p, prefixes)
      for _, prefix in ipairs(prefixes) do
        if p:sub(1, #prefix) == prefix then return true end
      end
      return false
    end

    local sensitive_ext_pattern = [[
      \.(gpg|asc|key|pem|crt|csr|p12|pfx|ca|fullchain|env|log|bak|tmp)$
    ]]

    local is_in_temp_dir = path_starts_with_any(path, temp_dirs)
    local is_sensitive_ext = path_lower:match(sensitive_ext_pattern)

    if is_in_temp_dir or is_sensitive_ext or filetype == 'text' then
      vim.opt_local.swapfile = false
      vim.opt_local.backup = false
      vim.opt_local.writebackup = false
      vim.opt_local.undofile = false

      vim.b.copilot_enabled = false -- zbirenbaum/copilot.lua

      vim.schedule(function()
        vim.notify('Disabled swap, backup, undo, copilot', vim.log.levels.WARN)
      end)
    end
  end,
})
