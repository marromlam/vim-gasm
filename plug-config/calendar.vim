" Opens calendar with animation
function! OpenCalendar() abort
  new | wincmd J | resize 1
  " call animate#window_percent_height(0.8)
  call timer_start(300, {id -> execute('Calendar -position=here')})
endfunction
" Cycle through relativenumber + number, number (only), and no numbering.
function! CycleLineNumbering() abort
  execute {
    \ '00': 'set relativenumber   | set number',
    \ '01': 'set norelativenumber | set number',
    \ '10': 'set norelativenumber | set nonumber',
    \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
endfunction

" Toggle virtualedit
function! ToggleVirtualEdit() abort
  if &virtualedit != "all"
    set virtualedit=all
  else
    set virtualedit=
  endif
endfunction
