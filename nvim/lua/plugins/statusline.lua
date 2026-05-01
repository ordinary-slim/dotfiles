return {
  {'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons', opt = true},
    enabled = function()
      return not vim.g.started_by_firenvim
    end,
    config = function()
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
