-- Airline + Tabline configuration


vim.g.airline_powerline_fonts = 0
vim.g["airline#extensions#tabline#enabled"] = 1

-- remove the encoding part
vim.g.airline_section_x=''
-- let g:airline_section_y=''
-- remove separators for empty sections
vim.g.airline_skip_empty_sections = 1

-- let g:airline#extensions#wordcount#format = '%d w'
vim.g["airline#parts#ffenc#skip_expected_string"] ='utf-8[unix]'
-- let g:airline_section_z = '%3p%% %3l/%L:%3v'
