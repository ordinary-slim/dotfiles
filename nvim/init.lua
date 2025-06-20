-- Set mapleader before loading any plugins
vim.g.mapleader = ' '

require('settings')
-- Setup nvim_lsp
require("mason").setup()
require("mason-lspconfig").setup()
local mynvim_lsp = require('mynvimlsp')
-- Setup nvim-cmp
local mynvimcmp = require('mynvimcmp')
-- Setup LuaSnip
local myluasnip = require('myluasnip')
-- My tex utils (background compilation)
local myTexUtils = require('myTexUtils')
require('keybinds')
