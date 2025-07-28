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

_G.common = require("common") -- define global variables and utility functions
require("lazy").setup({ import = "plugins" })

-- Generaly settings
require('options')
-- Setup LSPs
require("mason").setup()
require("mason-lspconfig").setup()
-- Shortcuts
require('keybinds')
-- Setup statusline
require("lualine").setup()
