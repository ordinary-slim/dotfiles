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

      vim.g.beamer_reveal_busy = false

      vim.api.nvim_create_autocmd('User', {
        group = 'VimtexPostCompile',
        pattern = 'VimtexEventCompileSuccess',
        callback = function()
          local script = 'publish.sh'
          if vim.fn.filereadable(script) == 1 then
            -- Don't start if it's working somewhere
            if vim.g.beamer_reveal_busy then
              vim.notify("beamer-reveal already working.", vim.log.levels.INFO)
              return
            end

            -- Start it
            vim.g.beamer_reveal_busy = true
            vim.fn.jobstart({'bash', script}, {
              pty=true,
              -- on_stdout = function(_, data, _)
              --   if not data then return end
              --   for _, line in ipairs(data) do
              --     if line ~= "" then
              --       print("[stdout]", line)
              --     end
              --   end
              -- end,
              --
              -- on_stderr = function(_, data, _)
              --   if not data then return end
              --   for _, line in ipairs(data) do
              --     if line ~= "" then
              --       print("[stderr]", line)
              --     end
              --   end
              -- end,
              on_exit = function(job_id, exit_code, event_type)
                vim.g.beamer_reveal_busy = false
                if exit_code == 0 then
                  vim.notify("Generated HTML", vim.log.levels.INFO)
                else
                  vim.notify(string.format("Failed to generate HTML (code %d)", exit_code), vim.log.levels.ERROR)
                end
              end,
            })
          end
        end,
      })

    end,

  },
}

