" Mappings {{{
lua << EOF
function runPython()
  -- Run python3 on current buffer
  pI = "python3"
  vim.cmd("wall") -- write all changed buffers
  currentBuffer = vim.api.nvim_eval("expand('%')")
  print("Running", pI)
  handle = vim.loop.spawn(pI, {
  args = {currentBuffer},
  },
  function (code, signal) -- on exit callback
    if (code==0) then
      print("Last run succeeded")
    else
      print("Last run FAILED")
    end
  end
  )
end
EOF
" }}}
" Modelines {{{
" Must be near (5 lines within) the top/bottom)
" vim:foldmethod=marker:foldlevel=0
" }}}
