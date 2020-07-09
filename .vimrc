" Plugs. Plug manager is vim-plug
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" let $HOME = $VIM
let g:vim_plug_path = $HOME.'/.vim/autoload/plug.vim'
let &rtp .= g:vim_plug_path

let g:vim_plug_installed = 1
" if vim-plug is not installed, install vim-plug
if empty(glob(g:vim_plug_path))
	if executable('curl')
		silent exec '!curl -fLo '.g:vim_plug_path.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	elseif executable('wget')
		silent exec '!wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -P '.fnamemodify(g:vim_plug_path, ":h")
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	else
		echo '! Could not install the plugin manager :('
		let g:vim_plug_installed = 0
	endif
endif
if g:vim_plug_installed
	exec 'source '.g:vim_plug_path

	call plug#begin('~/.vim/plugged')
	" Utility
	Plug 'MarcWeber/vim-addon-mw-utils' "required by snipmate
	Plug 'tomtom/tlib_vim' "required by snipmate
	Plug 'garbas/vim-snipmate' "snippets
	Plug 'skywind3000/asyncrun.vim' "job_start made easier
	" Aspect
	Plug 'morhetz/gruvbox' " gruvbox colorscheme
	" Miscellaneous
	Plug 'terryma/vim-smooth-scroll' " smooth scrolling
		noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
		noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
		noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
		noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
	call plug#end()
endif
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

if executable('pdflatex') "TO DO : Make it unix compatible
	let g:discrete_latex_path = '' "discrete_latex runs pdflatex w/o interaction and returns error level
	if has('win32')
		let g:discrete_latex_path = $HOME."/.vim/discrete_latex.bat"
	endif
	function! CompileLatex()
		write
		exec 'AsyncRun '.g:discrete_latex_path.' '.@%
		copen 6
		wincmd w
	endfunction
	nnoremap <C-Enter> :call CompileLatex() <cr>
	nnoremap <F11> :exec 'split '.expand('%:t:r').'.log'<cr> /!<cr>
endif
