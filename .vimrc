"  /$$$$$$  /$$ /$$              
" /$$__  $$| $$|__/              
"| $$  \__/| $$ /$$ /$$$$$$/$$$$ 
"|  $$$$$$ | $$| $$| $$_  $$_  $$
" \____  $$| $$| $$| $$ \ $$ \ $$
" /$$  \ $$| $$| $$| $$ | $$ | $$
"|  $$$$$$/| $$| $$| $$ | $$ | $$
" \______/ |__/|__/|__/ |__/ |__/
" Shell settings {{{
" set shell=\"C:\Users\U52430\OneDrive\ -\ Bühler\Desktop\Git\git-bash.exe"\
set shell=powershell
set shellquote=""
" set shelltype
" set shellpipe
" set shellslash
" set shellredir
" set shellcmdflag
" }}}
" Pluggins. Plug manager is vim-plug {{{
let g:vim_plug_path = $VIM.'/.vim/autoload/plug.vim'
let &rtp .= ','.g:vim_plug_path

let g:vim_plug_installed = 1
" if vim-plug is not installed, install vim-plug
if empty(glob(g:vim_plug_path))
	if executable('curl')
		silent exec '!curl -fLo '.g:vim_plug_path.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		" previous command could fail but g:vim_plug_path is still set to 1
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
	call plug#begin($VIM.'/.vim/plugged')
	" Utility
	Plug 'MarcWeber/vim-addon-mw-utils' "required by snipmate
	Plug 'tomtom/tlib_vim' "required by snipmate
	Plug 'garbas/vim-snipmate' "snippets
	Plug 'skywind3000/asyncrun.vim' "job_start made easier
	" Coding
	Plug 'JuliaEditorSupport/julia-vim' "julia syntax
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
" }}}
" Miscellaneous {{{
set guifont=Consolas:h11

try
	colorscheme Gruvbox
catch /^Vim\%((\a\+)\)\=:E185:/ 
	colorscheme desert
endtry

syntax enable
let &laststatus = 2 "always show status line
set number relativenumber | set numberwidth=3

set autoindent " indent after an indented line
set breakindent " wrapped lines are indented at ea pseudo new line
" }}}
" Mappings {{{
let mapleader = ' '
nnoremap <Leader>w :w<cr>
nnoremap <Leader>d :bd<cr>
nnoremap <Leader>c :close<cr>
nnoremap <Leader>q :quitall<cr>
nnoremap <Leader>t :call ToggleQuickFix()<cr>
nnoremap <Leader>f :vimgrep // ##<left><left><left><left>

nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>

nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>

nnoremap <cr> :call append(line("."), "")<cr>
nnoremap K i<cr><esc>

inoremap <c-e> <c-o>$
" }}}
" Modes {{{
let g:julia_programming = 0
let g:note_taking = 1
" LaTeX {{{
if g:note_taking
	let g:tex_flavor = "latex"
	" let g:tex_no_error = 1 " no error handling atm
	function! Add_TeX_to_args()
		if getcwd()==expand('~')
			echoe '! You should not do this in the root directory.'
			return -1
		else
			e main.tex
			argadd **/*.tex
			buffer main
			return 0
		endif
	endfunction
	nnoremap <Leader>X :call Add_TeX_to_args()<cr>

	if executable('pdflatex') "TO DO : Make it unix compatible
		let g:discrete_latex_path = '' "discrete_latex runs pdflatex w/o interaction and returns error level
		if &shell=="powershell"
			let g:discrete_latex_path = "& \"".$VIM."/discrete_latex.bat"."\"" "& is the call operator, runs a command from a variable (powershell)
			let g:overleaflike_path = "& \"".$VIM."/overleaflike.bat"."\""
		elseif stridx(&shell, "git-bash")
		endif

		function! CompileLaTex()
			wa
			let l:existing_buffers = GetBufferList()
			if (index(l:existing_buffers, 'main.tex')==-1)
				if (expand('%:e') != 'tex')&&(expand('%:e') != 'ltx')
					echoe '! You are trying to LaTeX compile a non-latex file'
					return -1
				else
					let l:mainbuffer = @%
				endif
			else
				let l:mainbuffer = 'main.tex'
			endif
			exec 'AsyncRun '.g:discrete_latex_path.' '. l:mainbuffer
			copen 6
			wincmd w
		endfunction
		function! OpenLog()
			cclose
			let l:existing_buffers = GetBufferList()
			if (index(l:existing_buffers, 'main.tex')==-1)
				exec 'split '.expand('%:t:r').'.log'
			else
				exec 'split main.log'
			endif
			silent! /!
		endfunction
		function! RunBibTex()
			wa
			let l:existing_buffers = GetBufferList()
			if (index(l:existing_buffers, 'main.tex')==-1)
				if (expand('%:e') != 'tex')&&(expand('%:e') != 'ltx')
					echoe '! You are trying to solve BiBTeX references for a non-latex file'
					return -1
				else
					let l:mainbuffer = expand("%:t:r") "name of current file
				endif
			else
				let l:mainbuffer = 'main'
			endif
			exec 'AsyncRun bibtex '.l:mainbuffer
			copen 6
			wincmd w
		endfunction
		function! OverleafLikeCompile()
			wa
			let l:existing_buffers = GetBufferList()
			if (index(l:existing_buffers, 'main.tex')==-1)
				if (expand('%:e') != 'tex')&&(expand('%:e') != 'ltx')
					echoe '! You are trying to LaTeX compile a non-latex file'
					return -1
				else
					let l:mainbuffer = expand("%:t:r") "name of current file
				endif
			else
				let l:mainbuffer = 'main'
			endif
			"let s:job = job_start(g:overleaflike_path . ' ' . l:mainbuffer)
			exec 'AsyncRun '.g:overleaflike_path.' '. l:mainbuffer
			copen 6
			wincmd w
		endfunction
		nmap <F8> :call CompileLaTex()<cr>
		nmap <F10> :call RunBibTex()<cr>
		nmap <F12> :call OpenLog()<cr>
		nmap <C-Enter> :call OverleafLikeCompile()<cr>
	endif
endif
" }}}
" Julia "{{{
if g:julia_programming
	let g:julia_path = 'C:\Users\mehdi\AppData\Local\Programs\Julia\Julia-1.4.2\bin\julia.exe'
	nnoremap <C-Enter> :exec '! '.g:julia_path.' '.@%.' --run'<cr>
endif
" }}}
" }}}
" File navigation {{{
set hidden " buffer is set to hidden when abandonned
let &path.= ','.'**' " add subdirectories when using find command
set wildmenu
set wildmode=full
let g:netrw_liststyle=3
let g:netrw_browse_split = 4
" }}}
" Section Folding {{{
set foldenable
set foldlevelstart=0
set foldmethod=syntax
" }}}
" Helper functions {{{
function! ToggleQuickFix()
	" check if quickfix buffer is in a window else open in a window
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
" Modelines. Must be near (5 lines within) the top/bottom) {{{
" vim:foldmethod=marker:foldlevel=0
" }}}
