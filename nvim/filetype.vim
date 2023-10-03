" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd BufNewFile,BufRead *.gcode set filetype=gcode
augroup END
