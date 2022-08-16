let g:Ctex    = "pdflatex" "latex compiler
"flags
let g:CFtex   = "-shell-escape"
let g:Cbibtex = "bibtex"
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
    silent exec printf("!%s %s %s", g:Ctex, g:CFtex, l:mainbuffer)
    call PrintShellErrorStatus()
endfunction
function BibtexCall()
    let l:mainbuffer=GetTexBuffer()
    wall
    silent exec printf("!%s %s", g:Cbibtex, fnamemodify(l:mainbuffer, ":r"))
    call PrintShellErrorStatus()
endfunction

function OverleafLikeCompile()
    "writes current buffer then calls lualatex once, bibtex once, lualatex
    "twice
    let l:mainbuffer=GetTexBuffer()
    wall
    silent exec printf("!%s %s %s", g:Ctex, g:CFtex, l:mainbuffer)
    silent exec printf("!%s %s", g:Cbibtex, fnamemodify(l:mainbuffer, ":r"))
    silent exec printf("!%s %s %s", g:Ctex, g:CFtex, l:mainbuffer)
    silent exec printf("!%s %s %s", g:Ctex, g:CFtex, l:mainbuffer)
    call PrintShellErrorStatus()
endfunction
" }}}
" Mappings {{{
" nnoremap <F8> :call QuickLatexCompile()<cr>
" nnoremap <F9> :call BibtexCall()<cr>
" nmap <F10> :call OverleafLikeCompile()<cr>
" }}}
" Modelines {{{
" Must be near (5 lines within) the top/bottom)
" vim:foldmethod=marker:foldlevel=0
" }}}
