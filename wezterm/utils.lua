--
-- utils.lua

local wezterm = require 'wezterm'
local mux = wezterm.mux

local M = {}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
M.basename = function(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

M.tab_title = function(tab)
  -- Prefer the title that was set via `tab:set_title()` or `wezterm cli set-tab-title`,
  local title = tab.tab_title
  if title and #title > 0 then
    return title
  end

  --- Active pane's process name
  title = M.basename(tab.active_pane.foreground_process_name)
  if title and #title > 0 then
    return title
  end

  -- Fallback, active pane's title
  return tab.active_pane.title
end

M.workspace_exists = function(existing_workspaces, workspace)
  for _, w in ipairs(existing_workspaces) do
    if w == workspace then
      return true
    end
  end
  return false
end

M.switch_to_workspace_or_create = function(workspace, cwd)
  local current_workspace = mux.get_active_workspace()
  local all_workspaces = mux.get_workspace_names()

  if workspace == current_workspace then
    return
  end

  for _, w in ipairs(all_workspaces) do
    if w == workspace then
      mux.set_active_workspace(workspace)
      wezterm.GLOBAL.previous_workspace = current_workspace
      return
    end
  end

  -- workspace doesn't exist
  mux.spawn_window {
    workspace = workspace,
    cwd = cwd,
  }
  mux.set_active_workspace(workspace)
  wezterm.GLOBAL.previous_workspace = current_workspace
end

-- M.switch_to_previous_workspace = function()
--   local current_workspace = mux.get_active_workspace()
--   local previous_workspace = wezterm.GLOBAL.previous_workspace
--
--   if current_workspace == previous_workspace or previous_workspace == nil then
--     return
--   end
--
--   M.switch_to_workspace_or_create(previous_workspace)
-- end

return M
