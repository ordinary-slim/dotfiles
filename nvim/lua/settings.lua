vim.cmd("colorscheme peachpuff")
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

-- TODO: Add folds
