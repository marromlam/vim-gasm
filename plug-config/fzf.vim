
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1

" map <C-f> :Files<CR>
" map <leader>b :Buffers<CR>
" nnoremap <leader>g :Rg<CR>
" nnoremap <leader>t :Tags<CR>
" nnoremap <leader>m :Marks<CR>



" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)



"let g:fzf_tags_command = 'ctags -R'
" Border color
"let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }



" Use agriculture as a global no hidden search
let g:agriculture#rg_options = '--no-ignore --hidden'
" Default FZF options with bindings to match layout and select all + none
" Some ripgrep searching defaults
function! RgCommand(ignore) abort
  return join([
    \ 'rg', '--hidden', '--color ansi', '--column',
    \ '--line-number', '--no-heading', '--smart-case',
    \ (a:ignore == 1 ? '--ignore' : '--no-ignore')
  \], ' ')
endfunction
" Adds prompt
function! PreviewFlags(prompt) abort
  return ' --prompt="' . a:prompt . '> "'
endfunction
" Ensure that only the 4th column delimited by : is filtered by FZF
function! RgPreviewFlags(prompt) abort
  return PreviewFlags(a:prompt) . ' --delimiter : --nth 4..'
endfunction
" Configs the preview
function! Preview(flags) abort
  return fzf#vim#with_preview({'options': a:flags})
endfunction
" xecutes ripgrep with a preview
function! Rg(ignore, args, bang) abort
  let command = RgCommand(a:ignore).' '.shellescape(a:args)
  call fzf#vim#grep(command, 1, Preview(RgPreviewFlags(a:ignore ? 'Grep' : 'Global Grep')), a:bang)
  call animate#window_percent_height(0.8)
endfunction
" Opens files search with preview
function! Files(args, bang) abort
  call fzf#vim#files(a:args, Preview(PreviewFlags('Files')), a:bang)
  call animate#window_percent_height(0.5)
endfunction
" Opens lines with animation
function! Lines(args, bang) abort
  call fzf#vim#lines(a:args, a:bang)
  call animate#window_percent_height(0.8)
endfunction
" Opens buffers with animation
function! Buffers(args, bang) abort
  call fzf#vim#buffers(a:args, a:bang)
  call animate#window_percent_height(0.2)
endfunction
" let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_OPTS = join(
  \ [
    \ '--layout=default', '--info inline',
    \ '--bind ' . join(
      \ [
        \ 'ctrl-a:select-all', 'ctrl-d:deselect-all',
        \ 'tab:toggle+up', 'shift-tab:toggle+down',
        \ 'ctrl-p:toggle-preview'
      \ ],
      \ ',',
    \ )
  \ ],
  \ ' ',
\ )



" Default location for FZF
let g:fzf_layout = {
 \ 'window': 'call NewFZFWindow()'
\ }

"let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"-g '!{node_modules,.git}'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Ctrl-l populates arglist. Use with :cfdo. Only works in :Files
let g:fzf_action = {
  \ 'ctrl-l': {l -> execute('args ' . join(map(l, {_, v -> fnameescape(v)}), ' '))},
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
\ }
"    \ 'ctrl-t': 'tab split',
"    \ 'ctrl-x': 'split',
"    \ 'ctrl-v': 'vsplit' }



" Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)


" Get text in files with Rg
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,

 " Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)















" Animate the quickfix and ensure it is at the bottom
function! OpenQuickFix() abort
  if getwininfo(win_getid())[0].loclist != 1
    wincmd J
  endif
  call NaturalDrawer()
endfunction



function! NewFZFWindow() abort
  new | wincmd J | resize 1
endfunction



" There's an issue with animating FZF. The preview sees the terminal as having
" a small height, and therefore doesn't render the preview with any lines
" this hack is to toggle the preview on and off, thereby rerendering the
" preview
function! RefreshFZFPreview() abort
  if has('nvim')
    if exists('g:last_open_term_id') && g:last_open_term_id
      call timer_start(350, {t->chansend(g:last_open_term_id, "\<C-p>\<C-p>")})
    endif
  else
    call term_sendkeys(bufnr('%'), "\<C-p>\<C-p>")
  endif
endfunction



function! OnFZFOpen() abort
  call EnableCleanUI()
  call RefreshFZFPreview()
  tnoremap <Esc> <c-c>
  startinsert
endfunction
