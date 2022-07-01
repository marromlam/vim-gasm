-- main file

vim.g.start_time = vim.fn.reltime()
vim.g.elite_mode = true
vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == "Darwin" and "open" or "xdg-open"
vim.g.dotfiles = vim.fn.expand "~/.dotfiles"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- this is just for developing my own pluggins
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/darkplus.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/gruvbox.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/mytheme.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/afterglow.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/mytheme2.nvim" ]]

-- source settings and general keymaps
require "luavim.core"

-- load plugins, colorscheme and autocommands
require "luavim.plugins"
vim.o.background = "dark" -- or "light" for light mode
require "luavim.colorscheme"
require "luavim.autocommands"

-- TODO : find a good place for this
-- maybe remove -- function! OpenPDFCitekey()
-- maybe remove --    let kcmd = 'kitty --single-instance --instance-group=1 '
-- maybe remove --    let kcmd = kcmd . 'termpdf.py --nvim-listen-address '
-- maybe remove --    let kcmd = kcmd . $NVIM_LISTEN_ADDRESS . ' '
-- maybe remove --    let key=expand('<cword>')
-- maybe remove --    keepjumps normal! ww
-- maybe remove --    let page=expand('<cword>')
-- maybe remove --    if page ==? 'p'
-- maybe remove --        keepjumps normal! ww
-- maybe remove --        let page=expand('<cword>')
-- maybe remove --    endif
-- maybe remove --    keepjumps normal! bbb
-- maybe remove --    let kcmd = kcmd . '--open ' . key . ' '
-- maybe remove --    if page
-- maybe remove --        let kcmd = kcmd . '-p ' . page
-- maybe remove --    endif
-- maybe remove --    exe "!" . kcmd \
-- maybe remove -- endfunction

-- vim.cmd [[
--   augroup LspFormat
--     autocmd! * <buffer>
--     autocmd BufWritePre <buffer> lua require("config.lsp.null-ls.formatters").format()
--     autocmd BufWritePre <buffer> Format
--   augroup END
-- ]]

vim.cmd [[
  vmap <leader>sk ::w !kitty @ --to=tcp:localhost:$KITTY_PORT send-text --match=num:1 --stdin<CR><CR> 
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * setlocal scl=no

  if has('nvim') && executable('nvr')
    " pip3 install neovim-remote
    let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
    let $EDITOR='nvr --nostart --remote-tab-wait +"set bufhidden=delete"'
  endif
  nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>
  set path+=**,.,,
]]

-- vim:fdm=marker
