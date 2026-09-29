local installed = require("nvim-treesitter")
  .install({ "cpp" })
  :wait(300000) -- wait up to 5 minutes

if not installed then
  vim.notify("Treesitter parser installation failed", vim.log.levels.ERROR)
  return
end

vim.treesitter.start()
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
vim.wo.foldlevel = 2
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
