return {
  {
  'nvim-treesitter/nvim-treesitter', -- Smarter code understanding (syntax highlighting, folding, go to definition, etc.)
  build = ":TSUpdate",
  -- cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- parsers you want:
      ensure_installed = {
        "c", "cpp", "cmake", "diff", "gitcommit", "gitignore", "go",
        "html", "json", "lua",
        "markdown", "markdown_inline",
        "python", "toml", "vim", "vimdoc", "yaml",
        -- latex, bibtex,
        -- Controlled by vimtex
      },

      -- automatically download any that are missing
      auto_install = true,      -- installs on buffer enter
      ignore_install = { "latex", "bibtex" },
        -- MIGHT complain if tree-sitter-cli is not installed!
      sync_install = false,     -- set to true if you prefer :TSUpdateSync

      highlight = { enable = true },
      indent    = { enable = true },
    })

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
  end
  }
}
