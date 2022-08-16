" Mappings {{{
lua << EOF
vim.keymap.set('n', '<F8>', '<cmd>lua require"myTexUtils":compileTex()<cr>')
vim.keymap.set('n', '<F9>', '<cmd>lua require"myTexUtils":callBibTex()<cr>')
EOF
" }}}
" Modelines {{{
" Must be near (5 lines within) the top/bottom)
" vim:foldmethod=marker:foldlevel=0
" }}}
