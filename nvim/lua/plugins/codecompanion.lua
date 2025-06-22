return {'olimorris/codecompanion.nvim',
        event = 'VeryLazy',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'nvim-telescope/telescope.nvim',
        },
        config = function()
          require('codecompanion').setup({
            -- Add your configuration here
            -- For example:
            -- default_provider = 'telescope',
            -- providers = {
            --   telescope = {
            --     theme = 'dropdown',
            --   },
            -- },
          })
        end,
}
