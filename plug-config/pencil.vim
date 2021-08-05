let g:pencil#autoformat = 0
let g:pencil#textwidth = 80
let g:pencil#conceallevel = 0

" Enabled appropriate options for text files
function! EnableTextFileSettings() abort
  setlocal spell
  EnableAutocorrect
  silent TableModeEnable
  call pencil#init({'wrap': 'hard'})
endfunction
