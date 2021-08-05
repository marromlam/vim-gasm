let g:tex_flavor = 'latex'
"let g:vimtex_view_method = 'general'
"let g:vimtex_view_general_viewer = 'kitty @ kitten termpdf.py'
let g:vimtex_view_general_callback = 'VimtexCallback'
let g:vimtex_view_automatic = 0
let g:termpdf_lastcalled = 0



" This function is called if document was properly compiled. It calls 
function! VimtexCallback(status) abort
  "call system('kitty @ kitten termpdf.py ' . b:vimtex.out())
  "call TermPDF(b:vimtex.out())
  if a:status
    call TermPDF(b:vimtex.out())
  endif
endfunction



function! OpenPDFCitekey()
   let kcmd = 'kitty --single-instance --instance-group=1 '
   "let kcmd = 'kitty @ kitten '
   let kcmd = kcmd . 'termpdf.py --nvim-listen-address '
   let kcmd = kcmd . $NVIM_LISTEN_ADDRESS . ' '
   " let key=expand('<cword>')
   " keepjumps normal! ww
   " let page=expand('<cword>')
   " if page ==? 'p'
   "     keepjumps normal! ww
   "     let page=expand('<cword>')
   " endif
   " keepjumps normal! bbb
   " let kcmd = kcmd . '--open ' . key . ' '
   " if page
   "     let kcmd = kcmd . '-p ' . page 
   " endif
   call system(kcmd . b:vimtex.out())
endfunction



function! CompileMarkdown() abort
  :only
  let md_file = expand('%:p')
  let pdf_file = expand('%:p:r') . '.pdf'
  call system('pandoc -s -o ' . pdf_file . ' ' . md_file)
  call TermPDF(pdf_file)
endfunction



function! TermPDF(file) abort
  " Implement some basic throttling
  let time = str2float(reltimestr(reltime())) * 1000.0
  if time - g:termpdf_lastcalled > 1000
    if $MACHINEOS == "Linux"
      let kcmd = 'kitty @ send-text --match id:'
      let kcmd = kcmd . $KITTY_WINDOW_ID . ' termpdf.py '
      " echo "termpdf " . kcmd
      call system(kcmd . a:file . "\r")
    else
      call system('kitty @ set-background-opacity 1.0')
      call system('kitty @ kitten termpdf.py ' . a:file)
    endif
    let g:termpdf_lastcalled = time
  endif
endfunction



function! TermPDFClose() abort
  call system('kitty @ close-window --match title:termpdf')
  call system('kitty @ set-background-opacity 0.97')
endfunction
