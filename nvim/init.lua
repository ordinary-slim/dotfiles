-- Set mapleader before loading any plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = "-"

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
require('options') -- general settings
require('extra-filetypes') -- extra syntax highlighting
require('base-keybinds') -- non-plugin keybinds

require("lazy").setup({ import = "plugins" })

-- default ftplugin in lua/default-ftplugin.lua
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("DefaultFtplugin", { clear = true }),
  callback = function(event)
    local specific = vim.fn.stdpath("config")
      .. "/ftplugin/" .. event.match .. ".lua"

    if vim.fn.filereadable(specific) == 1 then
      return -- Neovim loads the specific file itself
    end

    require("default-ftplugin").setup(event.buf, event.match)
  end,
})
