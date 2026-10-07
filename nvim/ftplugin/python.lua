vim.treesitter.start()
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
vim.wo.foldlevel = 2

-- apparently this is bad and should be in after/indent/python.lua
-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
