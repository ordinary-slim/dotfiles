-- Set mapleader before loading any plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Lazy (plugin manager) setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- TODO: Refactor hierarchy plugins
-- TODO: Not load everything
require("lazy").setup({ import = "plugins" })

-- Generaly settings
require('settings')
-- Setup LSPs
require("mason").setup()
require("mason-lspconfig").setup()
local mynvim_lsp = require('mynvimlsp')
-- Setup nvim-cmp
local mynvimcmp = require('mynvimcmp')
-- Setup LuaSnip
local myluasnip = require('myluasnip')
-- My tex utils (background compilation)
local myTexUtils = require('myTexUtils')
-- Shortcuts
require('keybinds')
-- Setup statusline
require("lualine").setup()
