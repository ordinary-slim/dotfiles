"  /$$$$$$  /$$ /$$
" /$$__  $$| $$|__/
"| $$  \__/| $$ /$$ /$$$$$$/$$$$
"|  $$$$$$ | $$| $$| $$_  $$_  $$
" \____  $$| $$| $$| $$ \ $$ \ $$
" /$$  \ $$| $$| $$| $$ | $$ | $$
"|  $$$$$$/| $$| $$| $$ | $$ | $$
" \______/ |__/|__/|__/ |__/ |__/
" 
" User defined modes {{{
" Self implementation of filetype detection
" should be refactored! Rely on vim tools
let g:ExtensionFirstArgument = fnamemodify(argv(0), ":e")

let g:LaTeX=0
if g:ExtensionFirstArgument=="tex" || &ft=="tex"
    let g:LaTeX=1
endif
" }}}
" Plugin manager {{{
    call plug#begin('~/.config/nvim/plugged')

        Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
            let w:nvimgdb_termwin_command = "belowright new"
        Plug 'christoomey/vim-tmux-navigator'

        Plug 'neovim/nvim-lspconfig'

        " autocomplete
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'
        Plug 'hrsh7th/nvim-cmp'

        " For luasnip users.
        Plug 'L3MON4D3/LuaSnip'
        Plug 'saadparwaiz1/cmp_luasnip'

        "shitton of colorschemes
        Plug 'rafi/awesome-vim-colorschemes'
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
EOF
" }}}
" Plugin settings {{{
" nvimgdb {{
let g:nvimgdb_config_override = {
  \ 'key_step': '<ctrl-s>',
  \ }
" }}
" }}}
" General {{{
    colorscheme gruvbox
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
" Coding {
let fortran_have_tabs=1 "fortran77 syntax highlighting
"}
" }}}
" General mappings {{{
    let mapleader = ' '
    nnoremap <Leader>w :wa<cr>
    nnoremap <Leader>q :qa<cr>
    nnoremap <Leader>d :bp\|bd #<cr>
    " contained in autoload
    nnoremap <Leader>e :call ud_loadsameextension#LoadSameExtension()<cr>
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
" LaTeX {{{
" Should be refactored !!!
if g:LaTeX
    let g:tex_flavor = "tex"
    " Functions
    function GetTexBuffer()
        let l:existing_buffers = GetBufferList()
        if (index(l:existing_buffers, 'main.tex')==-1)
            if (expand('%:e') != 'tex')&&(expand('%:e') != 'ltx')
                echo "Are you sure you've got the right file?"
                echo "Exiting execution before compilation..."
                return
            else
                let l:mainbuffer = @%
            endif
        else
            let l:mainbuffer = 'main.tex'
        endif
        return l:mainbuffer
    endfunction
    function QuickLatexCompile()
        let l:mainbuffer=GetTexBuffer()
        wall
        exec "!lualatex -shell-escape " . l:mainbuffer
    endfunction

    function LongLatexCompile()
        "writes current buffer then calls lualatex once, bibtex once, lualatex
        "twice
        let l:mainbuffer=GetTexBuffer()
        wall
        exec "!lualatex -shell-escape " . l:mainbuffer
        " GOTTA CORRECT THIS!!!
        exec "!bibtex " . fnamemodify(l:mainbuffer, ":r")
        exec "!lualatex -shell-escape " . l:mainbuffer
        exec "!lualatex -shell-escape " . l:mainbuffer
    endfunction
    " Mappings
    nnoremap <F8> :call QuickLatexCompile()<cr>
    nmap <F9> :call LongLatexCompile()<cr>
endif
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
" }}}
" Modelines {{{
" Must be near (5 lines within) the top/bottom)
" vim:foldmethod=marker:foldlevel=0
" }}}
