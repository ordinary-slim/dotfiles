" Plugins. Plugin manager is vim-plug
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" let $HOME = $VIM
let g:vim_plug_path = $HOME.'/.vim/autoload/plug.vim'
let &rtp .= g:vim_plug_path

" if vim-plug is not installed, install vim-plug
if empty(glob(g:vim_plug_path))
	silent exec '!curl -fLo '.g:vim_plug_path.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
exec 'source '.g:vim_plug_path

call plug#begin('~/.vim/plugged')
" Aspect
Plug 'morhetz/gruvbox' " gruvbox colorscheme
" Miscellaneous
Plug 'terryma/vim-smooth-scroll' " smooth scrolling
	noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
	noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
	noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
	noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
call plug#end()
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set guifont=Consolas:h11

silent! colorscheme Gruvbox

syntax enable
let &laststatus = 2 "always show status line
set number | set numberwidth=3

set autoindent " indent after an indented line
set breakindent " wrapped lines are indented at ea pseudo new line

" Mappings
let mapleader = ','
nnoremap <Leader>w :bd<cr>
nnoremap <Leader>c :close<cr>
nnoremap <Leader>q :quit<cr>
nnoremap <cr> :call append(line("."), "")<cr>
inoremap <c-e> <c-o>$
