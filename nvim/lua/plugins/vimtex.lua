return {
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_complete_enabled = false
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_syntax_conceal_disable = true

      -- Live compilation
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = 'build',
        out_dir = 'build',
        callback = 1,
        continuous = 1,
        options = {
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      if common.is_unix then
        vim.g.vimtex_view_method = "zathura"
      elseif common.is_windows then
        vim.g.vimtex_view_general_viewer = "SumatraPDF"
        vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
      end
      vim.api.nvim_create_augroup('VimtexPostCompile', { clear = true })

      vim.api.nvim_create_autocmd('User', {
        group = 'VimtexPostCompile',
        pattern = 'VimtexEventCompileSuccess',
        callback = function()
          local script = 'publish.sh'
          if vim.fn.filereadable(script) == 1 then
            vim.fn.jobstart({ 'bash', script })
          end
        end,
      })

    end,

  },
}

