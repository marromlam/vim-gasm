" Tell vim our background-style color
set background=dark
" Access colors present in 256 colorspace
let base16colorspace=256
" Enables 24 bit colors
set termguicolors
" Add indicator for line 80 and 120
let &colorcolumn="81,121"

" Character for vertical split pane
set fillchars=vert:│

" Use italics for comments
highlight Comment cterm=italic gui=italic

" Color support
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files

" Color scheme {{{
colorscheme gruvbox
let g:airline_theme='gruvbox'
highlight Comment cterm=italic gui=italic
" }}}

" Dim Inactive {{{
" Handle focus lost and gained events
let g:diminactive_enable_focus = 1
" Use color column to help with active/inactive
let g:diminactive_use_colorcolumn = 1
" }}}
