-- Ipython configuration

-- let g:ipython_cell_regex = 1
-- let g:ipython_cell_tag = '# %%( [^[].*)?'
vim.cmd([[
nmap <S-CR> <Plug>(SlimeLineSend)<CR>
xmap <S-CR> <Plug>(SlimeRegionSend)<CR>
imap <S-CR> <Plug>(SlimeRegionSend)<CR>
]])
