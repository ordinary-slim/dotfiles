vim.g.mapleader = ' '

-- TODO: Switch plugin manager
vim.cmd [[
  call plug#begin('~/.config/nvim/plugged')

      " gdb inside vim
      Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
          let w:nvimgdb_termwin_command = "belowright new"
      " seamless vim/tmux pane navigation
      Plug 'christoomey/vim-tmux-navigator'

      " language server protocols
      Plug 'neovim/nvim-lspconfig'

      " autocomplete
      Plug 'hrsh7th/cmp-nvim-lsp'
      Plug 'hrsh7th/cmp-buffer'
      Plug 'hrsh7th/cmp-path'
      Plug 'hrsh7th/cmp-cmdline'
      Plug 'hrsh7th/nvim-cmp'

      " luasnip
      Plug 'L3MON4D3/LuaSnip'
      Plug 'saadparwaiz1/cmp_luasnip'

      " Colorschemes
      Plug 'rafi/awesome-vim-colorschemes'

      " ''premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim``
      Plug 'tpope/vim-fugitive'

      " highly extendable fuzzy finder over lists
      Plug 'nvim-lua/plenary.nvim'
      Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }

      " Statusline
      Plug 'nvim-lualine/lualine.nvim'
      " If you want to have icons in your statusline choose one of these
      Plug 'nvim-tree/nvim-web-devicons'
      " Plug 'smartpde/telescope-recent-files'

  call plug#end()
]]

vim.cmd("colorscheme 256_noir")
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
