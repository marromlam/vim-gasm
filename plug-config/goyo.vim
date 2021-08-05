" nmap <silent> <leader>z :Goyo<CR>
" autocmd User GoyoEnter set laststatus=0 
" autocmd User GoyoLeave set laststatus=2
" function! s:goyo_enter()
  
"   set wrap
"   set conceallevel=0
"   set tw=100
"   set noshowcmd
"   set scrolloff=999
"   set laststatus=0 

" endfunction

" function! s:goyo_leave()

"   set wrap!
"   set showcmd
"   set scrolloff=5
"   set laststatus=2

" endfunction

" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_width = 81

autocmd! User GoyoEnter lua require('galaxyline').disable_galaxyline()
autocmd! User GoyoLeave lua require('galaxyline').galaxyline_augroup()



let g:distraction_free = 0
function! ToggleDistractionFreeSettings() abort
  if g:distraction_free
    call DisableDistractionFreeSettings()
  else
    call EnableDistractionFreeSettings()
  endif
endfunction

function! EnableDistractionFreeSettings() abort
  if g:distraction_free
    return
  endif
  let g:distraction_free = 1
  let g:lens#disabled = 1
  call goyo#execute(0, 0)
  Limelight
  set showtabline=0
endfunction

function! DisableDistractionFreeSettings() abort
  if ! g:distraction_free
    return
  endif
  let g:distraction_free = 0
  let g:lens#disabled = 0
  call goyo#execute(0, 0)
  Limelight!
  set showtabline=1
endfunction
