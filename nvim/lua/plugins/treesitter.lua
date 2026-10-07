return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ensure_installed = {
      "bash",
      "python",
      "cpp",
    }
    if #ensure_installed > 0 then
      local nts = require("nvim-treesitter")
      nts.install(ensure_installed)
    end
  end,
}
