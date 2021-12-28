-- main file

vim.g.start_time = vim.fn.reltime()
vim.g.elite_mode = true
vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == "Darwin" and "open" or "xdg-open"
vim.g.dotfiles = vim.fn.expand("~/.dotfiles")
vim.g.luavim_config = vim.fn.expand("~/.config/nvim")
vim.g.skeleton_template_dir = vim.g.luavim_config .. "/templates"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- this is just for developing my own pluggins
vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/darkplus.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/gruvbox.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/mytheme.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/afterglow.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/mytheme2.nvim" ]]

-- source settings and general keymaps
require("luavim.core")

-- load plugins, colorscheme and autocommands
require("luavim.plugins")
require("luavim.colorscheme")
require("luavim.autocommands")

-- TODO : find a good place for this
vim.cmd([[
  let g:skeleton_replacements = {}
  function! g:skeleton_replacements.TITLE()
    return toupper(expand("%:t:r"))
  endfunction

function! OpenPDFCitekey()
   let kcmd = 'kitty --single-instance --instance-group=1 '
   let kcmd = kcmd . 'termpdf.py --nvim-listen-address '
   let kcmd = kcmd . $NVIM_LISTEN_ADDRESS . ' '
   let key=expand('<cword>')
   keepjumps normal! ww
   let page=expand('<cword>')
   if page ==? 'p'
       keepjumps normal! ww
       let page=expand('<cword>')
   endif
   keepjumps normal! bbb
   let kcmd = kcmd . '--open ' . key . ' '
   if page
       let kcmd = kcmd . '-p ' . page 
   endif
   exe "!" . kcmd
endfunction

function! CompileMarkdown() abort
  :only
  let md_file = expand('%:p')
  let pdf_file = expand('%:p:r') . '.pdf'
  call system('pandoc -s -o ' . pdf_file . ' ' . md_file)
  call TermPDF(pdf_file)
endfunction

augroup Markdown
  autocmd!
  autocmd FileType markdown autocmd BufWritePost <buffer> call CompileMarkdown()
  autocmd FileType markdown autocmd BufDelete <buffer> call TermPDFClose()
augroup end

let g:termpdf_lastcalled = 0
function! TermPDF(file) abort
  " Implement some basic throttling
  let time = str2float(reltimestr(reltime())) * 1000.0
  if time - g:termpdf_lastcalled > 1000
    call system('kitty @ set-background-opacity 1.0')
    call system('kitty @ kitten termpdf.py ' . a:file . ' -i -a')
    let g:termpdf_lastcalled = time
  endif
endfunction

function! TermPDFClose() abort
  call system('kitty @ close-window --match title:termpdf')
  call system('kitty @ set-background-opacity 0.97')
endfunction

" Vimtex {{{
" let g:vimtex_view_general_callback = 'VimtexCallback'
let g:vimtex_view_automatic = 0

function! VimtexCallback(status) abort
  if a:status
    call TermPDF(b:vimtex.out())
  endif
endfunction

augroup VimtexTest
  autocmd!
  autocmd! User VimtexEventCompileStopped call TermPDFClose()
  autocmd! User VimtexEventCompileSuccess call VimtexCallback(1)
  autocmd! User VimtexEventView call VimtexCallback(1)
  autocmd FileType tex autocmd BufDelete <buffer> call TermPDFClose()
augroup end
" }}}

let folddigest_options = "nofoldclose,vertical,flexnumwidth"
let folddigest_size = 40
" }}}
]])

-- vim:fdm=marker
