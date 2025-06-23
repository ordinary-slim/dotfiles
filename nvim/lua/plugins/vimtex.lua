return {
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_complete_enabled = false
      vim.g.vimtex_quickfix_enabled = false
      vim.g.vimtex_syntax_conceal_disable = true

      -- Use the following command for inverse search on Linux / macOS
      --   nvim --headless -c "VimtexInverseSearch %l '%f'"
      -- and the following on Windows (to reduce CMD popping)
      --   cmd /c start /min "" nvim --headless -c "VimtexInverseSearch %l '%f'"

      -- \ll to toggle interactive compilation (updates / launches PDF viewer on saved change)
      -- \lk to interrupt compilation
      -- \lc to clean files
      -- \lo to inspect output
      -- \li to see compile commands

      
      -- Live compilation
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-f",
        },
      }

      if common.is_unix then
        vim.g.vimtex_view_method = "zathura"
      elseif common.is_windows then
        vim.g.vimtex_view_general_viewer = "SumatraPDF"
        vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
      end
    end,
  },
}

