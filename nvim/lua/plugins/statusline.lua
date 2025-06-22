return {
  {'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons', opt = true},
    config = function()
      vim.opt.laststatus = 2
      vim.cmd("set completeopt=menu,menuone,noselect")
      require('lualine').setup {
        options = {
          icons_enabled = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
      }
    end
  }
}
