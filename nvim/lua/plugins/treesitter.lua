return { { 'nvim-treesitter/nvim-treesitter',
          config = function()
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end} }
