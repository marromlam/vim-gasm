" Random Useful Functions

" Turn spellcheck on for markdown files
augroup auto_spellcheck
  autocmd BufNewFile,BufRead *.md setlocal spell
augroup END


" Toggle virtual edit
function! ToggleVirtualEdit() abort
  if &virtualedit != "all"
    set virtualedit=all
  else
    set virtualedit=
  endif
endfunction


"""function! s:check_back_space() abort
"""  let col = col('.') - 1
"""  return !col || getline('.')[col - 1]  =~# '\s'
"""endfunction



" Auto Commands {{{
augroup General
  autocmd!
  " Put the quickfix window always at the bottom
  autocmd! FileType qf call OpenQuickFix()
  " Enable text file settings
  autocmd! FileType markdown,txt,tex call EnableTextFileSettings()
  autocmd! FileType sh call neoterm#repl#set('sh')
  autocmd! FileType fern,floggraph call EnableCleanUI()
  autocmd! FileType neoterm call OnNeoTermOpen()
  autocmd! FileType fzf call OnFZFOpen()
  autocmd! VimLeavePre * call DisableDistractionFreeSettings()
  if has('nvim')
    autocmd! TermOpen * let g:last_open_term_id = b:terminal_job_id
  endif
  autocmd! User VimtexEventCompileStopped call TermPDFClose()
  autocmd FileType tex autocmd BufDelete <buffer> call TermPDFClose()
  " autocmd FileType markdown autocmd BufWritePost <buffer> call CompileMarkdown()
  " autocmd FileType markdown autocmd BufDelete <buffer> call TermPDFClose()
augroup END
" }}}
