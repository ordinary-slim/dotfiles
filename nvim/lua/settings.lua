
vim.cmd.colorscheme('everforest')
vim.opt.mouse = "a"
vim.opt.hlsearch = false
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.hidden = true
vim.opt.syntax = "on" -- syntax on
-- Statusline
vim.opt.laststatus = 2
vim.cmd("set completeopt=menu,menuone,noselect")
-- Tabs
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.fortran_have_tabs = 1
vim.g.tex_flavor= "tex" -- treat plaintex as tex

-- Plugin settings
vim.g.nvimgdb_config_override = {
  key_step = "ctrl-s",
}

require("lualine").setup()

-- Copilot
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true


-- Utility functions
function ToggleQuickFixWindow()
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
