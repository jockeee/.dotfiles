--
-- commands.lua

vim.api.nvim_create_user_command('ConvertUnicodeEscapes', function()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  for i, line in ipairs(lines) do
    lines[i] = line:gsub('\\u([%da-fA-F]+)', function(hex) return utf8.char(tonumber(hex, 16)) end)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end, {})
