"
"           .---.
"           |   |.--. __  __   ___
"           |   ||__||  |/  `.'   `.
"           |   |.--.|   .-.  .-.   '
"           |   ||  ||  |  |  |  |  |
"       _   |   ||  ||  |  |  |  |  |
"     .' |  |   ||  ||  |  |  |  |  |
"    .   | /|   ||  ||  |  |  |  |  |
"  .'.'| |//|   ||__||__|  |__|  |__|
".'.'.-'  / '---'
".'   \_.'
"
"
" 
" LUA {{{
lua << EOF
require('settings')
-- Setup nvim_lsp
require("mason").setup()
require("mason-lspconfig").setup()
local mynvim_lsp = require('mynvimlsp')
-- Setup nvim-cmp
local mynvimcmp = require('mynvimcmp')
-- Setup LuaSnip
local myluasnip = require('myluasnip')
-- My tex utils (background compilation)
local myTexUtils = require('myTexUtils')
require('keybinds')
EOF
" }}}
" Utility functions {{{
function! GetBufferDict()
	" return a dictionary of the currently listed buffers
	let l:existing_buffers = {}
	for b in range(0, bufnr('$'))
		if buflisted(b)
			let l:existing_buffers[b] = bufname(b)
		endif
	endfor
	return l:existing_buffers
endfunction
function! GetBufferList()
	" return a list of the currently listed buffers
	let l:existing_buffers = []
	for b in range(0, bufnr('$'))
		if buflisted(b)
			call add(l:existing_buffers, bufname(b))
		endif
	endfor
	return l:existing_buffers
endfunction
" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)
" }}}
" WSL clipboard {{{
" set clipboard+=unnamedplus
" let g:clipboard = {
          " \   'name': 'win32yank-wsl',
          " \   'copy': {
          " \      '+': 'win32yank.exe -i --crlf',
          " \      '*': 'win32yank.exe -i --crlf',
          " \    },
          " \   'paste': {
          " \      '+': 'win32yank.exe -o --lf',
          " \      '*': 'win32yank.exe -o --lf',
          " \   },
          " \   'cache_enabled': 0,
          " \ }
" }}}
" Modelines (folds) {{{
" Must be near (5 lines within) the top/bottom)
" vim:foldmethod=marker:foldlevel=0
" }}}
