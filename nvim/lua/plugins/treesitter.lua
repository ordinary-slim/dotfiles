return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- require("nvim-treesitter.configs").setup {
    --     highlight = {
    --         additional_vim_regex_highlighting = false
    --     },
    -- }
  end,
}
