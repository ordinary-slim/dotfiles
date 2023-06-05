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
" Plugin manager {{{
    call plug#begin('~/.config/nvim/plugged')

        " gdb inside vim
        Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
            let w:nvimgdb_termwin_command = "belowright new"
        " seamless vim/tmux pane navigation
        Plug 'christoomey/vim-tmux-navigator'

        " language server protocols
        Plug 'neovim/nvim-lspconfig'

        " autocomplete
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'
        Plug 'hrsh7th/nvim-cmp'

        " luasnip
        Plug 'L3MON4D3/LuaSnip'
        Plug 'saadparwaiz1/cmp_luasnip'

        " Colorschemes
        Plug 'rafi/awesome-vim-colorschemes'

        " ''premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim``
        Plug 'tpope/vim-fugitive'
    call plug#end()
" }}}
" LUA {{{
lua << EOF
-- Setup nvim_lsp
local mynvim_lsp = require('mynvimlsp')
-- Setup nvim-cmp
local mynvimcmp = require('mynvimcmp')
-- Setup LuaSnip
local myluasnip = require('myluasnip')
-- My tex utils (background compilation)
local myTexUtils = require('myTexUtils')
EOF
" }}}
" General {{{
    colorscheme default
    " determine directory of .vimrc
    let vimrc_folder = split($MYVIMRC, "init.vim")[0]

    set mouse=a
    set nohlsearch
    set nu rnu
    set hidden
    syntax on
    filetype indent on "filetype based indentation
" Statusline {
    set laststatus=2
    set completeopt=menu,menuone,noselect
"}
" Tabs {
    set autoindent
    set tabstop=2
    set shiftwidth=2
    set expandtab
"}
" Filetype specific {
    let fortran_have_tabs=1 "fortran77 syntax highlighting
    let g:tex_flavor= "tex" "treat plaintex as tex
"}
" }}}
" Plugin settings {{{
" nvimgdb {{
let g:nvimgdb_config_override = {
  \ 'key_step': '<ctrl-s>',
  \ }
" }}
" }}}
" Mappings {{{
    let mapleader = ' '
    nnoremap <Leader>w :wa<cr>
    nnoremap <Leader>q :qa<cr>
    nnoremap <Leader>c :close<cr>
    nnoremap <Leader>d :bp\|bd #<cr>
    nnoremap <Leader>r :e<cr>zz
    "nnoremap <Leader>e :call ud_loadsameextension#LoadSameExtension()<cr>
    "Does not work in nvim
    " defined in Other functions (last section of this file)
    nnoremap <Leader>t :call ToggleQuickFixWindow()<cr>

    " Use ctrl-[hjkl] to select the active split!
    nmap <silent> <c-k> :wincmd k<CR>
    nmap <silent> <c-j> :wincmd j<CR>
    nmap <silent> <c-h> :wincmd h<CR>
    nmap <silent> <c-l> :wincmd l<CR>

    " navigate buffer list
    nnoremap <c-n> :bn<cr>
    nnoremap <c-p> :bp<cr>
    nnoremap <BS> <c-^>

    " navigate quickfix list
    nnoremap ]q :cnext<cr>
    nnoremap [q :cprev<cr>

    " experimental
    " TO CHANGE: not overwriting content of register p
    "" insert new line and come back at exact position
    nnoremap <cr> :normal mpo<Esc>`p

    " nnoremap K mpi<cr><Esc> `p "overwrites lsp hover
" }}}
" Utility functions {{{
function ToggleQuickFixWindow()
    "if quickfixwindow is open, close it, and viceversa
    " check if quickfixwindow is currently open
    if empty(filter(getwininfo(), 'v:val["quickfix"]'))
        copen 6
        normal G
    else
        cclose
    endif
endfunction
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
function! PrintShellErrorStatus()
	" check error status of the shell
  if (v:shell_error==0)
    echo "Last shell command succeeded"
  else
    echo "Last shell command FAILED"
  endif
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
" Modelines (folds) {{{
" Must be near (5 lines within) the top/bottom)
" vim:foldmethod=marker:foldlevel=0
" }}}
