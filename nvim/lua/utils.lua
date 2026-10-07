vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  -- group = vim.api.nvim_create_augroup("BodyWeight", { clear = true }),
  pattern = "body-weight.csv",
  callback = function(event)
    vim.keymap.set("n", "o", function()
      return "o<C-u>" .. os.date("%Y-%m-%d") .. ", "
    end, {
        buffer = event.buf,
        expr = true,
        desc = "(Body) weight entry",
      })
  end,
})
