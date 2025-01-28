-- Make sure to set map leader before plugin manager
vim.g.mapleader = ' '

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
require("lazy").setup({
  -- seamless vim/tmux pane navigation
  {'christoomey/vim-tmux-navigator'},
  -- Colorschemes
  {'rebelot/kanagawa.nvim',
    lazy=false,
    priority = 1000,
  },
  {'Mofiqul/vscode.nvim'},
  -- Statusline
  {'nvim-lualine/lualine.nvim'},
  -- If you want to have icons in your statusline choose one of these
  {'nvim-tree/nvim-web-devicons'},
  -- Plug 'smartpde/telescope-recent-files'
  -- language server protocols
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  -- autocomplete
  {'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
  },

  -- luasnip
  {'L3MON4D3/LuaSnip'},
  {'saadparwaiz1/cmp_luasnip'},

  -- ''premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim``
  {'tpope/vim-fugitive'},

  {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- gdb inside vim
  {'sakhnik/nvim-gdb'},
  --[=====[
  -- TODO: Restore old options
  { 'do': ':!./install.sh' }
  let w:nvimgdb_termwin_command = "belowright new"
  --]=====]
  -- zen mode
  {'folke/zen-mode.nvim'},
  -- nvim-treesitter
  { 'nvim-treesitter/nvim-treesitter'},
})


local vscode_colors = require('vscode.colors').get_colors()
require('vscode').setup({
  transparent=true,
  italic_comments=true,
  underline_links=true,
  disable_nvimtree_bg=true,
  -- Override colors (see ./lua/vscode/colors.lua)
  color_overrides = {
    vscLineNumber = '#FFFFFF',
  },
  -- Override highlight groups (see ./lua/vscode/theme.lua)
  group_overrides = {
      -- this supports the same val table as vim.api.nvim_set_hl
      -- use colors from this colorscheme by requiring vscode.colors!
      Cursor = { fg=vscode_colors.vscDarkBlue, bg=vscode_colors.vscLightGreen, bold=true },
  }
})
vim.cmd.colorscheme "vscode"
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

require("lualine").setup({
  options = {
    theme = 'vscode',
  },
})

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

-- TODO: Add folds
