" Marcos Romero Lamas
"
"    Configures camspiers/lens and camspiers/animate plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lens {{{
let g:lens#height_resize_min = 15
" If 1, lens is disabled
let g:lens#disabled = 0
" }}}

" Animate {{{
" If 0, animation is disabled
let g:lens#animate = 1
" }}}

" Define Drawers {{{
" Opens FoldDigest with some default visual settings
function! CustomFoldDigest() abort
  call FoldDigest()
  call EnableCleanUI()
  vertical resize 1
  call animate#window_absolute_width(lens#get_cols())
  set winfixwidth
endfunction
" Creates a vsplit in an animated fashion
function! Vsplit() abort
  vsplit
  call NaturalVerticalDrawer()
endfunction
" Creates a split with animation
function! Split() abort
  split
  call NaturalDrawer()
endfunction
" Creates a drawer effect that respects the natural height
function! NaturalDrawer() abort
  let height = winheight(0)
  resize 1
  call animate#window_absolute_height(height)
endfunction
" Creates a drawer effect that respects the natural width
function! NaturalVerticalDrawer() abort
  let width = winwidth(0)
  vertical resize 1
  call animate#window_absolute_width(width)
endfunction
" Animate the quickfix and ensure it is at the bottom
function! OpenQuickFix() abort
  if getwininfo(win_getid())[0].loclist != 1
    wincmd J
  endif
  call NaturalDrawer()
endfunction
" }}}
