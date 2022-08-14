let g:tex_flavor        = "tex"
let g:tex_executable    = "lualatex"
let g:bibtex_executable = "bibtex"
" Functions {{{
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
    exec "!" . g:tex_executable . " -shell-escape " . l:mainbuffer
endfunction
function BibtexCall()
    let l:mainbuffer=GetTexBuffer()
    wall
    exec "!" . g:bibtex_executable .  " " . fnamemodify(l:mainbuffer, ":r")
endfunction

function OverleafLikeCompile()
    "writes current buffer then calls lualatex once, bibtex once, lualatex
    "twice
    let l:mainbuffer=GetTexBuffer()
    wall
    exec "!" . g:tex_executable . " -shell-escape " . l:mainbuffer
    " GOTTA CORRECT THIS!!!
    exec "!" . g:bibtex_executable .  " " . fnamemodify(l:mainbuffer, ":r")
    exec "!" . g:tex_executable . " -shell-escape " . l:mainbuffer
    exec "!" . g:tex_executable . " -shell-escape " . l:mainbuffer
endfunction
" }}}
" Mappings {{{
nnoremap <F8> :call QuickLatexCompile()<cr>
nnoremap <F9> :call BibtexCall()<cr>
nmap <F10> :call OverleafLikeCompile()<cr>
" }}}
" Modelines {{{
" Must be near (5 lines within) the top/bottom)
" vim:foldmethod=marker:foldlevel=0
" }}}
