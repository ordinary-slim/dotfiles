-- Global vars and utility functions
local M = {}

local sysname = vim.loop.os_uname().sysname
M.is_linux = sysname == "Linux"
M.is_macos = sysname == "Darwin"
M.is_unix = M.is_linux or M.is_macos
M.is_windows = not M.is_unix

-- Utility functions
function M.ToggleQuickFixWindow()
  -- if quickfixwindow is open, close it, and viceversa
  -- check if quickfixwindow is currently open
  -- next(A) == nil checks if table A is empty
  if (next(vim.fn.filter(vim.fn.getwininfo(), 'v:val["quickfix"]')) == nil) then
      vim.cmd([[copen 6]])
      vim.cmd([[normal G]])
  else
      vim.cmd([[cclose]])
  end
end

return M
