--
-- sensitive file

local active = true

if not active then
  return
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Disable swap, backup, undo for sensitive extensions and paths',
  group = vim.api.nvim_create_augroup('config-sensitive-file', { clear = true }),
  callback = function()
    local path = vim.fn.expand '%:p' or ''

    local tmp_dirs = { '/tmp/', '/var/tmp/', '/dev/shm/', vim.fn.expand '~/.cache/' }
    local whitelist_dirs = { '/tmp/nvim.' .. vim.fn.expand '$USER' .. '/' }

    local sensitive_exts = {
      gpg = true,
      asc = true,
      key = true,
      pem = true,
      crt = true,
      csr = true,
      p12 = true,
      pfx = true,
      ca = true,
      fullchain = true,
      ovpn = true,
      env = true,
      bak = true,
      tmp = true,
      log = true,
    }

    local function starts_with_any(s, prefixes)
      for _, p in ipairs(prefixes) do
        if s:sub(1, #p) == p then
          return true
        end
      end
      return false
    end

    local ext = path:lower():match '%.([^.]+)$'
    local is_sensitive_ext = ext ~= nil and sensitive_exts[ext] ~= nil

    local is_in_temp_dir = starts_with_any(path, tmp_dirs)
    local is_in_whitelist = starts_with_any(path, whitelist_dirs)

    if is_sensitive_ext or (is_in_temp_dir and not is_in_whitelist) then
      vim.opt_local.swapfile = false
      vim.opt_local.backup = false
      vim.opt_local.writebackup = false
      vim.opt_local.undofile = false

      vim.schedule(function()
        vim.notify('Disabled swap, backup, undo', vim.log.levels.WARN)
      end)
    end
  end,
})
