-- Highlight on yank
vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200}) 
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

vim.cmd [[
fun! SetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:the_primeagen_qf_l = 1
    else
        let g:the_primeagen_qf_g = 1
    end
endfun

fun! UnsetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:the_primeagen_qf_l = 0
    else
        let g:the_primeagen_qf_g = 0
    end
endfun

augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

augroup fixlist
    autocmd!
    autocmd BufWinEnter quickfix call SetQFControlVariable()
    autocmd BufWinLeave * call UnsetQFControlVariable()
augroup END

fun! ToggleQFList()
  if g:the_primeagen_qf_g == 1
      cclose
  else
      copen
  end
endfun
]]

-- Formatoptions
vim.cmd [[
  augroup _formatoptions
    autocmd!
    autocmd BufWinEnter * :set formatoptions-=cro
  augroup end
]]
