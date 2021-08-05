" Use gx{text-object} in normal mode
nmap gx <Plug>(neoterm-repl-send)
" Send selected contents in visual mode.
xmap gx <Plug>(neoterm-repl-send)

" Enables UI styles suitable for terminals etc
function! EnableCleanUI() abort
  setlocal listchars=
    \ nonumber
    \ norelativenumber
    \ nowrap
    \ winfixwidth
    \ laststatus=0
    \ noshowmode
    \ noruler
    \ scl=no
    \ colorcolumn=
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endfunction

function! OnNeoTermOpen() abort
  call EnableCleanUI()
  wincmd J
  call NaturalDrawer()
endfunction


" Neoterm {{{
" Sets default location that neoterm opens
let g:neoterm_default_mod = 'botright'
let g:neoterm_autojump = 1
let g:neoterm_direct_open_repl = 1
" }}}
