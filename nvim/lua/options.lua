local vg = vim.g
local vb = vim.bo
local vw = vim.wo
local vo = vim.opt

vim.cmd([[colorscheme default]])
vo.mouse = "a"
vo.nu = true
vo.rnu = true
vo.hlsearch = false
vo.hidden = true
vo.syntax = "on" -- syntax on

-- Sets how Neovim will display certain whitespace characters in the editor
vo.list = true
vo.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Tabs
vo.autoindent = true
vo.tabstop = 2
vo.shiftwidth = 2
vo.expandtab = true

vo.splitright = true -- Put new windows right of current
vo.termguicolors = true -- True color support

vg.fortran_have_tabs = 1
vg.tex_flavor= "tex" -- treat plaintex as tex
