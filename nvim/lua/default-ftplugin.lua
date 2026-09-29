local M = {}

function M.setup(buf, filetype)
  local lang = vim.treesitter.language.get_lang(filetype)
  if lang == nil or vim.bo[buf].buftype ~= "" then
    return
  end

  if not vim.treesitter.language.add(lang) then
    local nt = require("nvim-treesitter")
    if (nt ~= nil and vim.list_contains(nt.get_available(), lang)) then
      vim.schedule(function()
        vim.notify(
          string.format("%s treesitter parser not installed.", lang),
          vim.log.levels.WARN
        )
      end)
    end
  else
    vim.treesitter.start(buf, lang)
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo.foldlevel = 99
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

return M
