let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1

" remove the encoding part
let g:airline_section_x=''
" let g:airline_section_y=''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1

" let g:airline#extensions#wordcount#format = '%d w'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline_section_z = '%3p%% %3l/%L:%3v'
