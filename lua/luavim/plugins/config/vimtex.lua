-- vim.g.vimtex_view_method = "general"
-- vim.g.latex_view_general_viewer = "termpdf.py"


vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_mode = 2

-- One of the neosnippet plugins will conceal symbols in LaTeX which is
-- confusing
vim.g.tex_conceal = ""

-- Can hide specifc warning messages from the quickfix window
-- Quickfix with Neovim is broken or something
-- https://github.com/lervag/vimtex/issues/773
-- vim.g.vimtex_quickfix_ignore_filters = {
--   default = 1,
--   fix_paths = 0,
--   general = 1,
--   references = 1,
--   overfull = 1,
--   underfull = 1,
--   font = 1,
--   packages = { default = 1,
--                natbib = 1,
--                biblatex = 1,
--                babel = 1,
--                hyperref = 1,
--                scrreprt = 1,
--                fixltx2e = 1,
--                titlesec = 1 } 
-- }

vim.g.vimtex_compiler_latexmk = { build_dir = "build", progname = "nvr" }
-- let g.vimtex_latexmk_build_dir = './build'
-- vim.g.vimtex_latexmk_progname = 'nvr'

-- Config from castel.dev
-- set conceallevel=1
vim.g.tex_conceal='abdmg'



-- pdf viewer
vim.cmd [[
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

]]




